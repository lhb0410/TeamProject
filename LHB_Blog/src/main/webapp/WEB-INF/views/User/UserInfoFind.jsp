<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<title> ID/PWD 찾기 </title>
     <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/css/loginstyle.css" />
    <style type="text/css">
   .findForm{height: 100%; margin: 0px auto; text-align: center; width: 300px; margin-bottom: 30px;}
   .tab{border: #2980b9 4px solid; border-radius:6px; white-space:nowrap; padding:0px 0px 70px 0px; }
    label{margin: 10px 20px 10px 40px;}
    td{margin-top: 30px;}
    input{margin-right: 30px; width: 200px;} 
    input,select{width: 200px;}
    select{margin-left: 0px;}
   .aaa{ color: white; padding: 0px; background-color: gray; caption-side: top; text-align: center; height: 30px;}
   .td{height: 40px; font-family: 'Open Sans', sans-serif; font-weight:bold; font-size:x-large; letter-spacing:10px;}
    
    
    </style>

<script src="<c:url value="/resources/jquery-3.1.1.min.js"/>"></script>
<script type="text/javascript">
function find() {
   var param = $('#idfind').serialize();
   $.ajax({
      url : "idfind",
      method : "post",
      data : param,
      dataType : 'json',
      beforeSend : function(xhr)
        {   
              xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
      success : function(result){
         if(result.get == "null"){
            alert("찾으시는 아이디가 존재하지 않습니다.");
         }
         else{
            alert("찾으시는 아이디는"+"\" "+result.get+" \""+"입니다");
         }
      },
      error : function(x, s, e) {
         alert("error");
      }
   });
   return false;
} 
function pwdfind() {
   var param = $('#pwdfind').serialize();
   $.ajax({
      url : "pwdfind",
      method : "post",
      data : param,
      dataType : 'json',
      beforeSend : function(xhr)
        {   
              xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
      success : function(result){
         if(result.pwd == 1){
            alert("가입 하신 email로 임시 비밀번호를 보내드렸습니다.")
         }
         else{
            alert("잘 못 입력되었습니다. 다시 입력해 주세요!")
         }      
      },
      error : function(x, s, e) {
         alert("error");
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
        <a class="navbar-brand mb-1" href="#" style ="font-size:25px;" hidden=""><i class="fa fa-bars fa-2x" aria-hidden="true" onclick="showreple()"></i></a>
        <a class="navbar-brand mb-1" href="loginform" style ="font-size:40px;">Dodo</a>
        <button type="button" class="hidden-md-up navbar-toggler" data-toggle="offcanvas" title="Toggle responsive left sidebar">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
    <div class="navbar-collapse collapse" id="collapsingNavbar">
        <ul class="navbar-nav">
            <li class="nav-item active">
                 <a class="nav-link" href="#"><span class="sr-only">Home</span></a>
            </li> 
        </ul>
    </div>
</nav>
<!-- <div class="container-fluid" id="main"> -->
<!--     <div class="row row-offcanvas row-offcanvas-left"> -->
<br>
<br>
<br>
<i class="fa fa-user-circle-o" aria-hidden="true"></i>
<!-- ID 찾기 -->
<div align="center" >
<div style="float: left; width:50%">
<form id="idfind" onsubmit="return find();" class="findForm" >
<table class="tab">
<tr><td colspan="2" class="td">아이디 찾기</td></tr>
<tr><td><label>이 름 </label></td><td><input type="text" name="name" value="j"></td></tr>
<tr><td><label>E-Mail</label></td><td><input type="text" name ="email" value="ee"></td></tr>
<tr><td colspan="2"><button type="submit" class="btn" style="margin-bottom: 15px;">찾기</button></td></tr>
</table>
</form>
</div>

<div style="float:left; width:50%;">
<form id="pwdfind" onsubmit="return pwdfind();" class="findForm">
<table class="tab">
<tr><td colspan="2" class="td">비밀번호 찾기<br></td></tr>
<tr><td><label>I D </label></td><td><input type="text" name="id" value="j"></td></tr>
<tr><td><label>E-Mail</label></td><td><input type="text" name ="email" value="ee"></td></tr>
<tr><td><label>질 문 </label></td><td><select name='que' size='1' class='select' style="margin-left: -30px;">
         <option value=''>선택하세요 </option>
         <option value='a'>졸업한 초등학교 이름은?</option>
         <option value='b'>제일 친한 친구의 핸드폰 번호는? </option>
         <option value='c'>아버지 성함은?</option>
         <option value='d'>어머니 성함은?</option>
      </select></td></tr>
      
<tr><td><label>질문답 </label></td><td><input type='text' name="ans" value ="ansans"></td></tr>
<tr><td colspan="2"><button type="submit" class="btn" style="margin-bottom: 15px;">찾기</button></td></tr>
</table>
</form>
</div>
</div>

<!-- <footer class="container-fluid">
    <p class="text-right small">ⓒ2016-2017 Company</p>
</footer> -->
   
  </body>
</html>