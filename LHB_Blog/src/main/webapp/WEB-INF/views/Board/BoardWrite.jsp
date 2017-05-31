<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글작성 페이지</title>
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
  <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="generator" content="Codeply">
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
  <link rel="stylesheet" href="<c:url value="/resources/css/styles.css/"/>"/>
<link rel="stylesheet" href="../../resources/css/main.css"/>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>

$(function(){
function add(){
      $('#fileadd').append("<input type='file' name='files'/><br>");
   }
   
$('#wbtn').click(function(){
   if($('#msg').val() == ""){
      alert('제목을 입력해 주세요.');
      return false;
   }
   else if($('[name=cat]').val() == ""){
      alert('카테고리를 선택해 주세요.');
      return false;
   }
   else if($('#contents').val() == ""){
      alert('내용을 입력해 주세요.');
      return false;
   }
})
})  
</script>
<style>

#t{
width: 600px;
margin: 0px auto;
}
#contents{height: 100px;}
</style>
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
                <sec:authorize access="!isAuthenticated()"><a class="nav-link" href="../../uc/User/loginform" >
                <i class="fa fa-sign-in fa-3x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a></sec:authorize>
            </li>
            <li class="nav-item">
                <sec:authorize access="!isAuthenticated()"><a class="nav-link" href="../../uc/User/userjoin" >
                <i class="fa fa-user fa-3x" style="color:white; margin-right:15px;" aria-hidden="true"></i></a></sec:authorize>
            </li>
            
            
           <!-- 유저전용 아이콘 표시 -->
           <sec:authorize access="hasAuthority('USER')">
           <li class="nav-item">
            <a class="nav-link" href=""  style="color:white;"><sec:authentication var="USERID" property="principal"/>${USERID.username}님</a>
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
             <c:set var="USERID" scope="session" value ="${USERID.username}"></c:set>
             </sec:authorize>
        </ul>
    </div>
</nav>


<!-- 사이드바 시작 -->
<div class="container-fluid" id="main">
  <div class="row row-offcanvas row-offcanvas-left"> 
        <div class="col-md-3 col-lg-2 sidebar-offcanvas" id="sidebar" role="navigation" style="float: left;">
            <ul class="nav flex-column pl-1">
                <!-- 사이드바 검색기능 -->
               <li class="nav-item">
               <form action="../../bc/main/ssearch" method="post" id="frm">
                   <input type="hidden" class="email" name="${_csrf.parameterName }" value="${_csrf.token }">
	               <input type="search" id="search" name="searchI">
	               <input type="hidden" name="searchS" value="title">
	               <input type="hidden" name="page" value="1">
				    <a href="#" onclick="$('#frm').submit();">
		               <i class="fa fa-search fa-2x" style="color:#014c8c; margin-left:10px;" aria-hidden="true"></i>
				   </a>
               </form>
               </li>
                <!-- 사이드바 검색기능 -->
                <li class="nav-item">
                    <a class="nav-link" href="#submenu1" data-toggle="collapse" data-target="#submenu1">게시판 리스트▾</a>
                    <ul class="list-unstyled flex-column pl-3 collapse" id="submenu1" aria-expanded="false">
                     <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Travel&page=1">여행</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Movie&page=1">영화</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Fashion&page=1">패션</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Love&page=1">연애</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=IT&page=1">IT</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Sprots&page=1">스포츠</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Music&page=1">음악</a></li>
                        <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Game&page=1">게임</a></li>
                    </ul>
                </li>
            </ul>

		</div> 

<div class="col-md-9 col-lg-10 main">

<!-- 폼시작 -->
<div id="t" style="margin: 0px auto; float: none;">

<form  style="display: inline" id="writeform" name="form" method="post" 
   enctype="multipart/form-data" action="write?${_csrf.parameterName}=${_csrf.token}">
<p>

<div class="input-group">
   <span class="input-group-addon" style="border-bottom: 0px;width:100px; height: 30px;">Title&nbsp;&nbsp;&nbsp; </span>
   <input id="msg" type="text" class="form-control" name="title" placeholder="제목을 입력하세요" style="border-bottom: 0px; height: 30px;">
</div>
 
<div class="input-group">
 <span class="input-group-addon" style="width:100px; height: 30px;">Author</span>
 <span class="form-control" style="text-align: left;height: 30px; color: gray;"><sec:authentication property="name"/></span>
</div>
<div class="input-group">
   <span class="input-group-addon" style="border-bottom: 0px;width:100px; height: 30px;">Category</span>
   <select size='1' class='form-control' name="cat" style="font-size: small; border-bottom: 0px; height: 30px;">
         <option  value=''>카테고리를 선택하세요 </option>
         <option  value='Movie'>Movie</option>
         <option  value='Sports'>Sports</option>
         <option  value='Music'>Music</option>
         <option  value='Fashion'>Fashion</option>
         <option  value='Travel'>Travel</option>
         <option  value='Game'>Game</option>
         <option  value='Love'>Love</option>
         <option  value='IT'>IT</option>
         
   </select>
</div>  
<div class="input-group">
   <textarea  placeholder="Contents" id="contents" class="form-control" name ="contents" rows="10" cols="29"  style="height: 300px;"></textarea>
</div>

<div class="input-group">
 <div class="input-group-addon" style="width:100px; height: 30px;">첨부</div>
 <span class="form-control" style="text-align: left;height: 30px; color: gray;"><input type="file" name="files"/></span>
   <button type="submit" >+</button>
</div>
<br>
   <div style="text-align: center;">
   <button id="wbtn" class="btn btn-primary" type="submit">등록</button>&emsp;&emsp;
   <button class="btn btn-primary" type="reset">리셋</button>&emsp;&emsp;
   <button class="btn btn-primary" type="button" onclick="location.href='boardList?page=1'">취소</button>
   </div>

</form>
</div>

</div>
</div>
</div>
<br>
   <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
</body>
</html>