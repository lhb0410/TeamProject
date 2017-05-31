<%@ page contentType="text/html; charset= UTF-8"
    pageEncoding= "UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 상세 페이지</title>
      <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="description" content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar 
    toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. 
    The top navbar is controlled by a separate hamburger toggle button." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/css/styles.css" />
    <link rel="stylesheet" href="../../resources/css/main.css"/>
<script src="<c:url value="/resources/jquery-3.1.1.min.js" />"></script>
<style type="text/css">
.notice {
   width:600px;
    padding: 20px;
    background-color: #fafafa;
    border-left: 6px solid #7f7f84;
    margin-bottom: 30px;
    -webkit-box-shadow: 0 5px 8px -6px rgba(0,0,0,.2);
       -moz-box-shadow: 0 5px 8px -6px rgba(0,0,0,.2);
            box-shadow: 0 5px 8px -6px rgba(0,0,0,.2);
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
#repple{
   
}
</style>
<script>
function retoggle(){
   $('#repple').toggle();
}

   function show()
   {
      $('#form').toggle();
   }
   function save(){
         if(confirm("저장 하시겠습니까??"))
         var param = $('#form').serialize();
         $.ajax({
            url:'comment?${_csrf.parameterName}=${_csrf.token}',
            method:'post',
            data:param,
            dataType:'text',
            success:function(res){
                  alert(res);
                  location.reload();
            },error:function(xhr,status,err){alert(err);}
         });
      return false;
      }
   
   function goodcnt(){
       $.ajax({
          url:'goodcnt?goodcnt=${read.goodcnt}&num=${read.num}&${_csrf.parameterName}=${_csrf.token}',
          method:'post',
          dataType:'text',
          success:function(res){
             alert(res);
             if(res == "true"){alert("추천완료");}
             else{alert("한번만 추천가능 합니다.");}
          },error:function(xhr,status,err){alert(err);}
       });
    }
   
    function boardedit()
   {
      var author = "${read.author}";
      var curruser="${USERID}";
      if(curruser !=author)
         {
            alert("글 작성자만 글을 수정/삭제할 수 있습니다.");
            return;
         }
      location.href='edit?num=${read.num}&${_csrf.parameterName}=${_csrf.token}';
   }
   
function boarddel()
   {
      var author = "${read.author}";
      var curruser= "${USERID}";
      alert(author);
      alert(curruser);
      if(curruser !=author)
         {
            alert("글 작성자만 글을 수정/삭제할 수 있습니다.");
            return;
         }
         if(confirm("삭제 할래?"))
            $.ajax({
               url:'del?num=${read.num}&${_csrf.parameterName}=${_csrf.token}',
               method:'post',
               dataType:'text',
               success:function(res){
                     alert(res);
                     location.href = "boardList?page=1&cat=${boardc}&${_csrf.parameterName}=${_csrf.token}";
               },error:function(xhr,status,err){alert(err);}
            });
      }
</script>
<style>
#t{
width: 600px;
margin: 0px auto;
}
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
 
        <!--<h1 class="display-2 hidden-xs-down">메인 게시판 내용</h1>
            <p class="lead hidden-xs-down">메인 게시판 수정중</p>
             -->
            <!-- 상단 wow 버튼 누르면 반응함 -->
            <div class="alert alert-warning fade collapse" role="alert" id="myAlert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">×</span>
                    <span class="sr-only">Close</span>
                </button>
                <strong>Holy guacamole!</strong> It's free.. this is an example theme.
            </div>
         <!-- 상담 wow 끝 -->
         
            <div class="row mb-3">
                <div class="col-lg-6" style="padding-right:5px;">
                    <div class="card card-default card-block">
                        <ul id="tabsJustified" class="nav nav-tabs nav-justified">
                            <li class="nav-item">
                                <a class="nav-link active" href="" data-target="#tab1" data-toggle="tab">공지사항</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link " href="" data-target="#tab2" data-toggle="tab">영화소개</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="" data-target="#tab3" data-toggle="tab">Weekly Best!</a>
                            </li>
                        </ul>
                        <!--/tabs-->
                        <br>
                        <div id="tabsJustifiedContent" class="tab-content">
                            <div class="tab-pane active" id="tab1">
                                  <div class="list-group">
                                <c:forEach var="nList" items="${nList}" end="3">
                                    <a href="" class="list-group-item">
                                	<table id="tabl1">
                                    	<tr>
                                    		<td class = "td1" style="width:500px; text-align: left; color:black;"><a class="a1" href="../../bc/main/nread?anum=${nList.anum}">＊${nList.atitle}</a></td>
                                    		<td style="width:100px; text-align:right; color:black;">★${nList.gm}</td>
                                    	</tr>
                                    </table>
                                    </a>
                                </c:forEach>
                               <a href="../../bc/main/notice?page=1" class="btn btn-info btn-block">Read More</a>
                                </div>
                           </div>
                            
                            
                            <div class="tab-pane " id="tab2">
                                <div class="row">
                                    <div class="col-sm-7">
                                        <h4>Profile Section</h4>
                                        <p>Imagine creating this simple user profile inside a tab card.</p>
                                    </div>
                                    <div class="col-sm-5"><img src="//placehold.it/170" class="float-right img-responsive img-rounded"></div>
                                </div>
                                <hr>
                                <a href="../../bc/main/notice?page=1" class="btn btn-info btn-block">Read More Profiles</a>
                                <div class="spacer5"></div>
                            </div>
                            
                            
                            <div class="tab-pane" id="tab3">
                                <div class="list-group">
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">44</span> <code>.panel</code> is now <code>.card</code></a>
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">8</span> <code>.nav-justified</code> is deprecated</a>
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">23</span> <code>.badge</code> is now <code>.label-pill</code></a>
                                    <a href="" class="list-group-item text-muted">Message n..</a>
                                     <a href="" class="list-group-item text-muted">Message n..</a>
                                </div>
                            </div>
                        </div>
                        <!--/tabs content-->
                    </div><!--/card-->
                </div><!--/col-->
                
                 <div class="card" style="margin-right: 5px; margin-left: 0px;">
                    <div class="card-block">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
                        <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                    </div>
                </div>
                </div>
            <hr>
         
<div id="t">
<div class="well">
<div class="container">
  <div class="notice notice-success">
   <strong>제목</strong> ${read.title}
    </div>
    <div class="notice notice-danger">
        <strong>작성자</strong>${read.author}
    </div>
    <div class="notice notice-info">
        <strong>작성일</strong> ${read.bdate}
    </div>
    <div class="notice notice-file">
        <strong>첨부파일</strong><c:forEach var="fname" items="${fname.getBflist()}">
File : ${fname.fname1}&nbsp;&nbsp; Filesize  : ${fname.fsize} kb&nbsp;&nbsp;
<button onclick="location.href='download?filename=${fname.fname2}'">Download</button>
</c:forEach>
    </div>
    <div class="notice notice-warning">
        <strong>조회수</strong> ${read.readcnt}
    </div>
    <div class="notice notice-lg">
        <strong>내용</strong> ${read.getContents()}
    </div>
    <div class="notice notice-sm" style="text-align: center;">
        <strong><button class="btn btn-default" onclick="location.href='boardList?page=1&cat=${boardc}'">목록</button>&emsp;&emsp;
        <sec:authorize access="hasAuthority('USER')">
<button class="btn btn-default " type="button" id="btn" onclick="show()">댓글<%-- <span style="color:red;">(${comment.cnt})</span> --%></button>&emsp;&emsp;
<button class="btn btn-default " type="button"  id="btn" onclick="boardedit()">수정</button>&emsp;&emsp;
<button class="btn btn-default " type="button" id="btn" onclick="boarddel()">삭제</button>&emsp;&emsp;
<button class="btn btn-default" type="button" id="btn" onclick="goodcnt()">추 천</button></strong>
 </sec:authorize>
    </div>
</div>

<table>
<div class="container">
<div class="row" id="repple">
<div class="col-md-8">
                  <div class="page-header">
                    <h1>Comments </h1>
                    <hr>
                  </div> 
<c:forEach var="ripple" items="${ripple.getBlist()}">
 <div class="comments-list">
 <h4 class="media-heading user_name">${ripple.author}</h4>
 ${ripple.contents}
 <p><small style="color:blue;"> ${ripple.bdate} <a href=""></a></small></p>
 </div>
 <p>
 <hr>   
</c:forEach> 
</div>
</div>
</div>
</table>



<div id="t">
<form id="form" style="display: none" onsubmit="return save()">
<br>
   <input id="msg" type="hidden" class="form-control" name="title" value="댓글">
   <div class="input-group">
   <span class="input-group-addon">Contents</span>
   <hr>
   <textarea  placeholder="내용을 적어주세요." id="contents" class="form-control" name ="contents" rows="10" cols="29"></textarea>
   <button class="btn btn-default" type="submit">전송</button></div>
   <input type="hidden" name="ref" value="${read.num}"></input>
   <input type="hidden" name="cat" value="${read.cat}"></input>
</form>
</div><!--/row-->
        
                
      </div>
        </div>
        </div>
</div>
</div>
        <!--/main col-->
        
        
        
        
        
        
        
        
        
<!-- Modal -->
  <div  class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <div style="text-align: center; width:400px;" class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>This is a small modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <br>
  <br>
 <hr>
<footer class="container-fluid">
    <p class="text-right small">ⓒ2016-2017 Company</p>
</footer>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
</body>
</html>