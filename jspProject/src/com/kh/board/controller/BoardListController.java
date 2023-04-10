package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/list.bo")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//-------------페이징 처리--------------
		int listCount; //현재 총 게시글의 개수 
		int currentPage; //현재 페이지
		int pageLimit; //페이지 하단에 보여질 페이징바의 페이지 최대 개수
		int boardLimit; //한 페이지에서 보여질 게시글 최대 개수
		
		int maxPage; //가장 마지막 페이지가 몇인지 (총페이지의 개수)
		int startPage; //페이지 하단에 보여질 페이징바의 시작수
		int endPage; //페이지 하단에 보여질 페이징바의 끝 수 
		
		//listCount : 총 게시글 개수 구하기
		listCount = new BoardService().selectListCount();
		
		//currentPage : 현재 페이지
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		//pageLimit : 페이지 하단에 보여질 페이징바의 페이지 최대개수 (목록 단위)
		pageLimit = 10;
		//boardLimit : 한 페이지에 보여질 게시글 개수 (게시글 단위)
		boardLimit = 10;
		//maxPage ; listCount와 boardLimit의 영향을 받는 수 
		
		/*
		 * -공식 찾기 
		 * 게시글 총 개수		boardLimit  	maxPage
		 * 100개 		 /		10	- 10.0		10 
		 * 101개		 /		10	- 10.1		11
		 * 111개		 / 		10	- 11.1		12
		 * 나눗셈 후 올림처리를 통해 maxPage를 구하자
		 * 
		 * 1)listCount 를 double자료형으로 바꾸기
		 * 2)listCount/boardLimit
		 * 3)결과를 올림처리(Math.ceil()메소드)
		 * 4)결과값을 int로 마무리 
		 * 
		 * */
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		//startPage : 페이징바의 시작수
		/*
		 * 공식 찾기 
		 * startPage : 1,11,21,31,41 ,..... n*pageLimit+1
		 * currentPage startPage pageLimit:10 
		 * 1 -1 0/10 0				1 0*pageLimit+1  - 1
		 * 5	4/10 0			1
		 * 10	9/10 1			1
		 * 11	10/10 1		11 1* pageLimit+1 - 11
		 * 15	14/10 1
		 * 20 11
		 * 21	20/10 2			21 2* pageLimit+1 -21
		 * 30
		 * 
		 * startPage : (currentPage-1)/pageLimit *pageLimit+1
		 * */
		startPage = (currentPage-1)/pageLimit * pageLimit +1;
		
		// 1- 10 / 11 - 20 / 21 - 30 / : startPage+pageLimit-1 
		//endPage : 페이징바 끝 수 
		endPage = startPage+pageLimit-1;
		// 20   -  13 
		//총페이지수가 13페이지라면? 
		//startPage : 11  / endPage : 20 
		if(endPage>maxPage) { //끝수가 총 페이지수보다 크다면 해당 수를 총페이지수로 바꿔주기
			endPage = maxPage;
		}
		
		//페이지 정보들을 하나의 공간에 담아보내기 (VO이용)
		PageInfo pi = new PageInfo(listCount,currentPage,pageLimit,boardLimit,maxPage,startPage,endPage);
		
		
		//현재 사용자가 요청한 페이지에 (currentPage)에 보여질 게시글 리스트 조회
		ArrayList<Board> list = new BoardService().selectList(pi);

		//조회된 리스트와 페이징정보 request로 보내기
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);
		request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
