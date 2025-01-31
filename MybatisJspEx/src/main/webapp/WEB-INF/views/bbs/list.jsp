<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/forms.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">

<style type="text/css">
  .body-container { margin: 30px auto; width: 700px; }
</style>

<script type="text/javascript">
//검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
window.addEventListener('load', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
	    if(evt.key === 'Enter') {
	    	evt.preventDefault();
	    	
	    	searchList();
	    }
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let requestParams = new URLSearchParams(formData).toString();
	
	/*
	let params = {
		schType:f.schType.value, kwd:f.kwd.value
	};
	// 자바스트립트 객체를 queryString(이름1=값1&이름2=값2)로 변환
	const requestParams = new URLSearchParams(params).toString();
	*/
	
	let url = '${pageContext.request.contextPath}/bbs/list';
	location.href = url + '?' + requestParams;
}
</script>
</head>
<body>

<div class="body-container">
	<div class="body-title">
	    <h2><span>|</span> 게시판</h2>
	</div>

	<table class="table">
		<tr>
			<td width="50%">${dataCount}개(${page}/${total_page} 페이지)</td>
			<td align="right">&nbsp;</td>
		</tr>
	</table>
	
	<table class="table table-border table-list">
		<thead>
			<tr>
				<th class="num">번호</th>
				<th class="subject">제목</th>
				<th class="name">작성자</th>
				<th class="date">작성일</th>
				<th class="hit">조회수</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="dto" items="${list}" varStatus="status">
				<tr>
					<td>${dataCount - (page-1) * size - status.index}</td>
					<td class="left"><a href="${articleUrl}&num=${dto.num}">${dto.subject}</a></td>
					<td>${dto.name}</td>
					<td>${dto.reg_date}</td>
					<td>${dto.hitCount}</td>
				</tr>
			</c:forEach>
		</tbody>
		
	</table>
	
	<div class="page-navigation">
		${dataCount==0 ? "등록된 게시물이 없습니다." : paging}
	</div>
	
	<table class="table">
		<tr>
			<td width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/list';">새로고침</button>
			</td>
			<td align="center">
				<form name="searchForm">
					<select name="schType" class="form-select" title="검색항목">
						<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
						<option value="name" ${schType=="name"?"selected":""}>작성자</option>
						<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
						<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
						<option value="content" ${schType=="content"?"selected":""}>내용</option>
					</select>
					<input type="text" name="kwd" value="${kwd}" class="form-control" title="검색키워드">
					<button type="button" class="btn" onclick="searchList()">검색</button>
				</form>
			</td>
			<td align="right" width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/write';">글올리기</button>
			</td>
		</tr>
	</table>	
</div>

</body>
</html>