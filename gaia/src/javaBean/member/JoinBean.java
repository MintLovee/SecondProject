package javaBean.member;

import java.util.Map;

public class JoinBean {

	private String ID;
	private String PASSWORD;
	private String CONFIRMPWD;
	private String NAME;
	private String ADDR;
	private String TEL;
	private String JUMIN;
	private String EMAIL;
	//private String NICKNAME;
	
	
	
	public void validate(Map<String, Boolean> errors) {
		checkEmpty(errors, ID, "ID");
		checkEmpty(errors, PASSWORD, "PASSWORD");
		checkEmpty(errors, CONFIRMPWD, "CONFIRMPWD");
		checkEmpty(errors, NAME, "NAME");
		//checkEmpty(errors, CONFIRMPWD, "CONFIRMPWD");
		
		if(!errors.containsKey("CONFIRMPWD")) {
			if(!isPasswordEqualToConfirm()) {
				errors.put("notMatch", Boolean.TRUE);
			}
		}
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
	public String getCONFIRMPWD() {
		return CONFIRMPWD;
	}
	public void setCONFIRMPWD(String cONFIRMPWD) {
		CONFIRMPWD = cONFIRMPWD;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getADDR() {
		return ADDR;
	}
	public void setADDR(String aDDR) {
		ADDR = aDDR;
	}
	public String getTEL() {
		return TEL;
	}
	public void setTEL(String tEL) {
		TEL = tEL;
	}
	public String getJUMIN() {
		return JUMIN;
	}
	public void setJUMIN(String jUMIN) {
		JUMIN = jUMIN;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public boolean isPasswordEqualToConfirm() {
		return PASSWORD!=null && PASSWORD.equals(CONFIRMPWD);
	}
	private void checkEmpty(Map<String, Boolean> errors, String value, String fieldName) {
		if(value == null || value.isEmpty()){
			errors.put(fieldName, Boolean.TRUE);
		}
	}
}
