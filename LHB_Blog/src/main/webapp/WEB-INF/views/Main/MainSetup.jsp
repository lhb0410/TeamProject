<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>설정 화면</title>
  	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/css/setupstyle.css" />
    <link rel="stylesheet" href="../../resources/css/main.css"/>
<!-- 	<link rel="stylesheet" href="resources/css/styles.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/styles.css" /> -->
    
   
  </head>
   
  <body >
    <nav class="navbar navbar-fixed-top navbar-toggleable-sm navbar-inverse bg-primary mb-3">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#collapsingNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="flex-row d-flex">
        <a class="navbar-brand mb-1" href="../../uc/Main/main" style ="font-size:40px;">Dodo</a>
        <button type="button" class="hidden-md-up navbar-toggler" data-toggle="offcanvas" title="Toggle responsive left sidebar">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
    <div class="navbar-collapse collapse" id="collapsingNavbar">
        <ul class="navbar-nav">
            <li class="nav-item active">
                 <a class="nav-link" href="#"><span class="sr-only">Home</span></a>
                 <!-- <i class="f a fa-cube fa-2x" aria-hidden="true"></i> -->
            </li> 
        </ul>
        
        
        <!-- 아이콘 표시 -->
        <ul class="navbar-nav ml-auto">
      	 	<li class="nav-item">	
        	<a class="nav-link" href=""  style="color:Black;"><sec:authorize access="!isAuthenticated()">게스트</sec:authorize></a>
        	</li>
             <li class="nav-item">
                <sec:authorize access="!isAuthenticated()"><a class="nav-link" href="../User/loginform" >
                <i class="fa fa-sign-in fa-3x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a></sec:authorize>
            </li>
        	 <li class="nav-item">
                <sec:authorize access="!isAuthenticated()"><a class="nav-link" href="../User/userjoin" >
                <i class="fa fa-user fa-3x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a></sec:authorize>
            </li>
            
            
           <!-- 유저전용 아이콘 표시 -->
        	<sec:authorize access="hasAuthority('USER')">
        	<li class="nav-item">
				<a class="nav-link" href=""  style="color:white;"><sec:authentication  property="name"/>님</a>
    			<%-- <a href="<c:url value='/BP/User/logout' />">로그아웃</a> --%>
			
			</li>
         	<li class="nav-item">
                <a class="nav-link" href="../../bc/main/write" >
                <i class="fa fa-pencil fa-3x" aria-hidden="true" style="color:white; margin-right:15px;"></i></a>
            </li>
            <li class="nav-item">
           			 <a class="nav-link" href="" data-toggle="dropdown">
                      	<i id="pop" class="fa fa-list-alt fa-3x" aria-hidden="true" style="color:white; margin-right:15px;"></i>
                   		 </a>
                    	<ul class="dropdown-menu dropdown-user" style="left:1270px; ">
                    	<c:forEach var="c" items="${cList}">
                        <li><a href="../../bc/main/boardList?page=1&cat=${c.hobby}">${c.hobby}</a></li>
                    	</c:forEach>
                        <li class="divider"></li>
                        <li><a href="#">Read More</a>
                        </li>
                   </ul>
  
             <li class="nav-item">
                <a class="nav-link" href="../../mc/Main/setup">
                <i class="fa fa-cogs fa-3x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="../../uc/User/logout" >
                <i class="fa fa-sign-out fa-3x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a>
             </li>
             </sec:authorize>
        </ul>
    </div>
</nav>

	<br>
	<br>
	<form class="editform">
	
	 <table class="box">
            <tr><td colspan="2" class="td">회원정보 설정</td></tr>
            
            <tr>
	            <td></td>
	            <td></td>
	        </tr>
	        
            <tr>
            	<td></td>
                <td><button type = "button" class="btn" onclick="location.href='usermodify'">회원정보 수정</button></td>
            </tr>
            
            	            
            <tr> 
            	<td></td>   
                <td><button type = "button" class="btn" onclick="location.href='withdrawal'">회원 탈퇴</button></td>
            </tr>
            
             <tr>
	            <td></td>
	            <td><button type = "button" class="btn" onclick="location.href='passwordchange'">비밀번호 변경</button></td>
	        </tr>
	        
	         <tr>
	            <td></td>
	            <td><button type = "button" class="btn" onclick="location.href='../../uc/Main/main'">메인 페이지</button></td>
	        </tr>
          
        </table>
   </form> 

 
  
<footer class="container-fluid">
    <p class="text-right small">ⓒ2016-2017 Company</p>
</footer>
    <!--scripts loaded here-->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
  
  </body>
</html>