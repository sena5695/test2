<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>    
<body>
<script type="text/javascript">
   alert("수정되었습니다.");
   
   window.close();
   window.opener.location.href="<%=request.getContextPath()%>/user/myPage/completedClass/list.do?sortType='extReport'";
</script>

</body>