package com.panda.project.device.model;

import java.util.Date;

import com.panda.system.model.BaseModel;

@SuppressWarnings("serial")
public class DeviceDetail extends BaseModel{
	private int id;
	private String dvid;
	private Date startTime;
	private Date endTime;
	private int used_num;
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
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public int getUsed_num() {
		return used_num;
	}
	public void setUsed_num(int used_num) {
		this.used_num = used_num;
	}
	
}
