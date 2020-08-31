package guestbook.service;

import java.sql.Connection;
import java.sql.SQLException;

import guestbook.dao.MessageDao;
import guestbook.model.Message;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class UpdateMessageService {
	private static UpdateMessageService instance = new UpdateMessageService();

	public static UpdateMessageService getInstance() {
		return instance;
	}

	private UpdateMessageService() {
	}

	public void updateMessage(int messageId, String guest_name, String message2, String password) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);

			MessageDao messageDao = MessageDao.getInstance();
			Message message = messageDao.select(conn, messageId);
			if (message == null) {
				throw new MessageNotFoundException("메시지 없음");
			}
			if (!message.matchPassword(password)) {
				throw new InvalidPassowrdException("bad password");
			}
			messageDao.update(conn, messageId, guest_name, message2); //비밀번호가 맞으면 업데이트하기

			conn.commit();  
		} catch (SQLException ex) {   //exception 처리할때 항상 해주는것 
			JdbcUtil.rollback(conn);
			throw new ServiceException("업데이트 실패:" + ex.getMessage(), ex);
		} catch (InvalidPassowrdException | MessageNotFoundException ex) {
			JdbcUtil.rollback(conn);
			throw ex;
		} finally {
			JdbcUtil.close(conn);
		}
	}

	
}
