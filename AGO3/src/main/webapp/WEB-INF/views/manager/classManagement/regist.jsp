<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="clCate" value="${dataMap.cateList}" />
<c:set var="dpId" value="${dataMap2.dpidList}" />
<c:set var="classList" value="${dataMap.classList}" />
<c:set var="studyDate" value="${dataMap2.studyDateList }" />
<c:set var="room" value="${dataMap2.roomList }" />
<c:set var="formatList" value="${dataMap.formatList }" />
<c:set var="divisionList" value="${dataMap.divisionList }" />


<head></head>

<title></title>

<body>

	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">강의등록</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><i class="fas fa-home"></i></li>
						<li class="breadcrumb-item"><a href="#">강의관리</a></li>
						<li class="breadcrumb-item active">강의 등록</li>
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
			<div class="col-12">
				<form role="classForm" class="form-horizontal" action="regist.do" method="post" enctype="multipart/form-data">
					<div class="card card-primary card-outline card-outline-tabs">
						<div class="card-header p-0 border-bottom-0">
							<ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
								<li class="nav-item"><a class="nav-link active"  id="custom-tabs-four-home-tab" data-toggle="pill" href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home" aria-selected="true">기본정보</a></li>
								<li class="nav-item"><a class="nav-link" onclick=" iframeResize(this)" id="custom-tabs-four-profile-tab" data-toggle="pill" href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" aria-selected="false">강의정보</a></li>
								<li class="nav-item"><a class="nav-link"  id="custom-tabs-four-profile-attach" data-toggle="pill" href="#custom-tabs-four-attach" role="tab" aria-controls="custom-tabs-four-attach" aria-selected="false">첨부파일</a></li>
							</ul>
						</div>
						<div class="card-body" style="min-height: 600px;">
							<div class="tab-content" id="custom-tabs-four-tabContent">
								<div class="tab-pane fade  active show" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
									<input type="hidden" name="clImg" />
									<div class="row">
										<section>
											<div>
												<div class="input-group col-12">
													<div class="col-md-12">
														<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid gray; height: 230px; width: 190px; margin: 0 auto;"></div>
														<div class="mailbox-attachment-info">
															<div class="input-group input-group-sm">
																<label for="inputFile" class=" btn btn-info btn-sm btn-flat input-group-addon">파일선택</label> <input id="inputFileName" class="form-control" type="text" name="tempPicture" disabled /> <span class="input-group-append-sm">
																	<button type="button" class="btn btn-secondary btn-sm btn-append" onclick="upload_go();">업로드</button>
																</span>
															</div>
														</div>
													</div>
												</div>
											</div>
										</section>
										<section style="width: 830px;">
											<div class="col-md-12">
												<table class="table table-sm">
													<tr>
														<td>강의명 :</td>
														<td><input type="text" name="clName" class="form-control form-control-sm " id="smallInput" placeholder="강의명"></td>
														<td>강의구분 :</td>
														<td><select class="form-control input-fixed" name="clDivision">
																<c:forEach items="${divisionList }" var="list">
																	<option value="${list.commonCode}">${list.codeName1 }</option>
																</c:forEach>
														</select></td>
													</tr>
													<tr>
														<td>강의분류 :</td>
														<td><select class="form-control form-control-sm input-fixed" name="clCate" onchange="checkboxabled();">
																<c:forEach items="${clCate }" var="list">
																	<option value="${list.commonCode}">${list.codeName1}</option>
																</c:forEach>


														</select></td>


														<td>이수시간 :</td>
														<td><input type="text" name="clCreditTime" class="form-control form-control-sm" placeholder="이수시간"></td>
													</tr>
													<tr>
														<td>이수점수 :</td>
														<td><input type="text" name="clPoint" class="form-control form-control-sm" placeholder="이수점수"></td>
														<td>강의형식 :</td>
														<td><select class="form-control form-control-sm input-fixed" name="clFormat" onchange="offline()">
																<c:forEach items="${formatList }" var="list">
																	<option value="${list.commonCode}">${list.codeName1 }</option>
																</c:forEach>
														</select></td>

													</tr>

												</table>
											</div>
										</section>
									</div>
									<br>
									<div class="row">
										<section class="col-12">
											<table class="table table-sm">
												<tr>
													<td>과정소개</td>
												</tr>
												<tr>
													<td>
													<textarea class="form-control" id="comment" rows="7" name="clIntro" style="resize: none;">구매관리실무 교육을 통해 구매관리의 목적과 주요기능 그리고 원칙에 대해
													</textarea>
													</td>
												</tr>
											</table>
										</section>

									</div>
									<!-- 								<input type="submit" class="btn btn-primary float-right" value="파일 등록"> -->
									<button class="btn btn-sm btn-default float-right" type="button" onclick="location.href='list.do'">취소</button>
									<button class="btn btn-sm btn-primary float-right  mr-1" type="button" onclick="nextButton()">다음</button>
								</div>

								<div class="tab-pane fade" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
									<input type="hidden" name="clCode" value="${clCode }">
									<section>
										<table class="table table-sm">
											<tr>
												<td class="text-center col-2 " style="background-color: #E6EFFC;">강의형식</td>
												<td class="col-4"><label id="readonlyformat" class="ml-1"></label></td>

												<td class="text-center col-2" style="background-color: #E6EFFC;">수강인원</td>
												<td><input type="text" name="enrPers" class="form-control  form-control-sm col-6" placeholder="수강인원"></td>

											</tr>
											<tr>
												<td class="text-center" style="background-color: #E6EFFC;">강의실</td>
												<td><input type="hidden" name="clRoomNo1" /> <select id="offlineRoom" class="form-control form-control-sm input-fixed" name="clRoomNo">
														<option selected="selected" value="0">해당없음</option>
														<c:forEach items="${room}" var="list">
															<option value="${list.clRoomNo }">${list.clRoomName}</option>
														</c:forEach>
												</select></td>
												<td class="text-center" style="background-color: #E6EFFC;">학습기간</td>
												<td><select class="form-control form-control-sm input-fixed col-6" name="studyDate">
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
												<td class="text-center align-middle" style="background-color: #E6EFFC;"><p class="onlineSelect">시험 선택</p>
													<p class="NonlineSelect">강의날짜</p></td>
												<td>
													<select name="testStatus" class="form-control form-control-sm onlineSelect" onchange="testCheck()">
														<option value="1">필수</option>
														<option value="0">없음</option>
													</select>
													<div class="row ml-1 NonlineSelect" id="NonlineSelect"> 
														<input style="width : 180px;" class="form-control form-control-sm" type="date" name="lecDate"/>&nbsp;&nbsp;-&nbsp;&nbsp;<input name="lecDateTime" type="time">
													</div>
												</td>
												<td class="text-center align-middle" style="background-color: #E6EFFC;">게시기간</td>
												<td class="row"><input type="date" name="postSdate" class="form-control form-control-sm col-5 ml-2" placeholder="게시날짜">&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" name="postEdate" class="form-control form-control-sm col-5" placeholder="마감날짜"></td>

											</tr>

											<tr>
												<td class="text-center align-middle" style="background-color: #E6EFFC;"><p>부서선택</p></td>
												<td colspan="6"><c:set var="i" value="0" /> <c:set var="j" value="5" />


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
															<c:forEach items="${dpId}" var="list" varStatus="status" begin="0" end="4">
																<td>
																	<div class="custom-control custom-checkbox ml-2">
																		<input class="custom-control-input individual" name="dpId" type="checkbox" id="customCheckbox${status.index }" value="${list.commonCode }"> <label for="customCheckbox${status.index }" class="custom-control-label">${list.codeName1}</label>
																	</div>
																</td>
															</c:forEach>
														</tr>

														<tr>
															<c:forEach items="${dpId}" var="list" varStatus="status" begin="5" end="9">
																<td>
																	<div class="custom-control custom-checkbox ml-2">
																		<input class="custom-control-input individual" name="dpId" type="checkbox" id="customCheckbox${status.index }" value="${list.commonCode }"> <label for="customCheckbox${status.index }" class="custom-control-label">${list.codeName1}</label>
																	</div>
																</td>
															</c:forEach>
														</tr>

														<tr>
															<c:forEach items="${dpId}" var="list" varStatus="status" begin="10" end="12">
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

									</section>

									<div class="row">
										<table class="table table-sm">
											<tr>
												<td>수료기준안내</td>
											</tr>
											<tr>
												<td>
													<textarea class="textarea" name="cutline" id="content" rows="6" placeholder="1000자 내외로 작성하세요." style="display: none;">학습기간 내에 목차에 있는 모든 강의 진도율 100%를 완성하고
시험이 있는 경우 70점 이상 만족해야합니다. </textarea> 
													<%@ include file="/WEB-INF/views/common/summernote.jsp"%>
													</td>
											</tr>
										</table>
									</div>
									<button class="btn btn-sm btn-default float-right" type="button" onclick="location.href='list.do'">취소</button>
									<button class="btn btn-sm btn-primary float-right  mr-1" type="button" onclick="nextButton2()">다음</button>
								</div>

								<div class="tab-pane fade" id="custom-tabs-four-attach" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">

									<section class="col-12">
										<table class="table col-12 teble-sm" id="fileTable">
											<thead>
												<tr>
													<th colspan="2" class="p-1 ml-4"><span class="text-danger">※반드시 양식을 다운받아 양식에 맞춰 파일을 업로드해주세요.</span></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="col-1"><label>강의 목차</label></td>
													<td class="row"><label for="chapterFile" onclick="" class=" btn btn-info btn-sm btn-flat input-group-addon" style="height: 38px;">파일선택</label> <input id="inputFileNameChapter" class="form-control col-6 " type="text" disabled placeholder="Excel(xlsx)" /> <input type="file" name="clChapName" class="form-control-file col-8 checkExcel" id="chapterFile" style="display: none;" accept=".xlsx" onchange="checkExcel('clChapName','inputFileNameChapter');">
														<button type="button" class="btn btn-outline-secondary btn-block btn-flat col-3 ml-2" style="height: 38px;" onclick="location.href='<%=request.getContextPath()%>/manager/classManagement/getClassExcelFileForm.do'">
															<i class="fas fa-arrow-alt-circle-down"></i> &nbsp;강의목차 양식
														</button></td>
												</tr>

												<tr id="mtestTR">
													<td><label>중간 평가</label></td>
													<td class="row"><label for="mtest" onclick="alertTest()" class="btn btn-info btn-sm btn-flat input-group-addon" style="height: 38px;">파일선택</label> <input id="inputFileNameMtest" class="form-control col-6 " type="text" disabled placeholder="Excel(xlsx)" /> <input type="file" name="mtestFile" class="form-control-file col-10 checkExcel" id="mtest" accept=".xlsx" onchange="checkExcel('mtestFile','inputFileNameMtest');" style="display: none;"> <br>
														<button type="button" class="btn btn-outline-secondary btn-block btn-flat col-3 ml-2" style="height: 38px;" onclick="location.href='<%=request.getContextPath()%>/manager/classManagement/getClassExcelMtestFileForm.do'">
															<i class="fas fa-arrow-alt-circle-down"></i> &nbsp;중간평가 양식
														</button></td>
												</tr>

												<tr id="ftestTR">
													<td class="align-middle"><label>최종 평가</label></td>

													<td class="row"><label for="ftest" onclick="alertTest()" class=" btn btn-info btn-sm btn-flat input-group-addon" style="height: 38px;">파일선택</label> <input id="inputFileNameFtest" class="form-control col-6 " type="text" disabled placeholder="Excel(xlsx)" /> <input type="file" name="ftestFile" class="form-control-file col-10 checkExcel" id="ftest" accept=".xlsx" onchange="checkExcel('ftestFile','inputFileNameFtest');" style="display: none;">
														<button type="button" class="btn btn-outline-secondary btn-block btn-flat col-3 ml-2" style="height: 38px;" onclick="location.href='<%=request.getContextPath()%>/manager/classManagement/getClassExcelFtestFileForm.do'">
															<i class="fas fa-arrow-alt-circle-down"></i> &nbsp;최종평가 양식
														</button></td>
												</tr>

											</tbody>
										</table>

										<table class="table">
											<tr>
												<td class="col-1"><label class="">강의 자료</label></td>
												<td id="insertFile" class="row">
													<label for="preference" class=" btn btn-info btn-sm btn-flat input-group-addon" style="height: 38px;">파일선택</label> <input id="inputFileNameDoc" class="form-control col-6 justify-content-center" type="text" disabled/> <input type="file" class="form-control-file" id="preference" name="DocName" onchange="docName('DocName','inputFileNameDoc')" style="display: none;">
													<button type="button" class="btn btn-success col-3 ml-2" style="height: 38px;" onclick="addClick()">추가</button>
												</td>
											</tr>
										</table>
										<div style="min-height: 150px;">
											<table class="table" id="add_table">
												<tr class="text-center">
													<th class="col-2">강의자료</th>
													<th class="col-1">비고</th>
												</tr>
											</table>
										</div>
										<button class="btn btn-sm btn-secondary float-right" type="button" onclick="registClass();">등록</button>
										<button class="btn btn-sm btn-default float-right  mr-1" type="button" onclick="location.href='list.do'">취소</button>
									</section>
								</div>
							</div>
							<!-- /.card -->
						</div>
					</div>
				</form>
			</div>

		</div>
	</section>


	<form role="imageForm" action="upload/picture" method="post" enctype="multpart/form-data">
		<input type="file" id="inputFile" name="pictureFile" class="form-control" onchange="picture_go();" style="display: none;" /> <input type="hidden" id="oldFile" name="oldpicture" value="" /> <input type="hidden" name="checkUpload" value="0">
	</form>



	<script>
		window.onload = function() {
			summernote_go($('textarea#content'), true);
			document.querySelector('div[role="textbox"]').setAttribute("style", "height:230px;");
			formatSetting();
			offline();

			$('input[name="clRoomNo1"]').val("0");
			
			$( '.check-all' ).click( function() {
			    $( '.individual' ).prop( 'checked', this.checked );
			});
		}
		
			  
			   
			   
	
		  
		function iframeResize(click) {
			window.parent.document.getElementById("ifr").setAttribute("style","width : 100%; height : 900px;");
		}

		function testCheck() {

			if ($('[name="testStatus"]').val() == 0) {
				$('#mtest').attr("disabled", true);
				$('#ftest').attr("disabled", true);
				
				$('#mtestTR').hide();
				$('#ftestTR').hide();
			} else {
				$('#mtest').removeAttr("disabled");
				$('#ftest').removeAttr("disabled");
				$('#mtestTR').show();
				$('#ftestTR').show();
			}

		}

		function alertTest() {

			if ($('[name="testStatus"]').val() == 0) {
				alert("시험이 필요하지 않은 강의입니다.");
			}
		}

		function formatSetting() {
			var clformat = $('select[name=clFormat]').val();
			if (clformat == 'A601') {
				$('#readonlyformat').text("오프라인");
				$("select[name=studyDate]").val("D103").prop("selected", true);
				$("select[name=studyDate]").attr("disabled","disabled");

			} else if (clformat == 'A602') {
				$('#readonlyformat').text("온라인");
				$("select[name=studyDate]").val("D101").prop("selected", true);
				$("select[name=studyDate]").removeAttr("disabled");
			} else {
				$('#readonlyformat').text("실시간");
				$("select[name=studyDate]").val("D103").prop("selected", true);
				$("select[name=studyDate]").attr("disabled","disabled");
			}
		}
		
		function nextButton() {
			if(next()){
				$('#custom-tabs-four-profile-tab').trigger("click");
			}
		}
		function nextButton2() {
			if(next2()){
				$('#custom-tabs-four-profile-attach').trigger("click");				
			}
		}
		function next() {
			if ($('input[name="pictureFile"]').val() == "") {
				$('input[name="pictureFile"]').focus();
				alert("썸네일을 선택해주세요.");
				return false;
			}
			if ($('input[name="clName"]').val() == "") {
					$('input[name="clName"]').focus();
					alert("강의명을 작성해주세요.");
					return false;
			}

			if ($('input[name="clCreditTime"]').val() == "") {
					$('input[name="clCreditTime"]').focus();
					alert("이수시간을 설정해주세요.");
					return false;
			}

			if ($('input[name="clPoint"]').val() == "") {
				$('input[name="clPoint"]').focus();
				alert("이수점수를 설정해주세요.");
				return false;
			}
			
			return true;

		}
		
		function next2() {
			if ($('input[name="enrPers"]').val() == "") {
				$('input[name="enrPers"]').focus();
				alert("수강인원을 배정해주세요.");
				return false;
			} 
			

			if ($('input[name="clPoint"]').val() == "") {
				$('input[name="clPoint"]').focus();
				alert("이수점수를 설정해주세요.");
				return false;
			}
		 if ($('input[name="postSdate"]').val() == "") {
			$('input[name="postSdate"]').focus();
			alert("게시시작날짜를 선택해주세요.");
			return false;
		}

		if ($('input[name="postSdate"]').val() == "") {
			$('input[name="postSdate"]').focus();
			alert("게시마감날짜를 작성해주세요.");
			return false;
		}

		if ($('select[name="clCate"]').val() != 'A203' && $('input[name="dpId"]').val() == "") {
			$('input[name="dpId"]').focus();
			alert("강의에 해당하는 부서를 설정해주세요.");
			return false;
		}

		return true;
		}		
		
		
		

		function registClass() {
			
			if(confirm("등록하시겠습니까?")){
				var clformat = $('select[name=clFormat]').val();
				if (clformat == 'A602'){
					if ($('[name="testStatus"]').val() == 1) {
						if($('input[id="inputFileNameFtest"]').val()==""){
							alert("시험등록이 필수입니다 시험을 선택해주세요.");
							return;
						}
					}
				}


				form = $('form[role="classForm"]')[0];
				formData = new FormData(form);

				$.ajax({
					url : 'regist.do',
					data : formData,
					type : 'post',
					processData : false,
					contentType : false,
					success : function(data) {
						location.href = "list.do";
					},
					error : function(error) {
						//alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
						AjaxErrorSecurityRedirectHandler(error.status);
						console.log(error.status);
					}
				})				
			}

		}

		function offline() {
			var format = $('[name=clFormat]').val();
			if (format == "A601" || format == "A603") {
				$('[name=clRoomNo]').removeAttr("disabled");
			} else {
				$('[name=clRoomNo] option[selected=selected]').removeAttr(
						"selected");
				$('#empty').attr("selected", "selected");
				$('[name=clRoomNo]').attr("disabled", true);
			}

			formatSetting();

			if (format == "A601" || format == "A603") {
				$('.onlineSelect').hide();
				$('.NonlineSelect').show();
				$('#NonlineSelect').removeAttr("disabled");

				$('#fileTable').hide();
				// 				$('#mtestTR').hide();
				// 				$('#ftestTR').hide();
			} else {
				$('.onlineSelect').show();
				$('.NonlineSelect').hide();
				$('#NonlineSelect').attr("disabled", true);

				$('#fileTable').show();
				// 				$('#mtestTR').show();
				// 				$('#ftestTR').show();
			}

		}

		let formData = "";
		function picture_go() {
			formData = new FormData($('form[role="imageForm"]')[0]);

			let form = $('form[role="imageForm"]');
			let picture = form.find('[name=pictureFile]')[0];

			// 		 	console.log(picture.value); 		//전체경로
			// 		 	console.log(picture.files[0].name); //파일명

			//이미지 확장자 jpg 확인
			let fileFormat = picture.value.substr(
					picture.value.lastIndexOf('.') + 1).toUpperCase();
			if (!(fileFormat == "JPG" || fileFormat == "JPEG")) {
				alert("이미지는 jpg/jpeg 형식만 가능합니다.");
				picture.value = "";
				return;
			}

			//이미지 파일 용량 체크
			if (picture.files[0].size > 1024 * 1024 * 5) {
				alert("사진 용량은 5MB 이하만 가능합니다.");
				picture.value = "";
				return;
			}

			//업로드 확인변수 초기화(사진 변경)
			form.find('[name="checkUpload"]').val(0);

			document.getElementById('inputFileName').value = picture.files[0].name;

			if (picture.files && picture.files[0]) {
				let reader = new FileReader();
				reader.onload = function(e) {
					$('div#pictureView').css({
						'background-image' : 'url(' + e.target.result + ')',
						'background-position' : 'center',
						'background-size' : 'cover',
						'background-repeat' : 'no-repeat'
					});
				}
				reader.readAsDataURL(picture.files[0]);
			}
		}

		function upload_go() {
			if (!$('input[name="pictureFile"]').val()) {
				alert("사진을 선택하세요");
				$('input[name="pictur	eFile"]').click();
				return;
			}
			if ($('input[name="checkUpload"]').val() == 1) {
				alert("이미 업로드 된 사진입니다.");
				return;
			}

			$.ajax({
				url : 'picture',
				data : formData,
				type : 'post',
				processData : false,
				contentType : false,
				success : function(data) {
					//업로드 확인 변수 세팅
					$('input[name="checkUpload"]').val(1);

					//저장된 파일명 저장
					$('input#oldFile').val(data); //변경시 삭제될 파일명
					$('form[role="classForm"] input[name="clImg"]').val(data);
					alert("사진이 업로드 되었습니다.");
				},
				error : function(error) {
					//alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
					AjaxErrorSecurityRedirectHandler(error.status);
					console.log(error.status);
				}
			})
		}

		function checkExcel(name, id) {

			let form = $('form[role="classForm"]');
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
		
		function checkboxabled(){
			var selectedVal = $('select[name="clCate"]').val();
			console.log(selectedVal);
			if(selectedVal == 'A203'){
				$('input[type="checkbox"]').each(function() {
				    $(this).prop('disabled', true);
				});
			}
		}
		
		function docName(name, id) {

			let form = $('form[role="classForm"]');
			var FileName = form.find('[name=' + name + ']')[0];

			//		var checkInput = $('.checkExcel').val();
	
			document.getElementById(id).value = FileName.files[0].name;		
		}
		  
		function resizeIFrame(iframeId) {

		   try{
		    	var innerBody = document.getElementById(iframeId).contentWindow.document.body;
		    	var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);

			    if(document.getElementById(iframeId).style.height != innerHeight){
					document.getElementById(iframeId).style.height = innerHeight;
			    }
			    if(document.all){
			     	innerBody.attachEvent('onclick',parent.do_resize);
			     	innerBody.attachEvent('onkeyup',parent.do_resize);
			    }else{
			     innerBody.addEventListener("click", parent.do_resize, false);
			     innerBody.addEventListener("keyup", parent.do_resize, false);
			    }
		   }
		   catch (e){
		    //alert("여긴안돼");
		   }
		}
		
		</script>

</body>
