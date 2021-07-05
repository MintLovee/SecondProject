package javaBean.member;

public class UserBean {
	private String ID;
	private String PASSWORD;
	
	public UserBean(String ID, String PASSWORD) {
		this.ID = ID;
		this.PASSWORD = PASSWORD;
		}

		public String getID() {
			return ID;
		}

		public void setID(String iD) {
			ID = iD;
		}

		public String getPASSWORD() {
			return PASSWORD;
		}	

		public void setPASSWORD(String pASSWORD) {
			PASSWORD = pASSWORD;
		}

	}
