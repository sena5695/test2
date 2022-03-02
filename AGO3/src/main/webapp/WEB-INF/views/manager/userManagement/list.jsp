<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${pageMaker.cri }" />
<c:set var="memberList" value="${dataMap.memberList }" />
<c:set var="depList" value="${dataMap.depList }" />

<head></head>

<title></title>
<body>
<script>
if(${from eq "regist"}){
	alert("등록되었습니다.");
	window.opener.location.reload();
	window.close();
}
</script>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">

					<h4 class="m-0">회원목록</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="#">회원관리</a>
						</li>
						<li class="breadcrumb-item active">회원목록</li>
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
					<select class="col-md-2 form-control" name="searchType" id="searchType" style="height: 39px;" >
						<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>이름</option>
						<option value="p" ${cri.searchType eq 'p' ? 'selected':'' }>직위</option>
					</select>
					<input type="text" name="keyword" placeholder="검색할 단어를 입력하세요" class="form-control col-md-7" value="${ cri.keyword }">
					<button type="button" class="col-md-1 btn btn-secondary float-right" onclick="list_go(1);">검색</button>
				</div>
			</div>
			<table class="col-md-12">
				<tr class="text-center">
					<td class="float-left">
						<select class="form-control form-control-sm" data-clue="d" name="department" onchange="fn_group(1);">

							<option value="${cri.sortType eq '' ? 'selected':'' }">전체</option>
							<option value="DP101" ${cri.sortType eq 'DP101' ? 'selected':'' }>총무부</option>
							<option value="DP102" ${cri.sortType eq 'DP102' ? 'selected':'' }>경리부</option>
							<option value="DP103" ${cri.sortType eq 'DP103' ? 'selected':'' }>구매자재부</option>
							<option value="DP104" ${cri.sortType eq 'DP104' ? 'selected':'' }>품질관리부</option>
							<option value="DP105" ${cri.sortType eq 'DP105' ? 'selected':'' }>생산1팀</option>
							<option value="DP106" ${cri.sortType eq 'DP106' ? 'selected':'' }>생산2팀</option>
							<option value="DP107" ${cri.sortType eq 'DP107' ? 'selected':'' }>상품관리부</option>
							<option value="DP108" ${cri.sortType eq 'DP108' ? 'selected':'' }>기술부</option>
							<option value="DP109" ${cri.sortType eq 'DP109' ? 'selected':'' }>해외영업부</option>
							<option value="DP110" ${cri.sortType eq 'DP110' ? 'selected':'' }>국내영업부</option>
							<option value="DP111" ${cri.sortType eq 'DP111' ? 'selected':'' }>고객관리부</option>
							<option value="DP112" ${cri.sortType eq 'DP112' ? 'selected':'' }>개발부</option>
							<option value="DP113" ${cri.sortType eq 'DP113' ? 'selected':'' }>부설연구소</option>

						</select>
					</td>
					<td style="text-align: right;"><span class="text-muted" style="color: gray; cursor: pointer;" onclick="OpenWindow('registUserForm','회원등록',800,500);">등록</span> <span class="text-muted" style="color: gray;">|</span> <span class="text-muted" style="color: gray; cursor: pointer;" onclick="OpenWindow('registExcel.pop','회원등록',810,500)">엑셀로 등록하기</span></td>
				</tr>
			</table>
			
			<div style="min-height:570px;">
			<table class="table mt-1 table-hover table-sm">
				<thead>
					<tr class="text-center" style="background-color: #F5F4F4;">
						<th class="col-2">부서</th>
						<th class="col-1">직위</th>
						<th class="col-2">성명</th>
						<th class="col-2">수강중&nbsp;|&nbsp;수강현황</th>
						<th>연락처</th>
						<th>이메일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty memberList }">
						<tr>
							<td colspan="6">해당 정보가 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach items="${memberList }" var="member">

					<tr class="text-center" style="cursor:pointer;" onclick="OpenWindow('detailUser.pop?memEmail=${member.memEmail}','회원상세', 1000,500);">
						<c:if test="${member.dpId eq 'DP101'}">
							<td>총무부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP102'}">
							<td>경리부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP103'}">
							<td>구매자재부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP104'}">
							<td>품질관리부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP105'}">
							<td>생산1팀</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP106'}">
							<td>생산2팀</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP107'}">
							<td>상품관리부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP108'}">
							<td>기술부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP109'}">
							<td>해외영업부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP110'}">
							<td>국내영업부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP111'}">
							<td>고객관리부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP112'}">
							<td>개발부</td>
						</c:if>
						<c:if test="${member.dpId eq 'DP113'}">
							<td>부설연구소</td>
						</c:if>

						<c:if test="${member.positionId eq 'PS101' }">
							<td>사원</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS102' }">
							<td>주임</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS103' }">
							<td>대리</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS104' }">
							<td>과장</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS105' }">
							<td>차장</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS106' }">
							<td>부장</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS107' }">
							<td>이사</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS108' }">
							<td>상무</td>
						</c:if>
						<c:if test="${member.positionId eq 'PS109' }">
							<td>대표</td>
						</c:if>

						<td>${member.memName }</td>
						<td>
							<span class="badge badge-info right">${member.c101Cnt }</span>
							&nbsp;|&nbsp;
							<span class="badge badge-success right">${member.c103Cnt }</span>
						</td>
						<td><a href="tel:${member.memPhone }">${member.memPhone }</a></td>
						<td><a href="mailto:${member.memEmail }">${member.memEmail }</a></td>
					</tr>

					</c:forEach>

				</tbody>
			</table>
			</div>
			<div class="card-body text-center">
				<%@include file="/WEB-INF/views/common/pagination.jsp"%>
			</div>
		</div>
	</section>


<form id=deptForm>
	<input type='hidden' id='group' name="searchType" value="" />
	<input type='hidden' id="groupNm" name="sortType" value=""/>
	<input type="hidden" name="page" value="" />
</form>


<script>
 function fn_bySection(){
	 var type = $('select[name="department"]').attr("data-clue");
	 console.log(type);

 }

 function fn_group(page,url){
	 if(!url) url="list.do";

	 var deptForm = $('#deptForm');

	 var type = $('select[name="department"]').attr("data-clue");
	 $('#group').val(type);
	 $('#groupNm').val($('select[name="department"]').val());
	 deptForm.find("[name='page']").val(page);

	 deptForm.attr({
		 action : url,
		 method : 'get'
	 }).submit();
 }


</script>


</body>

