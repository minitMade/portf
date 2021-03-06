<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
						
<body >
<script type="text/javascript">
	function postComment(){
		if(!frmCmt.content.value){
			document.getElementById('error').innerHTML="내용을 입력하십시오.";
			document.getElementById('error').style.color="#708090";
			frmCmt.content.focus();
			return false;
		}
		frmCmt.submit();
	}
	
	 function cmLikeBtn(cnt){
		 var c = cnt;
		 var f =document.getElementById("cmId"+c);
		 var g = 1; 
		 var h = +f.value + g;
		 f.value = h;
		 document.getElementById("cmId2"+c).innerHTML=h;
		 /* alert(c); */
		 
		 var topCmData = {
				 "commentNo": document.getElementById("topCmNo"+c).value,
				 "sortNo": document.getElementById("topCmSoNo"+c).value,
				 "commentUser":document.getElementById("topCmUsr"+c).value,
				 "ptNo": frmTopLike.ptNo.value,
				 "userid":frmTopLike.userid.value,
				 "sort":frmTopLike.sort.value,
		 };
		 
		 $.ajax({
			 url:"${pageContext.request.contextPath}/photo/comments/commentsLike.do",
			 type:'GET',
			 data:topCmData,
			 success:function(data){
				 /* alert("완료!"); */
				 window.opener.location.reload();
				 self.close();
			 },
			 error:function(jqXHR, textStatus, errorThrown){
				 alert("에러발생 \n" + textStatus+ " : " + errorThrown); 
				 self.close();
			 }
			 
		 });		
	  }  
</script>
<form name="frmTopLike" method="post">
	<input type="hidden" name="ptNo"  value="${ptNo}"/>
	<input type="hidden" name="userid"  value="${userid}"/>
	<input type="hidden" name="sort" value="${sort}"/>
</form> 

<form name="frmCmt" method="post">
<div style="background-color:#f5f5f5; min-height:75px; /* border:1px solid blue; */">
<div style="display:table; margin: 0 auto; min-width:1300px; ">
<div style="margin:10px 10px 10px 30px; color:#708090;/*  border:1px solid blue; */">
			
			<div style="">
				<h5 style="font-weight:bold;">Comments</h5>
			</div>
	
				<div style="float:left;">
					<img src="${pageContext.request.contextPath}/my_icon/${mvBean.myIcon}" style=" width:70px; height:70px;">
				</div>
				
				<div style="float:left; width:700px; margin-left:15px; " >
					<textarea class="form-control"  rows="3" name="content" placeholder="댓글 입력"></textarea>
					<div id="error" style="float:left;">
					</div>
					<div>
						<input type="button" class="btn btn-info btn-m" value="입력" id="insertCm"
							style="float:right; margin-top:10px; width:100px;" onclick="postComment()">
					</div>
				</div>
</div>
</div> 
</div>

<div style="display:table; margin: 0 auto; min-width:1300px; ">
<div style="margin:20px 10px 10px 30px; color:#708090;/*  border:1px solid blue; */">
<!-- hashMap -->
	<input type="text" name="userid2" id ="userid" value="${param.userid}"/>
	<input type="text" name="ptNo2" id ="ptNo" value="${param.ptNo}"/>
	
	<c:forEach var="clBean" items="${clikelist}">
		<input type="text" value="${clBean.userid}"/>
		<input type="text" value="${clBean.ptNo}"/>
		<input type="text" value="${clBean.commentNo}"/>
		<input type="text" value="${clBean.commentUser}"/>
		<input type="text" value="${clBean.sortNo}"/>
	</c:forEach>
		
	<c:if test="${tCmSize >=1 }">
		<div style="font-weight:bold; margin-bottom:-30px;">
			TOP Comments
		</div>
			<c:set var="cnt" value="0"/>
			<c:forEach var="i" begin="0" end="${tCmSize-1}">
				<c:set var="cnt" value="${cnt+1 }" />
				<c:set var="mcvBean" value="${tAlist[i]}"  />	
									
					<div style="margin-top:50px; width:750px; /* border:1px solid gray; */">
						<div style="float:left; ">
								<img src="${pageContext.request.contextPath }/my_icon/${mcvBean.myIcon}" style=" width:70px; height:70px;">	
						</div>
						<div style="float:left; margin-left:20px; width:100px; color:#4682b4; font-weight:bold;" >
							${mcvBean.userid }
						</div>
<!-- 탑 추천 -->						
						<c:if test="${mcvBean.commentLike >= 1 }">  
								
						<div style="float:right;" >	
							<c:if test="${mcvBean.userid == userid }">
								<button type="button" class="btn btn-cmBtn btn-xs disabled" id ="cmId${cnt}" onclick="cmLikeBtn(${cnt})"
								value="${mcvBean.commentLike}" style="float:right; color:#708090;"><i class="fa fa-thumbs-o-up fa-lg" style="" >
								</i> 좋아요</button>
							</c:if>
							
							<c:if test="${mcvBean.userid != userid}">
								<button type="button" class="btn btn-cmBtn btn-xs" id ="cmId${cnt}" onclick="cmLikeBtn(${cnt})"
								value="${mcvBean.commentLike}" style="float:right; color:#708090;"><i class="fa fa-thumbs-o-up fa-lg" style="" >
								</i> ${userid }좋아요</button>
							</c:if>																										
							
							<input type="hidden" name="commentNo" id ="topCmNo${cnt}" value="${mcvBean.commentNo}"/>
							<input type="hidden" name="sortNo" id ="topCmSoNo${cnt}" value="${mcvBean.sortNo }">
							<input type="hidden" name="commentUser" id ="topCmUsr${cnt}" value="${mcvBean.commentUser }">
							<input type="hidden" name="userid" id ="topUsrid${cnt}" value="${mcvBean.userid}">					
							
						<div id="cmId2${cnt}" style="float:right; margin-top:3px; margin-right:5px; font-size:10pt;">
								${mcvBean.commentLike}
						</div>
														
						</div>
						</c:if> 
<!-- 탑 추천 끝-->						
						<c:if test="${mcvBean.commentLike <= 0 }">
						<div style="float:right;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-thumbs-o-up fa-lg"></i> 좋아요</a>
						</div>
						</c:if>
						
						<div style="float:right; margin-right:10px;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-reply fa-lg"></i> 리플</a>
						</div>
						
						<c:if test="${mcvBean.userid==userid }">
						<div style="float:right;  margin-right:10px;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-trash-o fa-lg"></i> 삭제</a>
						</div>
						</c:if>
						
						<div style="margin-left:90px; padding-top:30px; min-height:60px; /* border:1px solid blue; */">	
							${mcvBean.content}
						</div>
					</div>
					</c:forEach>
<!-- log -->		</c:if> 
</div>
</div> 

<div style="display:table; margin: 0 auto; min-width:1300px; ">
<div style="margin:10px 10px 10px 30px; color:#708090;/*  border:1px solid blue; */">

	<c:if test="${cmSize >=1 && tCmSize >= 1}">
	<div style="border-bottom:solid 1px #f5f5f5; height: 20px; width:800px;">
	</div>
	</c:if>
	
	<c:if test="${cmSize >=1}">
	<c:set var="count" value="0" />
	<c:forEach var="g" begin="0" end="${cmSize-1 }">
		<c:set var="count" value="${count+1 }" />
		<c:set var="mcvBean" value="${alist[g]}" />
	
						<div style="margin-top:30px; width:750px; /* border:1px solid gray; */">
						<div style="float:left; ">
								<img src="${pageContext.request.contextPath }/my_icon/${mcvBean.myIcon}" style=" width:70px; height:70px;">	
						</div>
						<div style="float:left; margin-left:20px; width:100px; color:#4682b4; font-weight:bold;" >
							${mcvBean.userid }
						</div>
						
						<c:if test="${mcvBean.commentLike >= 1 }">
						<div style="float:right;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-thumbs-o-up fa-lg"></i> ${mcvBean.commentLike} 좋아요</a>
						</div>
						</c:if>
						
						<c:if test="${mcvBean.commentLike <= 0 }">
						<div style="float:right;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-thumbs-o-up fa-lg"></i> 좋아요</a>
						</div>
						</c:if>
												
						<div style="float:right; margin-right:10px;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-reply fa-lg"></i> 리플</a>
						</div>
						
						<c:if test="${mcvBean.userid==userid }">
						<div style="float:right;  margin-right:10px;">
							<a href="#" type="button" class="btn btn-default btn-xs">
							<i class="fa fa-trash-o fa-lg"></i> 삭제</a>
						</div>
						</c:if>
						
						<div style="margin-left:90px; padding-top:30px; min-height:60px; /* border:1px solid blue; */ ">	
							${mcvBean.content}
						</div>
					</div>
	
	
	</c:forEach>
	</c:if>
	
</div>
</div>

</form>

</body>