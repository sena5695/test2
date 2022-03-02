<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head></head>

<title>수강후기 등록</title>

<body>

	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h1 class="m-0 text-bold">${review.clName}</h1>
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
			<div class="card card-warning">
				<div class="card-header">
					<h3 class="card-title text-bold">수강후기 등록</h3>
				</div>
				<!-- /.card-header -->
				<div class="card-body">
						<div class="row">
							<div class="col-11 ml-4">
								<!-- textarea -->
								<div class="form-group">
									<label>수강후기</label>
									<textarea id="reviewContent" name="reviewContent" class="form-control" rows="3" placeholder="300자 이내로 작성해주세요" style="width: 100%; height: 200px; resize: none;"></textarea>
									<span id="counter" class="badge badge-warning navbar-badge" style="width:60px; height:20px; font-size:16px;" >0/300</span>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-6 ml-4">
								<!-- select -->
								<div class="form-group">
									<label>별점</label>
									<select class="form-control" id="reviewScore">
										<option>0</option>
										<option>1 ★</option>
										<option>1.5 ★☆</option>
										<option>2 ★★</option>
										<option>2.5 ★★☆</option>
										<option>3 ★★★</option>
										<option>3.5 ★★★☆</option>
										<option>4 ★★★★</option>
										<option>4.5 ★★★★☆</option>
										<option>5 ★★★★★</option>
									</select>
								</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-12 pr-5">
								<button type="button" class="btn btn-block btn-info col-3" style="float:right;" onclick="reviewRegist();">등록</button>
							</div>
						</div>
				</div>
				<!-- /.card-body -->
			</div>
		</div>
	</section>
	
	<form role="reviewRegistForm" action="registClsReview" method="post">
		<input type="hidden" name="opcl" value="${review.opcl}" />
		<input type="hidden" name="reviewContent" value="0">
		<input type="hidden" name="reviewScore" value="0">
	</form>

	<script>
		$('#reviewContent').keyup(function(e) {
			var content = $(this).val();
			if (content.length <= 300)
				$("#counter").text(content.length + "/300");

			if (content.length > 300) {
				$(this).val($(this).val().substring(0, 300));
				$("#counter").text("300/300");
			}
		});
		
		function reviewRegist(){
			let form = document.querySelector('form[role="reviewRegistForm"]');
			
			var reviewContent = $('#reviewContent').val();
			var reviewScore = $('#reviewScore').val();
			
			const words = reviewScore.split(' ');
			reviewScore = words[0];
			form.reviewContent.value=reviewContent;
			form.reviewScore.value=reviewScore;
			
			console.log(reviewContent);
			console.log(reviewScore);
			console.log(form);
			
			if(!(!!reviewContent)){
				alert("수강후기를 등록해주세요.");
				return;
			}
			
			if(confirm("이대로 등록하시겠습니까?")){
				form.submit();
			}
		}
	</script>
</body>


































