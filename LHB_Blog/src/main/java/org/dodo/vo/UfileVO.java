package org.dodo.vo;

import java.util.Date;

//����
public class UfileVO {
	private String id;
	private int num;   //�� ��ȣ
	private String ufname1; //���� ���ϸ�
	private String ufname2; //�ٲ� ���ϸ�
	private long ufsize; // ���� ũ��
	private String ufdate; //���� �ø� ��¥ (���ε� ����)
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUfname1() {
		return ufname1;
	}
	public void setUfname1(String ufname1) {
		this.ufname1 = ufname1;
	}
	public String getUfname2() {
		return ufname2;
	}
	public void setUfname2(String ufname2) {
		this.ufname2 = ufname2;
	}
	public long getUfsize() {
		return ufsize;
	}
	public void setUfsize(long ufsize) {
		this.ufsize = ufsize;
	}
	public String getUfdate() {
		return ufdate;
	}
	public void setUfdate(String ufdate) {
		this.ufdate = ufdate;
	}
	
	
}
