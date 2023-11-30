package ch13;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//import com.mysql.jdbc.PreparedStatement;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();

	public static BoardDBBean getInstance() {
		return instance;
	}

	private BoardDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}

	public void insertArticle(BoardDataBean article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		String sql = "";
		int number = 0; // 그룹 번호

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from board");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}

			if (num != 0) {
				sql = "update board set re_step = re_step+1 where ref=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}

			sql = "insert into board(writer,email,subject,passwd,reg_date,";
			sql += "ref,re_step,re_level,content,ip) values (?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Exception[insertArticle] : " + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			;
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			;
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
			;
		}
	}

	public List<BoardDataBean> getArticles(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "select * from board order by ref desc, re_step asc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start - 1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				articleList = new ArrayList<BoardDataBean>();
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				} while (rs.next());
			}
		} catch (Exception e) {
			System.out.println("Exception[getArticles] : " + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			;
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			;
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
			;
		}

		return articleList;
	}

	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from board");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("Exception[getArticleCount] : " + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			;
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			;
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
			;
		}

		return count;
	}

	public BoardDataBean getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update board set readcount=readcount+1 where num=?");
			pstmt.setInt(1, num);
			pstmt.executeLargeUpdate();
			pstmt.close();
			pstmt = conn.prepareStatement("select * from board where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			System.out.println("Exception[getArticle] : " + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			;
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			;
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
			;
		}
		return article;
	}

	public int updateArticle(BoardDataBean article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int updateCount = 0;
		try {
			String sql = "select passwd from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbpasswd = rs.getString(1);
				if (dbpasswd.equals(article.getPasswd())) {
					sql = "update board set writer=?,email=?,subject=?,content=? ";
					sql += "where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					updateCount = pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			System.out.println("Exception[updateArticle]" + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			;
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			;
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
			;
		}
		return updateCount;
	}

	public int deleteArticle(int num, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int deleteCount = 0;
		try {
			conn = getConnection();
			String sql = "delete from board where num = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, passwd);
			deleteCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Exception[deleteArticle]" + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			;
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			;
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
			;
		}

		return deleteCount;
	}
}