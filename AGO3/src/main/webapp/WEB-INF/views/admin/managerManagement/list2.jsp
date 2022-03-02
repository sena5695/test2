<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="employeeList" value="${dataMap.employeeList}" />
<c:set var="managerList" value="${dataMap.managerList }" />
<c:set var="cri" value="${dataMap.cri}" />

<body>
	<div class="container-fluid ">

		<div class="row navList mt-2 mb-2">
			<h4 class="col-9 m-0">운영자 관리</h4>
			<div class="col-3 text-right pt-2">
				<i class="fas fa-home" style="font-size: 15px;"></i><span> &nbsp;>&nbsp; <span>운영자 관리</span>
			</div>
		</div>

		<div class="row">
			<div style="width: 600px;">
				<div class="card-body px-2 py-0">
					<div class="row mb-2 px-2">
						<select class="form-control" name="searchType" style="width: 120px;">
							<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>사원명</option>
							<option value="e" ${cri.searchType eq 'e' ? 'selected':'' }>이메일명</option>
						</select>
						<input type="text" placeholder="제목을 입력해주세요..." name="keyword" class="form-control" value="${ param.keyword }" style="width: 405px;">
						<button class="btn btn-primary float-right" onclick="list_go();">검색</button>
					</div>

					<div class="card"  style="height: 630px;">
						<div class="card-header">
							<h3 class="card-title font-weight-bold" style="width: 470px;">부서원 목록</h3>
							<button style="width: 70px;" type="button" class="btn btn-block btn-outline-primary btn-xs" onclick="location.href ='main.do'">전체보기</button>
						</div>
						<div class="text-center row px-3 py-1 m-0 font-weight-bold" style="border-bottom:1.5px soild gray; height: 35px; width: 100%; background-color: #F5F4F4;">
							<div style="width: 150px;">아이디</div>
							<div style="width: 100px;">이름</div>
							<div style="width: 300px;">이메일</div>
						</div>

						<div  id="detailReviewList"  style="height: 535px; overflow-y: auto; -ms-overflow-style: none;">
							<ul id="employeeList" class="products-list product-list-in-card">
								<c:if test="${not empty employeeList}">
									<c:forEach items="${employeeList}" var="employee">
										<li id="li${employee.memId }" onclick="selectMember('${employee.memId }')" class="item px-2 py-1 row mr-0 ml-1" style="width: 580px; height: 33px; border-bottom:1.5px soild gray;">
											<div class="text-center" style="width: 155px;">${employee.memId }</div>
											<div id="${employee.memName }" class="text-center name" style="width: 100px;"><span>${employee.memName }</span></div>
											<div class="px-3" style="width: 300px;">${employee.memEmail }</div>
											<div hidden="" id="input${employee.memId }">
												<input id="${employee.memId }" name="checkbox_e" type="checkbox" value="${employee.memName }">
											</div>

										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty employeeList}">
									<li class="item px-2 py-1 row mr-0 ml-1" style="width: 580px; height: 33px; border-bottom:1.5px soild gray;">
										<span>사원이 존재하지 않습니다.</span>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="text-center align-self-center" style="width: 80px;">
				<span style="font-size: 45px;"><i class="fas fa-caret-square-left" onclick="remove()"></i></span><br>
				<span style="font-size: 45px;"><i class="fas fa-caret-square-right" onclick="add()"></i></span>
			</div>

			<div style="width: 600px;">
				<div class="card-body px-2 py-0">
					<div class="card"  style="height: 675px;">
						<div class="card-header">
							<h3 class="card-title font-weight-bold" style="width: 470px;">운영자 목록</h3>
						</div>
						<div class="text-center row px-3 py-1 m-0 font-weight-bold" style="border-bottom:1.5px soild gray; height: 35px; width: 100%; background-color: #F5F4F4;">
							<div style="width: 150px;">아이디</div>
							<div style="width: 100px;">이름</div>
							<div style="width: 300px;">이메일</div>
						</div>

						<div  id="detailReviewList"  style="height: 535px; overflow-y: auto; -ms-overflow-style: none;">
							<ul id="managerList" class="products-list product-list-in-card">
								<c:if test="${not empty managerList}">
									<c:forEach items="${managerList}" var="manager">
										<li id="li${manager.memId }" class="item px-2 py-1 row mr-0 ml-1" onclick="selectMember('${manager.memId }')" style="width: 580px; height: 33px; border-bottom:1.5px soild gray;">
											<div class="text-center" style="width: 155px;">${manager.memId }</div>
											<div class="text-center" style="width: 100px;">${manager.memName }</div>
											<div class="px-3" style="width: 300px;">${manager.memEmail }</div>
											<div hidden="" id="input${manager.memId }">
												<input id="${manager.memId }" name="checkbox_m" type="checkbox" value="${manager.memName }">
											</div>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty managerList}">
									<li class="item px-2 py-1 row mr-0 ml-1" style="width: 580px; height: 33px; border-bottom:1.5px soild gray;">
										<span>사원이 존재하지 않습니다.</span>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form id="jobForm">
		<input type="hidden" name="searchType" value="" />
		<input type="hidden" name="keyword" value="" />
	</form>

	<script type="text/javascript">
		var memberIdList = [];
		let chk_Val = [];
		let chkId_Val = [];
		function selectMember(memId) {
			if($('#li'+memId+'>div>input').is(":checked") == true){
				$('#li'+memId).removeClass('bg-primary')
				$('#input'+memId+'>input').prop("checked", false);
			}else{
				$('#li'+memId).addClass('bg-primary')
				$('#input'+memId+'>input').prop("checked", true);
			}

		}

		function add() {
			chk_Val = [];
			chkId_Val = [];
			var member=$('#employeeList').children('.bg-primary')
			memberIdList = $('#managerList>li .bg-primary').attr('id')
			// console.log(memberIdList)
			$('input[name=checkbox_e]:checked').each(function() {
				chk_Val.push($(this).val())
				chkId_Val.push($(this).attr('id'))
			})
			if(chk_Val[0] == null){
				alert("선택된 사원이 없습니다\n권한을 부여를 위해 왼쪽의 사원 목록을 선택하세요.")
			}else{
				var message = "";
				for(i=0;i<chk_Val.length;i++){
					message=message+(i+1)+". "+chk_Val[i]+"("+chkId_Val[i]+")\n"
				}
				message=message+"해당 사원에게 운영자 권한을 부여합니다."
				if(confirm(message)==true){
					// console.log(chk_Val)
					 $.ajax({
						url : "update.do?check=true&memId="+chkId_Val,
						type : "get",
						dataType : "json",
						success : function(data){
							if($('#managerList>li>span').text() == "사원이 존재하지 않습니다."){
								$('#managerList').empty();
							}
							$('#employeeList').remove('#'+memberIdList);
							$("#managerList").append(member)
							$('#managerList>li>div>input').attr('name','checkbox_m')
							if($('#employeeList>li').attr('id') == null){
								$('#employeeList').append("<li class='item px-2 py-1 row mr-0 ml-1' style='width: 580px; height: 33px; border-bottom:1.5px soild gray;'><span>사원이 존재하지 않습니다.</span></li>")
							}
						},
						error:function(error){
							AjaxErrorSecurityRedirectHandler(error.status);
						}
					});

				}else{
					alert("권한 부여가 취소되었습니다.")
				}
			}
			$('input[type=checkBox]').prop("checked", false);
			$('li').removeClass('bg-primary');

		}

		function remove() {
			chk_Val = [];
			chkId_Val = [];
			var member=$('#managerList').children('.bg-primary')
			memberIdList = $('#managerList').children('.bg-primary').attr('id')

			$('input[name=checkbox_m]:checked').each(function() {
				chk_Val.push($(this).val())
				chkId_Val.push($(this).attr('id'))
			})
			if(chk_Val[0] == null){
				alert("선택된 사원이 없습니다\n권한을 삭제를 위해 오른쪽의 운영자 목록을 선택하세요.")
			}else{
				var message = "";
				for(i=0;i<chk_Val.length;i++){
					message=message+(i+1)+". "+chk_Val[i]+"("+chkId_Val[i]+")\n"
				}
				message=message+"해당 사원에게 부여된 운영자 권한을 삭제합니다."
				if(confirm(message)==true){
					// console.log(chk_Val)
					 $.ajax({
						url : "update.do?check=false&memId="+chkId_Val,
						type : "get",
						dataType : "json",
						success : function(data){
							if($('#employeeList>li>span').text() == "사원이 존재하지 않습니다."){
								$('#employeeList').empty();
							}
							$('#managerList').remove('#'+memberIdList);
							$("#employeeList").append(member)
							$('#employeeList>li>div>input').attr('name','checkbox_e')
							if($('#managerList>li').attr('id') == null){
								$('#managerList').append("<li class='item px-2 py-1 row mr-0 ml-1' style='width: 580px; height: 33px; border-bottom:1.5px soild gray;'><span>사원이 존재하지 않습니다.</span></li>")
							}
						},
						error:function(error){
							AjaxErrorSecurityRedirectHandler(error.status);
						}
					});
				}else{
					alert("권한 삭제가 취소되었습니다.")
				}
			}
			$('input[type=checkBox]').prop("checked", false);
			$('li').removeClass('bg-primary');

		}

		function list_go() {
			var jobForm = $('#jobForm');

			jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
			jobForm.find("[name='keyword']").val($('input[name="keyword"]').val());

			jobForm.attr({
				action : 'main.do',
				method : 'get'
			}).submit();
		}
	</script>
</body>
