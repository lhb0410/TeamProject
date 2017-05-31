<%@ page contentType="text/html; charset= UTF-8"
    pageEncoding= "UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board list</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css">
<meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
<meta name="generator" content="Codeply">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="<c:url value="/resources/jquery-3.1.1.min.js" />"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js" />"></script> 

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
<link rel="stylesheet" href="../../resources/css/styles.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="../../resources/css/main.css"/>
<style type="text/css">
a{text-decoration: none;}
h4{text-align: center; margin-bottom: 5px;}
#search{margin-top: 10px;text-align: center;}
th{text-align: center;}
.td{text-align: center;}
.conteiner{width:900px; margin: 0px auto; text-align: center;}
.pagination {
margin: 0px auto; margin-top: 10px;
}

.pagination a {
    color: black;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    border: 1px solid #ddd;
    font-size: 15px;
}
.titleList{width: 300px;}
</style>

 <script>
        /* // init bootpag */
    $(function(){
        $('.pagination').bootpag({
            total: "${total}",         /* <!-- total pages --> */
            page: "${page}",          /* <!-- current page --> */
            maxVisible: 5,     /* <!-- Links per page --> */
            leaps: true,
            firstLastUse: true,
            first: '←',
            last: '→',
            wrapClass: 'pagination',
            activeClass: 'active',
            disabledClass: 'disabled',
            nextClass: 'next',
            prevClass: 'prev',
            lastClass: 'last',
            firstClass: 'first'
        }).on("page", function(event, num){
           $.ajax({
                 url:'notice?${_csrf.parameterName}=${_csrf.token}&page='+num,
                 method:'post',
                 data:num,
                 dataType:'json',
                 success:function(res){
                    $('#table').empty();
                    $('#table').append("<thead><tr><tr><th>글번호</th><th class='titleList'>제  목</th><th>작성자</th><th>작성날짜</th></tr></thead><tbody>");
                    for(var i=0;i<res.list.length;i++){
                       $('#table').append("<tr id='tr"+i+"'><td>"+res.list[i].anum+"</td><td class= 'td' id='td"+i+"'>"+
                             "<a href='nread?anum="+res.list[i].anum+"'>"+res.list[i].atitle+"</a>");
                       $('#tr'+i).append("</td><td>"+res.list[i].gm+"</td><td>"+res.list[i].adate+"</td></tr>");
                    }
                    $('#table').append("</tbody>");
                 },error:function(xhr,status,err){alert("에러");}
              });
        });
    });
    </script>
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
            <a class="nav-link" href=""  style="color:white;"><sec:authentication property="name"/>님</a>
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


<!-- 사이드바 시작 -->
<div class="container-fluid" id="main">
    <div class="row row-offcanvas row-offcanvas-left">
        <div class="col-md-3 col-lg-2 sidebar-offcanvas" id="sidebar" role="navigation">
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
 
               
            
           
            <br>
            <hr> 
<div class="conteiner">
<table id="table" class="table table-condensed">
<thead><tr><th>글번호</th><th class="titleList">제  목</th><th>작성자</th><th>작성날짜</th></tr></thead>
<tbody>
<c:forEach var="list" items="${list}">
   <tr>
   <td>${list.anum}</td>
   <td class="td">
   <a href="nread?anum=${list.anum}">${list.atitle}</a>
   </td>
   <td>${list.gm}</td>
   <td>${list.adate}</td>
   </tr>
</c:forEach>
</tbody>
</table>
</div>


<!-- 페이지네이션 -->
<p>
<div class="pagination"></div>
  <p>
   </div>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
</body>
</html>