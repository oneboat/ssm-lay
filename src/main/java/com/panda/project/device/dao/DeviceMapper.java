package com.panda.project.device.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.panda.project.device.model.Device;
import com.panda.project.device.model.DeviceDetail;

public interface DeviceMapper {

	List<Device> findPageDevices(@Param("map")Map<String, Object> map);

	int findAllDevices();

	int findPartDevices(@Param("map")Map<String, Object> map);

	void addDevice(@Param("device")Device device);

	void editDevice(@Param("device")Device device);

	void deleteDevice(@Param("ids")int[] ids);

	Device findDeviceByDvid(@Param("dvid")String dvid);

	List<DeviceDetail> getDeviceUseRecords(@Param("map")Map<String, Object> map);

}
