package com.panda.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.panda.system.dao.PermissionMapper;
import com.panda.system.model.Permission;
import com.panda.system.service.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService{
	@Resource
	private PermissionMapper permissionMapper;
	public int findAllPermissions() {
		// TODO Auto-generated method stub
		return this.permissionMapper.findAllPermissions();
	}

	public List<Permission> findPagePermissions(String name, String plevel, int page, int rows) {
		Map<String,Object> map = new HashMap<String, Object>();
		if(plevel != null && plevel.trim() != "") {
			map.put("plevel", Integer.valueOf(plevel));
		}else {
			map.put("plevel",null);
		}
		map.put("name", name);
		map.put("start", rows*(page-1));
		map.put("end", rows);
		return this.permissionMapper.findPagePermissions(map);
	}

	public int findPartPermissions(String name, String plevel) {
		Map<String,Object> map = new HashMap<String, Object>();
		if(plevel != null && plevel.trim() != "") {
			map.put("plevel", Integer.valueOf(plevel));
		}else {
			map.put("plevel",null);
		}
		map.put("name", name);
		// TODO Auto-generated method stub
		return this.permissionMapper.findPartPermissions(map);
	}

	@Override
	public Permission findPermissionByPcode(String getpCode) {
		// TODO Auto-generated method stub
		return permissionMapper.findPermissionByPcode(getpCode);
	}

	@Override
	public void addPermission(Permission permission) {
		// TODO Auto-generated method stub
		permissionMapper.addPermission(permission);
	}

	@Override
	public void editPermission(Permission permission) {
		// TODO Auto-generated method stub
		permissionMapper.editPermission(permission);
	}
}
