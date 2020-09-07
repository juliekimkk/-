package guestbook.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

//fileDAO.java : 이미지 파일 DB 처리



public class fileDAO {

	private Connection conn;

	

	// 생성자를 통해 db연결 해줌

	public fileDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost:3306/guestbook_message";

			String dbID = "root";

			String dbPW = "rootroot";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPW);

		} catch(Exception e) {

			e.printStackTrace();

		}

	}

	

	public int upload(String fileName, String fileRealName, String messageId) {

		String SQL = "update guestbook_message set filename = ?, realfilename= ? where message_id = "+messageId;

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1,  fileName);

			pstmt.setString(2,  fileRealName);

			return pstmt.executeUpdate();

		} catch(Exception e) {

			e.printStackTrace();

		}

		return -1;

	}

}
