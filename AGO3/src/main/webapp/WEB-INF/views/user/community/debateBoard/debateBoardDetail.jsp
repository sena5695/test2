<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${pageMaker.cri }" />
<c:set var="debateReplyList" value="${dataMap.debateReplyList }" />
<c:set var="memId" value="${memId}" />
<c:set var="url" value="detail.do" />

<head></head>

<title></title>

<body>
	<!-- 메인 바디 -->
	<!-- Main content -->
	<section class="content" style="width: 1250px; margin: 0 auto;">
		<div class="container-fluid">

			<div class="col-md-12">
				<!-- Box Comment -->
				<div class="card-widget">
					<div class="card-header row">
						<div class="user-block col-12">
							<div class="row mb-2">
								<div class="col-sm-6">
									<p class="text-secondary">토론게시판</p>
								</div>
								<div class="col-sm-6">
									<ol class="breadcrumb float-sm-right m-0 p-0" style="background-color : white;">
										<li class="breadcrumb-item">
											<i class="fas fa-home"></i>
										</li>
										<li class="breadcrumb-item">
											<a href="<%=request.getContextPath()%>/user/community/freeBoard/list.do">커뮤니티</a>
										</li>
										<li class="breadcrumb-item active">토론게시판</li>
									</ol>
				
								</div>
							</div>
							<div class="buttons row">
								<p class="h5  pl-1">${debateBoard.deTitle }</p>
							</div>
							<p class="text-secondary m-0">
								<b>${debateBoard.memId }</b>
							</p>

							<div class="d-block">
								<p class="text-secondary float-left mb-0">
									<fmt:formatDate value="${debateBoard.deRegdate}" pattern="yyyy-MM-dd" />
									&nbsp;| &nbsp;
								</p>
								<p class="text-secondary float-left mb-0">조회&nbsp;${debateBoard.deViewCnt}</p>
								<div class="justify-content-end float-right" id="tools">
									<a href="#replies-wrapper">
										<button type="button" class="btn btn-tool" data-spy="scroll" style="color: #007bff;">
											<i class="far fa-comment-dots mr-2"></i>댓글&nbsp;<span class="font-weight-bold">${debateBoard.replyCnt }</span>
										</button>
									</a>
										<c:if test="${memId  eq debateBoard.memId}">
											<button type="button" class="btn btn-tool" onclick="location.href='modifyForm.do?dboardNo=${debateBoard.dboardNo}'">
												<i class="far fa-edit text-success"></i><span class="text-success font-weight-bold">&nbsp;수정&nbsp;</span>
											</button>
											<button type="button" class="btn btn-tool" onclick="fn_remove();">
												<i class="fas fa-eraser text-danger"></i><span class="text-danger font-weight-bold">&nbsp;삭제&nbsp;</span>
											</button>
										</c:if>
									<c:if test="${memId ne debateBoard.memId }">
										<button type="button" class="btn btn-tool text-danger" onclick="fn_report(${debateBoard.dboardNo});">
											<i class="fas fa-bullhorn mr-2 text-danger"></i>신고 &nbsp;<span class="text-danger font-weight-bold reportCnt">${debateBoard.deReportCnt }</span>
										</button>
									</c:if>
									<button class="btn btn-tool" onclick="location.href='list.do'">
										<i class="fas fa-solid fa-list-ul"></i><span class="pl-1 font-weight-bold text-black">목록</span> 
									</button>
								</div>
							</div>
						</div>

					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<div class="content" style="min-height: 500px;">${debateBoard.deContent}</div>
					</div>
					<!-- /.card-body -->

					<!--댓글-->
					<div class="card-footer card-comments replies-wrapper" id="replies-wrapper">
						<!--댓글-->
						<div class="replies">
							<c:forEach var="debateReply" items="${debateReplyList}" varStatus="status">
								<c:if test="${status.first}">
									<c:if test="${debateReply.dereplyPreantNo eq 0}">
									<div class="card-comment reply-div">
										<div class="comment-text">
											<div class="username" id="username">
												<span class="username">${debateReply.memId}
													<div class="float-right dropdown">
														<span class="text-muted float-left mr-3" style="cursor: pointer;" onclick="showInputForm(${debateReply.dereplyNo})">답글쓰기</span> 
														<span class="text-muted float-left mr-3"> <fmt:formatDate value="${debateReply.dereplyRegdate}" pattern="yyyy-MM-dd" />
														</span>
														<c:if test="${memId eq debateReply.memId }">
															<span class="font-weight-bold" href="#" role="button" id="dropdownOption" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style=""> <i class="fas fa-ellipsis-v text-secondary"></i>
															</span>

															<div class="dropdown-menu dropdown-menu-sm dropdown-menu-right" aria-labelledby="dropdownOption" style="left: inherit; right: 0px;">
																<a onclick="fn_modifyForm(${debateReply.dereplyNo})" class="dropdown-item">수정</a>
																<a onclick="deleteReply(${debateReply.dereplyNo},${debateReply.dereplyPreantNo })" class="dropdown-item">삭제</a>
															</div>
														</c:if>
													</div>
												</span>
											</div>
											<span id="${debateReply.dereplyNo}spanContent">${debateReply.dereplyContent}</span>
											<form role="${debateReply.dereplyNo }modifyForm" action="modifyReply.do" method="post">
												<div id="${debateReply.dereplyNo}modifydiv" class="row mt-2 ml-1" style="display: none;">
													<input type="hidden" name="dereplyNo" value="${debateReply.dereplyNo}"> 
													<input type="hidden" name="dereplyPreantNo" value="${debateReply.dereplyPreantNo}"> 
													<input type="text" class="form-control form-control-sm col-9" name="dereplyContent" value="${debateReply.dereplyContent}">
													<button type="button" class="btn btn-primary btn-sm" onclick="modifyReply(${debateReply.dereplyNo})">댓글 수정</button>
												</div>
											</form>
										</div>
									</c:if>
									
									<c:if test="${debateReply.dereplyPreantNo ne 0}">
										<div class="m-4 reReply-wrapper">
											<div class="m-4">
												<i class="fas fa-reply fa-rotate-180 img-circle img-sm text-secondary"></i>
												<div class="comment-text bg-white p-2">
													<span class="username">${debateReply.memId}
														<div class="float-right dropdown">
		
															<span class="text-muted float-left mr-3"> <fmt:formatDate value="${debateReply.dereplyRegdate}" pattern="yyyy-MM-dd" />
															</span>
															<c:if test="${memId eq debateReply.memId }">
																<span class="font-weight-bold" href="#" role="button" id="dropdownOption" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style=""> <i class="fas fa-ellipsis-v text-secondary"></i>
																</span>
		
																<div class="dropdown-menu dropdown-menu-sm dropdown-menu-right" aria-labelledby="dropdownOption" style="left: inherit; right: 0px;">
																	<a onclick="fn_modifyForm(${debateReply.dereplyNo})" class="dropdown-item">수정</a>
																	<a onclick="deleteReply(${debateReply.dereplyNo },${debateReply.dereplyPreantNo })" class="dropdown-item">삭제</a>
																</div>
															</c:if>
														</div>
													</span> <span id="${debateReply.dereplyNo}spanContent">${debateReply.dereplyContent}</span>
													<form style="width: 100%;" role="${debateReply.dereplyNo }modifyForm" action="modifyReply.do" method="post">
														<div id="${debateReply.dereplyNo}modifydiv" class="row mt-2 ml-1" style="display: none;">
															<input type="hidden" name="dereplyNo" value="${debateReply.dereplyNo}"> 
															<input type="hidden" name="dereplyPreantNo" value="${debateReply.dereplyPreantNo}"> 
															<input type="text" class="form-control form-control-sm col-9" name="dereplyContent" value="${debateReply.dereplyContent}">
															<button type="button" class="btn btn-primary btn-sm" onclick="modifyReply(${debateReply.dereplyNo})">수정</button>
														</div>
													</form>
												</div>
		
		
											</div>
										</div>									
									</c:if>
									
									
								</c:if>
								<c:if test="${status.index ne 0}">
									<c:if test="${debateReply.dereplyPreantNo eq 0}">
										<form role="${status.index}reReplyForm" method="post">
											<input type="hidden" name="dboardNo" value="${debateReply.dboardNo }"> 
											<input type="hidden" name="dereplyPreantNo" value="${debateReply.prevReply }"> 
											<input type="text" class="form-control col-2" id="${status.index}replyer" style="display: none;">
											<div class="row m-4" style="display : none;" id="${debateReply.prevReply}inputForm">
												<i class="fas fa-reply fa-rotate-180 img-circle img-sm text-secondary"></i>
												<input type="text" class="form-control form-control-sm col-9 ml-2 mt-2" id="reply" name="dereplyContent" placeholder="댓글을 입력하세요">
												<button class="btn btn-primary btn-sm form-control-sm mt-2" type="button" onclick="reReply(${status.index});">답글 쓰기</button>
											</div>
										</form>
						</div>
						<div class="card-comment reply-div">
							<div class="comment-text">
								<div class="username" id="username">
									<span class="username">${debateReply.memId}
										<div class="float-right dropdown">
											<span class="text-muted float-left mr-3" style="cursor: pointer;" onclick="showInputForm(${debateReply.dereplyNo})">답글쓰기</span> <span class="text-muted float-left mr-3"> <fmt:formatDate value="${debateReply.dereplyRegdate}" pattern="yyyy-MM-dd" />
											</span>
											<c:if test="${memId eq debateReply.memId }">
												<span class="font-weight-bold" href="#" role="button" id="dropdownOption" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style=""> <i class="fas fa-ellipsis-v text-secondary"></i>
												</span>

												<div class="dropdown-menu dropdown-menu-sm dropdown-menu-right" aria-labelledby="dropdownOption" style="left: inherit; right: 0px;">
													<a onclick="fn_modifyForm(${debateReply.dereplyNo})" class="dropdown-item">수정</a>
													<a onclick="deleteReply(${debateReply.dereplyNo},${debateReply.dereplyPreantNo })" class="dropdown-item">삭제</a>
												</div>
											</c:if>
										</div>
									</span>
								</div>
								<span id="${debateReply.dereplyNo}spanContent">${debateReply.dereplyContent}</span>
								<form role="${debateReply.dereplyNo }modifyForm" action="modifyReply.do" method="post">
									<div id="${debateReply.dereplyNo}modifydiv" class="row mt-2 ml-1" style="display: none;">
										<input type="hidden" name="dereplyNo" value="${debateReply.dereplyNo}"> 
										<input type="hidden" name="dereplyPreantNo" value="${debateReply.dereplyPreantNo}"> 
										<input type="text" class="form-control form-control-sm col-9" name="dereplyContent" value="${debateReply.dereplyContent}">
										<button type="button" class="btn btn-primary btn-sm" onclick="modifyReply(${debateReply.dereplyNo})">댓글 수정</button>
									</div>
								</form>
							</div>
							</c:if>
							<c:if test="${debateReply.dereplyPreantNo ne 0}">
								<div class="m-4 reReply-wrapper">
									<div class="m-4">
										<i class="fas fa-reply fa-rotate-180 img-circle img-sm text-secondary"></i>
										<div class="comment-text bg-white p-2">
											<span class="username">${debateReply.memId}
												<div class="float-right dropdown">

													<span class="text-muted float-left mr-3"> <fmt:formatDate value="${debateReply.dereplyRegdate}" pattern="yyyy-MM-dd" />
													</span>
													<c:if test="${memId eq debateReply.memId }">
														<span class="font-weight-bold" href="#" role="button" id="dropdownOption" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style=""> <i class="fas fa-ellipsis-v text-secondary"></i>
														</span>

														<div class="dropdown-menu dropdown-menu-sm dropdown-menu-right" aria-labelledby="dropdownOption" style="left: inherit; right: 0px;">
															<a onclick="fn_modifyForm(${debateReply.dereplyNo})" class="dropdown-item">수정</a>
															<a onclick="deleteReply(${debateReply.dereplyNo },${debateReply.dereplyPreantNo })" class="dropdown-item">삭제</a>
														</div>
													</c:if>
												</div>
											</span> <span id="${debateReply.dereplyNo}spanContent">${debateReply.dereplyContent}</span>
											<form style="width: 100%;" role="${debateReply.dereplyNo }modifyForm" action="modifyReply.do" method="post">
												<div id="${debateReply.dereplyNo}modifydiv" class="row mt-2 ml-1" style="display: none;">
													<input type="hidden" name="dereplyNo" value="${debateReply.dereplyNo}"> 
													<input type="hidden" name="dereplyPreantNo" value="${debateReply.dereplyPreantNo}"> 
													<input type="text" class="form-control form-control-sm col-9" name="dereplyContent" value="${debateReply.dereplyContent}">
													<button type="button" class="btn btn-primary btn-sm" onclick="modifyReply(${debateReply.dereplyNo})">수정</button>
												</div>
											</form>
										</div>


									</div>
								</div>
							</c:if>
							</c:if>
							<c:if test="${status.last}">
								<form role="${status.index+1}reReplyForm" method="post" style="">
									<input type="hidden" name="dboardNo" value="${debateReply.dboardNo }"> 								
									<c:choose>
										<c:when test="${debateReply.dereplyPreantNo eq 0}">
											<input type="hidden" name="dereplyPreantNo" value="${debateReply.dereplyNo }">
										</c:when>
										<c:when test="${debateReply.dereplyPreantNo ne 0}">
											<input type="hidden" name="dereplyPreantNo" value="${debateReply.dereplyPreantNo}">
										</c:when>										
									</c:choose>										
									<input type="text" class="form-control col-2" id="${status.index}replyer" style="display: none;">
									<c:choose>
										<c:when test="${debateReply.dereplyPreantNo eq 0}">
											<div class="row m-4" style="display : none;" id="${debateReply.dereplyNo}inputForm">
										</c:when>
										<c:when test="${debateReply.dereplyPreantNo ne 0}">
											<div class="row m-4" style="display : none;" id="${debateReply.dereplyPreantNo}inputForm">
										</c:when>										
									</c:choose>		
											<i class="fas fa-reply fa-rotate-180 img-circle img-sm text-secondary"></i>
											<input type="text" class="form-control form-control-sm col-9 ml-2 mt-2" id="reply" name="dereplyContent" placeholder="댓글을 입력하세요">
											<button class="btn btn-primary btn-sm form-control-sm mt-2" type="button" onclick="reReply(${status.index +1});">답글 쓰기</button>
										</div>
								</form>
						</div>
						</c:if>

						</c:forEach>
					</div>
					<form role="registReplyForm" method="post" action="regist.do">
						<input type="hidden" name="dboardNo" value="${debateBoard.dboardNo }" />
						<div class="form-group d-inline-flex col-12 mt-3">
							<input type="text" class="form-control" id="replyer" style="display: none;"> <input type="text" class="form-control form-control-sm col-11" id="reply" name="dereplyContent" placeholder="댓글을 입력하세요">
							<button class="btn btn-primary btn-sm" type="button" onclick="registReply();">댓글 쓰기</button>
						</div>

					</form>
					<c:if test="${not empty debateReplyList}">
						<div class='text-center'>
							<ul id="pagination" class="pagination justify-content-center mt-4 mb-2">
								<%@include file="/WEB-INF/views/common/pagination.jsp"%>
							</ul>
						</div>
					</c:if>
				</div>
				<!--/댓글-->
			</div>
		</div>
		</div>
	</section>
	<form role="form">
		<input type="hidden" name="dboardNo" value="${debateBoard.dboardNo }" />
	</form>		
<form role="deleteForm" action="delete.do" method="post">
	<input type="hidden" name="dboardNo" value="${debateBoard.dboardNo}">
</form>
	<script>
	
	function showInputForm(index){
		var divv = $('#'+index+'inputForm');
		divv.css("display","");
	}
	
	
	
	function reReply(index){
		form = $('form[role='+index+'reReplyForm]')[0];
		formData = new FormData(form);
			
		
		$.ajax({
			url 		: 'registReply.do',
			data 		: formData,
			type 		: 'post',
			processData : false,
			contentType : false,
			success 	: function(data){
				console.log(data);
				alert(data);
				location.reload();
			},
			error 		: function(error){
				
				console.log(error.status);
				AjaxErrorSecurityRedirectHandler(error.status);
			}
		})			
	}
	function registReply(){
		form = $('form[role=registReplyForm]')[0];
		formData = new FormData(form);
			
		
		$.ajax({
			url 		: 'registReply.do',
			data 		: formData,
			type 		: 'post',
			processData : false,
			contentType : false,
			success 	: function(data){
				console.log(data);
				alert(data);
				location.reload();
			},
			error 		: function(error){
				
				console.log(error.status);
				AjaxErrorSecurityRedirectHandler(error.status);
			}
		})			
	}	
	
		function fn_remove() {
			let form = document.querySelector('form[role="form"]');
			let check = confirm("정말 삭제하시겠습니까?");
			if (check) {

				form.setAttribute("action", "delete.do");
				form.setAttribute("method", "post");

				form.submit();
			}
		}
		
		function deleteReply(dereplyNo,preant){
			
			$.ajax({
				url 		: 'deleteReply.do?dereplyNo='+dereplyNo+'&preant='+preant,
				type 		: 'post',
				processData : false,
				contentType : false,
				success 	: function(data){
					console.log(data);
					alert(data);
					location.reload();
				},
				error 		: function(error){
					
					console.log(error.status);
					AjaxErrorSecurityRedirectHandler(error.status);
				}
			})		
		}	
		
		function fn_modifyForm(index){
			$('#'+index+'spanContent').hide();
			$('#'+index+'modifydiv').css("display","");
		}
		
		
		function modifyReply(index){
			form = $('form[role='+index+'modifyForm]')[0];
			formData = new FormData(form);
				
			
			$.ajax({
				url 		: 'modifyReply.do',
				data 		: formData,
				type 		: 'post',
				processData : false,
				contentType : false,
				success 	: function(data){
					console.log(data);
					alert(data);
					location.reload();
				},
				error 		: function(error){
					
					console.log(error.status);
					AjaxErrorSecurityRedirectHandler(error.status);
				}
			})			
		}
		
		function fn_report(dboardNo){
			if(confirm("이 게시글을 신고하시겠습니까?")){
				$.ajax({
					url : 'report.do',
					type : "post",
					data : {"dboardNo":dboardNo},
					success : function(data){
						document.querySelector('.reportCnt').innerHTML = data;
					},
					error:function(error){
						alert("실패")
					}
				});
			}
		}
	</script>
</body>