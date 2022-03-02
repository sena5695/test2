<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="classInfo" value="${dataMap.classInfo }" />
<c:set var="memClassList" value="${dataMap.memberClassList }" />
<c:set var="extList" value="${dataMap.extList }"/>
<c:set var="reportList" value="${ dataMap.extReportList}"/>
<c:set var="message" value="${message}"/>
<c:set var="intReport" value="${dataMap.intReport }"/>
<head></head>

<title></title>

<body>
<input type="hidden" id="message1112" value="${message}"/>
<script type="text/javascript">
	window.onload=function(){
		var message = $('#message1112').val();
			
		if(message != ""){
			alert(message);
		}
	}
</script>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0" >
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">수강내역</h4>
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
						<li class="breadcrumb-item">수강내역</li>
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
			<div class="input-group justify-content-left col-12 p-0 mb-1">
				<div class="p-0 m-0 text-left col-5 float-left">
					<span class="text-muted ${cri.sortType eq 'int' ? 'text-bold': '' } ${cri.sortType eq '' ? 'text-bold': '' }" style="color: gray; cursor: pointer; font-size: 20px;" onclick="fn_sort(1,'int');">사내강의</span>
					<span class="text-muted" style="color: gray;">&nbsp;|&nbsp;</span>
					<span class="text-muted ${cri.sortType eq 'ext' ? 'text-bold': '' }" style="color: gray; cursor: pointer; font-size: 20px;" onclick="fn_sort(1,'ext');">HRD</span>
					<span class="text-muted" style="color: gray;">&nbsp;|&nbsp;</span>
					<span class="text-muted ${cri.sortType eq 'report' ? 'text-bold': '' }" style="color: gray; cursor: pointer; font-size: 20px;" onclick="fn_sort(1,'report');">외부강의</span>
				</div>
				<c:if test="${cri.sortType eq 'report' }">
					<div class="row col-7 justify-content-end p-0 mr-1">
						<button class="btn btn-primary float-right" id="extClass" type="button" onclick="OpenWindow('extReportForm.pop','외부수료증등록',1200,800);">외부 수료증등록</button>
					</div>
				</c:if>
			</div>

			<select class="form-control mb-2 form-control-sm float-left col-1" id="yearBox" onchange="YearSort()"></select>
			
			<div style="min-height:580px;">
			<table class="table mt-3 table-sm">
				<c:if test="${memClassList ne null }">
					<thead>
						<tr class="text-center" style="background-color: #E6EFFC;">
							<th class="col-md-1">강의코드</th>
							<th class="col-md-5">강의명</th>
							<th class="col-md-1">이수점수</th>
							<th class="col-md-1">진도율</th>
							<th class="col-md-2">보고서제출여부</th>
						</tr>
					</thead>
				</c:if>
				<c:if test="${extList ne null }" >
					<thead>
						<tr class="text-center" style="background-color: #E6EFFC;">
							<th class="col-md-1">강의코드</th>
							<th class="col-md-4">강의명</th>
							<th class="col-md-1">이수점수</th>
							<th class="col-md-2">이수여부</th>
							<th class="col-md-1">보고서상태</th>
						</tr>
					</thead>			
				</c:if>	
				<c:if test="${reportList ne null }">
					<thead>
						<tr class="text-center" style="background-color: #E6EFFC;">
							<th class="col-md-1">강의코드</th>
							<th class="col-md-5">강의명</th>
							<th class="col-md-2">보고서상태</th>
						</tr>
					</thead>			
				</c:if>					
				<tbody>
	<!-- ------------------------------------------------내부강의 출력 -------------------------------------------------- -->			
					<c:if test="${empty extList && empty reportList && empty memClassList}">
						<tr>
							<td colspan="5" class="text-center text-bold" style="hover: none;"><strong>해당 내용이 없습니다.</strong></td>
						</tr>
					</c:if>
					<c:if test="${not empty memClassList}">
					<c:forEach items="${ memClassList }" var="memClass">
						<tr>
							<td class="text-center">${memClass.opcl }</td>
							<td class="row">
								<img style="width: 130px; height: 90px;"	src="<%=request.getContextPath() %>/user/myPage/completedClass/getPicture.do?picture=${memClass.clImg }">
								<c:choose>
									<c:when test="${memClass.progRate eq 100}">
										<div class="col-md-8 column ui-sortable" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath() %>/user/myClass/clsStudying/detail.do?opcl=${memClass.opcl}&from=completed'">
									</c:when>
									<c:otherwise>
										<div class="col-md-8 column ui-sortable" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath() %>/user/myClass/clsStudying/detail.do?opcl=${memClass.opcl}'">
									</c:otherwise>
								</c:choose>
									<span class="h6">${memClass.clName }</span>
									<br>
									<span class="text-secondary">학습기간[ <fmt:formatDate value="${memClass.studySdate}" pattern="yyyy-MM-dd" />~ <fmt:formatDate value="${memClass.studyEdate}" pattern="yyyy-MM-dd" />]
									</span>
									<br>
									<c:if test="${memClass.clFormat eq 'A601'}">
										<span class=" badge badge-info">오프라인</span>
									</c:if>
									<c:if test="${memClass.clFormat eq 'A602'}">
										<span class=" badge badge-primary">온라인</span>
									</c:if>
									<c:if test="${memClass.clFormat eq 'A603'}">
										<span class=" badge badge-success">실시간</span>
									</c:if>
									<c:if test="${memClass.clDivision eq 'A501'}">
										<span class=" badge badge-danger">필수</span>
									</c:if>
									<c:if test="${memClass.clDivision eq 'A502'}">
										<span class=" badge badge-warning">선택</span>
									</c:if>
								</div>
							</td>
							<td class="text-center  align-middle">${memClass.clPoint}</td>
							<td class="text-center align-middle">
								<div class="progress">
									<div class="progress-bar bg-success" role="progressbar" style="width: ${memClass.progRate}%" aria-valuenow="${memClass.progRate }" aria-valuemin="0" aria-valuemax="100">${memClass.progRate }%</div>
								</div>
							</td>
							<td class="text-center align-middle">
								<c:if test="${memClass.intState eq 'B101'}">
										<span class="badge bg-warning" style="font-size: 12pt;">&nbsp;&nbsp;&nbsp;미제출&nbsp;&nbsp;&nbsp;</span>
								</c:if> 
								<c:if test="${memClass.intState eq 'B102'}">
										<span class="badge bg-primary" style="font-size: 12pt;">승인대기</span>
								</c:if> 
								<c:if test="${memClass.intState eq 'B103'}">
										<span class="badge bg-danger" style="font-size: 12pt;">&nbsp;&nbsp;&nbsp;&nbsp;반려&nbsp;&nbsp;&nbsp;&nbsp;</span>
								</c:if>
								<c:if test="${memClass.intState eq 'B104'}">
										<span class="badge bg-success " style="font-size: 12pt;">제출완료</span><br>
										<span class="text-bold mt-2" style="font-size: 10pt;cursor : pointer;"onclick="intReport_go('${memClass.memClNo}','completedList')">보고서 확인</span>
								</c:if>
								<c:if test="${memClass.intState eq 'B105'}">
										<span class="badge bg-danger" style="font-size: 12pt;">제출기한마감</span>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
		<!-- ------------------------------------------------------------------------------외부강의출력------------------------------------------------------------ -->			
				
					<c:if test="${not empty extList}">
					<c:forEach items="${ extList }" var="extList">
						<tr>
							<td class="text-center align-middle">${extList.extCode }</td>
							<td class="row">
								<img style="width: 130px; height: 90px;" src="<%=request.getContextPath()%>/resources/img/hrd2.png">
								<div class="col-md-8 column ui-sortable">
									<span class="h6" style=" overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
											<c:choose>
												<c:when test="${fn:length(extList.extClName) gt 30}">
													<c:out value="${fn:substring(extList.extClName,0,30) }..." ></c:out>
												</c:when>
												<c:otherwise>
													${extList.extClName}
												</c:otherwise>
											</c:choose>																					
									</span>
									<br>
									<span class="text-secondary">학습기간[ <fmt:formatDate value="${extList.studySdate}" pattern="yyyy-MM-dd" />~ <fmt:formatDate value="${extList.studyEdate}" pattern="yyyy-MM-dd" />]
									</span>
									<br>
										<c:if test="${extList.commonCode eq 'C301'}">
											<span class="badge bg-danger mt-2" style="font-size: 12pt;cursor : pointer;"onclick="deleteHRD('${extList.extCode}')">수강취소</span>
										</c:if>
								</div>
							</td>
							<td class="text-center align-middle">${extList.codeName1}</td>

							<td class="text-center align-middle">
								<c:if test="${extList.commonCode eq 'C301'}">
									<span class="badge bg-warning" style="font-size: 12pt;">&nbsp;&nbsp;&nbsp;이수중&nbsp;&nbsp;&nbsp;</span>
								</c:if> 
								<c:if test="${extList.commonCode eq 'C302'}">
									<span class="badge bg-primary " style="font-size: 12pt;">이수완료</span><br>
									<c:choose>
										<c:when test="${extList.extNo ne '0' }">
<%-- 											<span class="text-bold mt-2" style="font-size: 10pt;cursor : pointer;"onclick="report_go('${extList.extNo }','B104')">보고서 확인</span> --%>
										</c:when>
										<c:otherwise>
<!-- 											<span class="text-bold mt-2" style="font-size: 10pt; color: red;">보고서 미제출</span> -->
										</c:otherwise>
									</c:choose>
								</c:if> 
								<c:if test="${extList.commonCode eq 'C303'}">
									<span class="badge bg-danger " style="font-size: 12pt;">이수포기</span>
								</c:if> 
							</td>
							<td class="text-center align-middle">
								<c:if test="${extList.extState eq 'B101' ||extList.extState eq null }">
										<span class="badge bg-warning" style="font-size: 12pt;">&nbsp;&nbsp;&nbsp;미제출&nbsp;&nbsp;&nbsp;</span>
								</c:if> 
								<c:if test="${extList.extState eq 'B102'}">
										<span class="badge bg-primary" style="font-size: 12pt;">승인대기</span>
								</c:if> 
								<c:if test="${extList.extState eq 'B103'}">
										<span class="badge bg-danger" style="font-size: 12pt;">&nbsp;&nbsp;&nbsp;&nbsp;반려&nbsp;&nbsp;&nbsp;&nbsp;</span>
										<span class="text-bold mt-2" style="font-size: 10pt;cursor : pointer; color: red;"onclick="report_go('${extList.extNo}','${extList.extState }')">보고서 수정</span>
								</c:if>
								<c:if test="${extList.extState eq 'B104'}">
										<span class="badge bg-success " style="font-size: 12pt;">제출완료</span><br>
										<span class="text-bold mt-2" style="font-size: 10pt;cursor : pointer;"onclick="report_go('${extList.extNo }','B104')">보고서 확인</span>
								</c:if>
								<c:if test="${extList.extState eq 'B105'}">
										<span class="badge bg-danger" style="font-size: 12pt;">제출기한마감</span>
								</c:if>								
							</td>
							
						</tr>
					</c:forEach>					
					</c:if>
					
			<!--  -----------------------------------------------------------외부수료증 등록 리스트 ------------------------------------------------------------- -->		
			
					<c:if test="${not empty reportList}">
					<c:forEach items="${ reportList }" var="reportList">
						<tr>
							<td class="text-center align-middle">${reportList.extNo }</td>
							<td class="row">
								<img style="width: 130px; height: 90px;" src="<%=request.getContextPath()%>/resources/img/ExtReportimg.jpg">
								<div class="col-md-8 column ui-sortable">
									<span class="h6">${reportList.clName }</span>
									<br>
									<span class="text-secondary">보고서 제출일자[ <fmt:formatDate value="${reportList.extRegdate}" pattern="yyyy-MM-dd" />]
									</span>
									<br>
									<c:if test="${reportList.extState eq 'B104' || reportList.extState eq 'B103' }">
										
									</c:if> 
								</div>
							</td>
							<td class="text-center align-middle">
							<c:if test="${reportList.extState eq 'B101'}">
								<span class="badge bg-warning" style="font-size: 12pt;">&nbsp;&nbsp;미제출&nbsp;&nbsp;</span>
							</c:if> 
							<c:if test="${reportList.extState eq 'B102'}">
								<span class="badge bg-primary" style="font-size: 12pt;">승인대기</span>
							</c:if> 
							<c:if test="${reportList.extState eq 'B103'}">
								<span class="badge bg-danger" style="font-size: 12pt;">&nbsp;&nbsp;&nbsp;&nbsp;반려&nbsp;&nbsp;&nbsp;&nbsp;</span><br>
								<span class="text-bold mt-2" style="font-size: 10pt;cursor : pointer; color: red;"onclick="report_go('${reportList.extNo}','${reportList.extState }')">보고서 수정</span>
							</c:if> 
							<c:if test="${reportList.extState eq 'B104'}">
								<span class="badge bg-success" style="font-size: 12pt;">승인완료</span><br>
								<span class="text-bold mt-2" style="font-size: 10pt;cursor : pointer;"onclick="report_go('${reportList.extNo}','${reportList.extState }')">보고서 확인</span>
							</c:if> 
							<c:if test="${reportList.extState eq 'B105'}">
								<span class="badge bg-danger" style="font-size: 12pt;">제출기한마감</span>
							</c:if>
							</td>
						</tr>
					</c:forEach>					
					</c:if>
										
				</tbody>
			</table>
			</div>
<%-- 			<c:if test="${not empty memClassList}"> --%>
				<%@include file="/WEB-INF/views/common/pagination.jsp"%>
<%-- 			</c:if> --%>
<%-- 			<c:if test="${not empty extList}"> --%>
<%-- 				<%@include file="/WEB-INF/views/common/pagination.jsp"%> --%>
<%-- 			</c:if> --%>
<%-- 			<c:if test="${not empty reportList}"> --%>
<%-- 				<%@include file="/WEB-INF/views/common/pagination.jsp"%> --%>
<%-- 			</c:if> --%>
		</div>
	</section>
	<form id="sortForm">
		<input type="hidden" name="page" value="" />
		<input type="hidden" name="sortType" value="${cri.sortType}" />
	</form>
	
	<form id="searchForm">
		<input type="hidden" name="page" value="" />
		<input type="hidden" name="searchType" value="y" />
		<input type="hidden" name="keyword" value="" />
		<input type="hidden" name="sortType" value="${cri.sortType}" />
	</form>

	<script>


function deleteHRD(extCode){
	if(confirm("수강을 취소하시겠습니까?")){
		location.href="<%=request.getContextPath()%>/user/myPage/completedClass/deleteHRD.do?extCode="+extCode;
	}
	
}
function intReport_go(memClNo,fromList){
	OpenWindow("<%=request.getContextPath()%>/user/myClass/clsFinished/intReportForm.pop?memClNum="+memClNo+"&fromList="+fromList, '', 780, 850);
}

function report_go(no,extState){
	OpenWindow("<%=request.getContextPath()%>/user/myPage/completedClass/completedExtReportForm.pop?extNo="+no+"&extState="+extState, '', 1200, 800);
}

function fn_sort(page, sortOption) {
	var	url = "list.do";

	let sortForm = $('#sortForm');
	sortForm.find("[name='page']").val(page);
	sortForm.find("[name='sortType']").val(sortOption).val();

	
	
	sortForm.attr({
		action : url,
		method : 'get'
	}).submit();
}

function YearSort(){
	var year = $('#yearBox').val();
	$('[name="keyword"]').val(year);
	
	fn_list(1);
}


function fn_list(page,url){
	if (!url)
		url = "list.do";

	var searchForm = $('#searchForm');

	searchForm.find("[name='page']").val(page);

	searchForm.attr({
		action : url,
		method : 'get'
	}).submit();
}


$(document).ready(function(){
	
	var date = new Date();
	
	var selYear = date.getFullYear();
	
	getYears(selYear);
	
	$('#yearBox').val(selYear);
	
	var selectYear = ${fn:substring(cri.keyword,0,4)};
	
	$('#yearBox option[id="'+selectYear+'"]').attr("selected","selected");

	
	$('#yearBox').change(function(){
		var chgYear = $(this).val();
		getYears(chgYear);
		$('#yearBox').val(chgYear);
	});


	
});

	function getYears(getY){
		$('#yearBox option').remove();
		var stY = Number(getY)-1;
		var enY = Number(getY);
		for(var y = stY; y <= enY; y++){
			$('#yearBox').append("<option id="+y+" value='"+y+"'>"+y+" 년" + "</option>");
		}
	}
</script>

</body>
