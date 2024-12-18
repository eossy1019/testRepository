<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7b8a61ae85e27a17fc90cd2fcea0205&libraries=services"></script>
<!-- alertifyS alert창 활성화 -->
<!-- JavaScript -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
<!-- Bootstrap theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/bootstrap.min.css"/>
   
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 부트스트랩에서 제공하고 있는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
	.table-container {
		max-height: 400px;  
		overflow-y: auto; 
		margin-top: 10px;
	}	
	
	#address-area tr:hover{
		cursor: pointer;
		text-decoration: underline;
		font-weight: bold;
	}
</style>  

</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

	<h1>카카오맵 주소 찾기</h1>

	<!-- Button to Open the Modal -->
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#myModal">주소 찾기</button>

	<!-- The Modal -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					검색 : <input type="text" name="address" id="address">
					<button onclick="searchBtn();">search</button>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" style="height: 450px;">
					<div class="table-container">
						<table border="1">
							<tbody id="address-area">
								<tr align="center">
									<td>주소를 입력해주세요.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	
	<div id="map" style="width:600px;height:350px;"></div>   
	<div id="centerAddr"></div>
	
	<script>
		let addressName;
		
		function getLocationName(latitude, longitude){
			$.ajax({
				url : "user/searchLocation",
				data : {
					latitude : latitude,
					longitude : longitude
				},
				async : false,
				success : function(result){
					addressName = result.addressName;
					console.log(addressName);
					
				},
				error : function(){
					console.log("통신 오류");
				}
			})
		}
	
		$(function(){
			navigator.geolocation.getCurrentPosition((position) => {
				
				var latitude = position.coords.latitude;
				var longitude = position.coords.longitude;
				
				//var locationName = getLocationName(latitude, longitude);
				getLocationName(latitude, longitude);
				console.log(addressName);
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
		
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				
				var iwContent = '<div style="padding:5px;">'+addressName+'<br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다
	
				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
				    position : iwPosition, 
				    content : iwContent 
				});
				  
				// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
				infowindow.open(map, marker); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
		
				var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
				    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		
				// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
				kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
				    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
				        if (status === kakao.maps.services.Status.OK) {
				            var detailAddr = !!result[0].road_address ? '<div style="font-size:9px">&nbsp;' + result[0].road_address.address_name + '</div>' : '';
				            detailAddr += '<div style="font-size:9px">&nbsp;[지번]' + result[0].address.address_name + '</div>';
				            
				            var content = '<div class="bAddr" style="font-size:12px; display: inline-block; width: auto; height: auto;">' +
				                            detailAddr + 
				                        '</div>';
		
				            // 마커를 클릭한 위치에 표시합니다 
				            marker.setPosition(mouseEvent.latLng);
				            marker.setMap(map);
		
				            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
				            infowindow.setContent(content);
				            infowindow.open(map, marker);
				        }   
				    });
				});
				
				function searchAddrFromCoords(coords, callback) {
				    // 좌표로 행정동 주소 정보를 요청합니다
				    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
				}
		
				function searchDetailAddrFromCoords(coords, callback) {
				    // 좌표로 법정동 상세 주소 정보를 요청합니다
				    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
				}
			});
		})
	
		function searchBtn(){
			
			var location = $("#address").val();
			
			$.ajax({
				url : "user/search",
				data : {
					location : location
				},
				success : function(list){
					
					$("#address-area tr").remove();
					
					if(list != ""){
						
						for(var a of list){
							
							var tr = $("<tr>");
							tr.append($("<td>").html(a.addressName + "<br> <h6 style='color:gray; font-size: 12px;'>" + a.roadAddressName + "</h6>"));
							tr.append($("<td>").text(a.placeName));
							
							if(a.phone == null){
								tr.append($("<td>").text("-"));
							}
							else{
								tr.append($("<td>").text(a.phone));
							}
							
							$("#address-area").append(tr);

						}
					}
					else {
						var tr = $("<tr>");
						tr.append($("<td>").text("정확한 주소를 입력해주세요."));
						$("#address-area").append(tr);
					}
					
				},
				error : function(error){
					console.log(error);
					console.log("통신 오류");
				}
			});
			
		}
	</script>
	
</body>
</html>