<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="classList" value="${dataMap.classList }" />
<c:set var="memberClassList" value="${dataMap.memberClassList }" />
<c:set var="size" value="${dataMap.size }" />
<c:set var="dpId" value="${dataMap.dpId }" />
<c:set var="departmentClassList" value="${dataMap.departmentClassList }" />
<c:set var="departmentClassSize" value="${dataMap.departmentClassSize }" />
<c:set var="memberClassSize" value="${dataMap.memberClassSize }" />
<c:set var="intrList" value="${dataMap.intrList }" />
<c:set var="sysdate" value="${dataMap.sysdate }" />
<c:set var="positionId" value="${dataMap.positionId }" />

<body>

	<div class="container-fluid">
		<div class="input-group justify-content-end col-12 p-0 mb-1">
			<div class="p-0 m-0 text-left col-5 float-left">
			</div>
			<div class="row col-7 justify-content-end p-0 mr-1">
				<select class="col-md-2 form-control" name="searchType">
			        <option value=""  ${cri.searchType eq '' ? 'selected':'' }>전체</option>
					<option value="m" ${cri.searchType eq 'm' ? 'selected':'' }>필수</option>
					<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>선택</option>
				</select>
				<input type="text" placeholder="강의명 검색..." name="keyword" class="form-control col-md-7" value="${ param.keyword }" >
				<button class="col-md-1 btn btn-primary float-right" onclick="list_go(1);" >검색</button>
			</div>
		</div>
		<div class="row">
				<table style="height: 650px;">
					<tr class="row pl-3">
						<c:if test="${not empty classList }" >
							<c:forEach var="item" items="${classList}" varStatus="vs" >
								<c:if test="${vs.index%5 eq 0}"> 
									<td class="card p-2 pb-1 mb-2" style="width:240px; " >
										<c:if test="${item.clDivision eq 'A501'}">
											<div class="ribbon-wrapper">
						                        <div class="ribbon bg-danger">
						                       		 필수
						                    	</div>
						                    </div>
										</c:if>

										<img onclick="location.href='detail.do?clCode=${item.clCode}&opcl=${item.opcl }&type=${cri.sortType}'" class="mx-auto" src="/ago/user/rcls/common/getImg.do?fileNM=${item.clImg }" alt="..." style="width: 220px; height: 150px;">
										<div class="p-1" style="height: 70px;" onclick="location.href='detail.do?clCode=${item.clCode}&opcl=${item.opcl }&type=${cri.sortType}'">
											<h6 class="m-1 font-weight-bold">[${item.openRound}차시]&nbsp;${item.clName}</h6>
											
										</div>
										<div class="row pl-2">
											<c:if test="${item.clFormat eq 'A601'}">
												<span class="badge bg-info ml-1 pt-2">오프라인</span>
											</c:if>
											<c:if test="${item.clFormat eq 'A602'}">
												<span class="badge bg-primary ml-1 pt-2" style="width: 57.6px;">온라인</span>
											</c:if>
											<c:if test="${item.clFormat eq 'A603'}">
												<span class="badge badge-success ml-1 pt-2" style="width: 57.6px;">실시간</span>
											</c:if>
											<small class="badge badge-warning ml-1 pt-2 mr-5" style="width: 85px;">이수점수 : ${item.clPoint }</small>
										<c:set var="loop_flag" value="false" />
										<c:if test="${not empty memberClassList}">
											<c:forEach var="memberClass" items="${memberClassList}" varStatus="vs" >
												<c:if test="${not loop_flag }">
													<!-- 수강중인 경우 -->
													<c:if test="${item.opcl eq memberClass.opcl}">
														<i style="font-size: 25px;" id='bookmark' class="ml-1 far fa-bookmark"></i>
														</div>
														<span class="pl-1 text-primary">${item.posts}~${item.poste}</span>
														<c:if test="${memberClass.memclState eq 'C101'}">
															
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" value="학습중" />
															
														</c:if>
														<c:if test="${memberClass.memclState ne 'C101'}">
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-secondary"  value="수강완료" />
															
														</c:if>
														<c:set var="loop_flag" value="true" />
													</c:if>
													<!-- 수강신청이 가능한 경우 -->
													<c:if test="${item.opcl ne memberClass.opcl  and vs.index eq memberClassSize}">
														<!-- 북마크 -->
															<c:if test="${not empty intrList }">
																<c:set var="intrClassExist" value="false" />
																<c:forEach var="intr" items="${intrList}" varStatus="intrCount" >
																	<c:if test="${item.opcl eq intr}">
																		<c:set var="intrClassExist" value="true" />
																		
																	</c:if>
																</c:forEach>
																<c:if test="${intrClassExist }">
																	<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 fas fa-bookmark text-danger" onclick="bookmark(${item.opcl});"></i>
																</c:if>
																<c:if test="${not intrClassExist }">
																	<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
																</c:if>
															</c:if>
															<c:if test="${empty intrList }">
																<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
															</c:if>
															<!-- 북마크 끝 -->
														</div>
														<span class="pl-1 text-primary">${item.posts}~${item.poste}</span>
														<c:if test="${not empty departmentClassList}">
															<c:set var="noregist_flag" value="false" />
															<c:set var="mydp_flag" value="false" />
															<!-- 수강신청 버튼 부분 -->
															<c:if test="${item.postSdate <= sysdate}">
															
																<c:forEach var="departmentClass" items="${departmentClassList}" varStatus="is" >
																	
																		<c:if test="${departmentClass.dpId ne dpId}">
																			<c:if test="${departmentClass.opcl eq item.opcl}">
																				<c:set var="noregist_flag" value="true" />
																			</c:if>
													
																		</c:if>
																		<c:if test="${departmentClass.dpId eq dpId and departmentClass.opcl eq item.opcl}">
																			<c:set var="mydp_flag" value="true" />
																		</c:if>
																</c:forEach>
																<c:if test="${noregist_flag}">
																	<c:if test="${not mydp_flag}">
																		<input name="${dpId}" id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="noregist()" value="수강신청" />
																	</c:if>
																	<c:if test="${mydp_flag}">
																		<input name="${mydp_flag}" id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
																	</c:if>
																	
																</c:if>
																<c:if test="${not noregist_flag}">
																	<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
																</c:if>
															</c:if>
															<c:if test="${item.postSdate > sysdate}">
																<input disabled="disabled" id="${item.opcl}" style="vertical-align: bottom; cursor: default;" type="button" class="p-1 btn btn-block btn-primary" value="수강신청" />
															</c:if>
														</c:if>
														<c:if test="${empty departmentClassList}">
														
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
														</c:if>
													</c:if>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${empty memberClassList}">
											<!-- 북마크 -->
											<c:if test="${not empty intrList }">
												<c:set var="intrClassExist" value="false" />
												<c:forEach var="intr" items="${intrList}" varStatus="intrCount" >
													<c:if test="${item.opcl eq intr}">
														<c:set var="intrClassExist" value="true" />
														
													</c:if>
												</c:forEach>
												<c:if test="${intrClassExist }">
													<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 fas fa-bookmark text-danger" onclick="bookmark(${item.opcl});"></i>
												</c:if>
												<c:if test="${not intrClassExist }">
													<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
												</c:if>
											</c:if>
											<c:if test="${empty intrList }">
												<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
											</c:if>
											<!-- 북마크 끝 -->
											
											</div>
											<span class="pl-1 text-primary">${item.posts}~${item.poste}</span>
											<c:if test="${not empty departmentClassList}">
												<c:set var="noregist_flag" value="false" />
												<c:set var="mydp_flag" value="false" />
												<!-- 수강신청 버튼 부분 -->
												<c:if test="${item.postSdate <= sysdate}">
													<c:forEach var="departmentClass" items="${departmentClassList}" varStatus="is" >
															<c:if test="${departmentClass.dpId ne dpId}">
																<c:if test="${departmentClass.opcl eq item.opcl}">
																	<c:set var="noregist_flag" value="true" />
																</c:if>
												
															</c:if>
															<c:if test="${departmentClass.dpId eq dpId and departmentClass.opcl eq item.opcl}">
																<c:set var="mydp_flag" value="true" />
															</c:if>
													</c:forEach>
													<c:if test="${noregist_flag}">
														<c:if test="${not mydp_flag}">
															<input id="${dpId}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="noregist()" value="수강신청" />
														</c:if>
														<c:if test="${mydp_flag}">
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
														</c:if>
													</c:if>
													<c:if test="${not noregist_flag}">
													
														<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
													</c:if>
												</c:if>
												<c:if test="${item.postSdate > sysdate}">
													<input disabled="disabled" id="${item.opcl}" style="vertical-align: bottom; cursor: default;" type="button" class="p-1 btn btn-block btn-primary" value="수강신청" />
												</c:if>
											</c:if>
											<c:if test="${empty departmentClassList}">
												<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${classVO.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
											</c:if>
										</c:if>
									</td>
								</c:if>
								<c:if test="${vs.index%5 ne 0}"> 
									<td class="card p-2 pb-1 ml-3 mb-2" style="width:240px; " >
										<c:if test="${item.clDivision eq 'A501'}">
											<div class="ribbon-wrapper">
						                        <div class="ribbon bg-danger">
						                       		 필수
						                    	</div>
						                    </div>
										</c:if>
										<img onclick="location.href='detail.do?clCode=${item.clCode}&opcl=${item.opcl }&type=${cri.sortType}'" class="mx-auto" src="/ago/user/rcls/common/getImg.do?fileNM=${item.clImg }" alt="..." style="width: 220px; height: 150px;">
										<div class="p-1" style="height: 70px;" onclick="location.href='detail.do?clCode=${item.clCode}&opcl=${item.opcl }&type=${cri.sortType}'">
											<h6 class="m-1 font-weight-bold">[${item.openRound}차시]&nbsp;${item.clName}</h6>
											
										</div>
										<div class="row pl-2">
											<c:if test="${item.clFormat eq 'A601'}">
												<span class="badge bg-info ml-1 pt-2">오프라인</span>
											</c:if>
											<c:if test="${item.clFormat eq 'A602'}">
												<span class="badge bg-primary ml-1 pt-2" style="width: 57.6px;">온라인</span>
											</c:if>
											<c:if test="${item.clFormat eq 'A603'}">
												<span class="badge badge-success ml-1 pt-2" style="width: 57.6px;">실시간</span>
											</c:if>
											<small class="badge badge-warning ml-1 pt-2 mr-5" style="width: 85px;">이수점수 : ${item.clPoint }</small>
										<c:set var="loop_flag" value="false" />
										
										<!-- 이미 수강중일 경우 -->
										<c:if test="${not empty memberClassList}">
											<c:forEach var="memberClass" items="${memberClassList}" varStatus="vs" >
												<c:if test="${not loop_flag }">
													<c:if test="${item.opcl eq memberClass.opcl}">
														<i style="font-size: 25px;" id='bookmark' class="ml-1 pl-1 far fa-bookmark "></i>
														</div>
														<span class="pl-1 text-primary">${item.posts}~${item.poste}</span>
														<c:if test="${memberClass.memclState eq 'C101'}">
															
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" value="학습중" />
															
														</c:if>
														<c:if test="${memberClass.memclState ne 'C101'}">
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-secondary"  value="수강완료" />
															
														</c:if>
														<c:set var="loop_flag" value="true" />
													</c:if>
													<c:if test="${item.opcl ne memberClass.opcl  and vs.index eq memberClassSize}">
														<!-- 북마크 -->
														<c:if test="${not empty intrList }">
															<c:set var="intrClassExist" value="false" />
															<c:forEach var="intr" items="${intrList}" varStatus="intrCount" >
																<c:if test="${item.opcl eq intr}">
																	<c:set var="intrClassExist" value="true" />
																	
																</c:if>
															</c:forEach>
															<c:if test="${intrClassExist }">
																<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 fas fa-bookmark text-danger" onclick="bookmark(${item.opcl});"></i>
															</c:if>
															<c:if test="${not intrClassExist }">
																<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
															</c:if>
														</c:if>
														<c:if test="${empty intrList }">
															<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
														</c:if>
														<!-- 북마크 끝 -->
														</div>
														<span class="pl-1 text-primary">${item.posts}~${item.poste}</span>
														<c:if test="${not empty departmentClassList}">
															<c:set var="noregist_flag" value="false" />
															<c:set var="mydp_flag" value="false" />
															<!-- 수강신청 버튼 부분 -->
															<c:if test="${item.postSdate <= sysdate}">
																<c:forEach var="departmentClass" items="${departmentClassList}" varStatus="is" >
																	<!-- 무조건 타 부서 과목인 경우 -->
																		<c:if test="${departmentClass.dpId ne dpId}">
																			<c:if test="${departmentClass.opcl eq item.opcl}">
																				<c:set var="noregist_flag" value="true" />
																			</c:if>
													
																		</c:if>
																		<c:if test="${departmentClass.dpId eq dpId and departmentClass.opcl eq item.opcl}">
																			<c:set var="mydp_flag" value="true" />
																		</c:if>
																</c:forEach>
																<c:if test="${noregist_flag}">
																	<c:if test="${not mydp_flag}">
																		<input id="${item.opcl}" name="${dpId }" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="noregist()" value="수강신청" />
																	</c:if>
																	<c:if test="${mydp_flag}">
																		<input id="${item.opcl}" name="${dpId }" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
																	</c:if>
																</c:if>
																<c:if test="${not noregist_flag}">
																
																	<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
																</c:if>
															</c:if>
															<c:if test="${item.postSdate > sysdate}">
																<input disabled="disabled" id="${item.opcl}" style="vertical-align: bottom; cursor: default;" type="button" class="p-1 btn btn-block btn-primary" value="수강신청" />
															</c:if>
														</c:if>
														<c:if test="${empty departmentClassList}">
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
														</c:if>
													</c:if>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${empty memberClassList}">
											<!-- 북마크 -->
											<c:if test="${not empty intrList }">
												<c:set var="intrClassExist" value="false" />
												<c:forEach var="intr" items="${intrList}" varStatus="intrCount" >
													<c:if test="${item.opcl eq intr}">
														<c:set var="intrClassExist" value="true" />
														
													</c:if>
												</c:forEach>
												<c:if test="${intrClassExist }">
													<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 fas fa-bookmark text-danger" onclick="bookmark(${item.opcl});"></i>
												</c:if>
												<c:if test="${not intrClassExist }">
													<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
												</c:if>
											</c:if>
											<c:if test="${empty intrList }">
												<i style="font-size: 25px;" id='bookmark${item.opcl}' class="ml-1 far fa-bookmark" onclick="bookmark(${item.opcl});"></i>
											</c:if>
											<!-- 북마크 끝 -->
											</div>
											<span class="pl-1 text-primary">${item.posts}~${item.poste}</span>
											<c:if test="${not empty departmentClassList}">
												<c:set var="noregist_flag" value="false" />
												<c:set var="mydp_flag" value="false" />
												<!-- 수강신청 버튼 부분 -->
												<c:if test="${item.postSdate <= sysdate}">
													<c:forEach var="departmentClass" items="${departmentClassList}" varStatus="is" >
														<!-- 무조건 타 부서 과목인 경우 -->
															<c:if test="${departmentClass.dpId ne dpId}">
																<c:if test="${departmentClass.opcl eq item.opcl}">
																	<c:set var="noregist_flag" value="true" />
																</c:if>
													
															</c:if>
															<c:if test="${departmentClass.dpId eq dpId and departmentClass.opcl eq item.opcl}">
																<c:set var="mydp_flag" value="true" />
															</c:if>
													</c:forEach>
													<c:if test="${noregist_flag}">
														<c:if test="${not mydp_flag}">
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="noregist()" value="수강신청" />
														</c:if>
														<c:if test="${mydp_flag}">
															<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
														</c:if>
													</c:if>
													<c:if test="${not noregist_flag}">
													
														<input id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${item.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
													</c:if>
												</c:if>
												<c:if test="${item.postSdate > sysdate}">
													<input disabled="disabled" id="${item.opcl}" style="vertical-align: bottom; cursor: default;" type="button" class="p-1 btn btn-block btn-primary" value="수강신청" />
												</c:if>
											</c:if>
											<c:if test="${empty departmentClassList}">
												<input name="" id="${item.opcl}" style="vertical-align: bottom;" type="button" class="p-1 btn btn-block btn-primary" onclick="regist(${item.opcl},'${classVO.studyTime }','${item.lDate }', '${item.enrPers}')" value="수강신청" />
											</c:if>
										</c:if>
									</td>
								</c:if>
								
							</c:forEach>
						</c:if>	
						<c:if test="${empty classList }" >
							<h5 class="p-3 text-center"> 등록된 강의가 없습니다.</h5>
						</c:if>

						

					</tr> 
		
				</table>
					
					<!-- /.card -->
				</div>
				
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
				<input type="hidden" name="positionId" value="${positionId }" />
				<form id="jobForm">
					<input type="hidden" name="page" value="" />
					<input type="hidden" name="searchType" value="" />
					<input type="hidden" name="keyword" value="" />
					<input type="hidden" name="sortType" value="${ cri.sortType }" />
					<input type="hidden" name="clCode" value="" />
					<input type="hidden" name="opcl" value="" />
					
				</form>

			</div>
<script>
	function list_go(page,url, clCode, opcl) {
		//console.log( document.getElementsByClassName('field').getAttribute('data-fullText'));
		if(!url) url="list.do";
		var jobForm = $('#jobForm');

		jobForm.find("[name='page']").val(page);
		jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
		jobForm.find("[name='keyword']").val($('input[name="keyword"]').val());
		jobForm.find("[name='sortType']").val($('input[name="sortType"]').val());
		jobForm.find("[name='clCode']").val(clCode);
		jobForm.find("[name='opcl']").val(opcl);
		
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
<script type="text/javascript">
	function bookmark(opcl) {
		var markState = true;
		var result = "관심강의로 추가했습니다.";
		if($('#bookmark'+opcl+'').attr('class') == 'ml-1 far fa-bookmark'){
			$('#bookmark'+opcl+'').attr('class', 'ml-1 fas fa-bookmark text-danger');
			markState = true;
			result = "관심강의로 등록했습니다.";
		}else{
			$('#bookmark'+opcl+'').attr('class', 'ml-1 far fa-bookmark');
			markState = false;
			result = "관심강의를 해제했습니다.";
		}
		
		 $.ajax({
	         url         : 'bookmark',
	         data        : {	'opcl' : opcl
	        	 			   ,'markState' : markState
	         			   },
	         type        : 'post',
	         success     : function(data){
				// alert(result);
				
	         },
	         error         : function(error){
	             //alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
	             AjaxErrorSecurityRedirectHandler(error.status);
	             console.log(error.status);
	         }
	     })
		
	}
	
	function regist(opcl, endDay, lDate, totalCount) {

		if($("input[name='sortType']").val() == 's'){
			console.log($('input[name=positionId]').val())
			if($('input[name=positionId]').val() != 'PS101'){
				alert("신입사원만 수강 가능합니다.");
			}else{
				if (confirm("해당 강의를 신청하시겠습니까?")) {
					registFunction(opcl, endDay, lDate, totalCount);
			    } 
			}		
		}else{
			if (confirm("해당 강의를 신청하시겠습니까?")) {
				registFunction(opcl, endDay, lDate, totalCount);
		    } 
		}
		
		
		
	}
	
	function registFunction(opcl, endDay, lecDate, totalCount) {

		// alert($('#'+opcl+'').attr('value'));
		if(totalCount == "제한없음"){
			totalCount = 0;
		}
		 if($('#'+opcl+'').attr('value') == '수강신청'){
			 console.log(2)
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
		        		 if($('#bookmark'+opcl+'').attr('class') != 'ml-1 far fa-bookmark'){
			        		 markState = false;
			        		 $.ajax({
			        	         url         : 'bookmark',
			        	         data        : {	'opcl' : opcl
			        	        	 			   ,'markState' : markState
			        	         			   },
			        	         type        : 'post',
			        	         success     : function(data){
			        				// alert(result);
			        				
			        	        	 $('#bookmark'+opcl+'').attr('class', 'ml-1 far fa-bookmark');
			        	         },
			        	         error         : function(error){
			        	             //alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
			        	             AjaxErrorSecurityRedirectHandler(error.status);
			        	             console.log(error.status);
			        	         }
			        	     })
			        		 
			        	 }
			        	 $('#bookmark'+opcl+'').attr('onclick', '');
			        	$('#'+opcl+'').attr('value','학습중');
		        	 }else{
		        		 alert("수강인원이 마감되었습니다.")
		        	 }

		         },
		         error         : function(error){

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
