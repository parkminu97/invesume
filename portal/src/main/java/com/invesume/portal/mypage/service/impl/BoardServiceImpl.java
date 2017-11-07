package com.invesume.portal.mypage.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.PagingUtil;
import com.invesume.portal.mypage.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
    private BoardDAO boardDao;

	@Override
	public void boardList(Map<String, Object> params) {
		PagingUtil pagingUtil = new PagingUtil(Integer.parseInt(CommonUtil.isNull(params.get("currentPage"), "1")), Integer.parseInt(CommonUtil.isNull(params.get("pageRow"), "10")));
        pagingUtil.setTotalCount(boardDao.boardListCount(params));
        
        params.put("pageRow", pagingUtil.getPageRow());
        params.put("currentPage", pagingUtil.getCurrentPage());
        pagingUtil.setList(boardDao.boardList(params));
        
        params.put("pagingList", pagingUtil);
	}

	@Override
	public Map<String, Object> boardView(Map<String, Object> params) {
		return boardDao.boardView(params);
	}

	@Override
	public void boardInsert(Map<String, Object> params) {
		boardDao.boardInsert(params);
	}

	@Override
	public void boardUpdate(Map<String, Object> params) {
		boardDao.boardUpdate(params);
	}

	@Override
	public void boardDelete(Map<String, Object> params) {
		boardDao.boardDelete(params);
	}

	@Override
	public void boardReadHitUpdate(Map<String, Object> params) {
		boardDao.boardReadHitUpdate(params);
	}

}
