package com.kh.ajax.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AddressInfo {
	
	private String addressName;//	address_name
	private String categoryName;//	category_name "문화,예술 > 종교 > 기독교 > 교회"
	private String distance;//	distance
	private String addressId;//	id
	private String phone;//	phone
	private String placeName;//	place_name
	private String addressURL;//	place_url
	private String roadAddressName;//	road_address_name
	private String positionX;//	x
	private String positionY;//	y
}
