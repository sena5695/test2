<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="debateBoardList" value="${dataMap.debateBoardList }" />
<c:set var="importantNoticeList" value="${dataMap.importantNoticeList }" />

<head></head>
<title></title>

<body>

	<script>
if(${from eq "regist"}){
	alert("게시글을 등록하였습니다.");
	window.location.reload();
}

if(${from eq "remove"}){
	alert("게시글을 삭제하였습니다.");
	window.location.reload();
}
</script>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0" >
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">토론게시판</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/user/community/freeBoard/list.do">커뮤니티</a>
						</li>
						<li class="breadcrumb-item">토론게시판</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

	<!-- 메인 바디 -->
	<!-- Main content -->
	<section class="content" >
		<div class="container-fluid">
			<div class="input-group justify-content-end col-12 p-0 mb-2">
				<div class="p-0 m-0 text-left col-6 float-left">
					<button type="button" class="btn btn-block btn-primary btn-sm col-2 float-left" onclick="location.href='registForm.do'">글쓰기</button>
				</div>
				<div class="row col-6 justify-content-end p-0 mr-1">
					<select class="col-md-3 form-control" name="searchType" id="searchType" style="height: 39px;">
						<option value="a">전체</option>
						<option value="t">제목</option>
						<option value="c">내용</option>
						<option value="w">작성자</option>
					</select>
					<input type="text" placeholder="검색할 단어를 입력하세요" name="keyword" class="form-control col-md-7">
					<button class="col-md-2 btn btn-primary float-right" onclick="list_go(1);">검색</button>
				</div>
			</div>
			
			<div style="height:630px;">
			<table class="table table-sm table-hover">
				<thead>
					<tr class="text-center" style="background-color:#E6EFFC;">
						<th class="col-1">번호</th>
						<th class="col-7">제목</th>
						<th class="col-1 text-left">작성자</th>
						<th class="col-2">등록날짜</th>
						<th class="col-1">조회수</th>
					</tr>
				</thead>
				<!-- 						<td style="cursor: pointer;" onclick="location.href='detail.do'"> -->
				<tbody>
					<c:if test="${not empty importantNoticeList }">
						<c:forEach items="${importantNoticeList }" var="importantNotice" end="2">
							<tr style="background-color: #FEDFDA;" class="freeBoardSize" id="importantNotice">
								<td class="text-center">${importantNotice.noticeNo}</td>
								<c:choose>
									<c:when test="${fn:length(importantNotice.noticeTitle) gt 48 }">
										<td class="text-danger" onclick="location.href='detailNotice.do?noticeNo=${importantNotice.noticeNo}&from=list'" style="cursor:pointer;">
											<i class="fas fa-bullhorn"> </i>
											&nbsp;[공지]&nbsp;<c:out value="${fn:substring(importantNotice.noticeTitle,0,48)}..."></c:out>
										</td>
									</c:when>
									<c:otherwise>
										<td class="text-danger" onclick="location.href='detailNotice.do?noticeNo=${importantNotice.noticeNo}&from=list'" style="cursor:pointer;">
											<i class="fas fa-bullhorn"> </i>
											&nbsp;[공지]&nbsp; ${importantNotice.noticeTitle }
										</td>
									</c:otherwise>
								</c:choose>
								<td class="">운영자</td>
								<td class="text-center">${importantNotice.noticeDate }</td>
								<td class="text-center">${importantNotice.noticeViewCnt }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty debateBoardList }">
						<tr>
							<td colspan="6" class="text-center"><strong>해당 내용이 없습니다.</strong></td>
						</tr>
					</c:if>
					<c:forEach items="${ debateBoardList }" var="debateBoard">
						<tr style="height: 40px;">
							<td class="text-center align-middle">${debateBoard.dboardNo}</td>
							<td class="align-middle" style="cursor: pointer;" onclick="location.href='detail.do?dboardNo=${debateBoard.dboardNo}&from=list'">
								<c:choose>
									<c:when test="${fn:length(debateBoard.deTitle) gt 48 }">
										<c:out value="${fn:substring(debateBoard.deTitle,0,48)}..."></c:out>

									</c:when>
									<c:otherwise>
										 ${debateBoard.deTitle }
									</c:otherwise>
								</c:choose>

								<c:if test="${debateBoard.replyCnt > 0 }">
									<span class="text-primary"><b>[${debateBoard.replyCnt }]</b></span>
								</c:if> <span></span>
							</td>
							<td class="align-middle">${debateBoard.memId }</td>
							<td class="text-center align-middle"><fmt:formatDate value="${debateBoard.deRegdate}" pattern="yyyy-MM-dd" /></td>
							<td class="text-center align-middle">${debateBoard.deViewCnt}</td>
						</tr>
					</c:forEach>


				</tbody>

			</table>
			</div>
		</div>

		<div class="card-body text-center pt-0">
			<%@include file="/WEB-INF/views/common/pagination.jsp"%>
		</div>


	</section>

	<form id="searchForm">
		<input type="hidden" name="page" value="" />
		<input type="hidden" name="searchType" value="" />
		<input type="hidden" name="keyword" value="" />
	</form>


	<script>
	function fn_list(page, url) {
		if (!url)
			url = "list.do";
	
		var searchForm = $('#searchForm');
	
		searchForm.find("[name='page']").val(page);
		searchForm.find("[name='searchType']").val(
				$('select[name="searchType"]').val());
		searchForm.find("[name='keyword']").val(
				$('input[name="keyword"]').val());
	
		searchForm.attr({
			action : url,
			method : 'get'
		}).submit();
	}

</script>

</body>