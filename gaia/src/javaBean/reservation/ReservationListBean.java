package javaBean.reservation;

import java.sql.Date;

public class ReservationListBean {
	private int REZ_NUM;
	private String REZ_ID;
	private String REZ_NAME;
	private String REZ_TEL;
	private String REZ_PNUM;
	private Date REZ_INDATE;
	private Date REZ_OUTDATE;
	private String REZ_DIFFDAYS;
	private int REZ_PRICE;
	private int REZ_TOTAL;
	
	public int getREZ_NUM() {
		return REZ_NUM;
	}
	public void setREZ_NUM(int rEZ_NUM) {
		REZ_NUM = rEZ_NUM;
	}
	public String getREZ_ID() {
		return REZ_ID;
	}
	public void setREZ_ID(String rEZ_ID) {
		REZ_ID = rEZ_ID;
	}
	public String getREZ_NAME() {
		return REZ_NAME;
	}
	public void setREZ_NAME(String rEZ_NAME) {
		REZ_NAME = rEZ_NAME;
	}
	public String getREZ_TEL() {
		return REZ_TEL;
	}
	public void setREZ_TEL(String rEZ_TEL) {
		REZ_TEL = rEZ_TEL;
	}
	public String getREZ_PNUM() {
		return REZ_PNUM;
	}
	public void setREZ_PNUM(String rEZ_PNUM) {
		REZ_PNUM = rEZ_PNUM;
	}
	public Date getREZ_INDATE() {
		return REZ_INDATE;
	}
	public void setREZ_INDATE(Date rEZ_INDATE) {
		REZ_INDATE = rEZ_INDATE;
	}
	public Date getREZ_OUTDATE() {
		return REZ_OUTDATE;
	}
	public void setREZ_OUTDATE(Date rEZ_OUTDATE) {
		REZ_OUTDATE = rEZ_OUTDATE;
	}
	public String getREZ_DIFFDAYS() {
		return REZ_DIFFDAYS;
	}
	public void setREZ_DIFFDAYS(String rEZ_DIFFDAYS) {
		REZ_DIFFDAYS = rEZ_DIFFDAYS;
	}
	public int getREZ_PRICE() {
		return REZ_PRICE;
	}
	public void setREZ_PRICE(int rEZ_PRICE) {
		REZ_PRICE = rEZ_PRICE;
	}
	public int getREZ_TOTAL() {
		return REZ_TOTAL;
	}
	public void setREZ_TOTAL(int rEZ_TOTAL) {
		REZ_TOTAL = rEZ_TOTAL;
	}
}
