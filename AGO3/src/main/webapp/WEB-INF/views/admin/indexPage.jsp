<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/scroll.css">
<script type="text/javascript" charset="utf-8">
	function logout() {
		let logout = confirm('로그아웃 하시겠습니까?');
		if (logout) {
			location.href = "logout.do";
		}
	}
</script>
</head>

<title></title>

<body>
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="<%=request.getContextPath()%>/resources/img/logo.png" alt="AGOLogo">
  </div>

	<script type="text/javascript">
		function resize(frame) {
			let height = frame.contentWindow.document.body.scrollHeight + 20;
			console.log(height);
			let winHeight = window.innerHeight - 103;
			if (height < winHeight) {
				height = winHeight;
				$('body').addClass("layout-footer-fixed");
			} else {
				$('body').removeClass("layout-footer-fixed");
			}
			frame.style.height = height + 'px';
		}
	</script>
	<iframe id="ifr" name="ifr" src="" frameborder="0" scrolling='no' style="width: 1030px;margin-left: 250px;" onload="resize(this);"></iframe>
	<script type="text/javascript">
function goPage(url,mCode){
	//alert(url);
	//alert(mCode);
	$('iframe[name="ifr"]').attr("src",url);
	//document.querySelector('iframe[name="ifr"]').src=url;


	  // HTML5 지원브라우저에서 사용 가능
	if (typeof(history.pushState) == 'function') {
	    //현재 주소를 가져온다.
	    var renewURL = location.href;
	    //현재 주소 중 .do 뒤 부분이 있다면 날려버린다.
	    renewURL = renewURL.substring(0, renewURL.indexOf(".do")+3);

	    if (mCode != 'M020000') {
	        renewURL += "?mCode="+mCode;
	    }
	    //페이지를 리로드하지 않고 페이지 주소만 변경할 때 사용
	    history.pushState(mCode, null, renewURL);

	} else {
	    location.hash = "#"+mCode;
	}
}


window.onload=function(){
	goPage('<%=request.getContextPath()%>${menu.murl}','${menu.mcode}');
}

</script>
</body>