<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

	<h3> 선언적 트랜잭션 </h3>
	<p>
		트랜잭션 코드를 직접 작성하지 않고
		설정 파일이나 애노테이션을 이용하여
		트랜잭션의 범위, 롤백 규칙등을 정의
	</p>

	<form action="<c:url value='/demo/write'/>" method="post">
		<p> 아이디 : <input type="text" name="id"> </p>
		<p> 이름 : <input type="text" name="name"> </p>
		<p> 생년월일 : <input type="text" name="birth"> </p>
		<p> 전화번호 : <input type="text" name="tel"> </p>
		<p>
			<button type="submit"> 등록하기 </button>
		</p>
	</form>

</body>
</html>