package com.one.security;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;

import com.one.dto.ManagerVO;
import com.one.dto.MemberVO;
import com.one.service.ManagerService;
import com.one.service.MemberService;
import com.one.utils.PwdToEncryption;

public class ManagerAuthenticationProvider implements AuthenticationProvider {

	private ManagerService managerService;

	public void setManagerService(ManagerService managerService) {
		this.managerService = managerService;
	}

	@Override
	public Authentication authenticate(Authentication auth) {
		String login_id = (String) auth.getPrincipal(); // 로그인 시도한 ID를 가져온다
		String login_pwd = (String) auth.getCredentials(); // 로그인 시도한 Password를 가져온다

		ManagerVO manager = null;
		try {
			manager = managerService.getManager(login_id);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BadCredentialsException("서버 장애로 서비스가 불가합니다.");
		}

		if (manager != null) {
			if (PwdToEncryption.encry(login_id, login_pwd).equals(manager.getManagerPwd())) { // 아이디 비밀번호 일치
				UserDetails authUser = new com.one.security.Manager(manager);
				boolean invaildCheck = authUser.isAccountNonExpired();
				if (invaildCheck) {
					// 스프링 시큐리티 내부 클래스로 인증 토큰 생성한다.
					UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(authUser.getUsername(), authUser.getPassword(), authUser.getAuthorities());

					// 전달할 내용을 설정한 후
					result.setDetails(authUser);

					// 리턴한다. successHandler로 전송한다.
					return result;
				}

				throw new BadCredentialsException("로그인이 불가합니다.");
			} else { // 패스워드 불일치
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
			}
		} else { // 존재하지 않는 아이디
			throw new BadCredentialsException("존재하지 않는 아이디입니다.");
		}
	}

	@Override
	public boolean supports(Class<?> auth) {
		return auth.equals(UsernamePasswordAuthenticationToken.class);
	}
}
