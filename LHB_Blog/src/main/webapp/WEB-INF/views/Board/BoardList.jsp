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
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
<link rel="stylesheet" href="../../resources/css/styles.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="../../resources/css/main.css"/>
 <script type="text/javascript">
 
 function search()
   {
      var param= {};
      param.searchS = $("#searchS").val();
      param.searchI = $("#searchI").val();
       $.ajax({
            url:'search?${_csrf.parameterName}=${_csrf.token}&page=1',
            method:'post',
            data:param,
            dataType:'json',
            success:function(res){
               $('#table').empty();
             $('#table').append("<thead><tr><th>글번호</th><th>카테고리</th><th>작성자</th><th class='titleList'>글 제 목</th><th>추천</th><th>조회</th><th>첨부</th></tr></thead><tbody>");
             for(var i=0;i<res[0].list.length;i++){
                 $('#table').append("<tr id='tr"+i+"'><td>"+res[0].list[i].num+"</td><td>"+res[0].list[i].cat+"<td>"+res[0].list[i].author+"</td><td class= 'td' id='td"+i+"'>"+
                       "<a href='read?num="+res[0].list[i].num+"&readcnt="+res[0].list[i].readcnt+"'>"+res[0].list[i].title+"</a>");
                 
                 for(var j=0;j<res[1].commend.length;j++)
                    {
                       if(res[0].list[i].num == res[1].commend[j].ref)
                          {
                             $('#td'+i).append("<span class='badge'style='margin-left: 5px; background-color: gray;'>"+res[1].commend[j].cnt+"</span>");
                          }
                    }
                 $('#tr'+i).append("</td><td>"+res[0].list[i].goodcnt+"</td>");
                 $('#tr'+i).append("</td><td>"+res[0].list[i].readcnt+"</td><td id='tdi"+i+"'>");
                 if(res[0].list[i].fenabled == 1)
                    {
                       $('#tdi'+i).append("<i class='material-icons' style='font-size:15px;'>attachment</i>");
                    }
                 $('#tr'+i).append("</td></tr>");
             }
             $('#table').append("</tbody>");
             $('.pagination').empty();
             $('.pagination').off("page");
              	alert("토탈"+res[0].list[0].total+"/페이지"+res[0].list[0].page);
             $('.pagination').bootpag({
                  total: res[0].list[0].total,         /* <!-- total pages --> */
                  page: res[0].list[0].page,          /* <!-- current page --> */
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
                       url:'search?${_csrf.parameterName}=${_csrf.token}&page='+num,
                       method:'post',
                       data:param,
                       dataType:'json',
                       success:function(res){
                          $('#table').empty();
                          $('#table').append("<thead><tr><th>글번호</th><th>카테고리</th><th>작성자</th><th class='titleList'>글 제 목</th><th>추천</th><th>조회</th><th>첨부</th></tr></thead><tbody>");
                          for(var i=0;i<res[0].list.length;i++){
                             $('#table').append("<tr id='tr"+i+"'><td>"+res[0].list[i].num+"</td><td>"+res[0].list[i].cat+"<td>"+res[0].list[i].author+"</td><td class= 'td' id='td"+i+"'>"+
                                   "<a href='read?num="+res[0].list[i].num+"&readcnt="+res[0].list[i].readcnt+"'>"+res[0].list[i].title+"</a>");
                             
                             for(var j=0;j<res[1].commend.length;j++)
                                {
                                   if(res[0].list[i].num == res[1].commend[j].ref)
                                      {
                                         $('#td'+i).append("<span class='badge'style='margin-left: 5px;background-color: gray;'>"+res[1].commend[j].cnt+"</span>");
                                      }
                                }
                             $('#tr'+i).append("</td><td>"+res[0].list[i].goodcnt+"</td>");
                             $('#tr'+i).append("</td><td>"+res[0].list[i].readcnt+"</td><td id='tdi"+i+"'>");
                             if(res[0].list[i].fenabled == 1)
                                {
                                   $('#tdi'+i).append("<i class='material-icons' style='font-size:15px;'>attachment</i>");
                                }
                             $('#tr'+i).append("</td></tr>");
                          }
                          $('#table').append("</tbody>");
                       },error:function(xhr,status,err){alert("검색결과가 없습니다.");}
                    });
              });
             
            },error:function(xhr,status,err){alert("검색결과가 없습니다.");}
         });
   }
  
  
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
   var param={};
   param.cat="${list[0].cat}";
   param.page= num;
   $.ajax({
         url:'boardList?${_csrf.parameterName}=${_csrf.token}',
         method:'post',
         data:param,
         dataType:'json',
         success:function(res){
            $('#table').empty();
            $('#table').append("<thead><tr><th>글번호</th><th>카테고리</th><th>작성자</th><th class='titleList'>글 제 목</th><th>추천</th><th>조회</th><th>첨부</th></tr></thead><tbody>");
            for(var i=0;i<res[0].list.length;i++){
               $('#table').append("<tr id='tr"+i+"'><td>"+res[0].list[i].num+"</td><td>"+res[0].list[i].cat+"<td>"+res[0].list[i].author+"</td><td class= 'td' id='td"+i+"'>"+
                     "<a href='read?num="+res[0].list[i].num+"&readcnt="+res[0].list[i].readcnt+"'>"+res[0].list[i].title+"</a>");
               
               for(var j=0;j<res[1].commend.length;j++)
                  {
                     if(res[0].list[i].num == res[1].commend[j].ref)
                        {
                           $('#td'+i).append("<span class='badge'style='margin-left: 5px; background-color: gray;'>"+res[1].commend[j].cnt+"</span>");
                        }
                  }
               $('#tr'+i).append("</td><td>"+res[0].list[i].goodcnt+"</td>");
               $('#tr'+i).append("</td><td>"+res[0].list[i].readcnt+"</td><td id='tdi"+i+"'>");
               if(res[0].list[i].fenabled == 1)
                  {
                     $('#tdi'+i).append("<i class='material-icons' style='font-size:15px;'>attachment</i>");
                  }
               $('#tr'+i).append("</td></tr>");
            }
            $('#table').append("</tbody>");
         },error:function(xhr,status,err){alert("에러");}
      });
});
});
</script>
<style type="text/css">
.th1{
	width: 100px;
	padding-left:0.5px;
	padding-right:0.5px;
}

#contents{
	overflow: hidden;
	text-overflow:ellipsis;
	white-space: nowrap;
	width: 520px;
	height:17px; 
}
a{text-decoration: none;}
h4{text-align: center; margin-bottom: 5px;}
#search{margin-top: 10px;text-align: center;}
th{text-align: center;}
.td{text-align: center;}
.conteiner{width:1250px; margin: 0px auto; text-align: center;}
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
.titleList{width: 400px;  }

#addbtn{
  margin-bottom: 17px;
}
#delbtn{
  margin-bottom: 17px;
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
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Sports&page=1">스포츠</a></li>
                       <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Music&page=1">음악</a></li>
                        <li class="nav-item"><a class="nav-link" href="../../bc/main/boardList?cat=Game&page=1">게임</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        
        
 <div class="col-md-9 col-lg-10 main">
           <div class="card" style="margin-right: 1px; margin-left: 0px; height:200px;" >
             <div class="card-block">
               그림
             </div>
          </div>
           <hr>
          <div class="row mb-3">
                <div class="col-lg-6" style="padding-right:5px;">
                    <div class="card card-default card-block">
                        <ul id="tabsJustified" class="nav nav-tabs nav-justified">
                            <li class="nav-item">
                                <a class="nav-link active" href="" data-target="#tab1" data-toggle="tab">공지사항</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="" data-target="#tab2" data-toggle="tab">게시판소개</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="" data-target="#tab3" data-toggle="tab">추천 Best!</a>
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
                            
                            
                            <div class="tab-pane" id="tab2">
                                <div class="row">
                                    <div class="col-sm-7">
                                        <h4>Profile Section</h4>
                                        <p>Imagine creating this simple user profile inside a tab card.</p>
                                    </div>
                                    <div class="col-sm-5"><img src="//placehold.it/170" class="float-right img-responsive img-rounded"></div>
                                </div>
                                <hr>
                                <a href="javascript:;" class="btn btn-info btn-block">Read More Profiles</a>
                                <div class="spacer5"></div>
                            </div>
                            
                            
                            <div class="tab-pane" id="tab3">
                                <div class="list-group">
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">44</span> <code>.panel</code> is now <code>.card</code></a>
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">8</span> <code>.nav-justified</code> is deprecated</a>
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">23</span> <code>.badge</code> is now <code>.label-pill</code></a>
                                    <a href="" class="list-group-item text-muted">Message n..</a>
                                </div>
                            </div>
                              <div class="tab-pane" id="tab4">
                                <div class="list-group">
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">44</span> <code>.panel</code> is now <code>.card</code></a>
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">8</span> <code>.nav-justified</code> is deprecated</a>
                                    <a href="" class="list-group-item"><span class="float-right label label-info label-pill">23</span> <code>.badge</code> is now <code>.label-pill</code></a>
                                    <a href="" class="list-group-item text-muted">Message n..</a>
                                </div>
                            </div>
                        </div>
                        <!--/tabs content-->
                    </div><!--/card-->
                </div><!--/col-->
                
                      <div class="card" style="width:620px;">
                       <div class="card-block">
                            <h4 class="card-title">월간 최고 글!</h4>
							<blockquote class="blockquote-reverse" id="block">
								 <p>유럽 30일 여행기!! 저가 항공편을 이용하고 나도 가고 싶다고....</p>
 								  <br>
 								 <footer><strong>이호병&emsp;</strong><cite title="Source Title">걸리버 여행기</cite></footer>
							</blockquote>
						</div>
						  <div class="card" style="width:610px;">
                  		  <div class="card-block" >
                  		  	<sec:authorize access="hasAuthority('USER')">
                  			 <c:set var="boardc" scope="session" value="${list[0].cat}"/>
                  			  
                  			 <c:set var ="f" value="false" />
                  			 
                  			  <c:if test="${not f}">
                  			  <c:forEach var="userc" items="${cList}" varStatus="us"> <!-- 유저관심사 -->
                  			  		<c:if test="${userc.hobby eq boardc}">
                  			  			<c:set var ="f" value="true" />
              			  			</c:if>
                  			  </c:forEach>
                  			  </c:if>
                  			  
                  			  <c:if test="${f}">
                  			  			<button type="button" id="addbtn" onclick="location.href='delcat?cat=${boardc}'"class="btn btn-default active">구독중</button>
              			  	 </c:if>
                  			  
                  			  <c:if test="${not f}">
              			  			<button type="button" id="delbtn" onclick="location.href='addcat?cat=${boardc}'" class="btn btn-danger">구독하기</button>
                  			  </c:if>
                      		<!--   <input id="toggle1" type="checkbox" checked data-toggle="toggle" data-on="구독하기" data-off="구독 취소" data-onstyle="success" data-offstyle="danger"/>
                       		  <div id="toggle"></div> -->
                  			  </sec:authorize>
                       		  <p class="card-text" style="">구독은 게시판의 힘입니다. 구독 좀 눌러 주세요.</p>
                        	  <p class="card-text"><small class="text-muted">구독수 9,342</small></p>
                    	 </div>
                </div>
                  </div>
<div class="conteiner">
 <hr> 
<table id="table" class="table table-striped">
<thead><tr><th class="th1">글번호</th><th class="th1">카테고리</th><th class="th1">작성자</th><th class="titleList">글 제 목</th><th class="th1">추천</th><th class="th1">조회</th><th class="th1">첨부</th></tr></thead>
<tbody>
<c:forEach var="list" items="${list}">
   <tr>
   <td>${list.num}</td>
   <td>${list.cat}</td>
   
   <td>
            ${list.author}
   </td>
   
   <!-- 댓글 -->
   <td class="td">
   <a href="read?num=${list.num}&readcnt=${list.readcnt}">${list.title}</a>
   <c:forEach var="comment" items="${comment}">
   <c:if test="${comment.ref == list.num}">
      <span class="badge" style="margin-left: 5px; background-color: gray;">${comment.cnt}</span>
   </c:if>
   </c:forEach> 
   </td>
   
   <td>${list.goodcnt}</td>
   <td>${list.readcnt}</td>
   <td>
      <c:if test="${list.fenabled==1}">
         <i class="material-icons" style="font-size:15px;" >attachment</i>
      </c:if>
   </td>
   </tr>
</c:forEach>
</table>
</tbody>

<!-- 검색기능 -->
   <div id="search">
        <select id="searchS">
            <option id="author" value="Author">작성자</option>
            <option id="title" value="title">글제목</option>
        </select>
        <input type="text" id="searchI"/>
        <input type="button"  value="검색" onclick="search()"/>
    </div>
<!-- 페이지네이션 -->
<p>
<div class="pagination"></div>
  <p>
   </div>
   </div>
</div>
</div>
   
    <script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <script src="../../resources/js/scripts.js"></script>
</body>
</html>