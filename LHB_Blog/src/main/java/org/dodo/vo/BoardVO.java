package org.dodo.vo;

import java.util.*;

//°Ô½ÃÆÇ
public class BoardVO {

	private List<BoardListVO> Blist;
	private List<BfileVO> Bflist;
	private List<GoodVO> Glist;
	private List<NoticeVO> Nlist;
	private List<BoardListVO> Clist;
	
	
	public List<BoardListVO> getClist() {
		return Clist;
	}
	public void setClist(List<BoardListVO> clist) {
		Clist = clist;
	}
	public List<BoardListVO> getBlist() {
		return Blist;
	}
	public void setBlist(List<BoardListVO> blist) {
		Blist = blist;
	}
	public List<BfileVO> getBflist() {
		return Bflist;
	}
	public void setBflist(List<BfileVO> bflist) {
		Bflist = bflist;
	}
	public List<GoodVO> getGlist() {
		return Glist;
	}
	public void setGlist(List<GoodVO> glist) {
		Glist = glist;
	}
	public List<NoticeVO> getNlist() {
		return Nlist;
	}
	public void setNlist(List<NoticeVO> nlist) {
		Nlist = nlist;
	}
	
	

}
