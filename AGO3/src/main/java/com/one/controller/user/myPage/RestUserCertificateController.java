package com.one.controller.user.myPage;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.one.service.impl.CertificateServiceImpl;
import com.one.utils.MakeFileName;

//import com.jsp.utils.MakeFileName;

//import kr.or.ddit.utils.ExceptionLoggerHelper;

@RestController
@RequestMapping("/user/myPage/certificate")
public class RestUserCertificateController {

	@Autowired
	private CertificateServiceImpl certificateService;

	@Resource(name = "certificateUploadPath")
	private String picturePath;

	@RequestMapping(value = "/picture", method = RequestMethod.POST, produces = "test/plain;charset=utf-8")
	public ResponseEntity<String> picture(@RequestParam("pictureFile") MultipartFile multi, String oldPicture)
			throws IOException {
		ResponseEntity<String> entity = null;

		String result = savePicture(oldPicture, multi);

		entity = new ResponseEntity<String>(result, HttpStatus.OK);

		return entity;

	}

	@RequestMapping(value = "/getPicture.do", produces = "text/plain;charset=utf-8")
	public ResponseEntity<byte[]> getPicture(String picture) throws IOException {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = this.picturePath;
		try {

			in = new FileInputStream(new File(imgPath, picture));
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} finally {
			in.close();
		}

		return entity;
	}

//	@RequestMapping(value = "/getPictureById.do/{id}", method = RequestMethod.GET, produces = "test/plain;charset=utf-8")
//	public ResponseEntity<byte[]> getPictureById(@PathVariable("id") String id, HttpServletRequest request)
//			throws Exception {
//
//		String picture = null;
//		try {
//			picture = memberService.getMember(id).getPicture();
//		} catch (Exception e) {
//			e.printStackTrace();
//			ExceptionLoggerHelper.write(request, e, memberService);
//			throw e;
//		}
//
//		return getPicture(picture);
//	}

	private String savePicture(String oldPicture, MultipartFile multi) throws IOException {

		String fileName = null;

		// 파일 유무 확인
		if (!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 5)) {

			// 파일 저장 폴더 설정
			String uploadPath = picturePath;
			fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
			File storeFile = new File(uploadPath, fileName);

			storeFile.mkdirs();

			// local HDD에 저장
			multi.transferTo(storeFile);

			if (oldPicture != null && !oldPicture.isEmpty()) {
				File oldFile = new File(uploadPath, oldPicture);
				if (oldFile.exists()) {
					oldFile.delete();
				}
			}
		}

		return fileName;
	}
}
