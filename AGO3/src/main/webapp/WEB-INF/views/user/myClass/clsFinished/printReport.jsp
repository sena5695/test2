<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
								<td style="width: 110px; height: 90px; padding-left:12px; ">
									<div id="printAgoStamp" data-id="agoStamp" style="width: 90px; height: 90px;"></div>
								</td>
								<td style="width: 110px; height: 90px;">
									<div id="printDphStamp" data-id="printDphStamp" style="width: 90px; height: 90px;"></div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<table border="1">
					<tbody>
						<tr class="trHeight">
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" rowspan="3" colspan="1">교육수료자</td>
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" colspan="1">부서명</td>
							<td class="p-2" style="width: 180px;" colspan="3">${report.dpName}</td>
						</tr>
						<tr class="trHeight">
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">직위</td>
							<td class="p-2" style="width: 120px;" colspan="3">${report.positionName}</td>
						</tr>
						<tr class="trHeight">
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">성명</td>
							<td class="p-2" style="width: 150px;" colspan="3">${report.memName}</td>
						</tr>
						<tr class="trHeight">
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육명</td>
							<td class="p-2" style="width: 390px;" colspan="2">${report.clName}</td>
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" colspan="1">교육분류</td>
							<td colspan="1" class="p-2" style="width: 130px;">${report.clCateName}</td>
						</tr>
						<tr class="trHeight">
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey; width: 130px;" colspan="1">수료날짜</td>
							<td class="p-2" style="width: 120px;" colspan="4">
								<fmt:formatDate value="${report.ctfDate}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
						<tr>
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육내용</td>
							<td id="printEduContent" style="height: 380px; vertical-align : top; padding: 10px; font-size: 15px;" colspan="4">${report.eduContent}</td>
						</tr>
						<tr style="margin">
							<td class="printColor font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">소감</td>
							<td id="printEduReview" style="height: 380px; vertical-align : top; padding: 10px; font-size: 15px;" colspan="4" >${report.eduReview}</td>
						</tr>
					</tbody>
				</table>
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
								<td style="width: 110px; height: 90px; padding-left:8px;">
									<div id="agoStamp" data-id="agoStamp" style="width: 90px; height: 90px;"></div>
								</td>
								<td style="width: 110px; height: 90px;">
									<div id="DphStamp" data-id="DphStamp" style="width: 90px; height: 90px;"></div>
								</td>
							</tr>
						</table>
					</div>
				</div>
					<table border="1">
						<tbody>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" rowspan="3" colspan="1">교육수료자</td>
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" colspan="1">부서명</td>
								<td id="dpName" style="width: 180px;" class="p-2" colspan="3">
									${report.dpName}
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">직위</td>
								<td id="authorityName" style="width: 120px;" class="p-2" colspan="3">
									${report.positionName}
								</td>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">성명</td>
								<td id="memName" style="width: 150px;" class="p-2" colspan="3">
									${report.memName}
								</td>
							</tr>
							<tr class="trHeight">
								<c:if test="${empty report.clCateName}">
									<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육명</td>
									<td class="p-2" style="width: 513px;" colspan="2">
										${report.clName}
									</td>
								</c:if>
								<c:if test="${not empty report.clCateName }">
									<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육명</td>
									<td id="clName" style="width: 390px;" class="p-2" colspan="2">
										${report.clName}
									</td>
									<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 100px;" colspan="1">교육분류</td>
									<td id="clCateName" colspan="1" class="p-2" style="width: 130px;">${report.clCateName}</td>
								</c:if>
							</tr>
							<tr class="trHeight">
								<td class="font-weight-bold text-center" style="background-color: lightgrey; width: 130px;" colspan="1">수료날짜</td>
								<td id="ctfDate" class="p-2" style="width: 120px;" colspan="4">
									<fmt:formatDate value="${report.ctfDate}" pattern="yyyy-MM-dd" />
								</td>
							</tr>
							<tr>
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">교육내용</td>
								<td style="height: 380px; vertical-align : top; padding: 10px; font-size: 13px;" colspan="4">${report.eduContent}</td>
							</tr>
							<tr>
								<td class="font-weight-bold text-center" style="background-color: lightgrey;" colspan="1">소감</td>
								<td style="height: 380px; vertical-align : top; padding: 10px; font-size: 13px;" colspan="4">${report.eduReview}</td>
							</tr>
						</tbody>
					</table>
			</div>
		</div>
	</div>
		<!-- 이미지 불러오기 -->
	<script type="text/javascript">
		window.onload=function(){
			ReportPictureThumb(document.querySelector('#agoStamp'), 'agoStamp.jpg', '<%=request.getContextPath()%>');
			ReportPictureThumb(document.querySelector('#printAgoStamp'), 'agoStamp.jpg', '<%=request.getContextPath()%>');
			ReportPictureThumb(document.querySelector('#printDphStamp'), '${common.option1}', '<%=request.getContextPath()%>');
			ReportPictureThumb(document.querySelector('#DphStamp'), '${common.option1}', '<%=request.getContextPath()%>');
		}
	</script>
	<script type="text/javascript">
		function print_report() {
			window.print();
		}
	</script>

</body>
