<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글보기</title>
    <link rel="stylesheet" href="/jboard/css/style.css">    
    <script>
    	window.onload = function() {
    		
	    	const commentForm = document.commentForm;
	    	const commentList = document.getElementsByClassName('commentList')[0];
	    	
	    	let originalText = '';
	    	
	    	// 동적 이벤트 처리
	    	document.addEventListener('click', function(e){
	    		
	    		// 수정 완료
	    		if(e.target.classList == 'commentUpdate') {
	    			e.preventDefault();	 // a 태그의 이벤트 속성 해제 하려고 하는거임
	    			
	    			const article = e.target.closest('article');
	    			const textarea = article.querySelector('textarea');		
	    			
	    			const no = e.target.dataset.no;
	    			const comment = textarea.value;
	    			
	    			const formData = new FormData();
	    			formData.append("no", no);
	    			formData.append("comment", comment);
	    			
	    			
	    			fetch('/jboard/comment/modify.do', {
	    				method: 'POST',
	    				body: formData
	    			})
	    				.then(resp => resp.json())
	    				.then(data => {
	    					console.log(data);
	    					
	    					if(data.result > 0) {
	    						alert('댓글이 수정되었습니다.');
	    					
	    						textarea.readOnly = true;
	    		    			textarea.style.background = 'transparent';
	    		    			textarea.style.border = 'none';
	    		    			e.target.innerText = '수정';
	    					
	    					}
	    					
	    				})
	    				.catch(err => {
	    					console.log(err);
	    				});
	    				
	    			
	    		}
	    		
	    		// 수정 & 취소
	    		if(e.target.classList == 'commentModify') {
	    			e.preventDefault();
	    			
	    			const article = e.target.closest('article');
	    			const textarea = article.querySelector('textarea');
	    			
	    			const mode = e.target.innerText;
	    			
	    			if(mode == '수정'){
	    				originalText = textarea.value;
	    				
	    				textarea.readOnly = false;
		    			textarea.style.background = 'white';
		    			textarea.style.border = '1px solid #555';
		    			textarea.focus();
		    			e.target.innerText = '취소';
	    			}else{
	    				originalText = textarea.value;
	    				
	    				textarea.readOnly = true;
		    			textarea.style.background = 'transparent';
		    			textarea.style.border = 'none';
		    			e.target.innerText = '수정';
	    			}
	    		}
	    		
	    		// 삭제
	    		if(e.target.classList == 'commentRemove') {
	    			e.preventDefault();
	    			
	    				
    				if(!confirm('정말 삭제하시겠습니까?')){
	    				return;
	    			}
	    			
					const article = e.target.closest('article');	    			
	    			const no = e.target.dataset.no; // a태그 data-no 속성값 가져오기
	    			
	    			fetch('/jboard/comment/delete.do?no='+no)
	    				.then(resp => resp.json())
	    				.then(data => {
	    					console.log(data);
	    					
	    					if(data.result > 0){
	    						alert('댓글이 삭제되었습니다.');
	    						
	    						// 동적 삭제 처리
	    						article.remove();
	    						
	    					}else{
	    						alert('댓글이 삭제가 실패했습니다.');
	    					}
	    				})
	    				.catch(err => {
	    					console.log(err);
	    				});
	    		}
	    		
	    	});
	    	
	    	// 댓글 등록
	    	commentForm.onsubmit = function(e) {
	    		e.preventDefault();
	    		
	    		// 사용자가 입력한 값 취합
	    		const parent = commentForm.parent.value;
	    		const writer = commentForm.writer.value;
	    		const comment = commentForm.comment.value;
	    		
	    		// 폼 데이터 생성(JSON 데이터로 전송하게 되면 getParameter 수신 처리가 안되기 때문에 FormData로 전송)
	    		const formData = new FormData();
	    		formData.append("parent", parent);
	    		formData.append("writer", writer);
	    		formData.append("comment", comment);
	    		
	    		console.log(formData);
	    		
	    		fetch('/jboard/comment/write.do', {
		    			method: "POST",
		    			body: formData
	    			})
	    			.then(resp => resp.json())
	    			.then(data => {
	    				console.log(data);
	    				
	    				if(data != null){
	    					alert('댓글이 등록되었습니다.');
	    					
	    					// 등록한 댓글 동적 태그 생성
	    					const commentArticle = `<article class='comment'>
								                        <span>
								                        	<span>\${data.rdate}</span>
								                            <span>\${data.nick}</span>
								                        </span>
								                        <textarea name='comment' readonly>\${data.content}</textarea>
								                        <div> 
								                        	<a href="#" class="commentRemove">삭제</a>
								                            <a href="#" class="commentModify">수정</a>
								                        </div>
								                    </article>`;
	    					
	    					commentList.insertAdjacentHTML('beforeend', commentArticle);
								                    
	    				}else{
	    					alert('댓글 등록이 실패했습니다.');
	    				}
	    			})
	    			.catch(err => {
	    				console.log(err);
	    			});
	    	
	    	}
    	
    	}
    
    </script>
    
    
</head>
<body>
    <div id="container">
         <%@ include file="./_header.jsp" %>
        <main>
            <section class="view">
                <h3>글보기</h3>
                <table>
                    <tr>
                        <td>제목</td>
                        <td><input type="text" name="title" value="${articleDTO.title}" readonly/></td>
                    </tr>
                    <!-- 첨부파일이 있으면 나타나게끔  -->
                    <c:if test="${articleDTO.file > 0}">
	                    <tr>
	                        <td>첨부파일</td>
	                        <td>
	                        <c:forEach var="file" items="${articleDTO.files}">
		                        <p style="margin:4px 0">
		                            <a href="/jboard/article/fileDownload.do?fno=${file.fno}">${file.oName}</a>
		                            <span>${file.download}회 다운로드</span>
		                        </p>
                       		</c:forEach>
	                        </td>
	                    </tr>
                    </c:if>
                    <tr>
                        <td>내용</td>
                        <td>
                            <textarea name="content" readonly>${articleDTO.title}</textarea>
                        </td>
                    </tr>
                </table>
                <div>
                    <a href="#" class="btnDelete">삭제</a>
                    <a href="#" class="btnModify">수정</a>
                    <a href="/jboard/article/list.do" class="btnList">목록</a>
                </div>  
                
                <!-- 댓글리스트 -->
                <section class="commentList">
                    <h3>댓글목록</h3>
                    <c:forEach var="comment" items="${comments}">
	                    <article class="comment">
	                        <span>
	                        	<span>${comment.rdate}</span>
	                            <span>${comment.nick}</span>
	                        </span>
	                        <textarea name="comment" readonly>${comment.content}</textarea>
	                        <div> 
	                        	<!-- HTML 사용자 정의 속성을 이용한 삭제/수정 -->
	                            <a href="#" class="commentRemove" data-no="${comment.no}">삭제</a>
	                            <a href="#" class="commentModify" data-no="${comment.no}">수정</a>
	                            <a href="#" class="commentUpdate" data-no="${comment.no}">수정완료</a>
	                        </div>
	                    </article>
                    </c:forEach>
                   	<!-- 댓글이 없을때만 나오게끔 -->
                    <c:if test="${empty comments}">
	                    <p class="empty">등록된 댓글이 없습니다.</p>
                    </c:if>
                </section>
    
                <!-- 댓글입력폼 -->
                <section class="commentForm">
                    <h3>댓글쓰기</h3>
                    <form name="commentForm"> 
                    	<input type="hidden" name="parent" value="${articleDTO.no}" />
                    	<input type="hidden" name="writer" value="${sessUser.uid}" />
                        <textarea name="comment"></textarea>
                        <div>
                            <a href="#" class="btnCancel">취소</a>
                            <input type="submit" class="btnWrite" value="작성완료"/>
                        </div>
                    </form>
                </section>
            </section>
        </main>
         <%@ include file="./_footer.jsp" %>
    </div>
</body>
</html>