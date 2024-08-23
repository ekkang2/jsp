package com.jboard.controller.user;

import java.io.IOException;

import com.jboard.dto.UserDTO;
import com.jboard.service.UserService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user/register.do")
public class RegisterController extends HttpServlet {

	private static final long serialVersionUID = 4818082532605926530L;

	// controller가 service랑 연결됨
	private UserService service = UserService.INSTANCE;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/register.jsp");
		dispatcher.forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 데이터 수신 (controller > service > dao순인데 service로 한꺼번에 데이터를 넘기기 위해서 DTO 생성)
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass1");
		String name = req.getParameter("name");
		String nick = req.getParameter("nick");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String zip = req.getParameter("zip");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		String regip = req.getRemoteAddr(); // 클라이언트의 ip 주소를 얻음
	 
		// DTO 생성
		UserDTO userDTO = new UserDTO();
		userDTO.setUid(uid);
		userDTO.setPass(pass);
		userDTO.setName(name);
		userDTO.setNick(nick);
		userDTO.setEmail(email);
		userDTO.setHp(hp);
		userDTO.setZip(zip);
		userDTO.setAddr1(addr1);
		userDTO.setAddr2(addr2);
		userDTO.setRegip(regip);
		
		// 데이터 저장
		service.insertUser(userDTO);
		
		// 리다이렉트
		resp.sendRedirect("/jboard/user/login.do");
	}
	

}
