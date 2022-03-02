<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="noticeList" value="${dataMap.noticeList }" />
<c:set var="imptNoticeList" value="${dataMap.imptNoticeList }" />
<head></head>

<title></title>

<body style="text-align: center;">
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">공지사항</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/user/management/notice/list.do">학습지원실</a>
						</li>
						<li class="breadcrumb-item">공지사항</li>
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

			<div class="input-group justify-content-end col-12 p-0 mb-1">
				<div class="p-0 m-0 text-left col-5 float-left"></div>
				<div class="row col-8 justify-content-end p-0 mr-1">
					<select class="col-md-2 form-control" name="searchType">
						<option value="tc" ${cri.searchType eq 'tc' ? 'selected':'' }>전체</option>
						<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>제목</option>
						<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>내용</option>
					</select>
					<input type="text" placeholder="검색할 단어를 입력하세요" name="keyword" class="form-control col-md-7" value="${ param.keyword }">
					<button class="col-md-1 btn btn-primary float-right" onclick="list_go(1);">검색</button>
				</div>
			</div>

			<table class="table table-hover table-sm col m-0 mt-2">
				<thead>
					<tr class="text-center" style="background-color:#E6EFFC;">
						<th style="width:60px;">번호</th>
						<th style="width:180px;">제목</th>
						<th style="width:60px;">조회수</th>
						<th style="width:90px;">등록날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty imptNoticeList }">
						<c:forEach items="${imptNoticeList }" var="notice">
							<tr style="background-color: #FEDFDA;" class="text-danger">
								<td class="text-center">${notice.noticeNo }</td>
								<td class="row" onclick="location.href='detail.do?noticeNo=${notice.noticeNo}&from=list'">
									
									<div style="cursor: pointer; max-width: 720px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
										<i class="fas fa-bullhorn"></i>&nbsp;[중요]&nbsp;${notice.noticeTitle }
									</div>
									<c:if test="${not empty notice.attachList }">
										<div style="cursor: pointer; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
											<i class="fas fa-file-alt ml-1"></i>
										</div>
									</c:if>
								</td>
								<td class="text-center">${notice.noticeViewCnt}</td>
								<td class="text-center">${notice.noticeRegdate}</td>
							</tr>
						</c:forEach>
					</c:if>

					<c:if test="${empty noticeList }">
						<tr class="text-center">
							<td colspan="6">공지사항이 없습니다.</td>
						</tr>
					</c:if>


					<c:if test="${not empty noticeList }">
						<c:forEach items="${noticeList }" var="notice">
							<tr>
								<td class="text-center">${notice.noticeNo }</td>
								<td class="row" onclick="location.href='detail.do?noticeNo=${notice.noticeNo}&from=list'" >	
									<div style="cursor: pointer; max-width: 730px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
										${notice.noticeTitle }
									</div>
									<c:if test="${not empty notice.attachList }">
										<div style="cursor: pointer; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
											<i class="fas fa-file-alt ml-1"></i>
										</div>
									</c:if>
								</td>
								<td class="text-center">${notice.noticeViewCnt}</td>

								<td class="text-center">${notice.noticeRegdate}</td>
							</tr>
						</c:forEach>
					</c:if>

				</tbody>
			</table>

			<%@include file="/WEB-INF/views/common/pagination.jsp"%>
		</div>
	</section>
	<script type="text/javascript">
			$( document ).ready( function() {
			  $( '.check-all' ).click( function() {
			    $( '.individual_check_boxes' ).prop( 'checked', this.checked );
			  });
			});
			
			function sort(sort) {
				$('#sort').val(sort);
				list_go(1);
			}
			
			function detail(num) {
				location.href = "detail.do";
			}
			
			function remove() {
				let chkVal = [];
				$("input:checkbox[name=impt]:checked").each(function() {
					chkVal.push($(this).val());
				});
				// console.log(chk_Val);
				//alert($("input[name='impt']:checked").val());
				 location.href="remove.do?noticeNo=" + chkVal;
			}
			
		</script>
</body>