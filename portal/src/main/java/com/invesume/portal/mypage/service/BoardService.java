package com.invesume.portal.mypage.service;

import java.util.Map;

public interface BoardService {
	void boardList(Map<String, Object> params);
	Map<String, Object> boardView(Map<String, Object> params);
	void boardInsert(Map<String, Object> params);
	void boardUpdate(Map<String, Object> params);
	void boardDelete(Map<String, Object> params);	
	void boardReadHitUpdate(Map<String, Object> params);	
}
