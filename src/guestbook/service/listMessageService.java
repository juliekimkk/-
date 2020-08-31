package guestbook.service;

import guestbook.dao.MessageDao;
import guestbook.model.Message;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import java.sql.Connection;
import java.sql.SQLException;

public class listMessageService {
		private static listMessageService instance = new listMessageService();

		public static listMessageService getInstance() {
			return instance;
		}

		private listMessageService() {
		}

	public Message listMessage(int messageId) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);

			MessageDao messageDao = MessageDao.getInstance();
			Message message = messageDao.select(conn, messageId);
			if (message == null) {
				throw new MessageNotFoundException("메시지 없음");
			}
			
			return message;
		
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
