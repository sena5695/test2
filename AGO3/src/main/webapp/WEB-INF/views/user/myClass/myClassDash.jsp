<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="studyClassList" value="${dataMap.studyClassList }" />
<c:set var="studyClassCount" value="${dataMap.studyClassCount}" />
<c:set var="finishClassList" value="${dataMap.finishClassList}" />
<c:set var="finishClassCount" value="${dataMap.finishClassCount }" />
<c:set var="credit" value="${dataMap.credit }" />
<c:set var="intrClassList" value="${dataMap.intrClassList }" />
<c:set var="departmentClassList" value="${dataMap.departmentClassList }" />
<c:set var="sysdate" value="${dataMap.sysdate }" />
<body>

	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid"></div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->


	<section class="content ui-sortable">
		<div class="row col-12">
			<section class="col-5">
				<div class="card">
					<div>
						<p class="h6 font-weight-bold pl-3 pt-3 pb-3 m-0" style="background-color: #E6EFFC;">학습중인 강의</p>
					</div>
					<!-- /.card-header -->
					<div class="p-2 card-body" style="height: 660px;">
						<table class="table table-sm">
							<c:if test="${not empty studyClassList }">
								<c:forEach var="studyClass" items="${studyClassList}" varStatus="vs">
									<tr style="cursor: pointer;" onclick="location.href='clsStudying/detail.do?opcl=${studyClass.opcl}'">
										<!-- <td class="text-center">1</td> -->
										<td class="col-1 text-center">
											<div class="d-block px-1">
												<c:if test="${studyClass.clFormat eq 'A601'}">
													<span class="badge bg-info col-12">오프라인</span>
												</c:if>
												<c:if test="${studyClass.clFormat eq 'A602'}">
													<span class="badge bg-primary col-12">온라인</span>
												</c:if>
												<c:if test="${studyClass.clFormat eq 'A603'}">
													<span class="badge badge-success col-12">실시간</span>
												</c:if>
												<c:if test="${studyClass.clDivision eq 'A501'}">
													<span class="badge badge-danger col-12">필수</span>
												</c:if>
												<c:if test="${studyClass.clDivision eq 'A502'}">
													<span class="badge badge-warning col-12">선택</span>
												</c:if>

											</div>
										</td>
										<td class="col-4">
											<div class="d-block pt-1">
												<span class="h6 font-weight-bold align-middle"> <c:choose>
														<c:when test="${fn:length(studyClass.clName) gt 26 }">
															<c:out value="${fn:substring(studyClass.clName,0,26) }..."></c:out>
														</c:when>
														<c:otherwise>
														${studyClass.clName }
													</c:otherwise>
													</c:choose>
												</span>

											</div>
											<div class="progress">
												<div class="progress-bar bg-success" role="progressbar" style="width: ${studyClass.progRate }%" aria-valuenow="${studyClass.progRate }" aria-valuemin="0" aria-valuemax="100">${studyClass.progRate }%</div>
											</div>
										</td>

									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty studyClassList }">
								<tr class="text-center text-bold" style="cursor: pointer;">
									<td>현재 수강중인 강의가 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</div>
					<!-- /.card-body -->

				</div>
				<!-- /학습중인 강의 -->


			</section>
			<section class="col-7">

				<div class="card memo col-12 mb-1 pl-0 pr-0">
					<p class="h6 font-weight-bold pl-3 pt-3 pb-3 m-0" style="background-color: #E6EFFC;">현황</p>
					<hr class="my-2">
					<!-- /.card-header -->
					<div class="card-body">
						<div class="row">
							<div class="col-sm-4 border-right">
								<div class="description-block pr-3" onclick="location.href='clsStudying/list.do'" style="cursor: pointer;">
									<h5 class="description-header">학습중</h5>
									<span class="description-text">${studyClassCount}</span>
								</div>
								<!-- /.description-block -->
							</div>
							<!-- /.col -->
							<div class="col-sm-4 border-right">
								<div class="description-block" onclick="location.href='clsFinished/list.do'" style="cursor: pointer;">
									<h5 class="description-header">학습완료</h5>
									<span class="description-text">${finishClassCount}</span>
								</div>
								<!-- /.description-block -->
							</div>
							<div class="col-sm-4">
								<div class="description-block pl-3">
									<h5 class="description-header">이수점수</h5>
									<span class="description-text">${credit}</span>
								</div>
								<!-- /.description-block -->
							</div>
							<!-- /.col -->
						</div>
					</div>
					<!-- /.card-body -->
				</div>

				<div class="row p-2">
					<div class="card pl-0 pr-0 mr-2" style="min-width: 48.5%; max-width: 48.5%; height: 528px;">
						<div class="col-12 p-0">
					<p class="h6 font-weight-bold pb-3 pt-3 pl-3 mb-2" style="background-color: #E6EFFC;">종료된강의</p>
					<table class="col-12 table">
						<c:if test="${not empty finishClassList }">
							<c:set var="date" value="<%=new Date()%>" />
							<c:forEach var="finishClass" items="${finishClassList}" varStatus="fi">
								<tr>
									<td class="row" style="width: 345px; margin-left: 1px;">
										<div class="d-block" style="width: 240px;">
											<span class="font-weight-bold" style="font-size: 13px;">
												 <c:choose>
													<c:when test="${fn:length(finishClass.clName) gt 20 }">
														<c:out value="${fn:substring(finishClass.clName,0,20) }..."></c:out>
													</c:when>
													<c:otherwise>
														${finishClass.clName}
													</c:otherwise>
												</c:choose>
											</span>
											<br>
											<span class="m-0" style="font-size: 13px;"> <c:if test="${finishClass.memclState ne 'C101'}">
												<c:if test="${ finishClass.memclState eq 'C103'}">미수료</c:if>
												<c:if test="${ finishClass.memclState ne 'C103'}">수료날짜 : ${finishClass.cdate}</c:if>
												</c:if> 
												<c:if test="${(finishClass.memclState eq 'C101') }">미수료</c:if>
											</span>
										</div>
										<c:if test="${finishClass.classType eq 'int'}">
											<c:if test="${intReport.intState ne 'B104'}">
												<button type="button" style="height: 30px; width: 80px;" type="button"
													class="btn btn-block mt-2 float-right btn-xs
																<c:choose>
															        <c:when test="${finishClass.memclState eq 'C101' || finishClass.memclState eq 'C103'}">
															        	btn-warning
															        </c:when>
															        <c:when test="${finishClass.intNo eq 0}">
															        	btn-primary
															        </c:when>
															        <c:when test="${finishClass.intState eq 'B101'}">
															        	btn-primary
															        </c:when>
																	<c:when test="${finishClass.intState eq 'B102'}">
																    	btn-info
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B103'}">
																   		btn-danger
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B104'}">
																   		btn-success
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B105'}">
																    	btn-danger
																    </c:when>
																</c:choose>
															
															"
													<c:choose>
																	<c:when test="${finishClass.memclState eq 'C101' || finishClass.memclState eq 'C103'}">
																    	disabled
																    </c:when>
																	<c:when test="${finishClass.intState eq 'B102'}">
																    	disabled
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B105'}">
																    	disabled
																    </c:when>
																</c:choose>
													<c:choose>
															        <c:when test="${finishClass.memclState eq 'C101' || finishClass.memclState eq 'C103'}">
															        	> 미수료
															        </c:when>
															        <c:when test="${finishClass.intNo eq 0}">
															        	onclick="intReport_go(${finishClass.memClNo});" > 제출하기
															        </c:when>
															        <c:when test="${finishClass.intState eq 'B101'}">
															        	onclick="intReport_go(${finishClass.memClNo});" > 제출하기
															        </c:when>
																	<c:when test="${finishClass.intState eq 'B102'}">
																    	onclick ="print_intReport(${finishClass.memClNo});" > 승인대기
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B103'}">
																   		onclick="intReport_go(${finishClass.memClNo});" > 반려-재제출
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B104'}">
																   		onclick ="print_intReport(${finishClass.memClNo});"> 승인완료
																    </c:when>
																    <c:when test="${finishClass.intState eq 'B105'}">
																    	> 마감
																    </c:when>
																</c:choose></button>
											</c:if>

										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty finishClassList }">
							<tr class="text-center text-bold">
								<td>최근 종료된 강의가 없습니다.</td>
							</tr>
						</c:if>
						<tbody>
					</table>
				</div>
					</div>
					
					<div class="card pl-0 pr-0 ml-2" style="min-width: 49%; max-width: 49%; height: 528px;">
						<div class="col-12 p-0">
							<p class="h6 font-weight-bold pb-3 pt-3 pl-3 mb-2" style="background-color: #E6EFFC;">관심강의</p>
							<table class="col-12 table">
								<c:if test="${not empty intrClassList }">
									<c:forEach var="intrClass" items="${intrClassList}" varStatus="fi">
										<tr>
											<td class="row pr-0" style="width: 345px; margin-left: 1px;">
												<c:if test="${intrClass.postEdate >= sysdate }">
													<c:if test="${intrClass.postSdate > sysdate }">
														<div class="d-block" style="width: 240px;">
															<span class="h6 font-weight-bold"> <c:choose>
																	<c:when test="${fn:length(intrClass.clName) gt 15 }">
																		<c:out value="${fn:substring(intrClass.clName,0,15) }..."></c:out>
																	</c:when>
																	<c:otherwise>
																			${intrClass.clName }
																		</c:otherwise>
																</c:choose>
															</span>
															<br>
															<span class="m-0 text-default">${intrClass.posts}~${intrClass.poste }</span>
														</div>
														<input disabled="disabled" id="${intrClass.opcl}" style="height: 30px; width: 80px;" type="button" class="btn btn-block mt-2 float-right btn-primary btn-xs" onclick="regist(${intrClass.opcl},'${intrClass.studyTime }', '${intrClass.lDate }', '${intrClass.enrPers}')" value="수강신청" />
													</c:if>
													<c:if test="${intrClass.postSdate <= sysdate }">
														<div class="d-block" style="width: 240px;">
															<span class="h6 font-weight-bold"> <c:choose>
																	<c:when test="${fn:length(intrClass.clName) gt 15 }">
																		<c:out value="${fn:substring(intrClass.clName,0,15) }..."></c:out>
																	</c:when>
																	<c:otherwise>
																			${intrClass.clName }
																		</c:otherwise>
																</c:choose>
															</span>
															<br>
															<span class="m-0 text-primary">${intrClass.posts}~${intrClass.poste }</span>
														</div>

														<c:if test="${not empty departmentClassList }">
															<c:set var="loop_flag" value="false" />
															<c:forEach var="departmentClass" items="${departmentClassList}" varStatus="i">
																<c:if test="${departmentClass.dpId ne dpId}">
																	<c:if test="${departmentClass.opcl eq intrClass.opcl}">
																		<c:set var="loop_flag" value="ture" />
																	</c:if>
																</c:if>
															</c:forEach>

															<c:if test="${loop_flag eq true}">
																<input id="${intrClass.opcl}" style="height: 30px; width: 80px;" type="button" class="btn btn-block mt-2 float-right btn-primary btn-xs" onclick="noregist()" value="수강신청" />
															</c:if>
															<c:if test="${loop_flag ne true }">
																<input id="${intrClass.opcl}" style="height: 30px; width: 80px;" type="button" class="btn btn-block mt-2 float-right btn-primary btn-xs" onclick="regist(${intrClass.opcl},'${intrClass.studyTime }', '${intrClass.lDate }', '${intrClass.enrPers}')" value="수강신청" />
															</c:if>
														</c:if>
														<c:if test="${empty departmentClassList }">
															<input id="${intrClass.opcl}" style="height: 30px; width: 80px;" type="button" class="btn btn-block mt-2 float-right btn-primary btn-xs" onclick="regist(${intrClass.opcl},'${intrClass.studyTime }', '${intrClass.lDate }', '${intrClass.enrPers}')" value="수강신청" />
														</c:if>
													</c:if>

												</c:if>
												<c:if test="${intrClass.postEdate < sysdate }">
													<div class="d-block" style="width: 240px;">
														<span class="h6 font-weight-bold"> <c:choose>
																<c:when test="${fn:length(intrClass.clName) gt 15 }">
																	<c:out value="${fn:substring(intrClass.clName,0,15) }..."></c:out>
																</c:when>
																<c:otherwise>
																			${intrClass.clName }
																		</c:otherwise>
															</c:choose>
														</span>
														<br>
														<span class="m-0 text-danger">${intrClass.posts}~${intrClass.poste }</span>
													</div>
													<input id="${intrClass.opcl}" style="height: 30px; width: 80px;" type="button" class="btn btn-block mt-2 float-right btn-danger btn-xs" onclick="intrDelete(${intrClass.opcl})" value="강의삭제" />
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty intrClassList }">
									<tr class="text-center text-bold">
										<td>관심강의가 없습니다.</td>
									</tr>
								</c:if>
							</table>
						</div>
					</div>
				</div>
			</section>

		</div>
	</section>

	<script type="text/javascript">
		function intReport_go(memClNo){
			OpenWindow("<%=request.getContextPath()%>/user/myClass/clsFinished/intReportForm.pop?memClNo="+memClNo+"&from=main", '', 780, 850);
		}
		function print_intReport(memClNo){
			OpenWindow("<%=request.getContextPath()%>/user/myClass/clsFinished/printReport.pop?memClNo="+memClNo, '', 780, 850);
		}
		
		function intrDelete(opcl) {
   		 $.ajax({
	         url         : 'bookmark',
	         data        : {	'opcl' : opcl
	        	 			   ,'markState' : 'false'
	         			   },
	         type        : 'post',
	         success     : function(data){
				
	        	 location.reload(true);
	         },
	         error         : function(error){
	             //alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
	             AjaxErrorSecurityRedirectHandler(error.status);
	             console.log(error.status);
	         }
	     })
		}
	
		function regist(opcl, endDay, lecDate, totalCount) {

			if (confirm("해당 강의를 신청하시겠습니까?")) {
				
				$.ajax({
					url         : 'regist',
					data        : {	'opcl' : opcl,
					 				'endDay' : endDay,
									'lecDate' : lecDate,
									'totalCount' : totalCount
								   },   
					type        : 'post',
					success     : function(data){
					 if(data == "1"){
						 alert("신청에 성공했습니다.");
						 intrDelete(opcl);
					 }else{
						alert("수강인원이 마감되었습니다.")
					 }
	
					},
					error         : function(error){
					    //alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
					    AjaxErrorSecurityRedirectHandler(error.status);
					    console.log(error.status);
					    }
				})
				
			}
	
		}
		
		function noregist() {
			alert("타부서 강의는 수강할 수 없습니다.")
		}
	
	</script>
</body>
