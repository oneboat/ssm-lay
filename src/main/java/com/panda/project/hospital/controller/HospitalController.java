package com.panda.project.hospital.controller;

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
import com.panda.project.hospital.model.Hospital;
import com.panda.project.hospital.service.HospitalService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/hospital")
public class HospitalController {
	@Resource
	private HospitalService hospitalService;
	
	@RequestMapping(value="/hospitalList",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object hospitalList(Map<String, Object> map,HttpServletRequest req,@RequestParam("page")int page,
			@RequestParam("limit")int rows) {
		String name=req.getParameter("name");
		String address = req.getParameter("address");
		List<Hospital> hlist = hospitalService.findPageHospitals(name,address,page,rows);
		JSONArray json = new JSONArray();
		for(Hospital h:hlist) {
			JSONObject jo = new JSONObject();
			jo.put("id", h.getId());
			jo.put("hpname",h.getHpname());
			jo.put("hpcode",h.getHpcode());
			jo.put("hptel",h.getHptel());
			jo.put("cardid",h.getCardid());
			jo.put("hpcontact",h.getHpcontact());
			jo.put("hpemail", h.getHpemail());
			jo.put("addressDetail", h.getAddressDetail());
			jo.put("createtime", h.getCreateTime());
			json.add(jo);
		}
		if((name == null || name == "") && (address == null || address == "")){
			int pAll = hospitalService.findAllHospitals();
			map.put("count", pAll);
		}else {
			int pPart = hospitalService.findPartHospitals(name,address);
			map.put("count", pPart);
		}
		map.put("data", json);
	    map.put("msg", null);
	    map.put("code", 0);
		return JSONObject.fromObject(map).toString();
	}
	//添加医院
		@RequestMapping(value="/addHospital",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
		public @ResponseBody String addHospital(Map<String, Object> map,Hospital hospital,HttpSession sessions){
			JSONObject jo = new JSONObject();
			try {
				hospitalService.addHospital(hospital);
				jo.put("msg", "新增成功！");
			}catch(Exception e) {
				jo.put("msg", "新增失败！");
			}
			return jo.toString();
		}
		//编辑医院
		@RequestMapping(value="/show/editHospital",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
		public @ResponseBody String editHospital(Map<String, Object> map,Hospital hospital,HttpSession sessions){
			JSONObject jo = new JSONObject();
			try {
				hospitalService.editHospital(hospital);
				jo.put("msg", "编辑成功！");
			}catch(Exception e) {
				jo.put("msg", "编辑失败！");
			}
			return jo.toString();
		}
		//删除医院
		@RequestMapping(value="/deleteHospital",method={RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
		public @ResponseBody String deleteHospital(Map<String, Object> map,Hospital hospital,HttpSession sessions,@RequestParam("ids")String ids){
			
			JSONObject jo = new JSONObject();
			try {
				hospitalService.deleteHospital(ids);
				jo.put("msg", "删除成功！");
			}catch(Exception e) {
				jo.put("msg", "删除失败！");
			}
			return jo.toString();
		}
		//获取所有医院
		@RequestMapping(value="/getHospitals",method={RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
		public @ResponseBody String getHospitals(Map<String, Object> map,HttpServletRequest req){
			List<Hospital> hList = hospitalService.getAllHospitals();
			JSONArray json = new JSONArray();
			for(Hospital h:hList) {
				JSONObject jo = new JSONObject();
				jo.put("id", h.getId());
				jo.put("hpname",h.getHpname());
				jo.put("hpcode",h.getHpcode());
				jo.put("hptel",h.getHptel());
				jo.put("cardid",h.getCardid());
				jo.put("hpcontact",h.getHpcontact());
				jo.put("hpemail", h.getHpemail());
				jo.put("addressDetail", h.getAddressDetail());
				jo.put("createtime", h.getCreateTime());
				json.add(jo);
			}
			map.put("count", hList.size());
			map.put("data", json);
		    map.put("msg", null);
		    map.put("code", 0);
			return JSONObject.fromObject(map).toString();
		}
}
