package guestbook.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import guestbook.dao.MessageDao;
import guestbook.model.Message;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class GetMessageListService {
	private static GetMessageListService instance = new GetMessageListService();

	public static GetMessageListService getInstance() {
		return instance;
	}

	private GetMessageListService() {
	}

	private static final int MESSAGE_COUNT_PER_PAGE = 3;

	public MessageListView getMessageList(int pageNumber) {
		Connection conn = null;
		int currentPageNumber = pageNumber;
		try {
			conn = ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDao.getInstance();  //new 해서 객체만들필요없이 바로 인스턴트해서 만들더줌

			int messageTotalCount = messageDao.selectCount(conn);

			List<Message> messageList = null;  //페이지에서 밑에 1.2.3페이지 카운트
			int firstRow = 0;
			int endRow = 0;
			if (messageTotalCount > 0) {  //게시물 페이지 
				firstRow =
						(pageNumber - 1) * MESSAGE_COUNT_PER_PAGE  + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				messageList =
						messageDao.selectList(conn, firstRow, endRow);
			} else {
				currentPageNumber = 0;
				messageList = Collections.emptyList();
			}
			return new MessageListView(messageList,
					messageTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new ServiceException("목록 구하기 실패: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}