<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="clDetail" value="${clDetail }"/>
<c:set var="graphDataMap" value="${graphDataMap }" />


<head></head>

<title>강의 통계 </title>

<body>
<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header pb-2">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="text-bold m-0">강의 통계</h4>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<i class="fas fa-home"></i>
						</li>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/manager/classManagement/list.do">강의관리</a>
						</li>
						<li class="breadcrumb-item active">강의 통계</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->
    <div class="container-fluid">

        <div class="class-detail row " style="margin-left: 10px;">
            <img src="<%=request.getContextPath() %>/manager/classManagement/getPicture?picture=${clDetail.clImg}" style="width: 200px; height: 150px;">
            <div class="col-8 column ui-sortable">
                <span class="h6">[${clDetail.openRound}차시] ${clDetail.clName }</span>

                <br>
                <span class="">
                
                <c:if test="${clDetail.clCate eq 'A201' }">
                	신입 의무 교육
                </c:if>
                <c:if test="${clDetail.clCate eq 'A202' }">
                	일반 교육
                </c:if>
                <c:if test="${clDetail.clCate eq 'A203' }">
                	자기개발/취미
                </c:if>
                
                </span><br>
                
                <span class="text-warning">
                <c:if test="${clDetail.reviewScore ne '0.0' }">
					<c:forEach var="i" begin="1" end="${clDetail.reScrIntPart }">
						<i class="text-warning fas fa-star"></i>
					</c:forEach>
					<c:if test="${clDetail.reScrDecimal gt 4 }">
						<i class="text-warning fas fa-star-half"></i>
					</c:if>
				</c:if>
                (${clDetail.reviewScore})</span>
            </div>

        </div>
        
        
        <table class="table mt-3">
            <tr>
                <td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">강의 분류</td>
                <td>
                <c:if test="${clDetail.clCate eq 'A201' }">
                	신입 의무 교육
                </c:if>
                <c:if test="${clDetail.clCate eq 'A202' }">
                	일반 교육
                </c:if>
                <c:if test="${clDetail.clCate eq 'A203' }">
                	자기개발/취미
                </c:if>
                </td>
                <td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">메인 노출</td>
                <td>
                <c:if test="${empty clDetail.mainExposure }">
                	<span class="badge badge-secondary">미 노출</span>
                </c:if>
                <c:if test="${clDetail.mainExposure eq 'M101' }">
                	<span class="badge badge-success">신규</span>
                </c:if>
                <c:if test="${clDetail.mainExposure eq 'M102' }">
                	<span class="badge badge-warning">인기</span>
                </c:if>
                <c:if test="${clDetail.mainExposure eq 'M103' }">
                	<span class="badge badge-info">추천</span>
                </c:if>
                </span></td>                

            </tr>
            <tr>
                <td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">수강 인원</td>
                <td>${clDetail.enrPers }</td>
                <td class="font-weight-bold text-center col-2" style="background-color: #F5F4F4;">게시상태</td>
                <td>
                <c:if test="${clDetail.postStatus eq '게시 종료'}">
                	<span class="text-bold text-danger">게시 종료</span>
                </c:if>
                <c:if test="${clDetail.postStatus eq '게시 전'}">
                	<span class="text-bold text-warning">게시 전</span>
                </c:if>
                <c:if test="${clDetail.postStatus eq '게시 중'}">
                	<span class="text-bold text-primary">게시 중</span>
                </c:if>
                 </td>
            </tr>


        </table><br>
            
        
            <div class="col-12">
                <div class="list-group d-flex flex-row" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-index-list" data-toggle="list" href="#list-index" role="tab" aria-controls="home">부서별</a>
                    <a class="list-group-item list-group-item-action" id="list-reference-list" data-toggle="list" href="#list-reference" role="tab" aria-controls="profile">연령별</a>
                </div>
            </div>

            <br>

            <div class="col-12">
                <div class="tab-content" id="nav-tabContent">

                    <!-- 부서별 그래프 -->
				<div class="tab-pane fade show active" id="list-index" role="tabpanel" aria-labelledby="list-home-list">
					<div class="col-md-12">
						<div class="chart-responsive">
							<div class="chartjs-size-monitor">
								<div class="chartjs-size-monitor-expand">
									<div class=""></div>
								</div>
								<div class="chartjs-size-monitor-shrink">
									<div class=""></div>
								</div>
							</div>
							<c:if test="${!empty graphDataMap.listByDp }">
							<canvas id="pieChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 644px;" width="644" height="250" class="chartjs-render-monitor"></canvas>
							</c:if>
							<c:if test="${empty graphDataMap.listByDp }">
								<div style="width:644; height:250;" class="text-center">데이터가 없습니다.</div>
							</c:if>
						</div>
						<!-- ./chart-responsive -->
					</div>
				</div>
				<!--/부서별 그래프-->


				<!-- 연령별 그래프 -->
				<div class="tab-pane fade" id="list-reference" role="tabpanel" aria-labelledby="list-profile-list">
					
					<div class="col-md-12">
						<div class="chart-responsive">
							<div class="chartjs-size-monitor">
								<div class="chartjs-size-monitor-expand">
									<div class=""></div>
								</div>
								<div class="chartjs-size-monitor-shrink">
									<div class=""></div>
								</div>
							</div>
							<c:if test="${!empty graphDataMap.listByDp }">
							<canvas id="pieChart02" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 644px;" width="644" height="250" class="chartjs-render-monitor"></canvas>
							</c:if>
							<c:if test="${empty graphDataMap.listByDp }">
								<div style="width:644; height:250;" class="text-center">데이터가 없습니다.</div>
							</c:if>
						</div>
						<!-- ./chart-responsive -->
					</div>
                    
                </div>
                    
                </div>
            </div>
            
            <button class="btn btn-default float-right" onclick="location.href='statistics.do?mCode=M010203'"><i class="la la-angle-double-left">목록</i></button>
    </div>
    
<%@include file="/WEB-INF/views/manager/classManagement/stastics/detailchartScript_js.jsp"%>
    
</body>
   
      
      