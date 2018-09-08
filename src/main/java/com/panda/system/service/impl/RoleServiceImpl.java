package com.panda.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.panda.system.dao.RoleMapper;
import com.panda.system.model.Role;
import com.panda.system.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService{
	@Resource
	private RoleMapper roleMapper;
	@Override
	public List<Role> findPageRoles(String name, String level, int page, int rows) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("level", level);
		map.put("name", name);
		map.put("start", rows*(page-1));
		map.put("end", rows);
		return roleMapper.findPageRoles(map);
	}
	@Override
	public int findAllRolers() {
		// TODO Auto-generated method stub
		return roleMapper.findAllRolers();
	}
	@Override
	public int findPartRoles(String name, String level) {
		Map<String,Object> map = new HashMap<String, Object>();
		if(level != null && level.trim() != "") {
			map.put("level", Integer.valueOf(level));
		}else {
			map.put("level",null);
		}
		map.put("name", name);
		// TODO Auto-generated method stub
		return roleMapper.findPartRoles(map);
	}
	@Override
	public List<Role> findAllRoles() {
		// TODO Auto-generated method stub
		return roleMapper.findAllRoles();
	}
	@Override
	public Role findRoleByRolecode(String rolecode) {
		// TODO Auto-generated method stub
		return roleMapper.findRoleByRolecode(rolecode);
	}
	@Override
	public void addRole(Role role) {
		// TODO Auto-generated method stub
		roleMapper.addRole(role);
	}
	@Override
	public void editRole(Role role) {
		// TODO Auto-generated method stub
		roleMapper.editRole(role);
	}
}
