if(ServletFileUpload.isMultipartContent(request)) {
			
			// 1_1. 전송파일 용량 제한 (int maxSize)
			int maxSize = 10 * 1024 * 1024;
			
			// 1_2. 전달된 파일을 저장시킬 서버의 폴더의 물리적인 경로 알아내기(String savePath)
			// "/" 는 WebContent 폴더를 의미함
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			
			// 2. 전달된 파일명 수정 작업 후 서버에 업로드
			// HttpServletRequest => MultipartRequest
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			// 3. 본격적으로 SQL 문 실행할 때 필요한 값(요청시 전달값) 뽑기
			// - 공통적으로 수행 : Board 테이블에 UPDATE
			int boardNo = Integer.parseInt(multiRequest.getParameter("bno"));
			String category = multiRequest.getParameter("category");
			String boardTitle = multiRequest.getParameter("boardTitle");
			String boardContent = multiRequest.getParameter("boardContent");
			
			Board b = new Board();
			b.setBoardNo(boardNo);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			b.setCategory(category);
			
			// 새로이 전달된 첨부파일이 있을 경우 필요한 값 뽑기
			Attachment at = null;
			
			if(multiRequest.getOriginalFileName("reUpfile") != null) {
				
				// 3개의 쿼리문 중 공통적으로 필요한 항목들을 한번에 담기
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("reUpfile"));
				at.setChangeName(multiRequest.getFilesystemName("reUpfile"));
				at.setFilePath("resources/board_upfiles/");
				
				// 첨부파일이 있을 경우 원본파일의 파일번호, 수정명을 hidden 으로 넘겼었음!!
				if(multiRequest.getParameter("originFileNo") != null) {
					// 새로운 첨부파일이 있고, 기존의 파일이 있었을 경우
					// => Update Attachment  
					//	  + 기존의 파일 고유번호
					at.setFileNo(Integer.parseInt(multiRequest.getParameter("originFileNo")));
					
					// 기존의 첨부파일 삭제
					new File(savePath + multiRequest.getParameter("originFileName")).delete();
				}
				else {
					// 새로운 첨부파일이 넘어왔지만, 기존의 파일이 없었을 경우
					// => Insert Attachment
					//    + 현재 게시글 번호
					at.setRefNo(boardNo);
					
				}
			}
			
			// 모두 하나의 트랜잭션으로 처리해야함
			int result = new BoardService().updateBoard(b, at);
			
			// case1 : 새로운 첨부파일 X 			  => b, null 			=> Board Update
			// case2 : 새로운 첨부파일 O, 기존 첨부파일 O => b, fileNo 이 담긴 at => Board Update, Attachment Update
			// case3 : 새로운 첨부파일 O, 기존 첨부파일 X => b, refNo 이 담긴 at  => Board Update, Attachment Insert

			if(result > 0) { // 수정 성공 => 상세조회페이지
				
				request.getSession().setAttribute("alertMsg", "성공적으로 수정되었습니다.");
				response.sendRedirect(request.getContextPath() + "/detail.bo?bno=" + boardNo);
			}
			else { // 수정 실패 => 에러페이지

				request.setAttribute("errorMsg", "게시글 수정에 실패했습니다.");
				
				RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
				view.forward(request, response);
			}
		}