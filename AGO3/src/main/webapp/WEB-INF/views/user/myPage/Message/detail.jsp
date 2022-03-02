<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title></title>
<head></head>
<body>

	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">쪽지</h4>
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
						<li class="breadcrumb-item active">쪽지함</li>
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

			<table class="col-12" style="border: none;">
				<tr>
					<td><button class="btn btn-primary btn-sm col-2" onclick="remove_msg();">삭제</button></td>
					<td style="text-align: right;"><button class="btn btn-primary btn-sm col-2" onclick="location.href='list.do';">목록</button></td>
				</tr>
			</table>
			<table class="table table-sm mt-3">
				<tbody>
					<tr>
						<td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">보낸 사람</td>
						<td class="col-4">운영자</td>
						<td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">받은 날짜</td>
						<td class="col-4"><fmt:formatDate value="${message.msgRegdate }" pattern="yyyy.MM.dd" /></td>
					</tr>
					<tr>
<!-- 						<td colspan="4" class="font-weight-bold text-center col-12" style="background-color: #F5F4F4;">내용</td> -->
					</tr>
					<tr>
						<td colspan="4">${message.msgContent }</td>
					</tr>
				</tbody>
			</table>
			
		</div>
	</section>
	<form role="removeForm">
		<input type="hidden" name="msgNo" value="${message.msgNo }">
	</form>
 <script>

 
 function remove_msg(){
	 var check = confirm("삭제하시겠습니까?");
	 if(check){
		 var form = document.querySelector('form[role="removeForm"]');
		 
		 form.setAttribute("action", "removeMsg.do");
		 form.setAttribute("method", "post");

		 form.submit();
	 }
 }
 </script>	
</body>

