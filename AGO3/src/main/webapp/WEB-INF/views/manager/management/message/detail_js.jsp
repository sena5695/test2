<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>

<script type="text/x-handlebars-template"  id="message-detail-template" >
<table class="table table-sm detail-body">
	<tbody>
		<tr>
			<td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">받는 사람</td>
			<td class="col-4"> <div style="overflow-y:auto; height: 150px;">{{ memName }}</div></td>
		</tr>
		<tr>
			<td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">보낸 날짜</td>
			<td class="col-4">{{prettifyDate msgRegdate }}</td>
		</tr>
		<tr>
			<td colspan="4">{{msgContent }}</td>
		</tr>
	</tbody>
</table>

<form role="removeForm">
	<input type="hidden" name="msgNo" value="{{msgNo}}">
</form>

<form role="reSendForm">
	<input type="hidden" name="memEmail" value="{{memEmail}}">
	<input type="hidden" name="msgContent" value="{{msgContent}}">
</form>
</script>

<script>
window.onload=function(){
	if(${empty msgList[0].msgNo}) return;
	
	getPage("<%=request.getContextPath()%>/manager/message/detail.do?msgNo=${msgList[0].msgNo}");
	
}


function printData(detail, target, templateObject){
	let template = Handlebars.compile(templateObject.html());
	let html = template(detail);
	$('.detail-body').remove();
	target.after(html);
}

function getPage(pageInfo){
	$.ajax({
		url : pageInfo,
		type : "get",
		dataType : "json",
		success : function(data){	
			printData(data, $('.table-wrapper'), $('#message-detail-template'));
			parent.resize(window.parent.document.getElementById("ifr"));
	
		},
		error:function(error){
			AjaxErrorSecurityRedirectHandler(error.status);
		}
	});
}

Handlebars.registerHelper({
	"prettifyDate" : function(timeValue) {
		let dateObj = new Date(timeValue);
		let year = dateObj.getFullYear();
		let month = dateObj.getMonth() + 1;
		month = (month).toString();
		if (month.length < 2) {
			month = "0" + month;
		}

		let date = dateObj.getDate();
		date = (date).toString();
		if (date.length < 2) {
			date = "0" + date;
		}
		return year + "-" + month + "-" + date;
	}
});
</script>