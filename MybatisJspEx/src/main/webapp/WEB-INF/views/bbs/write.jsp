<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/forms.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">

<style type="text/css">
  .body-container { margin: 30px auto; width: 700px; }
</style>

<script type="text/javascript">
function sendOk() {
    const f = document.boardForm;

    let str = f.subject.value.trim();
    if(!str) {
        alert('제목을 입력하세요. ');
        f.subject.focus();
        return;
    }

    str = f.name.value.trim();
    if(!str) {
        alert('이름을 입력하세요. ');
        f.name.focus();
        return;
    }

    str = f.content.value.trim();
    if(!str) {
        alert('내용을 입력하세요. ');
        f.content.focus();
        return;
    }

    str = f.pwd.value.trim();
    if( !str ) {
        alert('패스워드를 입력하세요. ');
        f.pwd.focus();
        return;
    }
	
    f.action = '${pageContext.request.contextPath}/bbs/${mode}';
    f.submit();
}
</script>
</head>
<body>

<div class="body-container">
	<div class="body-title">
	    <h2><span>|</span> 게시판</h2>
	</div>

	<form name="boardForm" method="post">
		<table class="table table-border table-form">
			<tr> 
				<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td> 
					<input type="text" name="subject" maxlength="100" class="form-control" value="${dto.subject}">
				</td>
			</tr>
			
			<tr> 
				<td>작성자</td>
				<td> 
					<input type="text" name="name" maxlength="10" class="form-control" value="${dto.name}">
				</td>
			</tr>
			
			<tr> 
				<td>내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<textarea name="content" class="form-control">${dto.content}</textarea>
				</td>
			</tr>
			
			<tr>
				<td>패스워드</td>
				<td> 
					<input type="password" name="pwd" maxlength="10" class="form-control">
					(게시물 수정 및 삭제시 필요 !!!)
				</td>
			</tr>
		</table>
			
		<table class="table">
			<tr> 
				<td align="center">
					<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/list';">${mode=='update'?'수정취소':'등록취소'}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
				</td>
			</tr>
		</table>
	</form>
	
</div>

</body>
</html>