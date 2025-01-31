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
function deleteOk(num) {
	if(confirm('위 자료를 삭제 하시겠습니까 ?')) {
		let url = '${pageContext.request.contextPath}/bbs/delete?num=' + num + '&${query}';
		location.href = url;
	}
}
</script>
</head>
<body>

<div class="body-container">
	<div class="body-title">
	    <h2><span>|</span> 게시판</h2>
	</div>
	
	<table class="table table-border table-article">
		<thead>
			<tr>
				<td colspan="2" align="center">
					${dto.subject}
				</td>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td width="50%">
					이름 : ${dto.name}
				</td>
				<td align="right">
					${dto.reg_date} | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty prevDto}">
						<a href="${pageContext.request.contextPath}/bbs/article?num=${prevDto.num}&${query}">${prevDto.subject}</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextDto}">
						<a href="${pageContext.request.contextPath}/bbs/article?num=${nextDto.num}&${query}">${nextDto.subject}</a>
					</c:if>
				</td>
			</tr>
			<tr style="border-bottom: none;">
				<td colspan="2" align="right" style="padding-top: 3px;">
					From : ${dto.ipAddr}
				</td>
			</tr>
		</tbody>
		
	</table>
	
	<table class="table">
		<tr>
			<td width="50%">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/update?num=${dto.num}&page=${page}';">수정</button>
				<button type="button" class="btn" onclick="deleteOk('${dto.num}');">삭제</button>
			</td>
			<td align="right">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/list?${query}';">리스트</button>
			</td>
		</tr>
	</table>
</div>

</body>
</html>