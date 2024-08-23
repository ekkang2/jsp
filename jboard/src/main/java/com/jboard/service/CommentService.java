package com.jboard.service;

import java.util.List;

import com.jboard.dao.CommentDAO;
import com.jboard.dto.CommentDTO;

public enum CommentService {

	Instance;
	private CommentDAO dao = CommentDAO.getInstance();
	
	public int insertComment(CommentDTO dto) {
		return dao.insertComment(dto);
	}
	
	public CommentDTO selectComment(int no) {
		return dao.selectComment(no);
	}
	
	public List<CommentDTO> selectComments(String parent) {
		return dao.selectComments(parent);
	}
	
	public int updateComment(CommentDTO dto) {
		return dao.updateComment(dto);
	}
	
	public int deleteComment(String no) {
		return dao.deleteComment(no);
	}
	
	
}
