package org.dodo.vo;

//방명록
public class UserBoardVO {
	private int num; // 글 번호
	private String masterid; // 방명록 주인 아이디 (로그인된 아이디)
	private String author; // 글 작성자 = id (내 아이디 말고 , 내 방명록에 글을 남긴 아이디)
	private String title; // 내용
	private String bdate; // 글 작성일
	private int uref; // ref
	private int secretnum; // 비밀글 번호
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getMasterid() {
		return masterid;
	}
	public void setMasterid(String masterid) {
		this.masterid = masterid;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public int getUref() {
		return uref;
	}
	public void setUref(int uref) {
		this.uref = uref;
	}
	public int getSecretnum() {
		return secretnum;
	}
	public void setSecretnum(int secretnum) {
		this.secretnum = secretnum;
	}
}
