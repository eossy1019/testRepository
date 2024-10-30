package com.kh.git.board;

public class Board {
	
	String name;
	String title;
	int age;

	public Board(String name, String title, int age) {
		super();
		this.name = name;
		this.title = title;
		this.age = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

}
