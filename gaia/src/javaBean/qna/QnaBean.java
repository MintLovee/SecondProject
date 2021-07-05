package javaBean.qna;

import java.sql.Date;
import java.sql.Time;

public class QnaBean {
	private int QNA_NUM;
	private String QNA_NAME;
	private String QNA_ID;
	private String QNA_SUBJECT;
	private String QNA_CONTENT;
	private int QNA_RE_NUM;
	private int QNA_RE_DEPTH;
	private String QNA_DATE;
	private Time QNA_TIME;
		
	private String QNA_CATEGORY;
	private int QNA_SECRET;
	
	private int FAQ_NUM;
	private String FAQ_Q;
	private String FAQ_A;
	
	public int getQNA_NUM() {
		return QNA_NUM;
	}
	public void setQNA_NUM(int qNA_NUM) {
		QNA_NUM = qNA_NUM;
	}
	public String getQNA_NAME() {
		return QNA_NAME;
	}
	public void setQNA_NAME(String qNA_NAME) {
		QNA_NAME = qNA_NAME;
	}
	public String getQNA_ID() {
		return QNA_ID;
	}
	public void setQNA_ID(String qNA_ID) {
		QNA_ID = qNA_ID;
	}
	public String getQNA_SUBJECT() {
		return QNA_SUBJECT;
	}
	public void setQNA_SUBJECT(String qNA_SUBJECT) {
		QNA_SUBJECT = qNA_SUBJECT;
	}
	public String getQNA_CONTENT() {
		return QNA_CONTENT;
	}
	public void setQNA_CONTENT(String qNA_CONTENT) {
		QNA_CONTENT = qNA_CONTENT;
	}
	public int getQNA_RE_NUM() {
		return QNA_RE_NUM;
	}
	public void setQNA_RE_NUM(int qNA_RE_NUM) {
		QNA_RE_NUM = qNA_RE_NUM;
	}
	public int getQNA_RE_DEPTH() {
		return QNA_RE_DEPTH;
	}
	public void setQNA_RE_DEPTH(int qNA_RE_DEPTH) {
		QNA_RE_DEPTH = qNA_RE_DEPTH;
	}
	public String getQNA_DATE() {
		return QNA_DATE;
	}
	public void setQNA_DATE(String qNA_DATE) {
		QNA_DATE = qNA_DATE;
	}
		
	public Time getQNA_TIME() {
		return QNA_TIME;
	}
	public void setQNA_TIME(Time qNA_TIME) {
		QNA_TIME = qNA_TIME;
	}
	public String getQNA_CATEGORY() {
		return QNA_CATEGORY;
	}
	public void setQNA_CATEGORY(String qNA_CATEGORY) {
		QNA_CATEGORY = qNA_CATEGORY;
	}
	public int getQNA_SECRET() {
		return QNA_SECRET;
	}
	public void setQNA_SECRET(int qNA_SECRET) {
		QNA_SECRET = qNA_SECRET;
	}
	public int getFAQ_NUM() {
		return FAQ_NUM;
	}
	public void setFAQ_NUM(int fAQ_NUM) {
		FAQ_NUM = fAQ_NUM;
	}
	public String getFAQ_Q() {
		return FAQ_Q;
	}
	public void setFAQ_Q(String fAQ_Q) {
		FAQ_Q = fAQ_Q;
	}
	public String getFAQ_A() {
		return FAQ_A;
	}
	public void setFAQ_A(String fAQ_A) {
		FAQ_A = fAQ_A;
	}
	
}
