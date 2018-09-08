package com.panda.project.hospital.model;

import com.panda.system.model.BaseModel;

public class Hospital extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2243170104326943430L;
	private int id;
	private String hpname;
	private String hpcode;//医院代号，同医院登录名
	private String cardid;
	private String addressDetail;//医院详细地址
	private String hptel;//联系电话
	private String hpcontact;//联系人
	private String hpemail;//邮箱
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getHpname() {
		return hpname;
	}
	public void setHpname(String hpname) {
		this.hpname = hpname;
	}
	public String getHpcode() {
		return hpcode;
	}
	public void setHpcode(String hpcode) {
		this.hpcode = hpcode;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public String getHptel() {
		return hptel;
	}
	public void setHptel(String hptel) {
		this.hptel = hptel;
	}
	public String getHpcontact() {
		return hpcontact;
	}
	public void setHpcontact(String hpcontact) {
		this.hpcontact = hpcontact;
	}
	public String getHpemail() {
		return hpemail;
	}
	public void setHpemail(String hpemail) {
		this.hpemail = hpemail;
	}
	
	
}
