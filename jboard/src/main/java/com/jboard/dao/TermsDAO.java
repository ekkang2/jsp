package com.jboard.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jboard.dto.TermsDTO;
import com.jboard.util.DBHelper;
import com.jboard.util.SQL;

public class TermsDAO extends DBHelper {

	private static TermsDAO instance = new TermsDAO();
	public static TermsDAO getInstance() {
		return instance;
	}
	private TermsDAO() {}
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public void insertTerms(TermsDTO dto) {
		
	}
	public TermsDTO selectTerms() {
		
		TermsDTO dto = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_TERMS);
			
			if(rs.next()) {
				dto = new TermsDTO();
				dto.setTerms(rs.getString(1));
				dto.setPrivacy(rs.getString(2));
			}
			closeAll();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return dto;
	}
	public List<TermsDTO> selectTermses() {
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public void updateTerms(TermsDTO dto) {}
	public void deleteTerms() {}
	
}