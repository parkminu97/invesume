package com.invesume.portal.mypage.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO extends SqlSessionDaoSupport {
    @Autowired
    @Resource(name="sqlSessionTemplate")
    private SqlSession sqlSessionTemplate;

    public List<Map<String, Object>> boardList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("board.boardList", params);
    }

    public int boardListCount(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("board.boardListCount", params);
    }

    public Map<String, Object> boardView(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("board.boardView", params);
    }

    public void boardInsert(Map<String, Object> params) {
    	sqlSessionTemplate.insert("board.boardInsert", params);
    }

    public void boardUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("board.boardUpdate", params);
    }

    public void boardDelete(Map<String, Object> params) {
    	sqlSessionTemplate.delete("board.boardDelete", params);
    }

    public void boardReadHitUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("board.boardReadHitUpdate", params);
    }

}
