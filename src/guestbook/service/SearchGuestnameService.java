package guestbook.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import guestbook.dao.MessageDao;
import guestbook.model.Message;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class SearchGuestnameService {
	private static SearchGuestnameService instance = new SearchGuestnameService();

	public static SearchGuestnameService getInstance() {
		return instance;
	}

	private SearchGuestnameService() {
	}

	private static final int MESSAGE_COUNT_PER_PAGE = 3;

	public MessageSearchView getMessageSearch(String  search) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDao.getInstance();  //new 해서 객체만들필요없이 바로 인스턴트해서 만들더줌

			int messageTotalCount = messageDao.searchCount(conn, search);

			List<Message> messageList = null;  //페이지에서 밑에 1.2.3페이지 카운트
			if (messageTotalCount > 0) {  //게시물 페이지 
				messageList = messageDao.searchList(conn, search);
			} else {
				messageList = Collections.emptyList();
			}
			return new MessageSearchView(messageList, messageTotalCount, search);
		} catch (SQLException e) {
			throw new ServiceException("목록 구하기 실패: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}