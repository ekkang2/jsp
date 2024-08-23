package com.jboard.controller.article;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jboard.dto.ArticleDTO;
import com.jboard.dto.FileDTO;
import com.jboard.dto.UserDTO;
import com.jboard.service.ArticleService;
import com.jboard.service.FileService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/article/write.do")
public class WriteController extends HttpServlet {

	private static final long serialVersionUID = 4818082532605926530L;
	private ArticleService articleService = ArticleService.INSTANCE;
	private FileService fileService = FileService.INSTANCE;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/article/write.jsp");
		dispatcher.forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String writer = req.getParameter("writer"); // session 값 hidden
		String regip = req.getRemoteAddr();
		
		// 파일 업로드
		List<FileDTO> files = fileService.fileUpload(req);
				
		ArticleDTO dto = new ArticleDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setFile(files.size()); // 파일 갯수 
		dto.setWriter(writer); 
		dto.setRegip(regip); 
		
		// 글 등록(글 등록 후, 등록된 글번호를 저장)
		int no = articleService.insertArticle(dto);
		
		
		for(FileDTO fileDTO : files) {
			fileDTO.setAno(no);
			fileService.insertFile(fileDTO);
		}
		
		
		resp.sendRedirect("/jboard/article/list.do");
		
	}
	

}
