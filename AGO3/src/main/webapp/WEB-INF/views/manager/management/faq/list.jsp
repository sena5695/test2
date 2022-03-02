<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="faqList" value="${dataMap.faqList }" />
<head></head>

<title></title>

<body>
	<div class="container-fluid">
		<div class="row navList mt-2 mb-2">
			<h4 class="col-9 m-0">자주 묻는 질문</h4>
			<div class="col-3 text-right pt-2">
				<i class="fas fa-home" style="font-size: 15px;"></i>
				<span> &nbsp;>&nbsp; </span>
				<span>운영관리</span>
				<span> &nbsp;>&nbsp; </span>
				<span>자주 묻는 질문</span>
			</div>
		</div>
		<div class="input-group justify-content-end col-12 p-0 mb-1">
			<div class="p-0 m-0 text-left col-5 float-left">
				<button type="button" class="btn btn-block btn-secondary btn-sm col-2 float-left" onclick="location.href='registForm.do'">등록</button>
			</div>
			<div class="d-flex col-7 justify-content-end p-0">
				<select class="col-md-2 form-control" name="searchType">
					<option value="tc" ${cri.searchType eq 'tc' ? 'selected':'' } selected="selected">전체</option>
					<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>제목</option>
					<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>내용</option>
				</select>
				<input type="text" placeholder="검색할 단어를 입력하세요" class="form-control col-md-7" name="keyword" value="${ cri.keyword }" />
				<button class="col-md-1 btn btn-secondary float-right" onclick="list_go(1);">검색</button>
			</div>
		</div>
		<div class="col-6 float-left">
			<span class="text-muted" style="color: gray; cursor: pointer;" onclick="sort('a');">전체</span>
			<span class="text-muted" style="color: gray;">&nbsp;|&nbsp;</span>
			<span class="text-muted" style="color: gray; cursor: pointer;" onclick="sort('i');">중요공지</span>
			<input type='text' id='sort' name='sortType' value="${ cri.sortType }" hidden="hidden" />
		</div>
		<table id="maincontent" class="table table-sm table-hover m-0 mb-1">
			<thead>
				<tr class="text-center">
					<th scope="col" style="width: 20%;">문의번호</th>
					<th scope="col" style="width: 60%;">문의제목</th>
					<th scope="col" style="width: 20%;">문의분류</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty faqList }">
					<tr>
						<td colspan="3">
							<strong>해당 내용이 없습니다.</strong>
						</td>
					</tr>
				</c:if>
				<c:forEach items="${ faqList }" var="faq">
					<tr>
						<td class="text-center">${ faq.faqNo }</td>
						<td id="title" style="cursor: pointer;" onclick="location.href='detail.do?faqNo=${ faq.faqNo }';">${ faq.faqQuestion }</td>
						<c:if test="${ faq.askSort eq 'c' }">
							<td class="text-center">수료 문의</td>
						</c:if>
						<c:if test="${ faq.askSort eq 'l' }">
							<td class="text-center">학습 문의</td>
						</c:if>
						<c:if test="${ faq.askSort eq 'e' }">
							<td class="text-center">기타</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@include file="/WEB-INF/views/common/pagination.jsp"%>
	</div>
</body>