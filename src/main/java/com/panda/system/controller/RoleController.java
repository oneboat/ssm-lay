package com.panda.system.controller;

import java.util.Date;
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

import com.panda.system.model.Role;
import com.panda.system.service.RoleService;
import com.panda.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Resource
	private RoleService roleService;
	@RequestMapping(value="/roleList",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object roleList(Map<String, Object> map,HttpServletRequest req,@RequestParam("page")int page,
			@RequestParam("limit")int rows) {
		String name=req.getParameter("name");
		String level = req.getParameter("level");
		List<Role> rlist = roleService.findPageRoles(name,level,page,rows);
		JSONArray json = new JSONArray();
		for(Role r:rlist) {
			JSONObject jo = new JSONObject();
			jo.put("id", r.getId());
			jo.put("rname", r.getRolename());
			jo.put("rcode", r.getRolecode());
			jo.put("rlevel", r.getLevel());
			jo.put("status", r.getStatus());
			jo.put("createtime", r.getCreateTime());
			jo.put("pid", r.getPid());
			json.add(jo);
		}
		if((name == null || name == "") && (level == null || level == "")){
			int pAll = roleService.findAllRolers();
			map.put("count", pAll);
		}else {
			int pPart = roleService.findPartRoles(name,level);
			map.put("count", pPart);
		}
		map.put("data", json);
	    map.put("msg", null);
	    map.put("code", 0);
		return JSONObject.fromObject(map).toString();
	}
	//添加角色
	@RequestMapping(value="/addRole",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
	public @ResponseBody String addUser(Map<String, Object> map,Role role,HttpSession sessions){
		JSONObject jo = new JSONObject();
		Role role_0 = roleService.findRoleByRolecode(role.getRolecode());
		if(role_0 == null) {
			jo.put("msg", "角色代号已存在，请重新输入！");
		}else {
			try {
				role.setCreateTime(StringUtil.getStrByDate(new Date()));
				roleService.addRole(role);
				jo.put("msg", "新增成功！");
			}catch(Exception e) {
				jo.put("msg", "新增失败！");
			}
		}
		return jo.toString();
	}
	//编辑角色
	@RequestMapping(value="/show/editRole",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
	public @ResponseBody String editUser(Map<String, Object> map,Role role,HttpSession sessions){
		JSONObject jo = new JSONObject();
		try {
			role.setUpdateTime(StringUtil.getStrByDate(new Date()));
			roleService.editRole(role);
			jo.put("msg", "编辑成功！");
		}catch(Exception e) {
			jo.put("msg", "编辑失败！");
		}
		return jo.toString();
	}
}
