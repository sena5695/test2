<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<head>
<script src="<%=request.getContextPath()%>/resources/js/jsQR.js"></script>
</head>

<title>출석체크</title>

<body>
<script>
	if(${chk eq 'success'}){
		alert("${message}");
		window.opener.location.reload(true);
		window.close();
	}
	if(${chk eq 'fail'}){
		alert("${message}");
		window.opener.location.reload(true);
		window.close();
	}

</script>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="">
					<h4 class="m-0">QR 출결체크</h4>
				</div>
				<!-- /.col -->
				<div class="ml-auto">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">QR 출결체크</li>
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
			<div id="test" class="d-flex">
				<div class="mx-auto" id="output">
					<div class="mx-auto" id="outputMessage">QR코드를 카메라에 노출시켜 주세요</div>
					<div class="mx-auto" id="outputLayer" hidden>
						<a id="outputData"></a>
					</div>
				</div>
			</div>
			<div>&nbsp;</div>
			<div>
				<div id="frame">
					<div id="loadingMessage">
						<span class="text-muted">🎥 비디오 스트림에 액세스 할 수 없습니다. 웹캠이 활성화되어 있는지 확인하십시오</span>
					</div>
					<canvas id="canvas"></canvas>
					<a id="link"></a>
				</div>
			</div>
		</div>
	</section>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		var video = document.createElement("video");
		var canvasElement = document.getElementById("canvas");
		var canvas = canvasElement.getContext("2d");
		var loadingMessage = document.getElementById("loadingMessage");
		var outputContainer = document.getElementById("output");
		var outputMessage = document.getElementById("outputMessage");
		var outputData = document.getElementById("outputData");
		let link = document.querySelector('#link');

		function drawLine(begin, end, color) {
			canvas.beginPath();
			canvas.moveTo(begin.x, begin.y);
			canvas.lineTo(end.x, end.y);
			canvas.lineWidth = 4;
			canvas.strokeStyle = color;
			canvas.stroke();
		}
		// 카메라 사용시
		navigator.mediaDevices.getUserMedia({
			video : true
// 			video : { facingMode: { exact: "environment" } }
		}).then(function(stream) {
			video.srcObject = stream;
			video.setAttribute("playsinline", true); // iOS 사용시 전체 화면을 사용하지 않음을 전달
			video.play();
			requestAnimationFrame(tick);
		}).catch(function(err) {
			alert(err.message);
		});

		function tick() {
			loadingMessage.innerText = "⌛ 스캔 기능을 활성화 중입니다."
			if (video.readyState === video.HAVE_ENOUGH_DATA) {
				loadingMessage.hidden = true;
				canvasElement.hidden = false;
				outputContainer.hidden = false;
				// 읽어들이는 비디오 화면의 크기
				canvasElement.height = video.videoHeight;
				canvasElement.width = video.videoWidth;
				canvas.drawImage(video, 0, 0, canvasElement.width,
						canvasElement.height);
				var imageData = canvas.getImageData(0, 0, canvasElement.width,
						canvasElement.height);
				var code = jsQR(imageData.data, imageData.width,
						imageData.height, {
							inversionAttempts : "dontInvert",
						});
				// QR코드 인식에 성공한 경우
				if (code) {
					if(code.data != ""){
						// 인식한 QR코드의 영역을 감싸는 사용자에게 보여지는 테두리 생성
						drawLine(code.location.topLeftCorner,
								code.location.topRightCorner, "#FF0000");
						drawLine(code.location.topRightCorner,
								code.location.bottomRightCorner, "#FF0000");
						drawLine(code.location.bottomRightCorner,
								code.location.bottomLeftCorner, "#FF0000");
						drawLine(code.location.bottomLeftCorner,
								code.location.topLeftCorner, "#FF0000");
						outputMessage.hidden = true;
						outputData.parentElement.hidden = false;
						// QR코드 메시지 출력
						location.href=code.data+"memId=${loginUser.memId}";
						return false;
					}
// 					outputData.innerHTML = code.data;
					// return을 써서 함수를 빠져나가면 QR코드 프로그램이 종료된다.
					// return;
				}
				// QR코드 인식에 실패한 경우
				else {
					outputMessage.hidden = false;
					outputData.parentElement.hidden = true;
				}
			}
			requestAnimationFrame(tick);
		}
	});
</script>
</body>



</body>