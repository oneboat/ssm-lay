package com.panda.system.model;

import java.io.Serializable;

public class BaseModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String createTime;
	protected String updateTime;
	protected int status;
	protected String remark;
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public int getStatus() {
		return status;
	}
	public String getRemark() {
		return remark;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
