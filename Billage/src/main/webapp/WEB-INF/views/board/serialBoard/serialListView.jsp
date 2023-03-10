<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    #boardList {text-align:center;}
    #boardList>tbody>tr:hover {cursor:pointer;}
    /*----------------------------------------*/
		#modal-donate-area{
			position: fixed;
	        width: 300px;
	        height:300px;
	        background-color: hotpink;
	        border-radius: 50px;
	        transform: translate(-50%, -50%);
	        left: 50%;
	        top: 50%;
	        z-index: 1005;
	        text-align: center;
	        display: none;
		}
		
		#modal-donate-area .close{
			font-size: 30px;
	        background-color:rgba(95, 152, 124, 0);
	        border: 1px solid rgba(245, 245, 220, 0);
	        cursor: pointer;
	        color:rgb(0, 0, 0);
		}
</style>
</head>
<body>
	<jsp:include page="../../common/header.jsp"/>
	
	   <div class="content">
        <div class="innerOuter" style="padding:5% 10%;">
        <div class="novelInfo" align="left">
        	<img src="${novel.changeName}" style="float:left;" width="150" height="200">
            <h2>제목 : ${novel.novelTitle}</h2>
            <h4>작가명 : ${novel.nickName}</h4>
            <h6>설명 : ${novel.novelDisplay }</h6>
            <p><b id="like-count">${ novel.likeUser }</b>명이 추천합니다!</p>
        </div>
            <br>
            <!-- 로그인 후 작가본인일 경우만 보여지는 글쓰기 버튼 -->
            <c:if test="${ loginUser.userNo eq novel.userNo }">
            <form action="enrollForm.se" method="post">
            <input type="hidden" class="nno" name="novelNo" value="${ novel.novelNo }">
            <input type="submit" class="btn btn-secondary" style="float:right;" value="연재하기">
            </form>
            </c:if>
            
            <!-- 로그인 후 작가본인이 아닐 경우만 보여지는 버튼 -->
            <c:if test="${ loginUser.userNo ne novel.userNo and loginUser.userNo ne null }">
            <button id="donate-novel" style="float:left;">작품후원</button>
            <!-- <button id="${ novel.likeUser }" class="like-novel" style="float:left;"></button> -->
            <div id="likeBtnArea">	
            </div>
            </c:if><br><br>
            
            <script>
            	$(function(){
            		btnchange();
            	})
            	
            	function btnchange(){
            		$.ajax({
						url : 'changeBtn.nv',
						data : {
							novelNo : '${ novel.novelNo }'
						},
						success : function(result){
							if(result > 0){
								$('#likeBtnArea').html('<button class="like-novel" style="float:left;" onclick="novelCancel();">취소</button>');
							}else{
								$('#likeBtnArea').html('<button class="like-novel" style="float:left;" onclick="novelLike();">추천</button>');
							}
						}
						
            		})
            	}
            	
            	function novelCancel(){
            		$.ajax({
						url : 'novelCancel.nv',
						data : {
							novelNo : '${ novel.novelNo }'
						},
						success :function(result){
							console.log(result)
							if(result[0] > 0){
								$('#likeBtnArea').html('<button class="like-novel" style="float:left;" onclick="novelLike();">추천</button>');
								$('#like-count').text(result[1]);
							}else{
								$('#likeBtnArea').html('<button class="like-novel" style="float:left;" onclick="novelCancel();">취소</button>');
								$('#like-count').text(result[1]);
							}
						}
            		})
            	}
            	function novelLike(){
            		$.ajax({
						url : 'novelLike.nv',
						data : {
							novelNo : '${ novel.novelNo }'
						},success : function(result){
								console.log(result);
							if(result[0] > 0){
								$('#likeBtnArea').html('<button class="like-novel" style="float:left;" onclick="novelCancel();">취소</button>');
								$('#like-count').text(result[1]);
							}else{
								$('#likeBtnArea').html('<button class="like-novel" style="float:left;" onclick="novelLike();">추천</button>');
								$('#like-count').text(result[1]);
							}
						}
            		});
            	}
            </script>
        <!--     
	    <c:if test="${ loginUser.userNo ne novel.userNo and loginUser.userNo ne null }">
	    
	    	<script>
				//추천하기 / 추천취소 
				const userNo  = ${ loginUser.userNo };  
				const novelNo = ${ novel.novelNo };
				
				//------------
				$('.like-novel').click(function(){
					
					var $likeStatus = $(this).attr('id');

					$.ajax({
						url : 'novelLike.nv',
						data : {
							likeStatus : $likeStatus,
							userNo : userNo,
							novelNo : novelNo
						},
						success : function( result ){
							console.log(result[0]);
							if(result[0] > 0){
								$('.like-novel').empty();
								$('#like-count').empty();
								$('#like-count').text(result[1]);
								$('.like-novel').attr('id', userNo);
					    		$($('.like-novel').text('추천취소'));
					    	} else if (result[0] == 0) {
					    		$('.like-novel').empty();
					    		$('#like-count').empty();
								$('#like-count').text(result[1]);
					    		$('.like-novel').attr('id', 0);
					    		$($('.like-novel').text('추천하기'));
					    	} else{
					    		alert('오류 발생');
					    	}
						},
						error : function(){
							console.log('추천 비동기 실패');
						}
						
					})
				});
				
				
		    	$(function(){
				
			    	if($('.like-novel').attr('id') > 0){
			    		$('.like-novel').text('추천취소');
			    	} else {
			    		$('.like-novel').text('추천하기');
			    	}
		    	});
	    	</script>
	    </c:if>
         -->    
            <br><br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <c:forEach items="${ list }" var="s">
                <tbody>
                		<tr>
                			<input type="hidden" class="nno" value="${ s.novelNo }">
                			<input type="hidden" class="sno" value="${ s.serialNo }">
                			<td>${ s.rownum }</td>
                			<td>${ s.serialTitle }</td>
                			<td>${ s.count }</td>
                			<td>${ s.uploadDate }</td>
                		</tr>
                </tbody>
                </c:forEach>
            </table>
            <br>
            
              <div id="pagingArea" style="display:inline-block; align:center;">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    	</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="detail.se?cpage=${ pi.currentPage - 1 }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    <li class="page-item"><a class="page-link" href="detail.se?cpage=${p}">${ p }</a></li>
                </c:forEach>
                <c:choose>
                	<c:when test="${ pi.currentPage eq pi.maxPage }">
	                    <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                	</c:when>
                	<c:otherwise>
	                    <li class="page-item"><a class="page-link" href="detail.se?cpage=${ pi.currentPage + 1 }">Next</a></li>
	                </c:otherwise>
	            </c:choose>
                </ul>
              </div>
    	</div>
    </div>
    
    <!-- --------------------------------------- -->
    
	<div id="modal-donate-area">
		<div id="donate-screen">
		 <button type="button" class="close">&times;</button>
		 <br><br>
			<h1>후원창</h1><br>
			<form action="donate.nv" method="post">
				<div class="control-group">
					<input type="text" class="donate-field" placeholder="후원 포인트를 입력하세요" id="donate-value" name="point">
					<input type="hidden" class="userPoint" id="userPoint" name="userPoint" value="${ loginUser.point }">
					<input type="hidden" class="userNo" id="userNo" name="userNo1" value="${ loginUser.userNo }">
					<input type="hidden" class="userNo" id="userNo" name="userNo2" value="${ novel.userNo }">
				</div>
				<div class="control-group">
					<button type="submit" class="">후원하기</button><br>
					<h2>보유 포인트 : ${ loginUser.point }</h2>
				</div>
			</form>
		</div>
	
</div> <!-- all-header끝 -->
            
   <script>
   // 연재 게시물 상세보기
   	$(function(){
   		$('#boardList>tbody>tr').click(function(){
   			/* location.href = 'detail.bo?bno=' + $(this).children('.bno').text(); */
   			location.href = 'detail.se?nno='
   							+ $(this).children('.nno').val()
   							+ '&sno='
   							+ $(this).children('.sno').val();
   		})
   	})
   
   // 작품 후원 모달창
 	$(function(){
    	$('#donate-novel').click(function(){
       	$('#modal-donate-area').fadeIn();
       });
       
	$('.close').click(function(){
		$('#modal-donate-area').fadeOut();
	});
	
});
   	
   </script>
	<jsp:include page="../../common/footer.jsp"/>

</body>
</html>