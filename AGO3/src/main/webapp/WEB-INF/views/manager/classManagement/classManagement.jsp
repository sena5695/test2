<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri}" />
<c:set var="classList" value="${dataMap.mainList }" />
<c:set var="detail" value="${dataMap.detail }" />
<c:set var="message" value="${message}"/>
<head></head>

<title></title>
<body>
<input type="hidden" id="message1112" value="${message}">
<script>
window.onload=function(){
	var message = $('#message1112').val();
		
	if(message != ""){
		alert(message);
	}
}
</script>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">강의목록</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath() %>/manager/classManagement/main.do">강의관리</a>
						</li>
						<li class="breadcrumb-item active">강의목록</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

	<div id="outdiv">
		<div class="row" id="innerdiv">
			<input type="hidden" id="firstclCode" value="${dataMap.firstclCode}" />
			<section class="content col-6">
				<div class="container-fluid">
				
					<input type='text' id='sort' name='sortType' value="${ cri.sortType }" hidden="hidden" />
					<div style="min-height:600px;">
					
					
					<table class="table table-sm" style="margin-bottom: 20px;">

						<caption style="caption-side: top;">
							<div class="row justify-content-center">
							<select class="col-md-3 form-control form-control-sm" style="margin-right : 350px;" name="sortSelect" onchange="sort()">
								<option value="" ${cri.sortType eq '' ? 'selected':'' }>분류</option>
								<option value="n" ${cri.sortType eq 'n' ? 'selected':'' }>일반교육</option>
								<option value="s" ${cri.sortType eq 's' ? 'selected':'' }>신입 의무 교육</option>
								<option value="h" ${cri.sortType eq 'h' ? 'selected':'' }>자기개발 및 취미</option>
							</select>
							
							<button class=" btn btn-secondary float-right" onclick="location.href='registClass.do'">강의등록</button>
							</div>
						</caption>

						<thead>
							<tr class="text-center" style="background-color: #F5F4F4;">

								<th>강의명</th>
								<!-- 					<th>학습기간</th> -->
								<!-- 					<th>수강기간</th> -->
								<th>강의구분</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty classList }">
								<tr class="text-center">
									<td colspan="3">등록된 강의가 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${classList }" var="list">
								<tr class="p-0">

									<td class="row" style="cursor: pointer" onclick="getPage('<%=request.getContextPath()%>/manager/classManagement/detailClass.do?clCode=${list.clCode}'); openclCode(${list.clCode });">
										<form action="detailClass.do" method="post">
											<input type="hidden" value="${list.clCode }">
										</form> <img style="width: 130px; height: 90px;" src="/ago/manager/classManagement/getPicture.do?picture=${list.clImg }">
										<div class="col-8 mt-3">
											<span class="h6 align-middle">
												<c:choose>
				                                    <c:when test="${fn:length(list.clName) gt 24 }">
				                                        <c:out value="${fn:substring(list.clName,0,24)}..."></c:out>
				                                    </c:when>
				                                    <c:otherwise>
				                                         ${list.clName }
				                                    </c:otherwise>
				                                </c:choose>
											 </span>
											 <br>
											 
											<c:if test="${list.clFormat eq 'A601'}">
												<span class=" badge badge-info">오프라인</span>
											</c:if>
											<c:if test="${list.clFormat eq 'A602'}">
												<span class=" badge badge-primary">온라인</span>
											</c:if>
											<c:if test="${list.clFormat eq 'A603'}">
												<span class=" badge badge-success">실시간</span>
											</c:if>
											<c:if test="${list.clDivision eq 'A501'}">
												<span class=" badge badge-danger">필수</span>
											</c:if>
											<c:if test="${list.clDivision eq 'A502'}">
												<span class=" badge badge-warning">선택</span>
											</c:if>
										</div>
									</td>
									<!-- 					<td class="text-center align-middle"> -->
									<%-- 								<c:if test="${list.studyDate == 'D101'}">신청일로부터 7일</c:if> --%>
									<%-- 								<c:if test="${list.studyDate == 'D102'}">신청일로부터 30일</c:if> --%>
									<%-- 								<c:if test="${list.studyDate == 'D103'}">제한없음</c:if> --%>
									<!-- 					</td> -->
									<!-- 					<td class="text-center">2021.01.01<br>~<br>2022.01.30 -->
									<!-- 					</td> -->
									<td class="text-center align-middle"><c:if test="${list.clCate  == 'A201'}">신입사원교육</c:if> <c:if test="${list.clCate  == 'A202'}">일반교육</c:if> <c:if test="${list.clCate  == 'A203'}">자기개발/취미</c:if></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
					<div class="card-body col-md-12 column ui-sortable ">
						<%@include file="/WEB-INF/views/common/pagination.jsp"%>
					</div>
				</div>

			</section>

			<section class="content col-6">
				<div class="col-12" style="border: none; box-shadow: none;">
					<div class="card-header">
						<h5 class="font-weight-bold">강의 정보</h5>
					</div>
					<div id="detail">
						<div id="detailhandle"></div>
					</div>

				</div>
				<div class="col-12" style="min-height: 520px;">
					<div class="row align-items-center mt-3 ml-2">
						<h5 class="font-weight-bold ml-2"  style="width: 490px;">회차정보</h5>
						<input type="hidden" name="openclCode">
						<button class=" btn btn-default" onclick="sendclCode()">회차 등록</button>
					</div>

					<div id="outOpcl">
						<div id="inOpcl"></div>
					</div>

				</div>

			</section>

		</div>
	</div>
	<%@include file="./handlebarsDetail.jsp"%>

	<script>


		function detail(clCode) {

			$.ajax({
				url : 'detailClass.do',
				data : {
					'clCode' : clCode
				},
				type : 'post',
				success : function(data) {
				},
				error : function(error) {
					//alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
					AjaxErrorSecurityRedirectHandler(error.status);
					console.log(error.status);
				}
			})
		}
		
		function openclCode(clCode){
			$('input[name="openclCode"]').val(clCode);
		}
		
		function sendclCode(){
		var clCode=	$('input[name="openclCode"]').val();
			OpenWindow('registOpenClassForm.do?mCode=M010200&clCode='+clCode,'회차등록',1200,800);
		}
		
		function sort() {
			$('#sort').val($("select[name=sortSelect]").val());
			list_go(1);
		}
		
	</script>
</body>