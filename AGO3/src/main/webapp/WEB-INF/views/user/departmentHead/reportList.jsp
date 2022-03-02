<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<head></head>
<title></title>

<body>
	<div class="content-wrapper m-0" style="min-width: 1280px;">
		<!-- 메인 헤더 -->
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h4 class="m-0">수강 내역</h4>
					</div>
					<!-- /.col -->
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item">
								<i class="fas fa-home"></i>
							</li>
							<li class="breadcrumb-item">
								<a href="<%=request.getContextPath()%>/user/departmentHead/main.do">메인보드</a>
							</li>
							<li class="breadcrumb-item">수강 내역</li>
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
				<div class="card">
					<div class="card-header">
						<div class="input-group justify-content-end col-12 p-0 mb-1">
							<div class="row col-7 justify-content-end p-0 mr-1">
								<select class="col-md-2 form-control" name="searchType">
									<option value="tn">전체</option>
									<option value="t">강좌명</option>
									<option value="n">부서원</option>
								</select>
								<input type="text" placeholder="검색할 단어를 입력하세요" class="form-control col-md-7" name="keyword" value="" />
								<button class="col-md-1 btn btn-primary float-right" onclick="list_go(1);">검색</button>
							</div>
						</div>
						<span class="text-muted" style="color: gray; cursor: pointer;" onclick="fn_list(1);">전체</span>
						<span class="text-muted" style="color: gray;">&nbsp;|&nbsp;</span>
						<span class="text-muted" style="color: gray; cursor: pointer;" id="sortOption" data-sort="r" onclick="fn_sort(1);"> 사내 </span>
						<span class="text-muted" style="color: gray;">&nbsp;|&nbsp;</span>
						<span class="text-muted" style="color: gray; cursor: pointer;" id="sortOption" data-sort="r" onclick="fn_sort(1);"> 외부 </span>
					</div>
					<div class="card-body p-0">
						<table class="table table-sm table-hover">
							<thead>
								<tr class="text-center">
									<th>구분</th>
									<th class="col-4 test-left">강좌명</th>
									<th>부서원</th>
									<th>수료날짜</th>
									<th>진도율</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">업무용 네트워크 기술</td>
									<td>조명석</td>
									<td>2021.12.31</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 30%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>수강중</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">업무용 네트워크 기술</td>
									<td>이단비</td>
									<td>2021.12.29</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 76%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>수강중</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">업무용 네트워크 기술</td>
									<td>김노을</td>
									<td>2021.12.28</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 60%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>수강중</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">업무용 네트워크 기술</td>
									<td>박소현</td>
									<td>2021.12.28</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 98%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>수강중</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">JSP ＆ Servlet Programming</td>
									<td>조명석</td>
									<td>2021.12.27</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재중</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">구조와 설계</td>
									<td>박소현</td>
									<td>2021.12.26</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 80%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>수강중</td>
								</tr>
								<tr class="text-center">
									<td>외부</td>
									<td class="col-4 text-left">디자인 시스템 구축</td>
									<td>김수진</td>
									<td>2021.12.22</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재 완료</td>
								</tr>
								<tr class="text-center">
									<td>외부</td>
									<td class="col-4 text-left">디자인 시스템 구축</td>
									<td>정현욱</td>
									<td>2021.12.18</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>미제출</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">구조와 설계</td>
									<td>조명석</td>
									<td>2021.12.18</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재 완료</td>
								</tr>
								<tr class="text-center">
									<td>외부</td>
									<td class="col-4 text-left">디자인 시스템 구축</td>
									<td>박소현</td>
									<td>2021.12.17</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재 완료</td>
								</tr>
								<tr class="text-center">
									<td>외부</td>
									<td class="col-4 text-left">디자인 시스템 구축</td>
									<td>이단비</td>
									<td>2021.12.17</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재 완료</td>
								</tr>
								<tr class="text-center">
									<td>외부</td>
									<td class="col-4 text-left">디자인 시스템 구축</td>
									<td>조명석</td>
									<td>2021.12.17</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>반려</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">JSP ＆ Servlet Programming</td>
									<td>정현욱</td>
									<td>2021.12.15</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>수강중</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">JSP ＆ Servlet Programming</td>
									<td>김노을</td>
									<td>2021.12.15</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재 완료</td>
								</tr>
								<tr class="text-center">
									<td>사내</td>
									<td class="col-4 text-left">구조와 설계</td>
									<td>김수진</td>
									<td>2021.12.14</td>
									<td>
										<div class="progress">
											<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</td>
									<td>결재 완료</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="card-footer text-center">
						<nav aria-label="Navigation">
							<ul class="pagination justify-content-center m-0">
								<li class="page-item">
									<a class="page-link" href="#">
										<i class="fas fa-angle-double-left"></i>
									</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#">
										<i class="fas fa-angle-left"></i>
									</a>
								</li>

								<li class="page-item active">
									<a class="page-link" href="#"> 1 </a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#"> 2 </a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#"> 3 </a>
								</li>

								<li class="page-item">
									<a class="page-link" href="#">
										<i class="fas fa-angle-right"></i>
									</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#">
										<i class="fas fa-angle-double-right"></i>
									</a>
								</li>
							</ul>
							<!-- /.pagination -->
						</nav>
					</div>
				</div>

			</div>
		</section>
</body>