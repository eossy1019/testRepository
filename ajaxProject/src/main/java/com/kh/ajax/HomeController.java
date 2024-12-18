package com.kh.ajax;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.ajax.model.vo.Member;

@Controller
public class HomeController {
	
	
	//1.HttpServletResponse 객체 이용해서 스트림 연결 후 데이터 전달하기
	
	/*
	@RequestMapping("/ajax.do")
	public void ajax1(String name, int age,HttpServletResponse response) throws IOException {
		
		System.out.println("이름 : "+name);
		System.out.println("나이 : "+age);
		
		//요청 처리가 되었다는 가정 후 문자열 전달 
		String responseStr = "응답 문자열 : "+name+"님은 "+age+"살 입니다.";
		
		//response 객체로 처리
		//예외처리는 throws로 스프링에게 위임하기 
		response.setContentType("text/html; charset=UTF-8"); //응답 데이터 타입 및 인코딩 설정
		response.getWriter().print(responseStr);
		
	}
	*/
	
	//2.응답할 데이터를 문자열로 반환하기
	//기존 문자열을 반환하는 형식은 viewResolver를 통해 view 페이지로 이동하게 된다.
	//따라서 내가 반환하는 문자열을 데이터 자체로 전달하고자 한다면 
	//해당 메소드에 @ResponseBody 어노테이션을 부여해야한다.
	//또한 @RequestMapping 어노테이션에 해당 응답 데이터의 형식(타입)과 인코딩 설정을 추가해야한다.
	
	
	@ResponseBody
	@RequestMapping(value="/ajax.do",produces = "text/html;charset=UTF-8")
	public String ajax2(String name, int age) {
		
		String responseStr = "응답 문자열 : "+name+"님은 "+age+"살 입니다.";
		
		System.out.println(responseStr);
		//WEB-INF/views/응답 문자열 : "+name+"님은 "+age+"살 입니다..jsp 
		return responseStr;
	}
	
	
	
	//다수의 응답 데이터가 있다는 가정 
	//기존 사용하던 방식처럼 response 이용해서 처리해보기
	
	@RequestMapping(value="ajax2.do")
	public void ajax3(int userNo,HttpServletResponse response) throws IOException {
		
		System.out.println(userNo);
		//이름,나이 묶어서 반환
		//김유저,20
		
		/*
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().println("김유저");
		response.getWriter().println(20);
		response.getWriter().println("user01");
		response.getWriter().println("당산동");
		*/
		
		//JSON (JavaScript Object Notation) 형태로 다수 데이터 한곳에 담아주기 
		//JSONArray -> [값,값,값,....] (자바의 ArrayList와 유사)
		//JSONObject -> {키:값,키:값,...} (자바의 HashMap과 유사)
		
		//JSONArray 이용해보기 
		JSONArray jArr = new JSONArray();
		jArr.add("김유저");
		jArr.add(20);
		jArr.add("user01");
		jArr.add("당산동");
		
		//아래와 같이 text/html; 형식으로 보내면 객체타입이 아니라 문자열로 출력되어 반환된다.
		//response.setContentType("text/html; charset=UTF-8");
		
		//JSON 형식을 전달할땐 타입을 application/json 형태로 전달해야한다.
		response.setContentType("application/json; charset=UTF-8");
		
		response.getWriter().print(jArr);
		
		
		
		
	}
	
	//JSONObject 이용해보기 
	@RequestMapping("ajax3.do")
	public void ajax4(int userNo,HttpServletResponse response) throws IOException {
		
		System.out.println(userNo);
		
		
		JSONObject jObj = new JSONObject();
		
		jObj.put("name", "김유저");
		jObj.put("age",20);
		jObj.put("gender", "남자");
		jObj.put("email","user01@naver.com");
		
		
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jObj);
		
	}
	
	/*
	 * 
	//DB에서 조회된 데이터를 JSON 방식으로 반환해보기 
	@RequestMapping("ajax4.do")
	public void ajax5(int userNo,HttpServletResponse response) throws IOException {
		
		//전달받은 userNo를 통해 db에서 데이터를 조회한 가정
		Member m = new Member("김유저",20,"남자","user01@gmail.com");
		
		JSONObject jObj = new JSONObject();
		jObj.put("name",m.getName());
		jObj.put("age",m.getAge());
		jObj.put("gender",m.getGender());
		jObj.put("email",m.getEmail());
		
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jObj);
		
	}
	*/
	
	//위에서 처리한 response를 이용하여 jsonObject를 전달한 방법 대신 
	//@ResponseBody 어노테이션을 이용하여 데이터 자체 돌려주기 
	@ResponseBody
	@RequestMapping(value="ajax4.do",produces = "application/json;charset=UTF-8")
	public String ajax5(int userNo){
		
		//전달받은 userNo를 통해 db에서 데이터를 조회한 가정
		Member m = new Member("김유저",20,"남자","user01@gmail.com");
		
		JSONObject jObj = new JSONObject();
		jObj.put("name",m.getName());
		jObj.put("age",m.getAge());
		jObj.put("gender",m.getGender());
		jObj.put("email",m.getEmail());
		
		System.out.println(jObj);
		System.out.println(jObj.toJSONString());
		
		//JSONObject를 문자열로 변경하여 전달할것 
		return jObj.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="selectList",produces = "application/json;charset=UTF-8")
	public String selectList() {
		
		//가상의 목록 조회 
		ArrayList<Member> list = new ArrayList<>();
		list.add(new Member("김유저",20,"남자","user01@gmail.com"));
		list.add(new Member("박유저",25,"여자","asd@naver.com"));
		list.add(new Member("최유저",30,"남자","qwe@gmail.com"));
		
		//위 리스트를 DB에서 조회해왔다는 가정으로 진행
		JSONArray jArr = new JSONArray();
		//jArr.add(new JSONObject());
		
		//return list.toString(); 처럼 JSON형태가 아닌 타입으로 응답 불가 (JSON화 시켜야함)
		//반복문을 이용하여 조회한 데이터를 JSON에 넣어주기 
		for(Member m : list) {
			JSONObject jobj = new JSONObject();
			jobj.put("name", m.getName());
			jobj.put("age", m.getAge());
			jobj.put("gender", m.getGender());
			jobj.put("email", m.getEmail());
			
			
			jArr.add(jobj); //JSONArray에 만들어준 JSONObject 추가하기
		}
		
		
		System.out.println(jArr);
		
		return jArr.toJSONString(); //만들어준 JSONArray 문자열로 변환하여 리턴
		
	}
	
	
	//GSON 이용해보기 
	@ResponseBody
	@RequestMapping(value="selectList2",produces = "application/json;charset=UTF-8")
	public String selectList2() {
		
		//가상의 목록 조회 
		ArrayList<Member> list = new ArrayList<>();
		list.add(new Member("김유저",20,"남자","user01@gmail.com"));
		list.add(new Member("박유저",25,"여자","asd@naver.com"));
		list.add(new Member("최유저",30,"남자","qwe@gmail.com"));
		
		
		return new Gson().toJson(list);
	}
	
	
	//GSON 이용해서 응답 데이터 타입으로 처리해보기 
	@ResponseBody
	@RequestMapping(value="selectList3",produces = "application/json;charset=UTF-8")
	public ArrayList<Member> selectList3() {
		
		//가상의 목록 조회 
		ArrayList<Member> list = new ArrayList<>();
		list.add(new Member("김유저",20,"남자","user01@gmail.com"));
		list.add(new Member("박유저",25,"여자","asd@naver.com"));
		list.add(new Member("최유저",30,"남자","qwe@gmail.com"));
		list.add(new Member("이유저",40,"남자","gee@naver.com"));
		list.add(new Member("김다음",22,"여자","hyu@daum.net"));
		
		
		return list;
	}
	
	
	@ResponseBody
	@RequestMapping("test1")
	public String test(Member m) {
		System.out.println(m);
		return "ㅎ";
	}
	
	
	
	
}
