<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>    
<body>
<script type="text/javascript">
   alert("보고서를 제출했습니다.");
   
   window.opener.location.href="<%=request.getContextPath()%>/user/myClass/main.do";
   window.close();
</script>

</body>