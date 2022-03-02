<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="memCertificateList" value="${dataMap.memCertificateList}" />
<c:set var="certificateYearList" value="${dataMap.certificateYearList}" />

<html>
<head>

<title>마이페이지</title>
</head>
<body>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header" >
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">수료증발급</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/user/myPage/myInfo/main.do">마이페이지</a>
						</li>
						<li class="breadcrumb-item">수료증발급</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

	<div class="container-fluid" >
		<select class="form-control form-control-sm col-1" name="searchType" id="searchType" style="height: 39px;" onchange="fn_list(1);">
			<option value="all" ${cri.searchType eq 'all' ? 'selected': '' }>전체</option>
			<c:forEach var="certificateYear" items="${certificateYearList}">
				<option value="${certificateYear}" ${cri.searchType eq certificateYear ? 'selected': '' }>${certificateYear}</option>
			</c:forEach>
		</select>
		<div class="col-md-12 column ui-sortable" style="height: 520px;">
			<table class="table mt-3 table-sm">
				<thead>
					<tr style="background-color:#E6EFFC;" class="text-center">
						<th class="col-md-1 column ui-sortable">강의코드</th>
						<th class="col-md-7 column ui-sortable">강의명</th>
						<th class="col-md-2 column ui-sortable">수료날짜</th>
						<th class="col-md-3 column ui-sortable">발급</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${not empty memCertificateList}">
					<c:forEach var="memCertificate" items="${memCertificateList}">
						<tr>
							<td class="text-center">${memCertificate.clCode}</td>
							<td>${memCertificate.clName}</td>
							<td class="text-center"><fmt:formatDate value="${memCertificate.ctfDate}" pattern="yyyy-MM-dd" /></td>
							<td class="text-center">
								<button class="btn btn-primary btn-sm" onclick="OpenWindow('<%=request.getContextPath()%>/user/myPage/certificate/certificate.pop?clCode=${memCertificate.clCode}','수료증발급',830,900);">수료증 발급</button>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty memCertificateList}">
						<tr>
							<td colspan="4" class="text-center text-bold">회원의 수료증 내역을 찾을 수 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<c:if test="${not empty memCertificateList}">
			<div class="card-body col-md-12 column ui-sortable ">
				<%@include file="/WEB-INF/views/common/pagination.jsp"%>
			</div>
		</c:if>
	</div>
	<form id="searchForm">
		<input type="hidden" name="page" value="3" />
		<input type="hidden" name="searchType" value="123456" />
		<input type="hidden" name="keyword" value="" />
	</form>
	<script>
		function fn_list(page) {
			var url = "list.do";

			var searchForm = $('#searchForm');

			searchForm.find("[name='page']").val(page);
			searchForm.find("[name='searchType']").val($('select[name="searchType"]').val());
			searchForm.find("[name='keyword']").val($('input[name="keyword"]').val());
			
			searchForm.attr({
				action : url,
				method : 'get'
			}).submit();
		}
	</script>
</body>
</html>













