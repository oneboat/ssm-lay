package com.panda.project.device.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.panda.project.device.dao.DeviceMapper;
import com.panda.project.device.model.Device;
import com.panda.project.device.model.DeviceDetail;
import com.panda.project.device.service.DeviceService;
@Service("deviceService")
public class DeviceServiceImpl implements DeviceService {
	@Autowired
	private DeviceMapper deviceMapper;
	@Override
	public List<Device> findPageDevices(String name, String dvtypecode, int page, int rows) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("dvtypecode", dvtypecode);
		map.put("name", name);
		map.put("start", rows*(page-1));
		map.put("end", rows);
		return deviceMapper.findPageDevices(map);
	}

	@Override
	public int findAllDevices() {
		// TODO Auto-generated method stub
		return deviceMapper.findAllDevices();
	}

	@Override
	public int findPartDevices(String name, String dvtypecode) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name", name);
		map.put("dvtypecode", dvtypecode);
		return deviceMapper.findPartDevices(map);
	}

	@Override
	public void addDevice(Device device) {
		// TODO Auto-generated method stub
		deviceMapper.addDevice(device);
	}

	@Override
	public void editDevice(Device device) {
		// TODO Auto-generated method stub
		deviceMapper.editDevice(device);
	}

	@Override
	public void deleteDevice(String ids) {
		// TODO Auto-generated method stub
		String [] arrayStr = ids.split(",");
		int[] arrInt = new int[arrayStr.length];
		for(int i=0;i<arrayStr.length;i++) {
			arrInt[i] = Integer.parseInt(arrayStr[i]);
		}
		deviceMapper.deleteDevice(arrInt);
	}

	@Override
	public Device findDeviceByDvid(String dvid) {
		// TODO Auto-generated method stub
		return deviceMapper.findDeviceByDvid(dvid);
	}

	@Override
	public List<DeviceDetail> getDeviceUseRecords(int page, int rows) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("start", rows*(page-1));
		map.put("end", rows);
		return deviceMapper.getDeviceUseRecords(map);
	}

}
