<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="debateBoardList" value="${dataMap.debateBoardList }" />

<head></head>
<title></title>
<body>

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
							<a href="<%=request.getContextPath() %>/manager/free/list.do">게시판관리</a>
						</li>
						<li class="breadcrumb-item active">토론게시판</li>
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
				<div class="row col-8 justify-content-end p-0 mr-1">
					<select class="col-md-2 form-control" name="searchType" id="searchType" style="height: 39px;">
						<option value="a" ${cri.searchType eq 'a' ? 'selected': '' }>전체</option>
						<option value="t" ${cri.searchType eq 't' ? 'selected': '' }>제목</option>
						<option value="c" ${cri.searchType eq 'c' ? 'selected': '' }>내용</option>
						<option value="w" ${cri.searchType eq 'w' ? 'selected': '' }>작성자</option>
					</select>
					<input type="text" placeholder="검색할 단어를 입력하세요." name="keyword" class="form-control col-md-7">
					<button class="col-md-1 btn btn-secondary float-right" onclick="fn_list(1);">검색</button>
				</div>
			</div>
			<div class="pb-2 pt-2">
				<span class="text-muted" style="color: gray; cursor: pointer;" onclick="fn_list(1);">전체</span> 
				<span class="text-muted" style="color: gray;">&nbsp;|&nbsp;</span> 
				<span class="text-muted" style="color: gray; cursor: pointer;" id="sortOption" data-sort="r" onclick="fn_sort(1);">신고된 게시물</span>
<!-- 				<span  class="float-right text-danger" style="cursor: pointer;"  data-toggle="modal" data-target="#modal-danger" > -->
				<span  class="float-right text-danger" style="cursor: pointer;" onclick="fn_remove();" >
					삭제
				</span>
			</div>
			
			<div style="height:530px;">
			<table class="table table-sm table-hover">
		
				<thead>
					<tr class="text-center" style="background-color: #F5F4F4;">
						<th style="width:20px;"><input type="checkbox" class="check-all"></th>
						<th style="width:30px;">번호</th>
						<th style="width:230px;">제목</th>
						<th class="text-left" style="width:40px;">작성자</th>
						<th style="width:40px;">등록날짜</th>
						<th style="width:40px;">조회수</th>
						<th style="width:30px;">신고횟수</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty debateBoardList }">
						<tr>
							<td colspan="6" class="text-center">
								<strong>해당 내용이 없습니다.</strong>
							</td>
						</tr>
					</c:if>
					<c:forEach items="${ debateBoardList }" var="debateBoard">
						<tr  style="cursor: pointer;">
							<td class="text-center">
								<input type="checkbox" class="individual_check_boxes" name="impt" data-no="${debateBoard.dboardNo}">
							</td>
							<td class="text-center">${debateBoard.dboardNo}</td>
							<td onclick="location.href='detail.do?dboardNo=${debateBoard.dboardNo}'"style="cursor: pointer;">
								<c:choose>
									<c:when test="${fn:length( debateBoard.deTitle) gt 40}">
										<c:out value="${fn:substring( debateBoard.deTitle,0,40) }..." ></c:out>
									</c:when>
									<c:otherwise>
										${ debateBoard.deTitle}
									</c:otherwise>
								</c:choose>
								<c:if test="${debateBoard.replyCnt > 0 }">
									<span class="text-primary">[${debateBoard.replyCnt }]</span>
								</c:if>
								<span></span>
							</td>
							<td class="text-left">${debateBoard.memId }</td>
							<td class="text-center">
								<fmt:formatDate value="${debateBoard.deRegdate}" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center">${debateBoard.deViewCnt}</td>
							<td class="text-center text-danger">${debateBoard.deReportCnt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
			<!-- </div> -->

				<%@include file="/WEB-INF/views/common/pagination.jsp"%>
		</div>
	</section>
	
	<div class="modal fade" id="modal-danger" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">선택한 항목들을 진짜로 삭제하시겠습니까?</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">×</span>
              </button>
            </div>
            <div class="modal-body">
            	<span>선택한 게시물의 번호를 입력해 주세요.</span><br>
            	<span class="text-danger">*번호는 공백으로 구분해주세요. 예)12 35 5 20</span>
            	<input type="text" id="deleteDeboardNo" autocomplete='off' style="width:100%; height:50px; outline:none;">
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-danger" onclick="fn_remove();">확인</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>

	<form id="sortForm">
		<input type="hidden" name="page" value="" />
		<input type="hidden" name="sortType" value="" />
	</form>
	<form id="searchForm">
		<input type="hidden" name="page" value="" />
		<input type="hidden" name="searchType" value="" />
		<input type="hidden" name="keyword" value="" />
	</form>
	<script>
		$(document).ready(function() {
			$('.check-all').click(function() {
				$('.individual_check_boxes').prop('checked', this.checked);
			});
		});
		$('.modal').on('hidden.bs.modal', function (e) {
			 $('#deleteDeboardNo').val('');
		});
		

		function fn_sort(page, url) {
			if (!url)
				url = "sortList.do";

			let sortForm = $('#sortForm');
			let sortOption = document.getElementById('sortOption')
					.getAttribute('data-sort');
			console.log(sortOption);
			sortForm.find("[name='page']").val(page);
			sortForm.find("[name='sortType']").val(sortOption).val();

			sortForm.attr({
				action : url,
				method : 'get'
			}).submit();
		}

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
		
		function fn_remove() {
			if(confirm("삭제하시겠습니까?")){
				let chkVal = [];
				if(!(!!$("input:checkbox[name='impt']:checked").attr('data-no'))){
					alert('항목을 선택 후 삭제를 눌러주세요.');
					return;
				}
				
				if($("input:checkbox[name='impt']:checked")){
					$("input:checkbox[name='impt']:checked").each(function() {
						chkVal.push($(this).attr( 'data-no' ));
					});
					location.href = "listremove.do?dboardNo=" + chkVal;
				}
			}
// 			let deleteDeboardNo = document.getElementById('deleteDeboardNo').value;
// 			var deboardNoArr = deleteDeboardNo.split(' ');
// 			let deleteNoSet = new Set(deboardNoArr);
// 			let uniqueDeleteNo = [...deleteNoSet];
// 			let chkVal = [];
// 			if(!(!!$("input:checkbox[name='impt']:checked").attr('data-no'))){
// 				alert('항목을 선택 후 삭제를 눌러주세요.');
// 				return;
// 			}
// 			if(!(!!deleteDeboardNo)){
// 				alert('삭제할 게시물 번호를 작성해주세요.');
// 				return;
// 			}
// 			$("input:checkbox[name='impt']:checked").each(function() {
// 				chkVal.push($(this).attr('data-no'));
// 			});
// 			var count = chkVal.length;
// 			for (step = 0; step < uniqueDeleteNo.length; step++) {
// 				if ($("input:checkbox[name='impt']:checked")) {
// 					$("input:checkbox[name='impt']:checked").each(function() {
// 						if($(this).attr('data-no') == uniqueDeleteNo[step]){
// 							count = count - 1;
// 						}
// 					});
// 				} else{
// 					return;
// 				}
// 			}
// 			if(deboardNoArr.length != chkVal.length){
// 				alert('선택한 항목과 작성한 항목의 개수가 다릅니다.');
// 				return;
// 			}
// 			if(count == 0){
// 				alert("선택한 항목을 삭제합니다.");
// 				$('#deleteDeboardNo').val('');
// 				location.href = "listremove.do?dboardNo=" + chkVal;
// 			} else{
// 				alert("번호 입력이 잘못 되었습니다.");
// 			}
		}
	</script>
</body>


















