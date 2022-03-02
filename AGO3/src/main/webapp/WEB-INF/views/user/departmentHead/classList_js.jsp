<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>



<script type="text/x-handlebars-template"  id="member-class-template" >
{{#if .}}
	{{#each .}}
		<li class="item px-3 py-1 row mr-0 ml-1" style="width: 805px; height: 33px; border-bottom:1.5px soild gray;">
			<div style="width: 380px;">{{clName}}</div>
			<div class="text-center px-2" style="width: 195px;"> 
				{{#if check}}
					<div class="progress">
                    	<div class="progress-bar bg-success" role="progressbar" style="width: {{progRate }}%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">{{progRate }}%</div>
                	</div>
                {{else}}
                    <span class="text-danger font-weight-bold" mx-auto">미신청</sapn>

                {{/if}}
            </div>
			<div class="text-center" style="width: 195px;">{{memName }}</div>
		</li>
	{{/each}}	

{{else}}
	<li class="item px-3 py-1 row m-0" style="width: 787px; height: 33px; border-bottom:1.5px soild gray;">
		<span >부서원의 강의내역이 존재하지 않습니다.</span>
	</li>
{{/if}}
    
</script>

<script>
function printData(detail, target, templateObject){
	let template = Handlebars.compile(templateObject.html());
	let html = template(detail);
	target.empty();
	target.append(html);
}

function getPage(opcl){
	$('li').removeClass('bg-primary')
	$('#'+opcl).addClass('bg-primary')
	$.ajax({
		url : "classClick?opcl="+opcl,
		type : "get",
		dataType : "json",
		success : function(data){
			printData(data, $('#memberClass'), $('#member-class-template'));
		},
		error:function(error){
			AjaxErrorSecurityRedirectHandler(error.status);
		}
	});
}


</script>