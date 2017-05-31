<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 로그인 페이지 </title>
	<link rel="stylesheet" href="../../resources/css/formstyle.css">
  	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/css/styles.css" />
</head>
<body>
<nav class="navbar navbar-fixed-top navbar-toggleable-sm navbar-inverse bg-primary mb-3">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#collapsingNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="flex-row d-flex">
        <a class="navbar-brand mb-1" href="loginform" style ="font-size:40px;">Dodo</a>
        <button type="" class="hidden-md-up navbar-toggler" data-toggle="offcanvas" title="Toggle responsive left sidebar">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
    <div class="navbar-collapse collapse" id="collapsingNavbar">
        <ul class="navbar-nav">
            <li class="nav-item active">
                 <a class="nav-link" href="#"><span class="sr-only">Home</span></a>
                 <!-- <i class="fa fa-cube fa-2x" aria-hidden="true"></i> -->
                 
            </li> 
         
        </ul>
<%--         <ul class="navbar-nav ml-auto">
        	<li class="nav-item">
        	<sec:authorize access="hasAuthority('USER')">
				<sec:authentication property="name" />님 환영합니다
    			<a href="<c:url value='/BP/User/logout' />">로그아웃</a>
			</sec:authorize>
			</li>
         	<li class="nav-item">
                <a class="nav-link" href="" data-target="#myModal" data-toggle="modal"><i class="fa fa-user fa-2x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="" data-target="#myModal" data-toggle="modal"><i class="fa fa-list-alt fa-2x" aria-hidden="true" style="color:white; margin-right:15px;"></i></a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="" data-target="#myModal" data-toggle="modal"><i class="fa fa-cogs fa-2x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="" data-target="#myModal" data-toggle="modal"><i class="fa fa-sign-out fa-2x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a>
             </li>
        </ul> --%>
    </div>
</nav>



<form method="post" action="loginform">
<br>
<br>
<br>
<div class="box">
<h1>LOGIN</h1>
<input type="hidden" class="email" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="text" name="id" id="id" value="enemfla1234"  class="email" />
<input type="password" name="pwd" name="pwd" value="enemfla1234"  class="email" />
<button type = "submit" id= "btn2">Login</button> <!-- End Btn2 -->
<div style="text-align:center; color:red;"><c:if test="${param.error==true}">Login Fail!</c:if></div>
<a href="infofind"><div class="btn">찾기</div></a> <!-- End Btn -->
<a href="userjoin"><div class="btn">회원가입</div></a> <!-- End Btn -->
</div> <!-- End Box -->
  
</form>
</body>
</html>