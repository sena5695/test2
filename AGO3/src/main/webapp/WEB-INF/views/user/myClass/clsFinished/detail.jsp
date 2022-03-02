<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<head></head>

<title>종료된 강의</title>

<body>
	<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">종료된 강의</h1>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/user/myClass/main.do">내강의실</a>
						</li>
						<li class="breadcrumb-item active">종료된 강의</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

		<div class="class-detail row col-10 ml-2">
			<img src="https://cdn.pixabay.com/photo/2016/01/19/17/57/car-1149997_960_720.jpg" style="width: 200px; height: 150px;">
			<div class="col-8 column ui-sortable">
				<span class="h6">개인 정보 보호 교육</span>
				<span class="badge badge-primary">온라인</span>
				<span class="badge badge-danger">필수</span>
				<br>
				<span class="">사내 교육</span><br>
				<i class="text-warning fas fa-star"></i>
				<i class="text-warning fas fa-star"></i>
				<i class="text-warning fas fa-star"></i>
				<i class="text-warning fas fa-star"></i>
				<i class="text-warning fas fa-star-half"></i>
				<span class="text-warning">(4.5)</span>
			</div>
		</div>
		
		<br>

		<div class="col-12">
			<div class="list-group d-flex flex-row" id="list-tab" role="tablist">
				<a class="list-group-item list-group-item-action" id="class-info-list" data-toggle="list" href="#class-info" role="tab" aria-controls="info">강의정보</a>
				<a class="list-group-item list-group-item-action active" id="list-index-list" data-toggle="list" href="#list-index" role="tab" aria-controls="home">강의목차</a>
				<a class="list-group-item list-group-item-action" id="list-reference-list" data-toggle="list" href="#list-reference" role="tab" aria-controls="profile">자료실</a>
				<a class="list-group-item list-group-item-action" id="list-review-list" data-toggle="list" href="#list-review" role="tab" aria-controls="messages">수강후기</a>
			</div>
		</div>

		<br>

		<div class="col-12">
			<div class="tab-content" id="nav-tabContent">

				<!-- 강의정보 -->
				<div class="tab-pane fade" id="class-info" role="tabpanel" aria-labelledby="class-info-list">
					<div class="row list-title">
						<h6 class="col-9" style="margin: 0px;">강의 정보</h6>
					</div>
					<hr color="#1D64F2" style="height:3px; border-radius:40px; margin-top:5px;" />
				
					<table class="table mt-3">
						<tr>
							<td class="font-weight-bold">수료기준안내</td>
							<td colspan="3">
								<p>-수료율 100%</p>
								<p>-시험 80점이상</p>
							</td>
						</tr>
						<tr>
							<td class="font-weight-bold">정원</td>
							<td>제한없음</td>
							<td class="font-weight-bold">강의이수시간</td>
							<td>2</td>
						</tr>
						<tr>
							<td class="font-weight-bold">신청기간</td>
							<td>2021.01.01 ~ 2021.12.31</td>
							<td class="font-weight-bold">교육기간</td>
							<td>신청일로부터 30일</td>
						</tr>
						<tr>
							<td class="font-weight-bold">과정소개</td>
							<td colspan="3">
								<p>- 개인정보 보호법 주요내용</p>
								<p>- 개인정보 안전성 확보조치</p>
								<p>- 개인정보 유노출 예방방안</p>
								<p> - 처리방침 및 개인정보 수집이용 동의 서식 작성(실습)</p>
							</td>
						</tr>
					</table>
				</div>

				<!-- 강의목차 -->
				<div class="tab-pane fade show active" id="list-index" role="tabpanel" aria-labelledby="list-home-list">

					<div class="row list-title">
						<h6 class="col-9" style="margin: 0px;">강의 목차</h6>
					</div>
					<hr color="#1D64F2" style="height: 3px; border-radius: 40px; margin-top: 5px;" />

					<table class="table table-hover">
						<thead>
							<tr class="text-center">
								<th scope="col">회차</th>
								<th scope="col">회차명</th>
								<th scope="col">학습상태</th>
								<th scope="col">강의보기</th>
								<th scope="col">시험</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td>1</td>
								<td>개인정보안정성 확보조치 기준 소개</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">85%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs" onclick="OpenWindow('/ago/user/myClass/clsStudying/clsPlay.pop','title' ,1000, 650);">강의보기</button>
								</td>
								<td>-</td>
							</tr>
							<tr class="text-center">
								<td>2</td>
								<td>접근권한의 관리</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs">강의보기</button>
								</td>
								<td>-</td>
							</tr>
							<tr class="text-center">
								<td>3</td>
								<td>접근통제</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs">강의보기</button>
								</td>
								<td>-</td>
							</tr>
							<tr class="text-center">
								<td>4</td>
								<td>개인정보의 암호화</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs">강의보기</button>
								</td>
								<td>-</td>
							</tr>
							<tr class="text-center">
								<td>5</td>
								<td>접속기록의 보관 및 점검</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs">강의보기</button>
								</td>
								<td>-</td>
							</tr>
							<tr class="text-center">
								<td>6</td>
								<td>악성프로그램 방치</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs">강의보기</button>
								</td>
								<td>-</td>
							</tr>
							<tr class="text-center">
								<td>7</td>
								<td>개인정보의 파기</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs">강의보기</button>
								</td>
								<td>-</td>
							</tr>

							<tr class="text-center">
								<td>8</td>
								<td>평가</td>
								<td>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
									</div>
								</td>
								<td>
									<button class="btn btn-primary btn-xs" disabled="disabled">시험보기</button>
								</td>
								<td>[17/20] | 85점</td>
							</tr>
						</tbody>
					</table>

					<!--보고서제출 -->
					<div class="row list-title">
						<h6 class="col-9" style="margin: 0px;">보고서 제출</h6>
					</div>
					<hr color="#1D64F2" style="height: 3px; border-radius: 40px; margin-top: 5px;" />
					<table class="table table-hover">
						<tr class="text-center">
							<td class="font-weight-bold">처리상태</td>
							<td>미제출</td>
							<td><button class="btn btn-success btn-xs" onclick="OpenWindow('reportForm.pop','교육 이수 보고서', 780 , 860)">보고서 제출</button></td>
						</tr>

						<tr class="text-center">
							<td class="font-weight-bold">처리상태</td>
							<td>처리중</td>
							<td><button class="btn btn-success btn-xs" disabled="disabled">보고서 제출</button></td>
						</tr>

						<tr class="text-center">
							<td class="font-weight-bold">처리상태</td>
							<td class="text-danger">반려</td>
							<td><button class="btn btn-success btn-xs">보고서 제출</button></td>
						</tr>

						<tr class="text-center">
							<td class="font-weight-bold">처리상태</td>
							<td>승인완료</td>
							<td><button class="btn btn-success btn-xs" disabled="disabled">보고서 제출</button></td>
						</tr>

					</table>
					<!--/보고서 제출-->
				</div>
				<!--/강의목차-->


				<!-- 자료실-->
				<div class="tab-pane fade" id="list-reference" role="tabpanel" aria-labelledby="list-profile-list">
					<div class="row list-title">
						<h6 class="col-9" style="margin: 0px;">자료실</h6>
					</div>
					<hr color="#1D64F2" style="height: 3px; border-radius: 40px; margin-top: 5px;" />

					<table class="table table-hover">
						<thead>
							<tr class="text-center">
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td>1</td>
								<td>개인정보교육 자료</td>
								<td><span class="h5" style="cursor: pointer;"><i class="la la-save"></i></span></td>
							</tr>

							<tr class="text-center">
								<td colspan="4">등록된 자료가 없습니다.</td>
							</tr>

						</tbody>
					</table>
				</div>
				<!--/자료실-->


				<!--수강후기-->
				<div class="tab-pane fade" id="list-review" role="tabpanel" aria-labelledby="list-messages-list">
					<div class="row list-title">
						<h6 class="col-9" style="margin: 0px;">수강후기</h6>

					</div>
					<hr color="#1D64F2" style="height: 3px; border-radius: 40px; margin-top: 5px;" />

					<div class="reviews-list">
						<div class="col-2 ml-auto">
							<button class="btn btn-primary btn-xs float-right" onclick="OpenWindow('registClsReviewForm.pop','수강후기 등록',1000,350)">수강후기 등록</button>
						</div>

						<br>
						<br>

						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<div class="reviews">
									<p>
									<div class="row">
										<div class="col-8">
											<span>dani</span> <span class="col">2021.01.03</span>

										</div>
										<div class="ml-auto h6">
											<i class="text-warning la la-star"></i> <i class="text-warning la la-star"></i> <i class="text-warning la la-star"></i> <i class="text-warning la la-star"></i> <i class="text-warning la la-star-half-empty"></i> <span class="text-warning">(4.5)</span>
										</div>
									</div>
									</p>
									<p class="inline-block">
										<span class="font-weight-bold">강의 정말 잘들었습니다.</span>
									</p>
								</div>
							</li>

							<li class="list-group-item">
								<div class="reviews">
									<p>
									<div class="row">
										<div class="col-8">
											<span>baldkingpenguin</span> <span class="col">2021.01.03</span>

										</div>
										<div class="ml-auto h6">
											<i class="text-warning la la-star"></i> <i class="text-warning la la-star"></i> <i class="text-warning la la-star"></i>
											<!-- <i class="text-warning la la-star"></i> -->
											<i class="text-warning la la-star-half-empty"></i> <span class="text-warning">(3.5)</span>
										</div>
									</div>
									</p>
									<p class="inline-block">
										<span class="font-weight-bold">대황펭이다</span>
									</p>
								</div>
							</li>

							<li class="list-group-item">
								<div class="reviews">
									<p class="text-center">등록된 수강 후기가 없습니다.</p>
								</div>
							</li>
						</ul>

					</div>
					<!--/수강후기-->

				</div>

				<div class="buttons">
					<div class="col-1 ml-auto d-flex justify-content-between">
						<!-- <button class="btn btn-primary float-right" onclick="fn_regist()"> &nbsp;등록&nbsp;</button> -->
						<button class="btn btn-default float-right" onclick="location.href='list.do?mCode=M000202'">
							<i class="la la-angle-double-left"></i>&nbsp;목록
						</button>
					</div>
				</div>

			</div>
		</div>
	</div>

</body>