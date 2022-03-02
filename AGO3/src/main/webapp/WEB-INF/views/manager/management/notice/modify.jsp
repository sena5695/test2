<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<c:set var="notice" value="${notice }" />
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/summernote/summernote-bs4.min.css">
<script src="<%=request.getContextPath()%>/resources/js/summernote/summernote-bs4.min.js"></script>
</head>

<title>공지사항</title>

<body>

	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">공지사항</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/manager/management/faq/list.do">운영관리</a>
						</li>
						<li class="breadcrumb-item active">공지사항</li>
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
		
		<button class="btn btn-default btn-sm" onclick="location.href='detail.do?noticeNo=${notice.noticeNo}'">취소</button>
		<button type="button" class="btn btn-secondary btn-sm float-right"  onclick="regist_go();">수정</button>
		<br>
		<form enctype="multipart/form-data" role="form" method="post" action="modify.do" name="registForm">
			<input type="hidden" name="noticeNo" value="${notice.noticeNo }" />
			<table class="col-12 table mt-3 table-sm" border="1" style="border: 1px solid #F5F4F4; ">
				<tr>
					<td class="col-1" style="font-weight: bold; background-color: #F5F4F4; text-align : center;">
						중요
					</td>
					<td class="col-1 text-center form-group" >
						
						<c:if test="${notice.noticeImpt eq '0'}" >
							<input type="checkbox"  checked="checked" class="individual_check_boxes" name="impt">
						</c:if>
						<c:if test="${notice.noticeImpt eq '1'}" >
							<input type="checkbox" class=" individual_check_boxes" name="impt">
						</c:if>
					</td>
					<td class="col-1" style="font-weight: bold; background-color: #F5F4F4; text-align : center;">
						제목
					</td>
					<td class="col-9 form-group">
						<input maxlength="72" type="text" id="title" name="title" class="form-control form-control-sm" placeholder="제목" style="border: none;" value="${notice.noticeTitle}">
					</td>
				</tr>
				<tr>
					<td colspan="4" class="p-0" >
						<br>
						<textarea class="textarea form-control p-0 m-0" name="content" id="content" rows="20" placeholder="1000자 내외로  작성하세요." style="display: none;">${notice.noticeContent}</textarea>
						<%@ include file="/WEB-INF/views/common/summernote.jsp" %>
					</td>
				</tr>
			</table>
			<table class="col-12 m-0 p-0"  id="file_add">
				<c:forEach items="${notice.attachList }" var="attach" >
					<tr class='${attach.ano } '>
						<td class="col-12 form-group">
							<span class="attachFile">${attach.fileRealName}&nbsp;<i class="fas fa-file-alt"></i></span>
						</td>
						<td>
							<button type="button" onclick="removeFile_go(${attach.ano});return false;" class="btn btn-secondary  btn-sm" style="color: white; font-size: 10px;"><i class="fas fa-times"></i></button>
						</td>
					</tr>
				</c:forEach>
				<tr class='1'>
					<td class="col-12 form-group">
						<input type="file" class="form-control-file" name='fileUpload'>
					</td>
					<td>
						<button type="button" onclick="add()" class="btn btn-primary btn-sm" style="color: white; font-size: 10px;"><i class="fas fa-plus"></i></button>
					</td>
				</tr>

			
			</table>
		</form>
			
	</div>
	</section>
	<script type="text/javascript">
		window.onload = function() {
			summernote_go($('#content'));
			$('.fileInput').on('change','input[type="file"]',function(event){
				// alert(this.files[0].size);
				if(this.files[0].size>1024*1024*40){
					alert("파일 용량이 40MB를 초과하였습니다.");
					this.value="";
					$(this).click();
					return false;
				}
			});
		}
	</script>
	<script>
		var data_num = 1

 		function add() {
			data_num++;
			if($('input[name="fileUpload"]').length >= 5-$('.attachFile').length){
				alert("파일추가는 5개까지만 가능합니다.");
				return;
			}
				
			$('#file_add').append("<tr class='"+data_num+"'>"
										+"<td class='col-12  form-group'>"
										+"<input type='file' class='form-control-file' name='fileUpload'>"
										+"</td>"
										+"<td>"
										+"<button class='btn btn-danger btn-sm' onclick='remove_go("+data_num+")' style='color: white; font-size: 10px;'><i class='fas fa-minus'></i></button>"
										+"</td>"
										+"</tr>");
 		}
	</script>
	
	<script type="text/javascript">
    function removeFile_go(ano){
    	$('.'+ano+'').remove();
    		
    	var input=$('<input>').attr({"type" : "hidden",
    								 "name" : "deleteFile",
    								"value" : ano});
    	$('form').prepend(input);
    		
    }
	
	function remove_go(dataNum) {
		$('.'+dataNum+'').remove();
	}
	
	function regist_go() {
		var files=$('input[name="fileUpload"]');
		console.log(files);
 		for(var file of files){
			console.log(file.name+" : "+file.value);
			if(file.value==""){
				file.remove();
			}
		}
		
		if($("input[name='title']").val()==""){ // form.title.value
			alert("제목은 필수입니다. 제목을 입력해주세요.");
			$("input[name='title']").focus();
			return;
		}
		// alert($("input[name='impt']:checked").val())

  		 document.querySelector('form[role="form"]').submit();  
	}
	
	$('#title').keyup(function (e) { 
		let title = $(this).value.lenght; 
		// 글자수 제한 
		if (title > $(this).maxLength) { 
			// 200자 부터는 타이핑 되지 않도록 
			$(this).val($(this).val().substring(0, $(this).maxLength)); 
			// 200자 넘으면 알림창 뜨도록 
			alert('제목은 72자까지 입력 가능합니다.'); 
		}; 
	});


	</script>
</body>