<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Kakao 지도 시작하기</title>
</head>
<body>
	<div id="map" style="width:500px;height:400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=105020d5be336948ef903114d3711ff8"></script>
	<script>
		var container = document.getElementById('map'); //지도 표시할 div 표시
		var options = {
			center: new kakao.maps.LatLng(36.1069736, 128.2746982), //지도 중심 좌표 
			level: 3 //지도 확대 레벨
		};

		var map = new kakao.maps.Map(container, options);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(36.1069736, 128.2746982); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var iwContent = '<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,36.1069736,128.2746982" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,36.1069736,128.2746982" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition = new kakao.maps.LatLng(36.1069736, 128.2746982); //인포윈도우 표시 위치입니다
	    
	 	// 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        position : iwPosition, 
	        content : iwContent 
	    });
	    
	    infowindow.open(map, marker); 
	</script>
</body>
</html>