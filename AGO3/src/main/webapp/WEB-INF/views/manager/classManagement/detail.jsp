<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="classDetail" value="${dataMap.detail}" />
<c:set var="chapterList" value="${dataMap.chapterList }" />
<c:set var="documentList" value="${dataMap.documentList1 }" />
<c:set var="reviewList" value="${dataMap.reviewList }" />
<c:set var="opcl" value="${dataMap.opcl }" />
<c:set var="pageMaker" value="${dataMap3.pageMaker }" />
<c:set var="cri" value="${dataMap3.pageMaker.cri}" />
<c:set var="memList" value="${dataMap3.memList }" />
<c:set var="classVO" value="${dataMap.classVO }" />
<c:set var="openRound" value="${openRound }"/>
<head></head>

<title></title>

<body>
<script type="text/javascript">
	if(${message ne null}){
		alert("${message}");
	} else {}

</script>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<%-- 					<h4 class="m-0">[${opcl.openRound}회]${classDetail.clName}</h4> --%>
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
						<li class="breadcrumb-item active">강의 상세</li>
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
	<section class="content">
		<div class="container-fluid">
			<section class="col-12">
				<div class="row">
					<div class="class-detail d-flex col-11 ">
						<div style="width: 200px; height: 150px;" id="pictureView"></div>
						<div class="column ui-sortable">
							<span class="h4 ml-2">[${opcl.openRound}회]</span> <span class="h4 font-bold ml-2">${classDetail.clName}</span> <span class="badge badge-primary ml-3"> ${classDetail.clFormat} </span> <span class="badge badge-danger"> ${classDetail.clDivision} </span> <br> <span class="ml-2"> <c:if test="${classDetail.clCate  == 'A201'}">[신입사원교육]</c:if> <c:if test="${classDetail.clCate  == 'A202'}">[일반교육]</c:if> <c:if test="${classDetail.clCate  == 'A203'}">[자기개발/취미]</c:if>
							</span> <br><br>
					<span class="row h5 m-0 py-1 ml-1 mb-1 mt-1 text-warning">
						<c:forEach var="i" begin="1" end="${classVO.frontScope}">
							<i class="fas fa-star"></i>
						</c:forEach>
						<c:if test="${classVO.backScope >= 5}">
							<i class="fas fa-star-half-alt"></i>
						</c:if>
						<c:forEach var="i" begin="1" end="${classVO.restScope}">
							<i class="far fa-star"></i>
						</c:forEach>
						<span>
							<c:if test="${classVO.scope > 0}">
								(<fmt:formatNumber value="${classVO.scope}" pattern=".00"></fmt:formatNumber>)
							</c:if>
							<c:if test="${classVO.scope < 1}">
								(${classVO.scope})
							</c:if>
						</span>

					</span>
							<c:if test="${classDetail.clFormat == '오프라인'}">
								<button type="button" class="btn btn-secondary btn-sm ml-2" onclick="OpenWindow('getQR.do?clCode=${classDetail.clCode}&opcl=${opcl.opcl }','QR코드생성',800,700)">QR코드 생성</button>
							</c:if>
							<c:if test="${classDetail.clFormat == '실시간'}">
								<button type="button" class="btn btn-secondary btn-sm ml-2" onclick="OpenWindow('https://192.168.143.25:8443/create.html?room=${opcl.opcl }&name=${ loginManager.memName }','',1600,1300)">실시간 강의 생성</button>
							</c:if>
						</div>
					</div>
					<div class="d-block justify-content-end">
						<div style="height:100px;">
							<button class="btn btn-default btn-sm float-right" onclick="location.href='list.do'">목록</button>
						</div>
						<div>
							<button class="btn btn-primary btn-sm float-left mr-1" onclick="location.href='modifyClass.do?clCode=${classDetail.clCode}&openRound=${opcl.openRound }&opclNo=${opcl.opcl }'">수정</button>
							<button class="btn btn-default btn-sm float-right" onclick="deleteClass(${classDetail.clCode},${opcl.openRound})">삭제</button>
						</div>
					</div>
				</div>
			</section>

			<br>
			<div class="col-12">
				<div class="card card-primary card-outline card-outline-tabs">
					<div class="card-header p-0 border-bottom-0">
						<ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" id="custom-tabs-four-home-tab" data-toggle="pill" href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home" aria-selected="true">기본정보</a>
							</li>
							<c:if test="${classDetail.clFormat eq '온라인'}">
							<li class="nav-item">
								<a class="nav-link" id="custom-tabs-four-profile-tab" data-toggle="pill" href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" aria-selected="false">강의목차</a>
							</li>
							</c:if>
							<li class="nav-item">
								<a class="nav-link" id="custom-tabs-four-profile-tab" data-toggle="pill" href="#custom-tabs-four-attach" role="tab" aria-controls="custom-tabs-four-attach" aria-selected="false">자료실</a>
							</li>
						</ul>
					</div>
					<div class="card-body" style="min-height: 600px;">
						<div class="tab-content" id="custom-tabs-four-tabContent">
							<div class="tab-pane fade active show" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">


								<section id="calssInfo">
									<table class="table mt-3 table-sm col-12">
										<tr>
											<td class="font-weight-bold text-center align-middle col-2" style="background-color: #E6EFFC;">과정소개</td>
											<td colspan="3" class="pl-3">
												<p style="white-space: pre-wrap;">${classDetail.clIntro }</p>
											</td>
										</tr>
										<tr>
											<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">수강인원</td>
											<td class="pl-3">${opcl.enrPers}</td>
											<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">강의이수시간</td>
											<td class="pl-3">${classDetail.clCreditTime }</td>
										</tr>
										<tr>
											<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">신청기간</td>
											<td class="pl-3"><fmt:formatDate value="${opcl.postSdate }" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${opcl.postEdate }" pattern="yyyy-MM-dd" /></td>
											<c:if test="${classDetail.clFormat eq '온라인'}">
											<td class="font-weight-bold text-center align-middle pl-3" style="background-color: #E6EFFC;">학습기간</td>
												<td>
													<c:if test="${opcl.studyDate == 'D101'}">신청일로부터 7일</c:if>
													<c:if test="${opcl.studyDate == 'D102'}">신청일로부터 30일</c:if>
													<c:if test="${opcl.studyDate == 'D103'}">제한없음</c:if>
												</td>
											</c:if>
											<c:if test="${classDetail.clFormat eq '오프라인' || classDetail.clFormat eq '실시간' }">
												<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">학습날짜</td>
												<td class="pl-3"><fmt:formatDate value="${opcl.lecDate }" pattern="yyyy-MM-dd a HH:mm" /></td>
											</c:if>
										</tr>
										<c:if test="${classDetail.clFormat eq '오프라인'}">
											<tr>
												<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">강의장소</td>
												<td class="pl-3">${opcl.clRoomNo }</td>
											</tr>
										</c:if>
										<tr>
											<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">수료기준안내</td>
											<td colspan="3" class="pl-3">
												<p style="white-space: pre-wrap;">${opcl.cutline}</p>
											</td>
										</tr>
										<tr>
											<td class="font-weight-bold text-center align-middle" style="background-color: #E6EFFC;">해당 부서</td>
											<td colspan="3" class="pl-3">
												<c:if test="${not empty dpList}">
													<c:forEach items="${dpList}" var="list" varStatus="status">
														<c:if test="${0 ne status.index and !status.last}"> &nbsp;|&nbsp;</c:if>
														<c:if test="${list.dpId eq 'DP101' }">총무부</c:if>
														<c:if test="${list.dpId eq 'DP102' }">경리부</c:if>
														<c:if test="${list.dpId eq 'DP103' }">구매자재부</c:if>
														<c:if test="${list.dpId eq 'DP104' }">품질관리부</c:if>
														<c:if test="${list.dpId eq 'DP105' }">생산1팀</c:if>
														<c:if test="${list.dpId eq 'DP106' }">생산2팀</c:if>
														<c:if test="${list.dpId eq 'DP107' }">상품관리부</c:if>
														<c:if test="${list.dpId eq 'DP108' }">기술부</c:if>
														<c:if test="${list.dpId eq 'DP109' }">해외영업부</c:if>
														<c:if test="${list.dpId eq 'DP110' }">국내영업부</c:if>
														<c:if test="${list.dpId eq 'DP111' }">고객관리부</c:if>
														<c:if test="${list.dpId eq 'DP112' }">개발부</c:if>
														<c:if test="${list.dpId eq 'DP113' }">부설연구소</c:if>

													</c:forEach>
												</c:if>
												<c:if test="${empty dpList}">
													전체
												</c:if>

											</td>
										</tr>

									</table>
								</section>

								<section id="classMemList">
									<div class="card">
										<div class="card-header">
											<h5 class="card-title">
												<b>수강생 목록</b>
											</h5>
										</div>
										<!-- /.card-header -->
										<div class="card-body" style="min-height: 350px;">
											<table class="table table-bordered table-sm">
												<thead>
													<tr class="text-center">
														<th>이름</th>
														<th>부서</th>
														<th>직위</th>
														<th>수강신청날짜</th>
													</tr>
												</thead>
												<tbody>
													<c:if test="${empty memList }">
														<tr class="text-center">
															<td colspan="4">수강생이 없습니다.</td>
														</tr>
													</c:if>
													<c:forEach items="${memList }" var="list">
														<tr>
															<td class="text-center">${list.memName }</td>
															<c:if test="${list.dpId eq 'DP101' }"><td class="text-center">총무부</td></c:if>
															<c:if test="${list.dpId eq 'DP102' }"><td class="text-center">경리부</td></c:if>
															<c:if test="${list.dpId eq 'DP103' }"><td class="text-center">구매자재부</td></c:if>
															<c:if test="${list.dpId eq 'DP104' }"><td class="text-center">품질관리부</td></c:if>
															<c:if test="${list.dpId eq 'DP105' }"><td class="text-center">생산1팀</td></c:if>
															<c:if test="${list.dpId eq 'DP106' }"><td class="text-center">생산2팀</td></c:if>
															<c:if test="${list.dpId eq 'DP107' }"><td class="text-center">상품관리부</td></c:if>
															<c:if test="${list.dpId eq 'DP108' }"><td class="text-center">기술부</td></c:if>
															<c:if test="${list.dpId eq 'DP109' }"><td class="text-center">해외영업부</td></c:if>
															<c:if test="${list.dpId eq 'DP110' }"><td class="text-center">국내영업부</td></c:if>
															<c:if test="${list.dpId eq 'DP111' }"><td class="text-center">고객관리부</td></c:if>
															<c:if test="${list.dpId eq 'DP112' }"><td class="text-center">개발부</td></c:if>
															<c:if test="${list.dpId eq 'DP113' }"><td class="text-center">부설연구소</td></c:if>

															<c:if test="${list.positionId eq 'PS101' }"><td class="text-center">사원</td></c:if>
															<c:if test="${list.positionId eq 'PS102' }"><td class="text-center">주임</td></c:if>
															<c:if test="${list.positionId eq 'PS103' }"><td class="text-center">대리</td></c:if>
															<c:if test="${list.positionId eq 'PS104' }"><td class="text-center">과장</td></c:if>
															<c:if test="${list.positionId eq 'PS105' }"><td class="text-center">차장</td></c:if>
															<c:if test="${list.positionId eq 'PS106' }"><td class="text-center">부장</td></c:if>
															<c:if test="${list.positionId eq 'PS107' }"><td class="text-center">이사</td></c:if>
															<c:if test="${list.positionId eq 'PS108' }"><td class="text-center">상무</td></c:if>
															<c:if test="${list.positionId eq 'PS109' }"><td class="text-center">대표</td></c:if>

															
																
															<td class="text-center">${fn:substring(list.studySdate,0,10)}</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										<!-- /.card-body -->
										<div class="card-footer clearfix">
											<nav aria-label="Navigation">
												<ul class="pagination justify-content-center m-0">
													<li class="page-item">
														<a class="page-link" href="javascript:list_go(1);">
															<i class="fas fa-angle-double-left"></i>
														</a>
													</li>
													<li class="page-item">
														<a class="page-link" href="javascript:list_go(${ pageMaker.prev ? pageMaker.startPage-1 : pageMaker.cri.page });">
															<i class="fas fa-angle-left"></i>
														</a>
													</li>
													<c:forEach var="pageNum" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
														<li class="page-item ${ pageMaker.cri.page == pageNum ? 'active' : ''  }">
															<a class="page-link" href="javascript:list_go(${ pageNum });"> ${ pageNum } </a>
														</li>
													</c:forEach>
											
													<li class="page-item">
														<a class="page-link" href="javascript:list_go(${ pageMaker.next ? pageMaker.endPage+1 : pageMaker.cri.page });">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
													<li class="page-item">
														<a class="page-link" href="javascript:list_go(${ pageMaker.realEndPage });">
															<i class="fas fa-angle-double-right"></i>
														</a>
													</li>
												</ul>
												<!-- /.pagination -->
											</nav>
											
											<form id="jobForm">
												<input type="hidden" name="page" value="" />
												<input type="hidden" name="searchType" value="" />
												<input type="hidden" name="keyword" value="" />
												<input type="hidden" name="sortType" value="${ cri.sortType }" />
												<input type="hidden" name="dboardNo" value="${debateBoard.dboardNo}" />
												<input type="hidden" name="openRound" value="${openRound }"/>
												<input type="hidden" name="clCode" value="${classDetail.clCode}">
											</form>
											<script>
												function list_go(page,url) {
													//console.log( document.getElementsByClassName('field').getAttribute('data-fullText'));
													if(!url) url= '${ url }';
													var jobForm = $('#jobForm');
											
													jobForm.find("[name='page']").val(page);
													jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
													jobForm.find("[name='keyword']").val($('input[name="keyword"]').val());
													jobForm.find("[name='sortType']").val($('input[name="sortType"]').val());
													
													jobForm.attr({
														action : url,
														method : 'get'
													}).submit();
												}
												function fc_sort(sort){
													var jobForm = $('#jobForm');
													jobForm.find("[name='sortType']").val(sort);
											
													list_go(1);
												}
											</script>
										</div>
									</div>
								</section>
							</div>
							<div class="tab-pane fade" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
								<section>
								<c:if test="${classDetail.clFormat eq '온라인'}">
									<table class="table table-hover table-sm">
										<thead>
											<tr class="text-center">
												<th class="col-1">회차</th>
												<th class="col-5">회차명</th>
												<th class="col-2">강의시간</th>
												<th class="col-3">강의파일코드</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty chapterList}">
												<tr class="text-center">
													<td colspan="4">등록된 목차가 없습니다.</td>
												</tr>
											</c:if>
											<c:forEach items="${chapterList}" var="list">
												<tr>
													<td class="text-center">${list.clChapNum}</td>
													<td>${list.clChapName}</td>
													<td class="text-center">${list.clChapTime}</td>
													<td class="text-center">${list.clChapVideo }</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!--/강의목차-->
									</c:if>
								</section>
							</div>
							<div class="tab-pane fade" id="custom-tabs-four-attach" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
								<table class="table table-hover table-sm">
							<thead>
								<tr class="text-center">
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty documentList}">
									<tr class="text-center">
										<td colspan="4">등록된 자료가 없습니다.</td>
									</tr>
								</c:if>
								<c:if test="${not empty documentList}">
									<c:forEach items="${documentList}" var="list">
									<c:set var="realName" value="${fn:split(list.clDocName,'$$')[1] }"/>
										<tr>
											<td class="text-center">${list.clDocNo}</td>
											<td style="cursor : pointer;" onclick="location.href='<%=request.getContextPath()%>/manager/classManagement/getClassDocumentFile.do?clDocName=${list.clDocName }'"><i class="fas fa-arrow-alt-circle-down"></i>${realName}</td>
											<td class="text-center"><span class="h5" style="cursor: pointer;"><i class="la la-save"></i></span></td>
										</tr>

									</c:forEach>
								</c:if>
							</tbody>
						</table>
							</div>
						</div>
					</div>
					<!-- /.card -->
				</div>
			</div>
		</div>

	</section>

	<script>
	window.onload=function(){
		ClassRegistPictureThumb($('#pictureView')[0], '${classDetail.clImg}', '<%=request.getContextPath()%>');
	}


	function deleteClass(clCode,openRound){

		if(confirm('정말 삭제하시겠습니까?')){

			$.ajax({
				url 		: 'deleteClass.do',
				data 		: {"clCode" : clCode,
								"openRound" : openRound
				},
				type 		: 'post',
				success 	: function(data){


					location.href="list.do"
				},
				error 		: function(error){

					console.log(error.status);
					AjaxErrorSecurityRedirectHandler(error.status);
				}
			})
		}

	}
</script>

</body>