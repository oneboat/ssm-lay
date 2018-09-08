package com.panda.project.device.service;

import java.util.List;

import com.panda.project.device.model.Device;
import com.panda.project.device.model.DeviceDetail;

public interface DeviceService{

	List<Device> findPageDevices(String name, String address, int page, int rows);

	int findAllDevices();

	int findPartDevices(String name, String address);

	void addDevice(Device device);

	void editDevice(Device device);

	void deleteDevice(String ids);

	Device findDeviceByDvid(String dvid);

	List<DeviceDetail> getDeviceUseRecords(int page, int rows);
	
}
