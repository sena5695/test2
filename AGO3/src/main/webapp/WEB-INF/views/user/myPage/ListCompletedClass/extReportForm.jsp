<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="attachDoc" value="${fn:split(extReport.attachDoc,'$$')[1]}" />
<head>
<meta charset="UTF-8">
<title>교육이수보고서</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/report.css">
</head>
<body>

	<div>
		<div>
			<button class="col-2 ml-3 mt-3 btn btn-default" id="printReport" onclick="print_report();">출력하기</button>
		</div>

		<div id="onlyPrint" class="paper">
			<div class="content" style="padding-left: 50px;">
				<div class="row mb-3" style="height: 130px;">
					<div class="mr-5 pt-4 pl-5" style="width: 357px;">
						<span class="text-center text-bold" style="font-size: 35px;">교육이수보고서</span>
					</div>
					<div style="width: 225px; margin-left: 120px;">
						<table border="1">
							<tr>
								<td class="text-center">교육담당</td>
								<td class="text-center">부서장</td>
							</tr>
							<tr>
								<td style="width: 110px; height: 90px;">얘는 걍 도장 박아놓는거 어떤가염?</td>
								<td style="width: 110px; height: 90px;"></td>
							</tr>
						</table>
					</div>
				</div>
				<form action="" enctype="multipart/form-data">
					<table border="1">
						<tbody>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" rowspan="3" colspan="1">교육수료자</td>
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" colspan="1">부서명</td>
								<td class="p-2" style="width: 180px;" colspan="3">${extReport.dpName}</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">직위</td>
								<td class="p-2" style="width: 120px;" colspan="3">${extReport.positionName}</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">성명</td>
								<td class="p-2" style="width: 150px;" colspan="3">${extReport.memName}</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육명</td>
								<td class="p-2" id="clName" style="width: 430px; vertical-align: top; padding: 10px;" colspan="2">${extReport.clName}</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 130px;" colspan="1">수료날짜</td>
								<td class="p-2" id="ctfDate" style="width: 120px; vertical-align: top; padding: 10px;" colspan="4"></td>
							</tr>
							<tr>
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육내용</td>
								<td class="p-2" id="printEduContent" style="height: 380px; vertical-align: top; padding: 10px;" colspan="4"></td>
							</tr>
							<tr style="">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">소감</td>
								<td class="p-2" id="printEduReview" style="height: 380px; vertical-align: top; padding: 10px;" colspan="4"></td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">수료증</td>
								<td class="p-2" id="attachDoc" colspan="4">${attachDoc}</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>

		<div id="onlyShow" class="paper">
			<div class="content">
				<div class="row mb-3">
					<div class="mr-5 p-5" style="width: 357px;">
						<span class="text-center text-bold" style="font-size: 35px;">교육이수보고서</span>
					</div>
					<div class="ml-4 mt-3" style="width: 225px;">
						<table border="1">
							<tr>
								<td class="text-center">교육담당</td>
								<td class="text-center">부서장</td>
							</tr>
							<tr>
								<td style="width: 110px; height: 90px;"></td>
								<td style="width: 110px; height: 90px;"></td>
							</tr>
						</table>
					</div>
				</div>
				<form action="extReportRegist.do" enctype="multipart/form-data" role="reportForm" method="post">
					<table border="1">
						<tbody>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" rowspan="3" colspan="1">교육수료자</td>
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" colspan="1">부서명</td>
								<td class="p-2" style="width: 180px;" colspan="3">
								<input type="hidden" name="extNo" value="${extReport.extNo}">
								<input type="hidden" name="extCode" value="${extReport.extCode}">
								<input type="hidden" name="dpId" value="${extReport.dpId}">
									${extReport.dpName}
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">직위</td>
								<td class="p-2" style="width: 120px;" colspan="3">
								<input type="hidden" name="positionId" value="${extReport.positionId}">
									${extReport.positionName}
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">성명</td>
								<td class="p-2" style="width: 150px;" colspan="3">
								<input type="hidden" name="memName" value="${extReport.memName}">
									${extReport.memName}
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육명</td>
								<td class="p-2" style="width: 513px;" colspan="2">
								<input type="hidden" name="clName" value="${extReport.clName}">

									${extReport.clName}
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 130px;" colspan="1">수료날짜</td>
								<td class="p-2" style="width: 120px;" colspan="4">
									<input class="form-control" type="date" name="insertCtfDate" id="insertCtfDate" value="" style="width: 100%; border: none; border-right: 0px; border-top: 0px; boder-left: 0px; boder-bottom: 0px;">
								</td>
							</tr>
							<tr>
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육내용</td>
								<td style="height: 380px;" colspan="4">
									<textarea class="form-control" name="eduContent" style="width: 100%; height: 95%; font-size:12px; border: none; resize: none;" rows="10" cols="">${extReport.eduContent}</textarea>
								</td>
							</tr>
							<tr>
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">소감</td>
								<td style="height: 380px;" colspan="4">
									<textarea class="form-control" name="eduReview" style="width: 100%; height: 95%; font-size:12px; border: none; resize: none;" rows="10" cols="">${extReport.eduReview}</textarea>
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">수료증</td>
								<td colspan="4" class="form-group">
									<div class="custom-file">
										<div class="row m-0">
											<input id="attachDocFileName" class="form-control-file col-8" type="file" name="attachDoc" value="${attachDoc}"/>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<button class="btn btn-primary" style="width: 140px; float: right; margin-top: 30px;" type="submit" onclick="report_save();">제 출</button>
		</div>
	</div>

	<script type="text/javascript">
		function print_report() {
			alert("여기서 데이터 넣어줘야돼....");
			
			let form = document.querySelector('form[role="reportForm"]');
			var insertCtfDate = form.insertCtfDate.value;
			var eduContent = form.eduContent.value;
			var eduReview = form.eduReview.value;
			if(insertCtfDate){
				document.getElementById('ctfDate').innerText=ctfDate;
			}else{
				document.getElementById('ctfDate').innerText='0000-00-00';
			}
			document.getElementById('printEduContent').innerText=eduContent;
			document.getElementById('printEduReview').innerText=eduReview;
			window.print();
		}
		
		function report_save() {
			let form = document.querySelector('form[role="reportForm"]');
			var insertCtfDate = form.insertCtfDate.value;
			var eduContent = form.eduContent.value;
			var eduReview = form.eduReview.value;
			
			var files=$('input[name="attachDoc"]');
			console.log(files);
	 		for(var file of files){
				console.log(file.name+" : "+file.value);
				if(file.value==""){
					alert("수료증을 첨부하지 않으면 제출할 수 없습니다.");
					file.focus();
					file.click();
					return;
				}
			}
	 		
	 		if(!insertCtfDate){
	 			alert("수료날짜를 선택해주세요.");
	 			insertCtfDate.focus();
				return;
			}
	 		if(!eduContent){
				alert("교육내용을 작성해주세요.");
				eduContent.focus();
				return;
			}
			if(!eduReview){
				alert("교육소감을 작성해주세요.");
				eduReview.focus();
				return;
			}
			
			if(confirm("이대로 제출하시겠습니까?")){
				form.submit();
			}
			
		}
		
	</script>

</body>

