<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Dodo 커뮤니티 사이트</title>
     <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/css/loginstyle.css" />
  <style type="text/css">
  td{line-height: 150%;
     padding-top:15px;
     padding-bottom: 15px;
   }
  </style>
  </head>
 <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
 <script type="text/javascript">
 
 jQuery(function($) { 
      var re_id = /^[a-z0-9]{6,13}$/; 
      var re_pw = /^[a-z0-9]{6,13}$/; 
      var re_email = /^([\w\.-]{4,15})@([a-z\d\.-]{4,8})\.([a-z\.]{2,6})$/; 
      var re_phone = /^[0-9]{9,11}$/; 
      var re_que = /^[a-d]$/;
      var re_ans = /^[가-힣a-zA-Z]{1,10}$/;
      
      var 
         form = $('#userjoin'), 
         uid = $('#id1'), 
         upw = $('#pwd1'), 
         uemail = $('#email1'),
         uque = $('#que1'),
         uans = $('#ans1'),
         uhobby = $('.hobby1'),
         uphone = $('#phone1');
      
      $('#id1, #pwd1').after('<strong></strong>');
      
      uid.keyup(function() {
         var s = $(this).next('strong'); 
         if (uid.val().length == 0) { 
            s.text('');
         } else if (uid.val().length < 6) { 
            s.text('짧아요.').css('color','red'); 
         } else if (uid.val().length > 13) { 
            s.text('길어요.').css('color','red');
         } else { 
            s.text('좋아요.').css('color','green'); 
         }
      });
      
      
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
      
      
      uphone.keydown(function() { 
         if(event.keyCode==109 || event.keyCode==189) {
            return false;
         }
      });
      
      
      form.submit(function(){
         if (re_id.test(uid.val()) != true) { // 아이디 검사
            alert('<ID 입력 오류> 유효한 ID를 입력해 주세요. 한글은 안되요!');
            uid.focus();
            return false;
         } else if(re_pw.test(upw.val()) != true) { // 비밀번호 검사
            alert('<PWD 입력 오류> 유효한 비밀번호를 입력해 주세요.');
            upw.focus();
            return false;
         } else if(re_que.test(uque.val()) != true) { // 질문 검사
            alert('<질문 입력 오류> 질문을 선택해 주세요.');
            uque.focus();
            return false;
         } else if(re_ans.test(uans.val()) != true) { // 답 검사
            alert('<답변 입력 오류> 유효한 질문을 입력해 주세요.');
            uans.focus();
            return false;
         } else if(re_email.test(uemail.val()) != true) { // 이메일 검사
            alert('<Email 입력 오류> 유효한 E-Mail 주소를 입력해 주세요.');
            uemail.focus();
            return false;
         } else if(re_phone.test(uphone.val()) != true) { // 전화번호 검사
            alert('<PhoneNumber 입력 오류> 유효한 번호를 입력해 주세요.');
            uphone.focus();
            return false;
         } else if($('.hobby1:checked').length <= 1){
        	 alert('<관심분야 입력 오류> 최소 2개를 체크해 주세요.');
        	 return false;
         }
         else{
            var param = $(form).serialize();
              $.ajax({
                 url :'usave',
                 method : 'post',
                 data : param,
                 dataType : 'json',
                 beforeSend : function(xhr)
                   {   
                         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                   },
                 success : function(e) {
                    if(e.save){
                       alert("회원가입을 축하드립니다.");
                       location.href="loginform";
                    }
                    else{
                        alert("다시 입력해 주세요");
                    }
                 },
                 error : function(xtr, status, err) {
                    alert("에러");
                 }
              });
         }
         return false; // 버튼에서도 submit 을 해주고 ajax에서도 해주기 때문에?
      }); // form.submit end
      
      
      
        $('#idbtn').click(function(){
        if($(uid).val() == ""){
        	alert("아이디를 입력해 주세요");
        	return false;
        }
             var param = {};
             param.id =  $(uid).val();
             $.ajax({
                url :'idcheck',
                method : 'post',
                data : param,
                dataType : 'json',
                beforeSend : function(xhr)
                  {   
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                  },
                success : function(e) {
                   if(e.idc != 'false') {
                      alert("사용 중인 ID 입니다!");
                   }
                   else{
                      alert("사용 가능한 ID 입니다.");
                   }
                },
                error : function(xtr, status, err) {
                   alert(err);
                }
             });
             return false;
          }); 
      
      
   }); //end
 
 
 </script>
  <body >
    <nav class="navbar navbar-fixed-top navbar-toggleable-sm navbar-inverse bg-primary mb-3">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#collapsingNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="flex-row d-flex">
        <a class="navbar-brand mb-1" href="#" style ="font-size:25px;" hidden=""><i class="fa fa-bars fa-2x" aria-hidden="true" onclick="showreple()"></i></a>
        <a class="navbar-brand mb-1" href="#" style ="font-size:40px;">Dodo</a>
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

<div class="container-fluid" id="main">
    <div class="row row-offcanvas row-offcanvas-left">

<i class="fa fa-user-circle-o" aria-hidden="true"></i>

<div style="margin: 0px auto;">

 <form id="userjoin" >

     <td colspan="2" align="left" valign="top" style="20px 0px 0px 0px;">
     <!---------------------내용시작------------------>
   <table width="780">
     <tr>
      <td>
 
         <!--테이블 시작 -->
         
         <table width="940" style="padding:5px 0 5px 0; ">
         
         <tr>
         <td style="font-weight: bold;">아이디</td>
         <td> <input type="text" id = "id1" name="id"/>&ensp;
         <button type="button" id="idbtn" class="btn btn-primary">중복체크</button>&ensp;<span style="color:red;">한글불가</span>,영문,숫자 포함된 6~13 문자</td>
         </tr>
 
         <tr>
         <td style="font-weight: bold;">비밀번호</td>
         <td><input type="password" id = "pwd1" name="pwd" value="jerwerqwe">&ensp;<span style="color:red;">한글불가</span>,영문,숫자 포함된 6~13 문자</td>
         </tr>
    
         <tr>
           <td style="font-weight: bold;">이름</td>
          <td><input type="text" name="name" value="q"></td>
         </tr>
 
      <tr>
         <td style="font-weight: bold;">질문</td>
         <td><select name='que' size='1' id ="que1" class='select'>
         <option value=''>선택하세요 </option>
         <option value='a'>졸업한 초등학교 이름은?</option>
         <option value='b'>제일 친한 친구의 핸드폰 번호는? </option>
         <option value='c'>아버지 성함은?</option>
         <option value='d'>어머니 성함은?</option>
      </select>
      </tr>
 
      <tr>   
         <td style="font-weight: bold;">답변</td>
         <td><input type='text' id="ans1" name="ans" value ="asdfasdf"></td>
      </tr>
 
      <tr>
         <td style="font-weight: bold;">이메일</td>
         <td>
            <input type="text" name="email" id ="email1" value="siaer00@naver.com">
         </td>
      </tr>

       
      <tr>
         <td style="font-weight: bold;">핸드폰 번호</td>
         <td>
            <input type="text" name="phone" id="phone1" value = "12341234123">&ensp;'-' 입력 불가입니다.
         </td>
      </tr>
 
      <tr>
         <td style="font-weight: bold;">관심분야</td>
         <td>
            <input type="checkbox" name="hobby" class = "hobby1" value="Movie" checked>영화
             <input type="checkbox" name="hobby" class = "hobby1" value="Sports">스포츠
             <input type="checkbox" name="hobby" class = "hobby1" value="Music">음악
             <input type="checkbox" name="hobby" class = "hobby1" value="Fashion">패션
             <input type="checkbox" name="hobby" class = "hobby1" value="Travel">여행
             <input type="checkbox" name="hobby" class = "hobby1" value="IT">IT
             <input type="checkbox" name="hobby" class = "hobby1" value="Love">연애
              <input type="checkbox" name="hobby" class = "hobby1" value="Game">게임
         <span>&emsp;&emsp; ※ 선택한 관심분야의 게시판이 자동으로 추가됩니다.</span>
         </td>
         
      </tr>
      
      
   </table>
    
   <!--테이블 끝-->
   
 
   <tr width="100" height="2" bgcolor="#2980b9">
   <td></td>
   </tr>
 
   <tr>
      <td colspan="2" align="center">
         <div id="member_button" style="margin-top: 20px;">
         <input type="hidden" name="enabled" value = "1">
          <input type="hidden" name="authority" value = "USER">
<button type="submit" class="btn btn-primary" >가입</button>
<button type="button" class="btn btn-primary" onclick="location.href='loginform'">취소</button>
         </div>
      </td>
   </tr>
   </table>
 
</form>
<!-- </table>   -->
</div> 
            </div>
<footer class="container-fluid">
    <p class="text-right small">ⓒ2016-2017 Company</p>
</footer>
  
  
  </body>
</html>