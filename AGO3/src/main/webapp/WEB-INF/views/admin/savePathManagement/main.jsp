<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head></head>

<title></title>

<body>
	<div class="content-header">
		<div class="container-fluid">
			<div class="row navList mt-2 mb-2 align-items-center">
				<h4 class="col-9 m-0">파일 저장 경로 관리</h4>
				<div class="col-3 text-right">
					<i class="fas fa-home" style="font-size: 15px;"></i> <span>&nbsp;>&nbsp;</span> <span>파일 저장 경로 관리</span>
				</div>
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-12">
					<c:forEach items="${ keys }" var="key" varStatus="status">
						<div class="input-group input-group-sm">
							<label for="${ key }">${ key }</label> <input id="${ key }" class="form-control" type="text" value="${ dataMap.get(key) }" name="tempPicture" disabled /> <span class="input-group-append-sm"> <label for="${ key }" class=" btn btn-info btn-sm btn-flat input-group-addon">경로변경</label>
							</span>
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- /.row -->
			<!-- Main row -->
		</div>
		<!-- /.container-fluid -->
	</section>
	<!-- /.content -->

	<form>
		<c:forEach items="${ keys }" var="key" varStatus="status">
			<input id="${ key }" type="hidden" value="${ dataMap.get(key) }" name="${ key }" />
			</div>
		</c:forEach>
	</form>
	<script>
		
	</script>
</body>
