<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title> 회원 정보 수정 페이지 </title>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/css/loginstyle.css" />
    <link rel="stylesheet" href="../../resources/css/main.css"/>
   <style type="text/css">
  td{line-height: 150%;
  	padding-top:15px;
  	padding-bottom: 15px;	}
  </style>
  
  
  
 <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>

function modf() {
      var param = $('#modform').serialize();
      $.ajax({
         url : "modf",
         method : "post",
         data : param,
         dataType : 'json',
         beforeSend : function(xhr)
           {   
                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
           },
         success : function(r){
          if(r.result == 1){
              alert("수정 완료 되었습니다.");
              location.href="setup";
          }
          else{
             alert("잘못 입력 하셨습니다.");
          }
         },
         error : function(x, s, e) {
            alert("빈칸을 채워 주세요!");
         }
      });
      return false;
   } 

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


<!-- <div class="container-fluid" id="main">
    <div class="row row-offcanvas row-offcanvas-left">
        <div class="col-md-3 col-lg-2 sidebar-offcanvas" id="sidebar" role="navigation">
            <ul class="nav flex-column pl-1">
                <li class="nav-item"><a class="nav-link" href="#">Overview</a></li>
               <li class="nav-item"><i class="fa fa-search fa-2x" style="color:#014c8c; margin-right:10px;" aria-hidden="true"></i><input type="search" id="search"></li>
                <li class="nav-item">
                    <a class="nav-link" href="#submenu1" data-toggle="collapse" data-target="#submenu1">Reports ?</a>
                    <ul class="list-unstyled flex-column pl-3 collapse" id="submenu1" aria-expanded="false">
                       <li class="nav-item"><a class="nav-link" href="">Sub item</a></li>
                       <li class="nav-item"><a class="nav-link" href="">Sub item</a></li>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="#">Analytics</a></li>
                <li class="nav-item"><a class="nav-link" href="">One more</a></li>
            </ul>
        </div>
     </div>
 </div>  
 -->
<div class="container-fluid" id="main">
    <div class="row row-offcanvas row-offcanvas-left">

<i class="fa fa-user-circle-o" aria-hidden="true"></i>

<div style="margin: 0px auto;">

 <form id="modform" onsubmit="return modf()">
     <td colspan="2" align="left" valign="top" style="20px 0px 0px 0px;">
    <!-- -------------------내용시작---------------- -->
   <table width="780">
     <tr>
      <td>

<div>

	<span style ="font-size:50px; color:red;">${USERID}</span> 회원님 의 개인정보입니다.
 </div>
	<table width="940" style="padding:5px 0 5px 0; ">
	
	<tr>
		<td id="div1" style="font-weight:bold;">이름</td>
		<td><input type ="text" id="span1" name = "name" value ="${uvo.name}"></td>
	</tr>
	
	<tr>
		<td id="div2" style="font-weight:bold;">E-mail</td>
		<td><input type ="text" id="span2" name ="email" value ="${uvo.email}"></td>
	</tr>
	
	<tr>
		<td id="div3" style="font-weight:bold;">핸드폰번호</td>
		<td><input type ="text"id="span3" name = "phone" value ="${uvo.phone}"></td>
	</tr>
	
	<tr>
		<td id="div4" style="font-weight:bold;">질문</td>
		<td><select name='que' size='1' id ="que1" class='select'>
         <option value='a'>졸업한 초등학교 이름은?</option>
         <option value='b'>제일 친한 친구의 핸드폰 번호는? </option>
         <option value='c'>아버지 성함은?</option>
         <option value='d'>어머니 성함은?</option>
      </select>
	</tr>
	
	<tr>
	<td id="div5" style="font-weight:bold;">답변</td>
	<td><input type ="text" name="ans" id="span5" value ="${uvo.ans}">&emsp;&emsp;</td>
	</tr>
	</table>
	
	<tr width="100" height="5px" bgcolor="#2980b9">
  		<td></td>
   	</tr> 
  
   <tr>
      <td colspan="2" align="center">
         <div id="member_button" style="margin-top: 20px;">
	<button class="btn" type ="submit">수정완료</button>
	<button class="btn" type ="reset">리셋</button>
	<button class="btn" type ="button" onclick= "location.href='setup'" >취소</button>
	
	  </div>
      </td>
   </tr>
   </table>
</form>
</div>
</div>
</div>
  <!--scripts loaded here-->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
  
</body>
</html>