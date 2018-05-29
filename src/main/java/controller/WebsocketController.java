package controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import dao.FriendDAO;
import dao.UserDAO;

@ServerEndpoint("/waitingRoom")
public class WebsocketController {
	private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	UserDAO udb = UserDAO.getInstance();
	FriendDAO fdb = FriendDAO.getInstance();

	@OnOpen
	public void onOpen(Session session) throws IOException {
		clients.add(session);
		String nickname = session.getRequestParameterMap().get("nickname").get(0);
		String id = session.getRequestParameterMap().get("id").get(0);

		String userNickStr = "list";
		String userIdStr="list";

		int count = 0;
		// 온라인한 전체 유저수 카운트
		for (Session client : clients) {
			count++;
			userNickStr += ":" + client.getRequestParameterMap().get("nickname").get(0);
			userIdStr+=":" + client.getRequestParameterMap().get("id").get(0);
		}
		System.out.println(userIdStr+"=========================");
		System.out.println(nickname + "님이 로그인하셨습니다.");
		onMessage("@online@#" + userNickStr + "#" + count+"#"+userIdStr, session);
	}

	@OnClose
	public void onClose(Session session) throws IOException {
		clients.remove(session);

		String nickname = session.getRequestParameterMap().get("nickname").get(0);
		String id = session.getRequestParameterMap().get("id").get(0);

		String userNickStr = "list";
		String userIdStr="list";

		int count = 0;
		// 온라인한 전체 유저수 카운트
		for (Session client : clients) {
			count++;
			userNickStr += ":" + client.getRequestParameterMap().get("nickname").get(0);
			userIdStr+=":" + client.getRequestParameterMap().get("id").get(0);
		}
		System.out.println(userIdStr+"=========================");
		onMessage("@online@#" + userNickStr + "#" + count+"#"+userIdStr, session);

		System.out.println(nickname + "님이 로그아웃하셨습니다.");
	}

	@OnMessage
	public void onMessage(String msg, Session session) throws IOException {
		System.out.println(msg);

		synchronized (clients) {
			String movemessage = "<span class='w3-text-orange w3-large'>"
					+ session.getRequestParameterMap().get("nickname") + "</span>  " + msg;

			for (Session client : clients) {
				client.getBasicRemote().sendText(movemessage);
			}
		}
	}
}
