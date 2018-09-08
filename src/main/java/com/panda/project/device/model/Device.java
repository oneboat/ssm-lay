package com.panda.project.device.model;

import com.panda.system.model.BaseModel;

public class Device  extends BaseModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2900978064265335834L;
	private int id;
	private String dvid;//设备ID
	private String dvname;//设备名称
	private String dvtypecode;//设备型号
	private String dvtotaltime;//设备使用总时间
	private int dvtusetimes;//设备使用总时间
	private int dvbelong;//设备所属医院ID
	private String dvbelong_name;//设备所属医院名称
	private String app_version;//app版本
	private String android_version;//安卓系统
	private String MAC_address;//MAC地址
	private String ip_address;//ip地址
	private String sim_code;//sim卡号
	private String imei_code;//IEMI号
	private String brand_pad;//平板品牌
	
	public int getDvbelong() {
		return dvbelong;
	}
	public void setDvbelong(int dvbelong) {
		this.dvbelong = dvbelong;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDvid() {
		return dvid;
	}
	public void setDvid(String dvid) {
		this.dvid = dvid;
	}
	public String getDvname() {
		return dvname;
	}
	public void setDvname(String dvname) {
		this.dvname = dvname;
	}
	public String getDvtotaltime() {
		return dvtotaltime;
	}
	public void setDvtotaltime(String dvtotaltime) {
		this.dvtotaltime = dvtotaltime;
	}
	public String getDvtypecode() {
		return dvtypecode;
	}
	public void setDvtypecode(String dvtypecode) {
		this.dvtypecode = dvtypecode;
	}
	public String getApp_version() {
		return app_version;
	}
	public void setApp_version(String app_version) {
		this.app_version = app_version;
	}
	public String getAndroid_version() {
		return android_version;
	}
	public void setAndroid_version(String android_version) {
		this.android_version = android_version;
	}
	public String getMAC_address() {
		return MAC_address;
	}
	public void setMAC_address(String mAC_address) {
		MAC_address = mAC_address;
	}
	public String getIp_address() {
		return ip_address;
	}
	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}
	public String getSim_code() {
		return sim_code;
	}
	public void setSim_code(String sim_code) {
		this.sim_code = sim_code;
	}
	public String getImei_code() {
		return imei_code;
	}
	public void setImei_code(String imei_code) {
		this.imei_code = imei_code;
	}
	public String getBrand_pad() {
		return brand_pad;
	}
	public void setBrand_pad(String brand_pad) {
		this.brand_pad = brand_pad;
	}
	public String getDvbelong_name() {
		return dvbelong_name;
	}
	public void setDvbelong_name(String dvbelong_name) {
		this.dvbelong_name = dvbelong_name;
	}
	public int getDvtusetimes() {
		return dvtusetimes;
	}
	public void setDvtusetimes(int dvtusetimes) {
		this.dvtusetimes = dvtusetimes;
	}
	
}
