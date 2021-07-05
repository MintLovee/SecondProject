package javaBean.auth;

public class AuthBean {
	private String MEM_ID;
	private String MEM_NICKNAME;
	private String MEM_TEL;
	
	public AuthBean(String MEM_ID, String MEM_NICKNAME, String MEM_TEL) {
		this.MEM_ID = MEM_ID;
		this.MEM_NICKNAME = MEM_NICKNAME; 
		this.MEM_TEL = MEM_TEL;
	}

	public String getMEM_ID() {
		return MEM_ID;
	}

	public String getMEM_NICKNAME() {
		return MEM_NICKNAME;
	}

	public String getMEM_TEL() {
		return MEM_TEL;
	}
}