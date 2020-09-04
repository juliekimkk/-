package guestbook.service;

import java.util.List;

import guestbook.model.Message;

public class MessageSearchView {

	private int messageTotalCount;
	private List<Message> messageList;
	
	
	
	public MessageSearchView(List<Message> messageList, int messageTotalCount, String search)
	{
		this.messageList = messageList;
		this.messageTotalCount = messageTotalCount;
	}

	public List<Message> getMessageList() {
		return messageList;
	}

	public boolean isEmpty() {
		return messageTotalCount == 0;
	}
}