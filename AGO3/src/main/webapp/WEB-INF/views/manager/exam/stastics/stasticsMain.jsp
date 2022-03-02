<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 시험 통계 -->
<c:set var="examStatisList" value="${dataMap.examStatisList}" />
<!-- 강의목록 -->
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head></head>
<title>시험 통계화면</title>
<body>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-0" >
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">시험 통계</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath() %>/manager/classManagement/main.do">강의관리</a>
						</li>
						<li class="breadcrumb-item active">시험 통계</li>
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
	<section class="content" >
		<div class="container-fluid">
			
			<div style="min-height:580px;">
			<table class="table mt-3">
				<thead>
					<tr class="text-center" style="background-color: #F5F4F4;">
						<th>강의코드</th>
						<th>강의명</th>
						<th>시험 평균 점수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="classItem" items="${examStatisList}">
						<tr>
							<td class="text-center align-middle" style="width:160px; font-size: 18px;">${classItem.clCode}</td>
							<td class="align-middle" style="width:500px; cursor: pointer" onclick="OpenWindow('scDetail.pop?opcl=${classItem.opcl}','시험관리', 900, 750);">
								<span class="text-bold font-monospace" style="font-size: 17px;">${classItem.clName}</span>
								<div class="row m-1">
									<c:if test="${classItem.clCate eq 'A201'}">
										<span class=" badge badge-info">${classItem.clCateName}</span>							
									</c:if>
									<c:if test="${classItem.clCate eq 'A202'}">
										<span class=" badge badge-primary">${classItem.clCateName}</span>							
									</c:if>
									<c:if test="${classItem.clCate eq 'A203'}">
										<span class=" badge badge-warning">${classItem.clCateName}</span>							
									</c:if>
								</div>
							</td>
							<td class="col-4" style="width:605px;">
								<table>
									<tbody>
										<c:if test="${not empty classItem.mtestFile}">
											<tr>
												<td style="border: none; height: 40px;" class="p-0">
													<div class="progress-group">
														중간 평균 점수 <span class="float-right"><b>${classItem.mtestAvgSco }</b>/100</span>
														<div class="progress progress-sm active" style="width: 585px;">
															<div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="${classItem.mtestAvgSco }" aria-valuemin="0" aria-valuemax="100" style="width: ${classItem.mtestAvgSco }%; background-color:#3c8dbc;"></div>
														</div>
													</div>
												</td>
											</tr>
										</c:if>
										<tr>
											<td style="border: none; height: 40px;" class="p-0">
												<div class="progress-group">
													기말 평균 점수<span class="float-right"><b>${classItem.ftestAvgSco }</b>/100</span>
													<div class="progress progress-sm active" style="width: 585px;">
														<div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="${classItem.ftestAvgSco }" aria-valuemin="0" aria-valuemax="100" style="width: ${classItem.ftestAvgSco }%; background-color:#123684;"></div>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>

			<div class="card-body text-center pt-0 pb-0">
				<%@include file="/WEB-INF/views/common/examStasticsPagination.jsp"%>
			</div>

		</div>
	</section>

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

			<c:forEach var="examList" items="${examMap}" varStatus="status">
				var areaChartCanvas${status.index} = $('#areaChart${status.index}').get(0).getContext('2d');
				var areaChartData${status.index} = {
					labels : [ 
						<c:forEach var="classExam" items="${examList.value}">
							'${classExam.clName}',
						</c:forEach> 
							],
					datasets : [ {
						label : 'Digital Goods',
						backgroundColor : 'rgba(60,141,188,0.9)',
						borderColor : 'rgba(60,141,188,0.8)',
						pointRadius : false,
						pointColor : '#3b8bba',
						pointStrokeColor : 'rgba(60,141,188,1)',
						pointHighlightFill : '#fff',
						pointHighlightStroke : 'rgba(60,141,188,1)',
						data : [ 
							<c:forEach var="classExam" items="${examList.value}">
								'${classExam.mtestAvgSco}',
							</c:forEach> 
							]
					}, {
						label : 'Electronics',
						backgroundColor : 'rgba(210, 214, 222, 1)',
						borderColor : 'rgba(210, 214, 222, 1)',
						pointRadius : false,
						pointColor : 'rgba(210, 214, 222, 1)',
						pointStrokeColor : '#c1c7d1',
						pointHighlightFill : '#fff',
						pointHighlightStroke : 'rgba(220,220,220,1)',
						data : [ 
							<c:forEach var="classExam" items="${examList.value}">
								'${classExam.ftestAvgSco}',
							</c:forEach>  
						]
					}, ]
				}
			</c:forEach>

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

			// This will get the first returned node in the jQuery collection.
			<c:forEach var="examList" items="${examMap}" varStatus="status">
				new Chart(areaChartCanvas${status.index}, {
					type : 'line',
					data : areaChartData${status.index},
					options : areaChartOptions
				})
			</c:forEach>

			//-------------
			//- LINE CHART -
			//--------------
			var lineChartCanvas = $('#lineChart').get(0).getContext('2d')
			var lineChartOptions = $.extend(true, {}, areaChartOptions)
			var lineChartData = $.extend(true, {}, areaChartData)
			lineChartData.datasets[0].fill = false;
			lineChartData.datasets[1].fill = false;
			lineChartOptions.datasetFill = false

			var lineChart = new Chart(lineChartCanvas, {
				type : 'line',
				data : lineChartData,
				options : lineChartOptions
			})

			//-------------
			//- DONUT CHART -
			//-------------
			// Get context with jQuery - using jQuery's .get() method.
			var donutChartCanvas = $('#donutChart').get(0).getContext('2d')
			var donutData = {
				labels : [ 'Chrome', 'IE', 'FireFox', 'Safari', 'Opera',
						'Navigator', ],
				datasets : [ {
					data : [ 700, 500, 400, 600, 300, 100 ],
					backgroundColor : [ '#f56954', '#00a65a', '#f39c12',
							'#00c0ef', '#3c8dbc', '#d2d6de' ],
				} ]
			}
			var donutOptions = {
				maintainAspectRatio : false,
				responsive : true,
			}
			//Create pie or douhnut chart
			// You can switch between pie and douhnut using the method below.
			new Chart(donutChartCanvas, {
				type : 'doughnut',
				data : donutData,
				options : donutOptions
			})

			//-------------
			//- PIE CHART -
			//-------------
			// Get context with jQuery - using jQuery's .get() method.
			var pieChartCanvas = $('#pieChart').get(0).getContext('2d')
			var pieData = donutData;
			var pieOptions = {
				maintainAspectRatio : false,
				responsive : true,
			}
			//Create pie or douhnut chart
			// You can switch between pie and douhnut using the method below.
			new Chart(pieChartCanvas, {
				type : 'pie',
				data : pieData,
				options : pieOptions
			})

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

			//---------------------
			//- STACKED BAR CHART -
			//---------------------
			var stackedBarChartCanvas = $('#stackedBarChart').get(0)
					.getContext('2d')
			var stackedBarChartData = $.extend(true, {}, barChartData)

			var stackedBarChartOptions = {
				responsive : true,
				maintainAspectRatio : false,
				scales : {
					xAxes : [ {
						stacked : true,
					} ],
					yAxes : [ {
						stacked : true
					} ]
				}
			}

			new Chart(stackedBarChartCanvas, {
				type : 'bar',
				data : stackedBarChartData,
				options : stackedBarChartOptions
			})
		})
	</script>
</body>








