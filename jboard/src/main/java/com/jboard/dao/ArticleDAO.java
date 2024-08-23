package com.jboard.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jboard.dto.ArticleDTO;
import com.jboard.dto.FileDTO;
import com.jboard.util.DBHelper;
import com.jboard.util.SQL;

public class ArticleDAO extends DBHelper {


	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	
	private ArticleDAO() {}
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public int insertArticle(ArticleDTO dto) {
		
		int no = 0;
		
		try {
			
			conn = getConnection();
			conn.setAutoCommit(false); // 데이터베이스 연결 객체 conn의 자동 커밋 기능을 비활성화하는 역할(트랜잭션)
			
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, dto.getFile());
			psmt.setString(4, dto.getWriter());
			psmt.setString(5, dto.getRegip());
			psmt.executeUpdate();

			rs = stmt.executeQuery(SQL.SELECT_MAX_NO); // no의 auto-increment를 이용하여 가장 최신글은 no값이 가장 큰 것을 이용해서 글 번호를 가져옴
			
			if(rs.next()) {
				 no = rs.getInt(1);
			}
			conn.commit();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			
			try {
				conn.rollback();
			} catch (Exception e1) {
				logger.error(e1.getMessage());
			}
			
		}finally {
			closeAll();
		}
		return no;
	}
	
	
	//	전체 게시물 갯수 구하기
	public int selectCountTotal() {
		
		int total = 0;
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}finally {
			closeAll();
		}
		
		return total;
	}
	
	public ArticleDTO selectArticle(String no) {
		
		ArticleDTO dto = null; // ArticleDTO 선언
		List<FileDTO> files = new ArrayList<FileDTO>(); // 파일이 2개 생성된다고 생각하고 LIST
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLE);
			psmt.setString(1, no);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				if(dto == null) {
					dto = new ArticleDTO(); // ArticleDTO 생성
					dto.setNo(rs.getInt(1));
					dto.setCate(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setComment(rs.getInt(5));
					dto.setFile(rs.getInt(6));
					dto.setHit(rs.getInt(7));
					dto.setWriter(rs.getString(8));
					dto.setRegip(rs.getString(9));
					dto.setRdate(rs.getString(10));
				}
				
				FileDTO fileDTO = new FileDTO();
				fileDTO.setFno(rs.getInt(11));
				fileDTO.setAno(rs.getInt(12));
				fileDTO.setoName(rs.getString(13));
				fileDTO.setsName(rs.getString(14));
				fileDTO.setDownload(rs.getInt(15));
				fileDTO.setRdate(rs.getString(16));
				files.add(fileDTO);
			}
			
			dto.setFiles(files);
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}finally {
			closeAll();
		}
		
		return dto;
	}
	
	public List<ArticleDTO> selectArticles(int start) {
		
		List<ArticleDTO> articles = new ArrayList<>();
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLES);
			psmt.setInt(1, start);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				ArticleDTO dto = new ArticleDTO();
				dto.setNo(rs.getInt(1));
				dto.setCate(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setComment(rs.getInt(5));
				dto.setFile(rs.getInt(6));
				dto.setHit(rs.getInt(7));
				dto.setWriter(rs.getString(8));
				dto.setRegip(rs.getString(9));
				dto.setRdateSubString(rs.getString(10));
				dto.setNick(rs.getString(11));
				
				articles.add(dto);
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}finally {
			closeAll();
		}
		
		return articles;
	}
	
	public void updateArticle(ArticleDTO dto) {}
	
	public void deleteArticle(int no) {
		
	}
}
