package org.dodo.vo;

import java.util.Date;

public class BoardListVO {
	private int num; //글번호
	private String title; //글 제목
	private String contents; // 글 내용
	private String author; // 글 작성자 (작성자 아이디)
	private String bdate; // 작성날짜
	private int goodcnt; // 추천수
	private int ref; // ref
	private String cat; // 관심분야 카테고리
	private int cnt; //댓글수
	private int readcnt; //조회수
	private int fenabled;  //파일첨부유무
	private int total;//전체페이지
	private int page;//현재페이지
	private String searchI; //검색입력값
	private String searchS; //검색카테고리값
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public int getGoodcnt() {
		return goodcnt;
	}
	public void setGoodcnt(int goodcnt) {
		this.goodcnt = goodcnt;
	}
	
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public String getCat() {
		return cat;
	}
	public void setCat(String cat) {
		this.cat = cat;
	}
	public int getFenabled() {
		return fenabled;
	}
	public void setFenabled(int fenabled) {
		this.fenabled = fenabled;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getSearchI() {
		return searchI;
	}
	public void setSearchI(String searchI) {
		this.searchI = searchI;
	}
	public String getSearchS() {
		return searchS;
	}
	public void setSearchS(String searchS) {
		this.searchS = searchS;
	}
	
	
}
