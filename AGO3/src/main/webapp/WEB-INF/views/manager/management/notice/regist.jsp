<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

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
		
		<button class="btn btn-default btn-sm" onclick="history.go(-1);">취소</button>
		<button type="button" class="btn btn-primary btn-sm float-right"  onclick="regist_go();">등록</button>
		<br>
		<form enctype="multipart/form-data" role="form" method="post" action="regist.do" name="registForm">
			<table class="col-12 table mt-3 table-sm" border="1" style="border: 1px solid #F5F4F4; ">
				<tr>
					<td class="col-1" style="font-weight: bold; background-color: #F5F4F4; text-align : center;">
						중요
					</td>
					<td class="col-1 text-center form-group" >
						<input type="checkbox" class=" individual_check_boxes" name="impt">
					</td>
					<td class="col-1" style="font-weight: bold; background-color: #F5F4F4; text-align : center;">
						제목
					</td>
					<td class="col-9 form-group">
						<input maxlength="72" type="text" id="title" name="title" class="form-control form-control-sm" placeholder="제목" style="border: none;">
					</td>
				</tr>
				<tr>
					<td colspan="4 form-group">
					<br>
						<textarea class="textarea form-control" name="content" id="content" rows="20" placeholder="1000자 내외로  작성하세요." style="display: none;"></textarea>
						<%@ include file="/WEB-INF/views/common/summernote.jsp" %>
						
					</td>
				</tr>
			</table>
			<table class="col-12"  id="file_add">
	
				<tr>
					<td colspan="2" style="font-weight: bold; background-color: #F5F4F4; text-align : center;">파일첨부</td>
				</tr>
				<tr data-no='1'>
					<td class="col-12 row">
						<label for="attachFile" class=" btn btn-info btn-sm btn-flat input-group-addon" style="height: 31px;">파일선택</label> 
						<input id="inputFileNameDoc" class="form-control form-control-sm rounded-0 col-6 justify-content-center"  name="DocName" type="text" disabled/> 
						<input type="file" class="form-control-file" id="attachFile" name='fileUpload' onchange="docName('DocName','attachFile')" style="display: none;">
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
			if($('input[name="file_upload"]').length >= 5){
				alert("파일추가는 5개까지만 가능합니다.");
				return;
			}
				
			$('#file_add').append("<tr data-no='"+data_num+"'>"
										+"<td class='col-12  form-group'>"
										+"<input type='file' class='form-control-file' name='fileUpload'>"
										+"</td>"
										+"<td>"
										+"<button class='btn btn-danger btn-sm' onclick='remove_go("+data_num+")' style='color: white; font-size: 10px;'><i class='fas fa-minus'></i></button>"
										+"</td>"
										+"</tr>");
 			}
		function docName(name, id) {
			var picture=$('input#attachFile')[0];
	        
	        var fileFormat=picture.value.substr(picture.value.lastIndexOf(".")+1).toUpperCase();

			let form = $('form[name="registForm"]');
			var FileName = form.find('[name=' + name + ']')[0];

			//		var checkInput = $('.checkExcel').val();

			document.getElementById('inputFileNameDoc').value=picture.files[0].name;	
		}


	</script>
	
	<script type="text/javascript">
/* 	var dataNum=0;
	function addFile_go() {
		// alert("add file");
		
		if($('input[name="uploadFile"]').length >= 5){
			alert("파일추가는 5개까지만 가능합니다.");
			return;
		}
		
		var div=$('<div>').addClass("inputRow").attr("data-no",dataNum);
		var input=$('<input>').attr({"type" : "file", "name" : "uploadFile"}).css("display","inline");
		
		div.append(input).append("<button onclick='remove_go("+dataNum+")' style='border:0; outline:0;' class='badge bg-red' type='button'>X</button>");
		$('.fileInput').append(div);
		
		dataNum++;
	} */
	
	function remove_go(dataNum) {
		$('div[data-no="'+dataNum+'"]').remove();
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