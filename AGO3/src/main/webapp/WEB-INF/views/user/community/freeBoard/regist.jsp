<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<head>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/summernote/summernote-bs4.min.css" />
<script src="<%=request.getContextPath() %>/resources/js/summernote/summernote-bs4.min.js"></script>
</head>

<title></title>

<body>

<!-- 메인 헤더 -->
<!-- Content Header (Page header) -->
	<div class="content-header pb-0"  >
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">대나무숲</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/user/community/freeBoard/list.do">커뮤니티</a>
						</li>
						<li class="breadcrumb-item">대나무숲</li>
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
        
        <form action="regist.do" role="registFreeBoardForm" method="post">
			<table id="maincontent" class="table table-sm m-0">
                <thead>
                    <tr>
                        <td class="font-weight-bold text-center col-1 pt-2" style="background-color:#E6EFFC;">제목</td>
                        <td ><input id="freeTitle" type="text" class="form-control border-0" name="freeTitle"></td>
                        <td class="font-weight-bold text-center col-1 pt-2" style="background-color:#E6EFFC;">작성자</td>
                        <td class="col-2">
                            <input type="hidden"  class="form-control-plaintext" name="memId" value="${memId}">
                            <input id="userNickName" maxlength='10' type="text" class="form-control border-0" name="nickName">
                        </td>
                    </tr>
             
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5">
                        <textarea id="freeBoardContent" class="textarea" name="freeContent" id="content" rows="20" placeholder="1000자 내외로 작성하세요." style="display: none;"></textarea>
                        </td>
                    <tr>
                </tbody>
            </table>
        </form>
        
        <%@ include file="/WEB-INF/views/common/summernote.jsp" %>

        <div style="float : right; margin-right: 20px;">
            <button class="btn btn-primary"  type="button" onclick="fn_regist();">등록</button>
            <button class="btn btn-default" type="button" onclick="location.href='list.do'">취소</button>
        </div>
    
    </div>
</section>
    
    
    <script>
    window.onload = function(){
        summernote_go($('textarea#freeBoardContent'));
    }
    
    function fn_regist(){
    	let form = document.querySelector('form[role="registFreeBoardForm"]');
		let inputTitle = document.querySelector("#freeTitle");
		let userNickName = document.querySelector("#userNickName");
		let freeBoardContent = document.querySelector("#freeBoardContent");
		if(!inputTitle.value){
			alert("제목을 입력하세요");
			return;
		}
		if(!userNickName.value){
			if(!confirm("닉네임을 설정하지 않으면 자신의 아이디로 보입니다.")){
				return;
			}
		}
		if(!freeBoardContent.value){
			alert("내용을 입력하세요");
			return;
		}
		if(confirm("등록하시겠습니까?")){
			form.submit();
		}
    }
    </script>

</body>