package com.panda.system.controller;

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

import com.panda.system.model.Permission;
import com.panda.system.service.PermissionService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/permission")
public class PermissionsController {
	@Resource
	private PermissionService permissionService;
	@RequestMapping(value="/perList",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object perList(Map<String, Object> map,HttpServletRequest req,@RequestParam("page")int page,@RequestParam("limit")int rows) {
		String name=req.getParameter("name");
		String plevel = req.getParameter("plevel");
		List<Permission> plist = permissionService.findPagePermissions(name,plevel,page,rows);
		JSONArray json = new JSONArray();
		for(Permission p:plist) {
			JSONObject jo = new JSONObject();
			jo.put("pname", p.getpName());
			jo.put("pcode", p.getpCode());
			jo.put("plevel", p.getPlevel());
			jo.put("purl", p.getUrl());
			jo.put("pid", p.getPid());
			jo.put("createtime", p.getCreateTime());
			jo.put("id", p.getId());
			json.add(jo);
		}
		if((name == null || name == "") && (plevel == null || plevel == "")){
			int pAll = permissionService.findAllPermissions();
			map.put("count", pAll);
		}else {
			int pPart = permissionService.findPartPermissions(name,plevel);
			map.put("count", pPart);
		}
		map.put("data", json);
	    map.put("msg", null);
	    map.put("code", 0);
		return JSONObject.fromObject(map).toString();
	}
	//添加权限
	@RequestMapping(value="/addNewPermission",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
	public @ResponseBody String addPermission(Map<String, Object> map,Permission permission,HttpSession sessions){
		JSONObject jo = new JSONObject();
		Permission permission_0 = permissionService.findPermissionByPcode(permission.getpCode());
		if(permission_0 != null) {
			jo.put("msg", "权限代号已存在，请重新输入！");
		}else {
			try {
				permissionService.addPermission(permission);
				jo.put("msg", "新增成功！");
			}catch(Exception e) {
				jo.put("msg", "新增失败！");
			}
		}
		return jo.toString();
	}
	//编辑权限
	@RequestMapping(value="/editPermission",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
	public @ResponseBody String editPermission(Map<String, Object> map,Permission permission,HttpSession sessions){
		JSONObject jo = new JSONObject();
		try {
			permissionService.editPermission(permission);
			jo.put("msg", "编辑成功！");
		}catch(Exception e) {
			jo.put("msg", "编辑失败！");
		}
		return jo.toString();
	}
	
	
}
