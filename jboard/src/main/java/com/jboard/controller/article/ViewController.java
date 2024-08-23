package com.jboard.controller.article;

import java.io.IOException;
import java.util.List;

import com.jboard.dto.ArticleDTO;
import com.jboard.dto.CommentDTO;
import com.jboard.service.ArticleService;
import com.jboard.service.CommentService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/article/view.do")
public class ViewController extends HttpServlet {

	private static final long serialVersionUID = 4818082532605926530L;
	private ArticleService service = ArticleService.INSTANCE;
	private CommentService commentService = CommentService.Instance;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		String no = req.getParameter("no");
		
		// 데이터 조회
		ArticleDTO articleDTO = service.selectArticle(no);
		
		// 댓글 조회
		List<CommentDTO> comments = commentService.selectComments(no);
		
		// 공유 참조
		req.setAttribute("articleDTO", articleDTO);
		req.setAttribute("comments", comments);
		
		// 포워드(화면출력)
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/article/view.jsp");
		dispatcher.forward(req, resp);
		
	}
	
	

}
