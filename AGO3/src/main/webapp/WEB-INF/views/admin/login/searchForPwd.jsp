<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Forgot Password (v2)</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">
</head>
<title>관리자 비밀번호 찾기</title>
<body class="hold-transition login-page">
<div class="col-md-5" style="max-width:450px;min-width:450px;">

<div class="login-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="../resources/index2.html" class="h1"><b>AGO</b><span class="h3">Admin</span></a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">비밀번호를 잊으셨나요?<br />등록하신 이메일을 인증하세요.</p>
      <form action="" method="post">
        <div class="input-group mb-3">
          <input type="email" class="form-control" name="manager_email" placeholder="Email">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <button type="button" onclick="searchForPwd()" class="btn btn-primary btn-block">이메일 전송</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      <p class="mt-3 mb-1">
        <a href="login.html">로그인</a>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->
</div>
	<!-- jQuery -->
<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/resources/bootstrap/dist/js/adminlte.min.js"></script>

<script>
 function send_email(email){
	$.ajax({
		    url         : 'searchPwd.do?email='+email,
		    type        : 'post',
		    success     : function(data){
				if(data){
					alert("해당 이메일로 비밀번호 변경 주소를 발송했습니다.\n이메일을 확인해주세요.");
					window.close();
				}else{
					alert("이메일 전송에 실패했습니다.")
				}
		    },
		    error         : function(error){
		        alert("현재 사진 업로드가 불가합니다. \n 관리자에게 연락바랍니다.");
		        //AjaxErrorSecurityRedirectHandler(error.status);
		        console.log(error.status);
		    }
		}) 
	 
	 
 }		
 
 function searchForPwd() {
	var adminEmail = $('input[name=manager_email]').val();
	var regEmail = /^[0-9a-zA-Z_]+[@][0-9a-zA-Z]+(([\.][0-9a-zA-Z]+){1,2})$/;
	console.log(adminEmail)
	if(adminEmail == ""){
		alert("이메일을 작성해 주세요.")
	}else if(!(regEmail.test(adminEmail))){
		alert("이메일 형식에 맞지 않습니다. \n다시 작성해 주세요.")
	}else{
		$.ajax({
	        url         : 'checkPwd?adminEmail='+adminEmail,
	        type        : 'post',
	        success     : function(data){
				if(data){
					send_email(adminEmail);
				}else{
					alert("존재하지 않는 이메일 입니다.\n다시 입력해주세요.")
				}
	        },
	        error         : function(error){
	            console.log("이메일 확인 불가");
	        }
	    }) 
	}

}
	
</script>
</body>
