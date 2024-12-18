package com.kh.ajax;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.ajax.model.vo.AddressInfo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class MapController {
	// 회원가입 시 주소를 입력하는 메소드
		@ResponseBody
		@RequestMapping(value = "search", produces = "application/json;charset=UTF-8")
		public ArrayList<AddressInfo> searchAddress(String location) throws Exception {
			
			String url = "https://dapi.kakao.com/v2/local/search/keyword.JSON";
			url += "?query=" + URLEncoder.encode(location, "UTF-8");
			url += "&analyze_type=similar";
			
			URL requestURL = new URL(url);
			HttpURLConnection urlCon = (HttpURLConnection)requestURL.openConnection();
			urlCon.setRequestProperty("Authorization", "KakaoAK ee0fa04eff270f586463a6c95c8047d6");
			urlCon.setRequestProperty("Content-Type", "application/json");
			urlCon.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
			
			String responseData = "";
			String line;
			
			while((line = br.readLine()) != null) {
				responseData += line;
			}
			
			JsonObject jobj = JsonParser.parseString(responseData).getAsJsonObject();
			JsonArray documents = jobj.getAsJsonArray("documents");
			
			log.debug("{}", documents);
			
			ArrayList<AddressInfo> aList = new ArrayList<>();
			
			for(int i = 0; i < documents.size(); i++) {
				
				JsonObject address = documents.get(i).getAsJsonObject();
				
				new AddressInfo();
				aList.add(AddressInfo.builder()
								     .addressName(address.get("address_name").getAsString())
								     .categoryName(address.get("category_name").getAsString())
								     .distance(address.get("distance").getAsString())
								     .addressId(address.get("id").getAsString())
								     .phone(address.get("phone").getAsString())
								     .placeName(address.get("place_name").getAsString())
								     .addressURL(address.get("place_url").getAsString())
								     .roadAddressName(address.get("road_address_name").getAsString())
								     .positionX(address.get("x").getAsString())
								     .positionY(address.get("y").getAsString())
								     .build());
			}
			
			return aList;
			
		}
		
		@ResponseBody
		@RequestMapping(value="searchLocation", produces="application/json;charset=UTF-8")
		public AddressInfo getLocationName(String latitude, String longitude) throws Exception{
			
			String url = "https://dapi.kakao.com/v2/local/geo/coord2address.JSON";
			url += "?x=" + longitude;
			url += "&y=" + latitude;
			
			URL requestURL = new URL(url);
			HttpURLConnection urlCon = (HttpURLConnection)requestURL.openConnection();
			urlCon.setRequestProperty("Authorization", "KakaoAK ee0fa04eff270f586463a6c95c8047d6");
			urlCon.setRequestProperty("Content-Type", "application/json");
			urlCon.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
			
			String responseData = "";
			String line;
			
			while((line = br.readLine()) != null) {
				responseData += line;
			}
			
			JsonObject jobj = JsonParser.parseString(responseData).getAsJsonObject();
			JsonArray documents = jobj.getAsJsonArray("documents");
			JsonArray address1 = documents.getAsJsonArray();
			JsonObject address2 = address1.get(0).getAsJsonObject();
			JsonObject addressName = address2.get("address").getAsJsonObject();
			
			AddressInfo addressInfo = AddressInfo.builder().addressName(addressName.get("address_name").getAsString()).build();
			
			log.debug("{}", addressInfo);
			
			return addressInfo;
		}
}
