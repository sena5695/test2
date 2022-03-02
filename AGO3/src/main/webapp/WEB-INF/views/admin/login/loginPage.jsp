<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 로그인</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- icheck bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">
<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<link rel="icon" href="<%=request.getContextPath()%>/resources/img/pavicon.png">
</head>
<body class="hold-transition login-page">
	<div class="login-box">
		<!-- /.login-logo -->
		<div class="card card-outline card-primary">
			<div class="card-header text-center">
				<a href="<%=request.getContextPath()%>/resources/bootstrap/index2.html" class="h1">
					<b>AGO</b>
					<span class="h3">Admin</span>
				</a>
			</div>
			<div class="card-body">

				<form action="login.do" method="post">
					<div class="input-group mb-3">
						<input type="text" name="id" class="form-control" placeholder="Id">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
					<div class="input-group mb-3">
						<input type="password" name="pwd" class="form-control" placeholder="Password">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-8">
							<div class="icheck-primary">
								<p class="mb-0">
									<a href="<%=request.getContextPath() %>/admin/login/searchForPwd.do" class="text-center" onclick="OpenWindow(this.href, '비밀번호 찾기', '450', '500'); return false;">비밀번호 찾기</a>
								</p>
							</div>
						</div>
						<!-- /.col -->
						<div class="col-4">
							<button type="submit" class="btn btn-primary btn-block">로그인</button>
						</div>
						<!-- /.col -->
					</div>
				</form>

				<div class="social-auth-links text-center mt-2 mb-3">
					<a href="<%=request.getContextPath()%>/user/loginPage.do" class="btn btn-block btn-primary">
						<i class="fas fa-user mr-2"></i>
						사용자 로그인
					</a>
					<a href="<%=request.getContextPath()%>/manager/loginPage.do" class="btn btn-block btn-danger">
						<i class="fas fa-clipboard-list mr-2"></i>
						운영자 로그인
					</a>
				</div>
				<!-- /.social-auth-links -->

<!-- 				<p class="mb-1"> -->
<!-- 					<a href="forgot-password.html">아이디 찾기</a> -->
<!-- 				</p> -->

			</div>
			<!-- /.card-body -->
		</div>
		<!-- /.card -->
	</div>
	<!-- /.login-box -->

	<!-- jQuery -->
	<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="<%=request.getContextPath()%>/resources/bootstrap/dist/js/adminlte.min.js"></script>
</body>
</html>
