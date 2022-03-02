<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><decorator:title default="All Gi For Organixation" /></title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/daterangepicker/daterangepicker.css">
<!-- jQuery -->
<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<link rel="icon" href="<%=request.getContextPath()%>/resources/img/pavicon.png">

<decorator:head />
<style>
#remdDIV::-webkit-scrollbar {
	display: none;
}
</style>
</head>
<body class="mx-auto text-sm" style="width: 1280px; margin-left: 10px;">
  <!-- Preloader -->

	<div class="wrapper">

		<!-- Navbar -->
		<nav class="main-header navbar navbar-expand ${ !empty loginUser ? 'navbar-primary' : 'navbar-secondary' } navbar-dark m-0 px-4" role="logoNav" id="logoNav" style="min-width: 1280px;">
			<!-- Left navbar links -->
			<ul class="navbar-nav align-items-center">
				<li>
					<a href="indexPage.do">
						<img src="<%=request.getContextPath()%>/resources/img/logo.png" id="logoId" name="logo" style="width: 200px; height: 55px;">
					</a>
				</li>
				<!-- mainMunu 생성 -->
				<c:forEach items="${ menuList }" var="menu">
					<li class="nav-item d-none d-sm-inline-block">
						<a href="javascript:goPage('<%=request.getContextPath() %>${menu.murl }','${menu.mcode }');subMenu_go('${menu.mcode}');" class="nav-link">${menu.mname }</a>
					</li>
				</c:forEach>

			</ul>

			<c:if test="${empty member.memName}">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item dropdown" style="cursor:pointer;">
						<a class="nav-link" data-toggle="dropdown" onclick="logout();">
							logout
						</a>
					</li>
				</ul>
			</c:if>

			<!-- Right navbar links -->
			<c:if test="${!empty member.memName }">
			<ul class="navbar-nav ml-auto">
				<c:if test="${loginUser.authorityId eq 'A102' }">
				<li class="nav-item">
					<a class="nav-link" href="javascript:goPage('<%=request.getContextPath()%>/user/departmentHead/main.do', 'M000700');subMenu_go('M000700');">
						<i class="fas fa-briefcase"></i>
					</a>
				</li>
				</c:if>

				<!-- Logout DropDown Menu -->

<%-- 				<c:if test="${!empty member.memName }"> --%>
				<li class="nav-item dropdown">
					<a class="nav-link" data-toggle="dropdown" href="#">
						<i class="far fa-user"></i>

					</a>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
						<span class="dropdown-item dropdown-header">내 정보</span>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item"> <!-- Message Start -->
							<div class="media">

								<div class="media-body">
									<h3 class="dropdown-item-title">
										${member.memName }(${member.memId })
									</h3>
									<p class="text-sm">${member.dpId }</p>
									<p class="text-sm text-muted">
										 ${member.memEmail }<br>
										 ${member.memPhone }
									</p>
								</div>
								<img src="<%=request.getContextPath()%>/resources/img/logo.png" alt="User Avatar" style="width:60px;height:36px;background-color:#007bff;">
							</div> <!-- Message End -->
						</a>



						<div class="dropdown-divider"></div>
						<a href="<%=request.getContextPath() %>/user/myPage/myInfo/modifyMemberPwdForm.pop" onclick="OpenWindow(this.href, '비밀번호 변경', '450', '450'); return false;" class="dropdown-item">
							<i class="fas fa-lock"></i>&nbsp;
							<span class="text-sm">비밀번호 변경하기</span>
						</a>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item" onclick="logout();">
							<i class="fas fa-unlink"></i>&nbsp;
							<span class="text-sm">로그아웃</span>
						</a>
					</div>
				</li>
<%-- 				</c:if> --%>


				<!-- Messages Dropdown Menu -->

				<a class="nav-link" href="javascript:goPage('<%=request.getContextPath()%>/user/myPage/message/list.do', 'M000502');subMenu_go('M000500'); ">
					<i class="far fa-comments"></i>
					<span class="badge badge-danger navbar-badge">${msgCnt }</span>
				</a>


				<c:set var="totalRemindCount" value="${dataMap.totalRemindCount }"/>
				<c:set var="intrClassList" value="${dataMap.intrClassList }"/>
				<c:set var="realTimeClassList" value="${dataMap.realTimeClassList }"/>
				<c:set var="emergencyReportList" value="${dataMap.emergencyReportList }"/>
				<c:set var="today" value="<%= new Date() %>"/>

				<!-- Notifications Dropdown Menu -->
				<li class="nav-item dropdown">
					<a class="nav-link" data-toggle="dropdown" href="#">
						<i class="far fa-bell"></i>
						<c:if test="${totalRemindCount ne 0 || member.authorityId eq 'A102' && reportCnt ne 0}">
							<span class="badge badge-warning navbar-badge">
								<c:if test="${member.authorityId eq 'A102' && reportCnt ne 0}">
									${totalRemindCount + 1}
								</c:if>
								<c:if test="${member.authorityId ne 'A102' || member.authorityId eq 'A102' && totalRemindCount ne 0 && reportCnt eq 0}">
									${totalRemindCount}
								</c:if>
							</span>
						</c:if>
					</a>
					<div id="remdDIV"  class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="overflow-y: scroll; -ms-overflow-style: none; left: inherit;right: 0px; max-width:370px; min-width:370px; z-index:1035px;">
						<c:if test="${totalRemindCount eq 0 && member.authorityId ne 'A102' || reportCnt eq 0 && member.authorityId eq 'A102' && totalRemindCount eq 0}">
							<span class="dropdown-item dropdown-header">
								온 알림이 없습니다.
							</span>
						</c:if>
						<c:if test="${totalRemindCount ne 0 || member.authorityId eq 'A102'  && reportCnt ne 0}">
							<span class="dropdown-item dropdown-header">
								총
								<c:if test="${member.authorityId eq 'A102' && reportCnt ne 0}">
									${totalRemindCount + 1}
								</c:if>
								<c:if test="${member.authorityId ne 'A102' || member.authorityId eq 'A102' && totalRemindCount ne 0 && reportCnt eq 0}">
									${totalRemindCount}
								</c:if>
								개의 알림이 있습니다.
							</span>

							<c:if test="${remindSet.realtimeClFlag == 1}">
								<c:forEach items="${realTimeClassList}" var="realTimeClass">
									<div class="dropdown-divider"></div>
									<a href="javascript:goPage('<%=request.getContextPath() %>/user/myClass/clsStudying/list.do,'M000201');subMenu('M000200');" class="dropdown-item">
										<div class="row">
											<i class="fas fa-solid fa-calendar-check pt-1 pr-1 ml-1"></i>
											<div style=" width:325px; white-space : pre-wrap;">오늘 <span class="text-primary">${realTimeClass.clName}</span> 실시간 강의가 있습니다.</div>
											<span class="float-right text-danger text-sm" style="width:100%; text-align:right;">TODAY</span>
										</div>
									</a>
								</c:forEach>
							</c:if>
							<c:if test="${remindSet.reportDlFlag == 1}">
								<c:forEach items="${emergencyReportList}" var="emergencyReport">
									<div class="dropdown-divider"></div>
									<a href="javascript:goPage('<%=request.getContextPath() %>/user/myClass/clsFinished/list.do','M000202');subMenu_go('M000200');" class="dropdown-item">
										<div class="row">
											<c:if test="${not empty emergencyReport.clName}">
												<i class="fas fa-solid fa-file-signature pt-1 pr-1 ml-1"></i>
												<div style=" width:325px; white-space : pre-wrap;" ><span class="text-primary">${emergencyReport.clName}</span>의 보고서 제출기한이 임박했습니다.</div>
												<span class="float-right text-danger text-sm" style="width:100%; text-align:right;">
													마감일 : <fmt:formatDate value="${emergencyReport.reportDeadLine}" pattern="yyyy-MM-dd"/>
												</span>
											</c:if>
										</div>
									</a>
								</c:forEach>
							</c:if>
							<c:if test="${remindSet.intrClFlag == 1}">
								<c:forEach items="${intrClassList}" var="intrClass">
									<div class="dropdown-divider"></div>
									<a href="javascript:goPage('<%= request.getContextPath() %>/user/myClass/clsLike/list.do','M000203');subMenu_go('M000200');" class="dropdown-item">
										<div class="row">
											<i class="fas fa-solid fa-bell pt-1 pr-1 ml-1"></i>
											<div style=" width:325px; white-space : pre-wrap;"><span class="text-primary">${intrClass.clName}</span> 수강기간 마감 임박</div>
											<span class="float-right text-danger text-sm" style="width:100%; text-align:right;">
												마감일 : <fmt:formatDate value="${intrClass.postEdate}" pattern="yyyy-MM-dd"/>
											</span>
										</div>
									</a>
								</c:forEach>
							</c:if>

							<c:if test="${member.authorityId eq 'A102' && reportCnt ne 0}">
								<div class="dropdown-divider"></div>
								<a href="javascript:goPage('<%= request.getContextPath() %>/user/departmentHead/reportApproval.do','M000704');subMenu_go('M000700');" class="dropdown-item">
									<i class="fas fa-file mr-2"></i>
									${reportCnt}개의 보고서가 결재대기 중입니다.
								</a>
							</c:if>
						</c:if>
					</div>
				</li>
			</ul>
			</c:if>
		</nav>
		<!-- /.navbar -->
		<nav class="main-header navbar navbar-expand navbar-white navbar-light m-0 p-0" style="min-width: 1280px; z-index:inherit;">
			<ul class="navbar-nav align-items-center pl-5" id="subMenuList">

			</ul>
		</nav>
		<!-- /.navbar -->