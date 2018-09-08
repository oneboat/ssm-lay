package com.panda.system.model;

public class Permission  extends BaseModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 830138610070255536L;
	private int id;
	private String pName;
	private String pCode;
	private int pid;
	private int plevel;
	private String url;
	private String pa_pname;
	private String pa_pcode;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpCode() {
		return pCode;
	}
	public void setpCode(String pCode) {
		this.pCode = pCode;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getPlevel() {
		return plevel;
	}
	public void setPlevel(int plevel) {
		this.plevel = plevel;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPa_pname() {
		return pa_pname;
	}
	public String getPa_pcode() {
		return pa_pcode;
	}
	public void setPa_pname(String pa_pname) {
		this.pa_pname = pa_pname;
	}
	public void setPa_pcode(String pa_pcode) {
		this.pa_pcode = pa_pcode;
	}
	
}
