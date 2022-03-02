<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set value="${examDetail.mTest}" var="mTest"/>
<c:set value="${examDetail.fTest}" var="fTest"/>

<html>
<head>
<meta charset="UTF-8">
<title>시험통계 상세화면</title>
</head>
<body>
	<div class="content-header pb-2">
		<div class="container-fluid ">
			<div class="row mb-2 ">
				<div class="col-sm-9">
					<h3 class="text-bold m-0">${examDetail.clName}</h3>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
	</div>
	<hr class="bg-secondary m-0 ml-2"
		style="width: 98.5%; height: 5px; border-radius: 7px;">
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-body p-2">
							<div class="row">
								<div class="col-5  border-right">
									<i class="fas fa-user-friends align-middle ml-4 mt-2"
										style="font-size: 55px;">
										<p class="ml-1 mt-1 text-gray" style="font-size: 15px;">수강인원</p>
									</i> <span class="ml-3 align-middle" style="font-size: 46px;">${examDetail.student}</span>
								</div>

								<div class="col-7">
									<i class="far fa-calendar-alt align-middle ml-4 mt-2"
										style="font-size: 55px;">
										<p class="mt-1 text-gray text-bold"
											style="margin-left: -5px; font-size: 15px;">수강기간</p>
									</i> <span class="ml-3 align-middle" style="font-size: 38px;">
										<fmt:formatDate value="${examDetail.postSdate}"
											pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
											value="${examDetail.postEdate}" pattern="yyyy-MM-dd" />
									</span>
								</div>
							</div>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
				<!-- col-md-12 -->
				<div class="col-md-6">
					<div class="card card-secondary">
						<div class="card-header">
							<h2 class="card-title float-left">
								<b>중간평가 달성률</b>
							</h2>
						</div>
						<div class="card-body">
							<c:if test="${examDetail.mTotalCount eq 0}">
								<div class="text-bold text-center pt-5" style="width:100%; height:118px;">
									중간 평가가 없는 과목입니다.
								</div>
							</c:if>
							<c:if test="${examDetail.mTotalCount ne 0}">
								<div class="row">
									<div class="col-6 col-md-4 text-center">
										<div style="display: inline; width: 115px; height: 115px;">
											<input type="text" class="knob" 
												value="<fmt:formatNumber value="${examDetail.mPassRate}" pattern=".0"/>" 
												data-width="95" 
												data-height="95" 
												data-fgcolor="#3c8dbc" 
												data-readonly="true" 
												readonly="readonly" 
												style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;">
										</div>
									</div>
									<div class="col-6 col-md-8 mt-3">
										<div class="row">
											<div class="col-6 col-md-4 text-right" style="font-size: 13px;">0-40점 미만</div>
											<div class="col-6 col-md-8 ">
												<div class="progress mb-3">
													<div class="progress-bar bg-success" role="progressbar" style="width: <fmt:formatNumber value="${examDetail.mScorePersent[0]}" pattern=".0"/>%" aria-valuenow="${examDetail.mScoreCount[0]}" aria-valuemin="0" aria-valuemax="${examDetail.student}"></div>
													<span style="position: absolute; right: 10px; top: 8px;">${examDetail.mScoreCount[0]}명</span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-6 col-md-4 text-right" style="font-size: 13px;">40-70점 미만</div>
											<div class="col-6 col-md-8 ">
												<div class="progress mb-3">
													<div class="progress-bar bg-success" role="progressbar" style="width: <fmt:formatNumber value="${examDetail.mScorePersent[1]}" pattern=".0"/>%" aria-valuenow="${examDetail.mScoreCount[1]}" aria-valuemin="0" aria-valuemax="${examDetail.student}"></div>
													<span style="position: absolute; right: 10px; top: 8px;">${examDetail.mScoreCount[1]}명</span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-6 col-md-4 text-right" style="font-size: 13px;">70점 이상</div>
											<div class="col-6 col-md-8 ">
												<div class="progress">
													<div class="progress-bar bg-success" role="progressbar" style="width: <fmt:formatNumber value="${examDetail.mScorePersent[2]}" pattern=".0"/>%" aria-valuenow="${examDetail.mScoreCount[2]}" aria-valuemin="0" aria-valuemax="${examDetail.student}"></div>
													<span style="position: absolute; right: 10px; top: 8px;">${examDetail.mScoreCount[2]}명</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="text-bold text-info ml-3" style="font-size: 12px;">
									시험 응시자 수 : ${examDetail.mTotalCount}
								</div>
							</c:if>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
				<!-- col-md-6 -->
				<div class="col-md-6">
					<div class="card card-secondary">
						<div class="card-header">
							<h2 class="card-title float-left">
								<b>기말평가 달성률</b>
							</h2>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-6 col-md-4 text-center">
									<div style="display: inline; width: 110px; height: 110px;">
										<input type="text" class="knob"
											value="<fmt:formatNumber value="${examDetail.fPassRate}" pattern=".0"/>" data-width="95"
											data-height="95" data-fgcolor="#123684" data-readonly="true"
											readonly="readonly"
											style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;">
									</div>
								</div>
								<div class="col-6 col-md-8 mt-3">
									<div class="row">
										<div class="col-6 col-md-4 text-right"
											style="font-size: 13px;">0-40점 미만</div>
										<div class="col-6 col-md-8 ">
											<div class="progress mb-3">
											 
												<div class="progress-bar bg-success" role="progressbar"
													style="width: <fmt:formatNumber value="${examDetail.fScorePersent[0]}" pattern=".0"/>%"
													aria-valuenow="${examDetail.fScoreCount[0]}"
													aria-valuemin="0" aria-valuemax="${examDetail.student}"></div>
													<span style="position: absolute; right: 10px; top: 8px;">${examDetail.fScoreCount[0]}명</span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-6 col-md-4 text-right"
											style="font-size: 13px;">40-70점 미만</div>
										<div class="col-6 col-md-8 ">
											<div class="progress mb-3">
												<div class="progress-bar bg-success" role="progressbar"
													style="width: <fmt:formatNumber value="${examDetail.fScorePersent[1]}" pattern=".0"/>%"
													aria-valuenow="${examDetail.fScoreCount[1]}"
													aria-valuemin="0" aria-valuemax="${examDetail.student}"></div>
													<span style="position: absolute; right: 10px; top: 8px;">${examDetail.fScoreCount[1]}명</span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-6 col-md-4 text-right"
											style="font-size: 13px;">70점 이상</div>
										<div class="col-6 col-md-8 ">
											<div class="progress">
												<div class="progress-bar bg-success" role="progressbar"
													style="width: <fmt:formatNumber value="${examDetail.fScorePersent[2]}" pattern=".0"/>%"
													aria-valuenow="${examDetail.fScoreCount[2]}"
													aria-valuemin="0" aria-valuemax="${examDetail.student}"></div>
													<span style="position: absolute; right: 10px; top: 8px;">${examDetail.fScoreCount[2]}명</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="text-bold text-info ml-3" style="font-size: 12px;">
								시험 응시자 수 : ${examDetail.fTotalCount}
							</div>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
				<!-- col-md-6 -->

				<div class="col-md-12">
					<!-- BAR CHART -->
					<div class="card card-secondary">
						<div class="card-header">
							<h3 class="card-title text-bold">문제별 정답률</h3>
						</div>
						<div class="card-body">
							<div class="chart">
								<div class="chartjs-size-monitor">
									<div class="chartjs-size-monitor-expand">
										<div class=""></div>
									</div>
									<div class="chartjs-size-monitor-shrink">
										<div class=""></div>
									</div>
								</div>
								<canvas id="barChart"
									style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 764px;"
									width="764" height="250" class="chartjs-render-monitor"></canvas>
							</div>
						</div>
						<!-- /.card-body -->
					</div>
				</div>
			</div>
		</div>
	</section>


	<script>
		function go_list(url) {
			window.top.location.replace('<%=request.getContextPath()%>' + url);
		}
	</script>
	<script>
		function click_pdf(){
			window.open("data:application/pdf;base64, " + qweqweaa.pdf.base64EncodedPDF);
		}
	
		$(function() {
			/* ChartJS
			 * -------
			 * Here we will create a few charts using ChartJS
			 */
			var areaChartData = {
				labels : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
						'11', '12', '13', '14', '15', '16', '17', '18', '19',
						'20', ],
				datasets : [
						{
							label : '기말평가 정답률',
							backgroundColor : 'rgba(60,141,188,0.9)',
							borderColor : 'rgba(60,141,188,0.8)',
							pointRadius : false,
							pointColor : '#3b8bba',
							pointStrokeColor : 'rgba(60,141,188,1)',
							pointHighlightFill : '#fff',
							pointHighlightStroke : 'rgba(60,141,188,1)',
							data : [ 
								<c:forEach items="${fTest}" var="fTestVar">
									${fTestVar},
								</c:forEach>
							]
						},
						{
							label : '중간평가 정답률',
							backgroundColor : '#adb5bd',
							borderColor : '#adb5bd',
							pointRadius : false,
							pointColor : 'rgba(210, 214, 222, 1)',
							pointStrokeColor : '#c1c7d1',
							pointHighlightFill : '#fff',
							pointHighlightStroke : 'rgba(220,220,220,1)',
							data : [ 
								<c:forEach items="${mTest}" var="mTestVar">
									${mTestVar},
								</c:forEach>
							]
						}, ]
			}

			var areaChartOptions = {
				maintainAspectRatio : false,
				responsive : true,
				legend : {
					display : false
				},
				scales : {
					xAxes : [ {
						gridLines : {
							display : false,
						}
					} ],
					yAxes : [ {
						gridLines : {
							display : false,
						}
					} ]
				}
			}

			//-------------
			//- BAR CHART -
			//-------------
			var barChartCanvas = $('#barChart').get(0).getContext('2d')
			var barChartData = $.extend(true, {}, areaChartData)
			var temp0 = areaChartData.datasets[0]
			var temp1 = areaChartData.datasets[1]
			barChartData.datasets[0] = temp1
			barChartData.datasets[1] = temp0

			var barChartOptions = {
				responsive : true,
				maintainAspectRatio : false,
				datasetFill : false
			}

			new Chart(barChartCanvas, {
				type : 'bar',
				data : barChartData,
				options : barChartOptions
			})

		})
	</script>

	<script>
		$(function() {
			/* ChartJS
			 * -------
			 * Here we will create a few charts using ChartJS
			 */

			//--------------
			//- AREA CHART -
			//--------------
			// Get context with jQuery - using jQuery's .get() method.
			var areaChartCanvas = $('#areaChart').get(0).getContext('2d')

			var areaChartData = {
				labels : [ 'January', 'February', 'March', 'April', 'May',
						'June', 'July' ],
				datasets : [ {
					label : 'Digital Goods',
					backgroundColor : 'rgba(60,141,188,0.9)',
					borderColor : 'rgba(60,141,188,0.8)',
					pointRadius : false,
					pointColor : '#3b8bba',
					pointStrokeColor : 'rgba(60,141,188,1)',
					pointHighlightFill : '#fff',
					pointHighlightStroke : 'rgba(60,141,188,1)',
					data : [ 28, 48, 40, 19, 86, 27, 90 ]
				}, {
					label : 'Electronics',
					backgroundColor : 'rgba(210, 214, 222, 1)',
					borderColor : 'rgba(210, 214, 222, 1)',
					pointRadius : false,
					pointColor : 'rgba(210, 214, 222, 1)',
					pointStrokeColor : '#c1c7d1',
					pointHighlightFill : '#fff',
					pointHighlightStroke : 'rgba(220,220,220,1)',
					data : [ 65, 59, 80, 81, 56, 55, 40 ]
				}, ]
			}

			var areaChartOptions = {
				maintainAspectRatio : false,
				responsive : true,
				legend : {
					display : false
				},
				scales : {
					xAxes : [ {
						gridLines : {
							display : false,
						}
					} ],
					yAxes : [ {
						gridLines : {
							display : false,
						}
					} ]
				}
			}

			//-------------
			//- BAR CHART -
			//-------------
			var barChartCanvas = $('#barChart').get(0).getContext('2d')
			var barChartData = $.extend(true, {}, areaChartData)
			var temp0 = areaChartData.datasets[0]
			var temp1 = areaChartData.datasets[1]
			barChartData.datasets[0] = temp1
			barChartData.datasets[1] = temp0

			var barChartOptions = {
				responsive : true,
				maintainAspectRatio : false,
				datasetFill : false
			}

			new Chart(barChartCanvas, {
				type : 'bar',
				data : barChartData,
				options : barChartOptions
			})
		})
	</script>

	<script>
		$(function() {
			/* jQueryKnob */

			$('.knob').knob(
					{
						draw : function() {

							// "tron" case
							if (this.$.data('skin') == 'tron') {

								var a = this.angle(this.cv) // Angle
								, sa = this.startAngle // Previous start angle
								, sat = this.startAngle // Start angle
								, ea // Previous end angle
								, eat = sat + a // End angle
								, r = true

								this.g.lineWidth = this.lineWidth

								this.o.cursor && (sat = eat - 0.3)
										&& (eat = eat + 0.3)

								if (this.o.displayPrevious) {
									ea = this.startAngle
											+ this.angle(this.value)
									this.o.cursor && (sa = ea - 0.3)
											&& (ea = ea + 0.3)
									this.g.beginPath()
									this.g.strokeStyle = this.previousColor
									this.g.arc(this.xy, this.xy, this.radius
											- this.lineWidth, sa, ea, false)
									this.g.stroke()
								}

								this.g.beginPath()
								this.g.strokeStyle = r ? this.o.fgColor
										: this.fgColor
								this.g.arc(this.xy, this.xy, this.radius
										- this.lineWidth, sat, eat, false)
								this.g.stroke()

								this.g.lineWidth = 2
								this.g.beginPath()
								this.g.strokeStyle = this.o.fgColor
								this.g.arc(this.xy, this.xy, this.radius
										- this.lineWidth + 1 + this.lineWidth
										* 2 / 3, 0, 2 * Math.PI, false)
								this.g.stroke()

								return false
							}
						}
					})
			/* END JQUERY KNOB */

			//INITIALIZE SPARKLINE CHARTS
			var sparkline1 = new Sparkline($('#sparkline-1')[0], {
				width : 240,
				height : 70,
				lineColor : '#92c1dc',
				endColor : '#92c1dc'
			})
			var sparkline2 = new Sparkline($('#sparkline-2')[0], {
				width : 240,
				height : 70,
				lineColor : '#f56954',
				endColor : '#f56954'
			})
			var sparkline3 = new Sparkline($('#sparkline-3')[0], {
				width : 240,
				height : 70,
				lineColor : '#3af221',
				endColor : '#3af221'
			})

			sparkline1
					.draw([ 1000, 1200, 920, 927, 931, 1027, 819, 930, 1021 ])
			sparkline2.draw([ 515, 519, 520, 522, 652, 810, 370, 627, 319, 630,
					921 ])
			sparkline3.draw([ 15, 19, 20, 22, 33, 27, 31, 27, 19, 30, 21 ])

		})
	</script>
	<!-- FLOT CHARTS -->
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/plugins/flot/jquery.flot.js"></script>

	<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/plugins/flot/plugins/jquery.flot.resize.js"></script>

	<!-- FLOT PIE PLUGIN - also used to draw donut charts -->
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/plugins/flot/plugins/jquery.flot.pie.js"></script>

	<script type="module"
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>
</html>

















