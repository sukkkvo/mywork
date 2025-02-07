<%@ page contentType="text/html; charset=UTF-8"%>
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
<style type="text/css">
  .body-container { margin: 30px auto; width: 700px; }
  .body-main { padding-top: 5px; }
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>

<div class="body-container">
	<div class="body-title">
	    <h2><span>|</span> API</h2>
	</div>
	
	<div class="body-main">
		<p style="margin-bottom: 5px">
			<select id="selectRegion" class="form-select">
				<option data-nx="59" data-ny="126">마포구 서교동</option>
				<option data-nx="61" data-ny="125">강남구 역삼동</option>
				<option data-nx="60" data-ny="127">성북구 성북동</option>
			</select>
		</p>
		<p style=" padding: 0 5px; margin-bottom: 10px;">
			<button type="button" class="btn btnWeatherJSON">날씨 JSON</button>
		</p>
		<hr>
		
		<p style="padding: 5px; margin-bottom: 5px">
			<button type="button" class="btn btnWeatherXML">날씨 XML</button>
		</p>
		
		<div id="resultLayout" style="margin-top: 10px; padding: 5px;" ></div>
	</div>
</div>

<script type="text/javascript">
function ajaxFun(url, method, formData, dataType, fn, file = false) {
	const settings = {
			type: method, 
			data: formData,
			dataType:dataType,
			success:function(data) {
				fn(data);
			},
			beforeSend: function(jqXHR) {
			},
			complete: function () {
			},
			error: function(jqXHR) {
				console.log(jqXHR.responseText);
			}
	};
	
	if(file) {
		settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
	}
	
	$.ajax(url, settings);
}

$(function() {
	$('.btnWeatherJSON').click(function() {
		let nx = $('#selectRegion option:selected').attr('data-nx');
		let ny = $('#selectRegion option:selected').attr('data-ny');
		
		let params = {nx:nx, ny:ny};
		let url = '${pageContext.request.contextPath}/api/weather';
		const fn = function(data) {
			// console.log(data);
			
			let out = '<h3>날씨 - 초단기 실황 조회(JSON)</h3>';
			
			let list = data.response.body.items.item;
			let category;
			let obsrValue;
			for (let item of list) {
				category = item.category;
				obsrValue = item.obsrValue;
				
				if (category === 'PTY') {
					// 강수형태
				} else if (category === 'RN1') {
					// 강수형태
				} else if (category === 'T1H') {
					// 섭씨온도 
					out += '<p>섭씨온도 : ' + obsrValue + '</p>';
				} 
			}
			
			$('#resultLayout').html(out);
			
		};
		
		ajaxFun(url, 'get', params, 'json', fn);
	});
});

$(function() {
	$('.btnWeatherXML').click(function() {
		let url = '${pageContext.request.contextPath}/api/weatherXML';
		let url = '${pageContext.request.contextPath}/static/dist/wicon';
		
		const fn = function(data) {
			// console.log(data);
			let year = $(data).find('weather').attr('year');
			let month = $(data).find('weather').attr('month');
			let day = $(data).find('weather').attr('day');
			let hour = $(data).find('weather').attr('hour');
			
			let base_city = '서울';
			let out = '<h3>날씨 - ' + city + '</h3>';
			out += '<p>' + year + '년 ' + month + '월 ' + day + '일 ' + hour + '시</p>';
			
			let icon, desc, ta, city, rn_hr1, iconSrc;
			$(data).find('local').each(function() {
				city = $(this).text(); // 지역
				icon = $(this).attr('icon'); // 아이콘
				desc = $(this).attr('desc') || ''; // 날씨 
				ta = $(this).attr('ta') || ''; // 현재 온도
				rn_hr1 = $(this).attr('rn_hr1') || ''; // 시간당 강수량
				
				if (city === base_city) {
					our += '<p>날씨 : ' + desc + '</p>';
					out += '<p>기온 : ' + ta;
					if (rn_hr1) {
						out += ', 시간당 강수량 : ' + rn_hr1;
					}
					out += '</p>';
					iconSrc = iconUrl + icon + '.png';
					out += '<p><img src="' + iconSrc + '" title="' + desc + '"></p>';
				
					return false;
				}
				
			});
			
			$('#resultLayout').html(out);
		};
		
		ajaxFun(url, 'get', null, 'xml'. fn);
		
	});
})

</script>

</body>
</html>