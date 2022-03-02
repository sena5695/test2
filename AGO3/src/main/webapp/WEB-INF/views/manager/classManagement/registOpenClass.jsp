<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="studyDate" value="${dataMap.studyDateList }" />
<c:set var="room" value="${dataMap.roomList }" />
<c:set var="clCode" value="${clCode }" />
<c:set var="classList" value="${dataMap.classList}" />
<c:set var="clformat" value="${dataMap2.detail}" />
<c:set var="dpId" value="${dataMap.dpidList}" />
<head></head>

<title>강의 회차 등록</title>
<body>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">강의 회차 등록</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="#">강의관리</a>
						</li>
						<li class="breadcrumb-item active">강의 회차 등록</li>
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

			<form role="opclForm" action="registOpcl.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="openRound" value="${maxRound}">
				<input type="hidden" name="clCode" value="${clCode }">

				<section>

					<table class="table" id="infoForm">
						<tr>
							<td class="text-center" style="background-color: #E6EFFC;">강의형식</td>
							<td>${clformat.clFormat}<input type="hidden" id="clFormatvalue" name="clFormat" value="${clformat.clFormat }" />
							</td>
							<td class="text-center" style="background-color: #E6EFFC;">수강인원</td>
							<td><input type="text" name="enrPers" class="form-control col-6" placeholder="수강인원"></td>

						</tr>
						<tr>

							<td class="text-center" style="background-color: #E6EFFC;">오프라인 강의실</td>
							<td><input type="hidden" name="clRoomNo1" /> <select id="offlineRoom" class="form-control input-fixed" name="clRoomNo">
									<option selected="selected" value="0">해당없음</option>
									<c:forEach items="${room}" var="list">
										<option value="${list.clRoomNo }">${list.clRoomName}</option>
									</c:forEach>
								</select></td>
							<td class="text-center" style="background-color: #E6EFFC;">학습기간</td>
							<td><select class="form-control input-fixed col-6" name="studyDate">
									<c:forEach items="${studyDate }" var="list">
										<c:if test="${list.commonCode == 'D101'}">
											<option value="${list.commonCode}">신청일로부터 7일</option>
										</c:if>
										<c:if test="${list.commonCode == 'D102'}">
											<option value="${list.commonCode}">신청일로부터 30일</option>
										</c:if>
										<c:if test="${list.commonCode == 'D103'}">
											<option value="${list.commonCode}">제한없음</option>
										</c:if>
									</c:forEach>
								</select></td>
						</tr>
						<tr>

							<td class="text-center" style="background-color: #E6EFFC;"><c:choose>
									<c:when test="${clformat.clFormat eq '오프라인' || clformat.clFormat eq '실시간' }">강의 날짜</c:when>

									<c:otherwise>시험 선택	</c:otherwise>
								</c:choose>
							</td>
							
							<td>
								<c:choose>
									<c:when test="${clformat.clFormat eq '오프라인' || clformat.clFormat eq '실시간' }">
									<div class="row ml-1">
										<input style="width : 180px;" class="form-control" type="date" name="lecDate" />&nbsp;&nbsp;-&nbsp;&nbsp;
										<input style="width : 180px;" class="form-control" type="time" name="lecDateTime"/>
									</div>
									</c:when>

									<c:otherwise>
										<select name="testStatus" class="form-control" onchange="testFormShow();">
											<option value="1">필수</option>
											<option value="0">없음</option>
										</select>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center" style="background-color: #E6EFFC;">게시기간</td>
							<td class="row"><input type="date" name="postSdate" class="form-control col-5" placeholder="게시날짜">&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" name="postEdate" class="form-control col-5" placeholder="마감날짜"></td>

						</tr>
						<tr>
							<td class="text-center" style="background-color: #E6EFFC;"><p>부서선택</p></td>
							<td colspan="3"><c:set var="i" value="0" /> <c:set var="j" value="5" />						
													<table class="col-11">

														<tr>
															<td colspan="6">
																<div class="custom-control custom-checkbox ml-2">
																	<input type="checkbox" class="custom-control-input check-all" name="dpId" id="customCheckboxAll"> 
																	<label for="customCheckboxAll" class="custom-control-label">전체</label>
																</div>
															</td>
														</tr>

														<tr>
															<c:forEach items="${dpId}" var="list" varStatus="status" begin="1" end="5">
																<td>
																	<div class="custom-control custom-checkbox ml-2">
																		<input class="custom-control-input individual" name="dpId" type="checkbox" id="customCheckbox${status.index }" value="${list.commonCode }"> <label for="customCheckbox${status.index }" class="custom-control-label">${list.codeName1}</label>
																	</div>
																</td>
															</c:forEach>
														</tr>

														<tr>
															<c:forEach items="${dpId}" var="list" varStatus="status" begin="6" end="10">
																<td>
																	<div class="custom-control custom-checkbox ml-2">
																		<input class="custom-control-input individual" name="dpId" type="checkbox" id="customCheckbox${status.index }" value="${list.commonCode }"> <label for="customCheckbox${status.index }" class="custom-control-label">${list.codeName1}</label>
																	</div>
																</td>
															</c:forEach>
														</tr>

														<tr>
															<c:forEach items="${dpId}" var="list" varStatus="status" begin="11" end="13">
																<td>
																	<div class="custom-control custom-checkbox ml-2">
																		<input class="custom-control-input individual" name="dpId" type="checkbox" id="customCheckbox${status.index }" value="${list.commonCode }"> <label for="customCheckbox${status.index }" class="custom-control-label">${list.codeName1}</label>
																	</div>
																</td>
															</c:forEach>
														</tr>

													</table>
	                       		
							</td>
						</tr>						
					</table>

					<table class="table">
						<tr>
							<td>수료기준안내</td>
						</tr>
						<tr>
							<td><textarea class="textarea" name="cutline" id="content" rows="10" placeholder="1000자 내외로 작성하세요." style="display: none;"></textarea> <%@ include file="/WEB-INF/views/common/summernote.jsp"%></td>
						</tr>
					</table>
				</section>
				<section class="col-12">
					<div class="ml-2">
						<c:if test="${clformat.clFormat ne '오프라인' && clformat.clFormat ne '실시간' }">
							<div id="testDiv">
								<div class="row">
									<label class="col-2">중간 평가 :</label>
									<label for="mtest" class=" btn btn-sm btn-flat input-group-addon">
										<i class="fas fa-file-excel" style="font-size: 2em;"></i>
									</label>
									<input id="inputFileNameMtest" class="form-control col-6 " type="text" disabled placeholder="Excel(xlsx)" />
									<input type="file" onclick="testCheck()" name="mtestFile" class="form-control-file col-10 checkExcel" id="mtest" accept=".xlsx" onchange="checkExcel('mtestFile','inputFileNameMtest');" style="display: none;">
									<br>
									<button type="button" class="btn btn-outline-secondary btn-block btn-flat col-3 ml-2" style="height: 38px;" onclick="location.href='<%=request.getContextPath()%>/manager/classManagement/getClassExcelMtestFileForm.do'">
										<i class="fas fa-arrow-alt-circle-down"></i> &nbsp;중간평가 양식
									</button>
								</div>
								<div class="row">
									<label class="col-2">최종 평가 :</label>
									<label for="ftest" class=" btn btn-sm btn-flat input-group-addon">
										<i class="fas fa-file-excel" style="font-size: 2em;"></i>
									</label>
									<input id="inputFileNameFtest" class="form-control col-6 " type="text" disabled placeholder="Excel(xlsx)" />
									<input type="file" onclick="testCheck()" name="ftestFile" class="form-control-file col-10 checkExcel" id="ftest" accept=".xlsx" onchange="checkExcel('ftestFile','inputFileNameFtest');" style="display: none;">
									<button type="button" class="btn btn-outline-secondary btn-block btn-flat col-3 ml-2" style="height: 38px;" onclick="location.href='<%=request.getContextPath()%>/manager/classManagement/getClassExcelFtestFileForm.do'">
										<i class="fas fa-arrow-alt-circle-down"></i> &nbsp;최종평가 양식
									</button>
								</div>
							</div>
						</c:if>
						<table class="table">
							<tr>
								<td class="col-2"><label class="">강의 자료</label></td>
								<td id="insertFile" class="row">
									<label for="preference" class=" btn btn-info btn-sm btn-flat input-group-addon" style="height: 38px;">파일선택</label> <input id="inputFileNameDoc" class="form-control col-7 justify-content-center" type="text" disabled/> <input type="file" class="form-control-file" id="preference" name="DocName" onchange="docName('DocName','inputFileNameDoc')" style="display: none;">
									<button type="button" class="btn btn-success col-3 ml-2" style="height: 38px;" onclick="addClick()">추가</button>
								</td>
							</tr>
						</table>
						<table class="table" id="add_table">
							<tr class="text-center">
								<th class="col-2">강의자료</th>
								<th class="col-1">비고</th>
							</tr>
						</table>						
						</div>
					<button class="btn btn-secondary float-right" type="button" onclick="registOpcl()">등록</button>
				</section>
			</form>
		</div>
	</section>
	<script>
		window.onload = function() {
			summernote_go($('textarea#content'), true);
			//offlineForm();
			var formatValue = $('#clFormatvalue').val();

			if (formatValue == '오프라인') {
				$('select[name="clRoomNo"]').attr("disabled", false);
			} else {
				$('select[name="clRoomNo"]').attr("disabled", true);
				$('input[name=clRoomNo1]').val(0);
			}
			$( '.check-all' ).click( function() {
			    $( '.individual' ).prop( 'checked', this.checked );
			});
		}
		
		function testFormShow(){
			var status = $('[name="testStatus"]').val();
			
			if(status == 1){
				$('#testDiv').show();
			}
			if(status == 0){
				$('#testDiv').hide();
			}
		}

		function offlineForm() {

			var $addTR = $('<tr><td></td><td></td><td class="text-center" style="background-color : #E6EFFC;">강의날짜</td><td></td></tr>');

			if ($('#clFormatvalue').val() == '오프라인'
					|| $('#clFormatvalue').val() == '실시간') {
				$('#infoForm').append($addTR);

				$('[name="testStatus"]').val(0);

				$('[name="testStatus"]').attr("disabled", true);
			}
		}

		function testCheck() {
			if ($('[name="testStatus"]').val() == 0) {
				alert("시험이 필요하지 않는 강의입니다.");
				return false;
			}

		}

		function addClick() {

			//			var insertFile = $('<input type="file" name="clDocName" class="form-control-file" style="display : none;" value="'+$('#preference').val()+'">');
			var $insertFile = $('#preference').clone();
			$insertFile.attr("style", "display:none;");
			$insertFile.attr("name", "clDocName");
			$insertFile.removeAttr("id");

			$('#insertFile').append($insertFile);

			var fileName = $('#preference').val();

			var onlyName = fileName.substr(fileName.lastIndexOf('\\') + 1,
					fileName.length);

			$('#add_table')
					.append(
							"<tr class='text-center'>"
									+ "<td>"
									+ onlyName
									+ "</td>"
									+ "<td>"
									+ "<button type='button' class='btn btn-danger btn-xs' onclick='rowDelete()'>제거</button>"
									+ "</td>");

		}

		function rowDelete() {
			var trCnt = $('#add_table tr').length;
			if (trCnt >= 1) {
				$('#add_table > tbody:last > tr:last').remove();
			} else {
				return false;
			}
		}

		function filediv() {
			$('#filediv').removeAttr("style")
		}

		//파일 고른게 엑셀인지 아닌지 
		function checkExcel(name, id) {

			let form = $('form[role="opclForm"]');
			var FileName = form.find('[name=' + name + ']')[0];

			//		var checkInput = $('.checkExcel').val();

			document.getElementById(id).value = FileName.files[0].name;

			//			let mtest = mtestName.value.substr(mtestName.value.lastIndexOf('.')+1).toUpperCase();

			let excel = FileName.value.substr(
					FileName.value.lastIndexOf('.') + 1).toUpperCase();

			if (!(excel == "XLSX" || excel == "XLX")) {
				alert("파일은 엑셀 형식의 xlsx만 가능합니다.");
				checkInput.value = "";
				return;
			}

		}

		function registOpcl() {
			form = $('form[role="opclForm"]')[0];
			formData = new FormData(form);

			$.ajax({
				url : 'registOpcl.do',
				data : formData,
				type : 'post',
				processData : false,
				contentType : false,
				success : function(data) {
					alert(data);
					window.opener.location.reload();
					window.close();

				},
				error : function(error) {
					//alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
					AjaxErrorSecurityRedirectHandler(error.status);
					console.log(error.status);
				}
			})
		}

		function testCheck() {
			var testvalue = $('input[name="testStatus"]').val();
			if (testvalue == 0) {
				$('#testDiv').attr("display", "none");
			}
		}
		
		function addClick() {

			//			var insertFile = $('<input type="file" name="clDocName" class="form-control-file" style="display : none;" value="'+$('#preference').val()+'">');
			var $insertFile = $('#preference').clone();
			$insertFile.attr("style", "display:none;");
			$insertFile.attr("name", "clDocName");
			$insertFile.removeAttr("id");

			$('#insertFile').append($insertFile);

			var fileName = $('#preference').val();

			var onlyName = fileName.substr(fileName.lastIndexOf('\\') + 1,
					fileName.length);

			$('#add_table')
					.append(
							"<tr>"
									+ "<td>"
									+ onlyName
									+ "</td>"
									+ "<td class='text-center'>"
									+ "<button type='button' class='btn btn-danger btn-xs' onclick='rowDelete()'>제거</button>"
									+ "</td>");

		}
		
		function docName(name, id) {

			let form = $('form[role="opclForm"]');
			var FileName = form.find('[name=' + name + ']')[0];

			//		var checkInput = $('.checkExcel').val();

			document.getElementById(id).value = FileName.files[0].name;		
		}		
	</script>

</body>
