package org.dodo.vo;

//추천
public class GoodVO {
	private int num; // 글 번호
	private int goodcnt; // 추천 수
	private String goodid; // 추천한 아이디
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getGoodcnt() {
		return goodcnt;
	}
	public void setGoodcnt(int goodcnt) {
		this.goodcnt = goodcnt;
	}
	public String getGoodid() {
		return goodid;
	}
	public void setGoodid(String goodid) {
		this.goodid = goodid;
	}
}
