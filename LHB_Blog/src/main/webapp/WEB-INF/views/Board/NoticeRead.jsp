<%@ page contentType="text/html; charset= UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 상세 페이지</title>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<meta name="description"
	content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar 
    toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. 
    The top navbar is controlled by a separate hamburger toggle button." />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
<link rel="stylesheet" href="../../resources/css/styles.css" />
<link rel="stylesheet" href="../../resources/css/main.css" />
<script src="<c:url value="/resources/jquery-3.1.1.min.js" />"></script>
<style type="text/css">
.notice {
	width: 600px;
	padding: 20px;
	background-color: #fafafa;
	border-left: 6px solid #7f7f84;
	margin-bottom: 30px;
	-webkit-box-shadow: 0 5px 8px -6px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 5px 8px -6px rgba(0, 0, 0, .2);
	box-shadow: 0 5px 8px -6px rgba(0, 0, 0, .2);
}

.notice-sm {
	padding: 10px;
	font-size: 80%;
}

.notice-lg {
	padding: 35px;
	font-size: large;
}

.notice-success {
	border-color: #80D651;
}

.notice-success>strong {
	color: #80D651;
}

.notice-info {
	border-color: #45ABCD;
}

.notice-info>strong {
	color: #45ABCD;
}

.notice-file {
	border-color: black;
}

.notice-file>strong {
	color: #black;
}

.notice-warning {
	border-color: #FEAF20;
}

.notice-warning>strong {
	color: #FEAF20;
}

.notice-danger {
	border-color: #d73814;
}

.notice-danger>strong {
	color: #d73814;
}

#repple {
	
}
</style>
<script>
	
</script>
<style>
#t {
	width: 600px;
	margin: 0px auto;
}
</style>
</head>
<body>
	<nav
		class="navbar navbar-fixed-top navbar-toggleable-sm navbar-inverse bg-primary mb-3">
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#collapsingNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="flex-row d-flex">
			<a class="navbar-brand mb-1" href="../../uc/Main/main"
				style="font-size: 40px;">Dodo</a>
			<button type="button" class="hidden-md-up navbar-toggler"
				data-toggle="offcanvas" title="Toggle responsive left sidebar">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
		<div class="navbar-collapse collapse" id="collapsingNavbar">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="sr-only">Home</span></a> <!-- <i class="f a fa-cube fa-2x" aria-hidden="true"></i> -->
				</li>
			</ul>


			<!-- 아이콘 표시 -->
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href=""
					style="color: Black;"><sec:authorize
							access="!isAuthenticated()">게스트</sec:authorize></a></li>
				<li class="nav-item"><sec:authorize access="!isAuthenticated()">
						<a class="nav-link" href="../../uc/User/loginform"> <i
							class="fa fa-sign-in fa-3x"
							style="color: white; margin-right: 15px;" aria-hidden="true"></i></a>
					</sec:authorize></li>
				<li class="nav-item"><sec:authorize access="!isAuthenticated()">
						<a class="nav-link" href="../../uc/User/userjoin"> <i
							class="fa fa-user fa-3x"
							style="color: white; margin-right: 15px;" aria-hidden="true"></i></a>
					</sec:authorize></li>


				<!-- 유저전용 아이콘 표시 -->
				<sec:authorize access="hasAuthority('USER')">
					<li class="nav-item"><a class="nav-link" href=""
						style="color: white;"><sec:authentication var="USERID"
								property="principal" />${USERID.username}님</a> <%-- <a href="<c:url value='/BP/User/logout' />">로그아웃</a> --%>

					</li>
					<li class="nav-item"><a class="nav-link"
						href="../../bc/main/write"> <i class="fa fa-pencil fa-3x"
							aria-hidden="true" style="color: white; margin-right: 15px;"></i></a>
					</li>
					<li class="nav-item"><a class="nav-link" href=""
						data-toggle="dropdown"> <i id="pop"
							class="fa fa-list-alt fa-3x" aria-hidden="true"
							style="color: white; margin-right: 15px;"></i>
					</a>
						<ul class="dropdown-menu dropdown-user" style="left: 1270px;">
							<c:forEach var="c" items="${cList}">
								<li><a href="../../bc/main/boardList?page=1&cat=${c.hobby}">${c.hobby}</a></li>
							</c:forEach>
							<li class="divider"></li>
							<li><a href="#">Read More</a></li>
						</ul>
					<li class="nav-item"><a class="nav-link"
						href="../../mc/Main/setup"> <i class="fa fa-cogs fa-3x"
							style="color: white; margin-right: 15px;" aria-hidden="true"></i></a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="../../uc/User/logout"> <i class="fa fa-sign-out fa-3x"
							style="color: white; margin-right: 15px;" aria-hidden="true"></i></a>
					</li>
					<c:set var="USERID" scope="session" value="${USERID.username}"></c:set>
				</sec:authorize>
			</ul>
		</div>
	</nav>


	<!-- 사이드바 시작 -->
	<div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">
			<div class="col-md-3 col-lg-2 sidebar-offcanvas" id="sidebar"
				role="navigation">
				<ul class="nav flex-column pl-1">
					<!-- 사이드바 검색기능 -->
					<li class="nav-item">
						<form action="../../bc/main/ssearch" method="post" id="frm">
							<input type="hidden" class="email" name="${_csrf.parameterName }"
								value="${_csrf.token }"> <input type="search"
								id="search" name="searchI"> <input type="hidden"
								name="searchS" value="title"> <input type="hidden"
								name="page" value="1"> <a href="#"
								onclick="$('#frm').submit();"> <i class="fa fa-search fa-2x"
								style="color: #014c8c; margin-left: 10px;" aria-hidden="true"></i>
							</a>
						</form>
					</li>
					<!-- 사이드바 검색기능 -->
					<li class="nav-item"><a class="nav-link" href="#submenu1"
						data-toggle="collapse" data-target="#submenu1">게시판 리스트▾</a>
						<ul class="list-unstyled flex-column pl-3 collapse" id="submenu1"
							aria-expanded="false">
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Travel&page=1">여행</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Movie&page=1">영화</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Fashion&page=1">패션</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Love&page=1">연애</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=IT&page=1">IT</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Sports&page=1">스포츠</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Music&page=1">음악</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../../bc/main/boardList?cat=Game&page=1">게임</a></li>
						</ul></li>
				</ul>
			</div>



			<div class="col-md-9 col-lg-10 main">

				<!--<h1 class="display-2 hidden-xs-down">메인 게시판 내용</h1>
            <p class="lead hidden-xs-down">메인 게시판 수정중</p>
             -->
				<!-- 상단 wow 버튼 누르면 반응함 -->
				<div class="alert alert-warning fade collapse" role="alert"
					id="myAlert">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
					</button>
					<strong>Holy guacamole!</strong> It's free.. this is an example
					theme.
				</div>
				<!-- 상담 wow 끝 -->
				<hr>

				<div id="t">
					<div class="well">
						<div class="container">
							<div class="notice notice-success">
								<strong>제목</strong> ${read.atitle}
							</div>
							<div class="notice notice-danger">
								<strong>작성자</strong>${read.gm}
							</div>
							<div class="notice notice-info">
								<strong>작성일</strong> ${read.adate}
							</div>
							<div class="notice notice-lg">
								<strong>내용</strong> ${read.acontents}
							</div>
							<div class="notice notice-sm" style="text-align: center;">
								<strong><button class="btn btn-default"
										onclick="location.href='notice?page=1'">목록</button>&emsp;&emsp;
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/main col-->

	<br>
	<br>
	<hr>
	<footer class="container-fluid">
		<p class="text-right small">ⓒ2016-2017 Company</p>
	</footer>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script
		src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
	<script src="../../resources/js/scripts.js"></script>
</body>
</html>