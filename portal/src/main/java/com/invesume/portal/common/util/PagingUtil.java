package com.invesume.portal.common.util;

import java.util.List;


public class PagingUtil {
    private int blockPage = 10; // 한페이지에 보여주는 페이지 블럭 수
    
    private int pageRow = 10;   // 한페이지에 보여주는 글 수
    
    private int currentPage; // 현재페이지

    private int totalCount; // 전체 게시물 수

    private int totalPage; // 전체 페이지 수

    private int startCount; // 한 페이지에서 보여줄 게시글의 시작 번호

    private int endCount; // 한 페이지에서 보여줄 게시글의 끝 번호

    private int startPage; // 시작 페이지

    private int endPage; // 마지막 페이지
    
    private List<?> list;
    
    private String pagingHtml;
    
    public PagingUtil(int currentPage) {
        this.currentPage = currentPage;
    }
    
    public PagingUtil(int currentPage, int pageRow) {
        this.currentPage = currentPage;
        this.pageRow = pageRow;
    }

    public PagingUtil(int currentPage, int pageRow, int blockPage) {
        this.currentPage = currentPage;
        this.pageRow = pageRow;
        this.blockPage = blockPage;
    }

    public int getBlockPage() {
        return blockPage;
    }

    public void setBlockPage(int blockPage) {
        this.blockPage = blockPage;
    }

    public int getPageRow() {
        return pageRow;
    }

    public void setPageRow(int pageRow) {
        this.pageRow = pageRow;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.setPagingHtml(getPagingHtml());
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getStartCount() {
        return startCount;
    }

    public void setStartCount(int startCount) {
        this.startCount = startCount;
    }

    public int getEndCount() {
        return endCount;
    }

    public void setEndCount(int endCount) {
        this.endCount = endCount;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
    
    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }

    public String getPagingHtml() {
        // 전체 페이지 수
        totalPage = (int) Math.ceil((double) totalCount / pageRow);
        if (totalPage == 0) {
            totalPage = 1;
        }

        // 현재 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
        if (currentPage > totalPage) {   
            currentPage = totalPage;
        }

        // 현재 페이지의 처음과 마지막 글의 번호 가져오기
        startCount = (currentPage - 1) * pageRow;
        endCount = startCount + pageRow;

        // 시작 페이지와 마지막 페이지 값 구하기
        startPage = (int) ((currentPage - 1) / blockPage) * blockPage + 1;
        endPage = startPage + blockPage - 1;

        // 마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        StringBuffer sb = new StringBuffer();
	    sb.append("<ul class='page_num'>");
	    sb.append("<li class='prev'><a href='#' onclick='fn_list(" + (startPage - 1 == 0 ? 1 : (startPage - 1)) + ")'>이전</a></li>");
	
	    for (int i = startPage; i <= endPage; i++) {
	        if (i > totalPage) {
	            break;
	        }
	        
	        if (i == currentPage) {
	            sb.append("<li class='num_choice'><a href='#'>");
	            sb.append(i);
	            sb.append("</a></li>");
	        } else {
	            sb.append("<li><a href=javascript:fn_list(" + i + ")>");
	            sb.append(i);
	            sb.append("</a></li>");
	        }
	    }
	
	    sb.append("<li class='next'><a href='#' onclick='fn_list(" + (endPage + 1 > totalPage ? totalPage : (endPage + 1))+ ")'>다음</a></li> ");
	    sb.append("</ul>");
        
        this.pagingHtml = sb.toString();
        
        return pagingHtml;
    }

    public void setPagingHtml(String pagingHtml) {
        this.pagingHtml = pagingHtml;
    }
}