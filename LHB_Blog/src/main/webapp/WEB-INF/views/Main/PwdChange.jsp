<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 변경 페이지</title>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
<link rel="stylesheet" href="../../resources/css/main.css"/>
<style type="text/css">
body {
	font-family: 'Open Sans', sans-serif;
	margin: 0 auto 0 auto;
	width: 100%;
	text-align: center;
}

.td {
	height: 40px;
	font-family: 'Open Sans', sans-serif;
	font-weight: bold;
	font-size: x-large;
	letter-spacing: 10px;
}

#changeform {
	height: 100%;
	margin: 0px auto;
	text-align: center;
	width: 300px;
	margin-bottom: 30px;
}

th, td {
	padding: 8px;
	
}

.box {
	background: white;
	width: 300px;
	border-radius: 6px;
	margin: 20 auto;
	padding: 0px 0px 70px 0px;
	border: #2980b9 4px solid;
}

.btn {
	background: #2ecc71;
	width: 125px;
	padding-top: 5px;
	padding-bottom: 5px;
	color: white;
	border-radius: 4px;
	border: #27ae60 1px solid;
	margin-top: 20px;
	margin-bottom: 20px;
	float: left;
	margin-left: 16px;
	font-weight: 800;
	font-size: 0.8em;
}
.btn:hover{
	background: #4594d2;
}
</style>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
jQuery(function($) { // HTML 문서를 모두 읽으면 포함한 코드를 실행
     var re_pw = /^[a-z0-9A-Z]{6,13}$/; 
    
     var form = $('#changeform'),upw = $('.pwd');
       
     
     $('.pwd').after('<strong></strong>');
     
     
     upw.keyup(function() {
        var s = $(this).next('strong'); 
        if (upw.val().length == 0) { 
           s.text(''); 
        } else if (upw.val().length < 6) { 
           s.text('짧아요.').css('color','red'); 
        } else if (upw.val().length > 13) { 
           s.text('길어요.').css('color','red'); 
        } else { 
           s.text('좋아요.').css('color','green'); 
        }
     });
     
     
     form.submit(function(){
        if(re_pw.test(upw.val()) != true) { // 비밀번호 검사
           alert('<PWD 입력 오류> 유효한 비밀번호를 입력해 주세요.');
           upw.focus();
           return false;
        }else if(($('[name=npwd]').val() != $('[name=npwd1]').val())){
        	alert('<PWD 입력 오류> 새로운 비밀번호가 일치하지 않습니다.');
            upw.focus();
            return false;
        }
        else{
           var param = {};
           param.id = $('[name = id]').val();
           param.npwd1 = $('[name=npwd1]').val();
             $.ajax({
                url :'pwdchange',
                method : 'post',
                data : param,
                dataType : 'json',
                beforeSend : function(xhr)
                  {   
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                  },
                success : function(e) {
                   if(e.result == 1){
                      alert("비밀번호가 변경되었습니다.");
                      location.href="../../uc/User/loginform";
                   }
                   else{
                       alert("다시 입력해 주세요");
                   }
                },
                error : function(xtr, status, err) {
                   alert("잘못 입력되었습니다. 다시 입력해 주세요.");
                }
             });
        }
        return false;
     });
})
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
	<br>
	<br>
	<br>
	

		<form id="changeform">
			<table class="box">
				<tr>
					<td colspan="2" class="td">비밀번호 변경</td>
				</tr>

				<tr>
					<td></td>
					<td></td>
				</tr>

				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd" maxlength="50"></td>
				</tr>


				<tr>
					<td>새 비밀번호</td>
					<td><input type="password" class="pwd" name="npwd" maxlength="50"></td>
				</tr>

				<tr>
					<td>새 비밀번호 확인</td>
					<td><input type="password" class="pwd" name="npwd1" maxlength="50"></td>
				</tr>
			</table>
				<input type ="hidden" name = id value = "${USERID}" />
				<button type="button" class="btn" value="취소" onclick="location.href='setup'">취소</button>
				<button type="submit" class="btn" value="탈퇴">변경</button>
			</form>


<!-- <footer class="container-fluid">
    <p class="text-right small">ⓒ2016-2017 Company</p>
</footer> -->
  <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
</body>
</html>