<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="classList" value="${dataMap.classList }" />
<c:set var="member" value="${dataMap.member}" />
<c:set var="departmentList" value="${dataMap.departmentList}" />
<c:set var="positionList" value="${dataMap.positionList}" />
<c:set var="authorityList" value="${dataMap.authorityList}" />



<body>
	<br><br>
	<div class="row col-md-12 column">

		<div class="col-md-11 column mx-auto">
			
			<table class="col-md-12 column">
				<tr>
					<td>
						<h4 class="col-9 m-0">회원상세페이지</h4>
					</td>
					<td style="text-align: right;">
						<button class="btn btn-secondary btn-sm" onclick="changeAuthority()">저장</button>
						<button class="btn btn-default btn-sm" onclick="window.close();">취소</button>
					</td>
				</tr>
			</table>

			<table class="table mt-3">
				<thead>
					<tr style="background-color: #EDEDED;" class="justify-content-center">
						<th class="col-md-2 align-middle pl-4">이름 : ${member.memName }</th>
						<th class="col-md-3 align-middle">부서 :
							<c:forEach items="${departmentList }" var="department">
								<c:if test="${department.commonCode eq member.dpId}">
									${ department.codeName1}
								</c:if>
							</c:forEach>
						</th>
						<th class="col-md-2 align-middle">직위 :
 							<c:forEach items="${positionList }" var="position">
								<c:if test="${position.commonCode eq member.positionId}">
									${position.codeName1}
								</c:if>
							</c:forEach>
						</th>
						<th class="col-md-2 pr-0 pl-0 mt-1 align-middle">권한 :
							<select id='selector' class="form-control-sm">
								<c:forEach items="${authorityList }" var="authority">
									<c:choose>
										<c:when test="${authority.commonCode eq member.authorityId}">
											<option selected="selected" value="${authority.commonCode}">
											  <c:if test="${authority.codeName1 eq '사용자'}">부서원</c:if>
											  <c:if test="${authority.codeName1 ne '사용자'}">부서장</c:if>
											</option>
										</c:when>
										<c:otherwise>
											<option value="${authority.commonCode}">
												<c:if test="${authority.codeName1 eq '사용자'}">부서원</c:if>
											  	<c:if test="${authority.codeName1 ne '사용자'}">부서장</c:if>
											</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</th>
						<th class="col-md-3 pl-0 pr-2 align-middle pr-4" style="text-align: right;">총 이수 점수 : ${member.memCredit}점</th>
					</tr>
				</thead>
			</table>

			<table class="table mt-3 table-sm">
				<thead>
					<tr class="text-center"  style="background-color: #EDEDED;">
						<th class="col-md-2">강의번호</th>
						<th class="col-md-7">강의명</th>
						<th class="col-md-3">진도율</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty classList }">
						<tr>
							<td colspan="4" class="text-center">수강한 강의가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty classList }">
						<c:forEach items="${classList }" var="classVO">
							<tr>
								<td class="text-center">${classVO.clCode }</td>
								<td>${classVO.clName }</td>
								<td class="text-center">
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: ${classVO.progRate}%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">${classVO.progRate}%</div>
									</div>
								</td>
	
							</tr>
						</c:forEach>
					</c:if>

				</tbody>
			</table>
		</div>

	</div>
	<script type="text/javascript">
		function changeAuthority() {

			var authorityId = $("#selector option:selected").val();
			var memEmail = '${member.memEmail}';
			$.ajax({
	             url         : 'updateAuthority',
	             data        : {'authorityId' : authorityId,
	            	 			'memEmail' : memEmail
	             },
	             type        : 'post',
	             success     : function(data){
	            	 if(data == "success"){
	            		 alert("수정이 완료되었습니다.");
	            	 } else{
	            		 alert("수정에 실패하였습니다.");
	            	 }
	            	 window.close();
	             },
	             error         : function(error){
	                 //alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
	                 AjaxErrorSecurityRedirectHandler(error.status);
	                 console.log(error.status);
	             }
	         })
		}

	</script>
</body>