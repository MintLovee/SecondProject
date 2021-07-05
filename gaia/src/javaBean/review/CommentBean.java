package javaBean.review;

import java.sql.Date;

public class CommentBean {
	
	private int RE_NUM;
	private String RE_ID;
	private String RE_NICKNAME;
	private String RE_CONTENT;
	private Date RE_DATE;
	private int RE_PT_NUM;
	
	
	public int getRE_NUM() {
		return RE_NUM;
	}
	public void setRE_NUM(int rE_NUM) {
		RE_NUM = rE_NUM;
	}
	public String getRE_ID() {
		return RE_ID;
	}
	public void setRE_ID(String rE_ID) {
		RE_ID = rE_ID;
	}
	public String getRE_NICKNAME() {
		return RE_NICKNAME;
	}
	public void setRE_NICKNAME(String rE_NICKNAME) {
		RE_NICKNAME = rE_NICKNAME;
	}
	public String getRE_CONTENT() {
		return RE_CONTENT;
	}
	public void setRE_CONTENT(String rE_CONTENT) {
		RE_CONTENT = rE_CONTENT;
	}
	public Date getRE_DATE() {
		return RE_DATE;
	}
	public void setRE_DATE(Date rE_DATE) {
		RE_DATE = rE_DATE;
	}
	public int getRE_PT_NUM() {
		return RE_PT_NUM;
	}
	public void setRE_PT_NUM(int rE_PT_NUM) {
		RE_PT_NUM = rE_PT_NUM;
	}
	
}
