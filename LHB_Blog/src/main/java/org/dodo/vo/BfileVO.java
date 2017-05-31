package org.dodo.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

//게시판 파일
public class BfileVO {
	private int num;// 번호
	private String fname1; // 원본 파일명
	private String fname2; // 바뀐 파일명
	private long fsize; // 파일 크기
	private String fdate; // 올린 날짜
	private List<MultipartFile> files; //멀티파트파일
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getFname1() {
		return fname1;
	}
	public void setFname1(String fname1) {
		this.fname1 = fname1;
	}
	public String getFname2() {
		return fname2;
	}
	public void setFname2(String fname2) {
		this.fname2 = fname2;
	}
	public long getFsize() {
		return fsize;
	}
	public void setFsize(long fsize) {
		this.fsize = fsize;
	}
	
	public String getFdate() {
		return fdate;
	}
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	
}
