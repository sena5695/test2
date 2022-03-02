<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>


<script type="text/x-handlebars-template" id="exam-detail-template">
<tr>
<td>
	<table class="table table-borderless">
		<tbody>
			<tr>
				<td class="p-0" style="font-size: 20px"><b style="font-size: 28px" class="text-center">{{testNum}}</b>
					<p class="text-danger m-0" style="font-size: 15px; width:50px;"></p></td>
			</tr>
			<tr>
				<td class="p-0" colspan="2" style="font-size: 16px">⑴ {{testNumber1}}</td>
			</tr>
			<tr>
				<td class="p-0" colspan="2" style="font-size: 16px">⑵ {{testNumber2}}</td>
			</tr>
			<tr>
				<td class="p-0" colspan="2" style="font-size: 16px">⑶ {{testNumber3}}</td>
			</tr>
			<tr>
				<td class="p-0" colspan="2" style="font-size: 16px">⑷ {{testNumber4}}</td>
			</tr>
		</tbody>
	</table>
</td>
</tr>
</script>

<c:if test="${ !empty examInfo.mtestFile }">
	<script>
		window.onload = function() {
			getTest('getTest.do','${examInfo.mtestFile}');
		}
	</script>
</c:if>
<c:if test="${ !empty examInfo.ftestFile }">
	<script>
		window.onload = function() {
			getTest('getTest.do','${examInfo.ftestFile}');
		}
	</script>
</c:if>
<script>
	function printData(detail, target, templateObject) {
		let template = Handlebars.compile(templateObject.html());
		let html = template(detail);
		$('.detail-body').remove();
		target.append(html);
	}

	function getTest(pageInfo, exam) {
		$.ajax({
			url : pageInfo,
			type : "post",
			data : {
				'fileName' : exam
			},
			dataType : "json",
			success : function(data) {
				for (i = 0; i < data.length; i++) {
					if (i % 2 == 0) {
						printData(data[i], $('#exam-left'), $('#exam-detail-template'));
					} else {
						printData(data[i], $('#exam-right'), $('#exam-detail-template'));
					}
				}
			},
			error : function(error) {
				AjaxErrorSecurityRedirectHandler(error.status);
			}
		});
	}
</script>