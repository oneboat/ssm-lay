package com.panda.system.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.panda.system.model.Permission;
import com.panda.system.service.SystemService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 系统管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/system")
public class SystemController {
	@Resource
	private SystemService systemService;
	
	@RequestMapping(value="/getRootPermission",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object getRootPermission(Map<String, Object> map,HttpSession sessions,HttpServletRequest req) {
		Permission rootPer = systemService.getRoorPermission();
		JSONObject jo = new JSONObject();
		jo.put("id", rootPer.getId());
		jo.put("pname", rootPer.getpName());
		jo.put("pcode", rootPer.getpCode());
		jo.put("pid", rootPer.getPid());
		jo.put("url",rootPer.getUrl());
		return jo.toString();
	}
	@RequestMapping(value="/getChildrenPers",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object getChildrenPers(Map<String, Object> map,HttpSession sessions,HttpServletRequest req) {
		int id = Integer.valueOf(req.getParameter("id")==null?"0":req.getParameter("id"));
		List<Permission> flist = systemService.findPersById(id);
		JSONArray json = new JSONArray();
		for(Permission per:flist) {
			String flag = "open"; 
			JSONObject jo = new JSONObject();
			List<Permission> pflist = systemService.findPersById(per.getId());
			if(pflist.size()>0) {
				flag = "closed";
			}
			jo.put("per_flag", flag);
			jo.put("per_id", per.getId());
			jo.put("per_name", per.getpName());
			jo.put("per_code", per.getpCode());
			jo.put("per_url", per.getUrl());
			jo.put("pid",per.getPid());
			json.add(jo);
		}
		map.put("value", json);
		map.put("size", flist.size());
		return JSONObject.fromObject(map).toString();
	}
	@RequestMapping(value="/getPersonalPers",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object getPersonalPers(Map<String, Object> map,HttpSession sessions,HttpServletRequest req) {
		int mid = Integer.valueOf(req.getParameter("id")==null?"0":req.getParameter("id")==""?"0":req.getParameter("id"));
		List<Permission> flist = systemService.findPersonalPersById(mid);
		JSONArray json = new JSONArray();
		for(Permission per:flist) {
			JSONObject jo = new JSONObject();
			jo.put("per_id", per.getId());
			jo.put("per_name", per.getpName());
			jo.put("per_code", per.getpCode());
			jo.put("per_url", per.getUrl());
			jo.put("pid",per.getPid());
			json.add(jo);
		}
		map.put("value", json);
		map.put("size", flist.size());
		return JSONObject.fromObject(map).toString();
	}
	//为角色赋权
	@RequestMapping(value="/addPersonalPers",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody String addPersonalPers(Map<String, Object> map,HttpSession sessions,HttpServletRequest req) {
		JSONObject jo = new JSONObject();
		int rid = Integer.valueOf(req.getParameter("id")==null?"0":req.getParameter("id")==""?"0":req.getParameter("id"));
		String ids = req.getParameter("ids");
		systemService.changePers(rid, ids);
		jo.put("msg", "分配权限操作完成！");
		return jo.toString();
	}
}
