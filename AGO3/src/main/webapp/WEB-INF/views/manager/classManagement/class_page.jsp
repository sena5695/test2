<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head></head>

<title></title>
<body>

<!-- 메인 헤더 -->
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h4 class="m-0">강의목록</h4>
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
						<li class="breadcrumb-item active">강의목록</li>
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
	
		<div class="col-12 p-3" style="background-color: #EDEDED;">
			<div class="input-group justify-content-center">
				<select class="col-md-2 form-control" style="height: 39px;">
					<option>전체</option>
					<option>강의명</option>
					<option>강의코드</option>
				</select>
				<input type="text" placeholder="Search..." class="form-control col-md-4">
				<button class="col-md-1 btn btn-default">검색</button>
			</div>
		</div>
		
		<table class="col-md-12 column" style="border: none;">
			<tr>
				<td style="text-align: left;"><select>
						<option>전체</option>
						<option>인사과</option>
					</select></td>
				<td style="text-align: right;">
					<button class="btn-primary">등록</button>
				</td>
			</tr>
		</table>
		<table class="table mt-3">
			<thead>
				<tr>
					<th class="col-md-1 column">강의코드</th>
					<th class="col-md-7 column">강의명</th>
					<th class="col-md-1 column">학습기간</th>
					<th class="col-md-1 column">수강기간</th>
					<th class="col-md-2 column">강의구분</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>20200101</td>
					<td class="row">
						<div class="col-md-9 column ui-sortable">
							<span class="h5 mt-5">멀티미디어의 이해 </span><span class="h5">(5) </span> <br> <span class="text-primary">2021.01.01~2022.01.01</span><br>
							<br> <span class="h5 badge badge-primary">오프라인</span> <span class="h5 badge badge-danger">필수</span>
						</div>
					</td>
					<td style="text-align: center;">2020.01.01<br>~<br>2022.01.01
					</td>
					<td style="text-align: center;">2020.01.01<br>~<br>2022.01.01
					</td>
					<td>신입의무교육</td>

				</tr>
			</tbody>
		</table>
		<div class="card-body col-md-12 column ui-sortable ">
			<ul class="pagination pg-primary justify-content-center">
				<li class="page-item">
					<a class="page-link" href="#" aria-label="Previous">
						<span aria-hidden="true">«</span> <span class="sr-only">Previous</span>
					</a>
				</li>
				<li class="page-item active">
					<a class="page-link" href="#">1</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="#">2</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="#">3</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span> <span class="sr-only">Next</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
	</section>
</body>