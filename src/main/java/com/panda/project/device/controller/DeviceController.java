package com.panda.project.device.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.panda.project.device.service.DeviceService;
import com.panda.project.device.model.Device;
import com.panda.project.device.model.DeviceDetail;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/device")
public class DeviceController {
	@Resource
	private DeviceService deviceService;
	//设备列表
	@RequestMapping(value="/deviceList",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object roleList(Map<String, Object> map,HttpServletRequest req,@RequestParam("page")int page,
			@RequestParam("limit")int rows) {
		String name=req.getParameter("name");
		String address = req.getParameter("address");
		List<Device> dlist = deviceService.findPageDevices(name,address,page,rows);
		JSONArray json = new JSONArray();
		for(Device d:dlist) {
			JSONObject jo = new JSONObject();
			jo.put("id", d.getId());
			jo.put("dvid", d.getDvid());
			jo.put("dvname", d.getDvname());
			jo.put("dvtypecode", d.getDvtypecode());
			jo.put("dvtotaltime", d.getDvtotaltime());
			jo.put("dvbelong", d.getDvbelong());
			jo.put("dvbelong_name", d.getDvbelong_name());
			jo.put("MAC_address", d.getMAC_address());
			jo.put("ip_address", d.getIp_address());
			jo.put("android_version", d.getAndroid_version());
			jo.put("app_version", d.getApp_version());
			jo.put("brand_pad", d.getBrand_pad());
			jo.put("sim_code", d.getSim_code());
			jo.put("imei_code", d.getImei_code());
			json.add(jo);
		}
		if((name == null || name == "") && (address == null || address == "")){
			int pAll = deviceService.findAllDevices();
			map.put("count", pAll);
		}else {
			int pPart = deviceService.findPartDevices(name,address);
			map.put("count", pPart);
		}
		map.put("data", json);
	    map.put("msg", null);
	    map.put("code", 0);
		return JSONObject.fromObject(map).toString();
	}
	//添加设备
	@RequestMapping(value="/addDevice",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
	public @ResponseBody String addUser(Map<String, Object> map,Device device,HttpSession sessions){
		JSONObject jo = new JSONObject();
		Device device_0 = deviceService.findDeviceByDvid(device.getDvid());
		if(device_0 != null) {
			jo.put("msg", "设备ID已经存在，请确认无误后提交！");
		}else {
			try {
				deviceService.addDevice(device);
				jo.put("msg", "新增成功！");
			}catch(Exception e) {
				jo.put("msg", "新增失败！");
			}
		}
		return jo.toString();
	}
	//编辑设备
	@RequestMapping(value="/show/editDevice",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
	public @ResponseBody String editUser(Map<String, Object> map,Device device,HttpSession sessions){
		JSONObject jo = new JSONObject();
		try {
			deviceService.editDevice(device);
			jo.put("msg", "编辑成功！");
		}catch(Exception e) {
			jo.put("msg", "编辑失败！");
		}
		return jo.toString();
	}
	//删除设备
	@RequestMapping(value="/deleteDevice",method={RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	public @ResponseBody String deleteUser(Map<String, Object> map,Device device,HttpSession sessions,@RequestParam("ids")String ids){
		
		JSONObject jo = new JSONObject();
		try {
			deviceService.deleteDevice(ids);
			jo.put("msg", "删除成功！");
		}catch(Exception e) {
			jo.put("msg", "删除失败！");
		}
		return jo.toString();
	}
	//设备使用记录
	@RequestMapping(value="/deviceInfoList",method={RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	public @ResponseBody String deviceInfoList(Map<String, Object> map,@RequestParam("page")int page,
			@RequestParam("limit")int rows){
		List<DeviceDetail> dList = deviceService.getDeviceUseRecords(page,rows);
		JSONArray json = new JSONArray();
		for(DeviceDetail d:dList) {
			JSONObject jo = new JSONObject();
			jo.put("id", d.getId());
			jo.put("dvid", d.getDvid());
			jo.put("starttime", d.getStartTime());
			jo.put("endtime", d.getEndTime());
			jo.put("usednum", d.getUsed_num());
			json.add(jo);
		}
		map.put("data", json);
	    map.put("msg", null);
	    map.put("code", 0);
	    map.put("count", dList.size());
		return JSONObject.fromObject(map).toString();
	}
}
