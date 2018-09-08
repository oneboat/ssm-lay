package com.panda.system.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.panda.system.dao.UserMapper;
import com.panda.system.model.Role;
import com.panda.system.model.User;
import com.panda.system.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource
	private UserMapper userMapper;

	@Override
	public User findUserPassword(String username) {
		// TODO Auto-generated method stub
		return this.userMapper.findUserPassword(username);
	}

	@Override
	public void addUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
			this.userMapper.addUser(map);
			
	}

	@Override
	public User findUserById(int userid) {
		// TODO Auto-generated method stub
		return this.userMapper.findUserById(userid);
	}

	@Override
	public List<User> findAllUsersByPage(int rows, int page, String name, String address) {
		Map<String,Object> map = new HashMap<String,Object>();
		int start = (page-1)*rows;
		map.put("start", start);
		map.put("rows", rows);
		map.put("name", name);
		map.put("address", address);
		return this.userMapper.findAllUsersByPage(map);
	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return this.userMapper.findAllUsers();
	}

	@Override
	public List<User> findPartUsers(String name, String address) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name", name);
		map.put("address", address);
		return this.userMapper.findPartUsers(map);
	}

	@Override
	public void addUser(User user) {
		// TODO Auto-generated method stub
		this.userMapper.addUserOnly(user);
		if(user.getIdentnum() != null && user.getIdentnum() != "") {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("uid", user.getId());
			map.put("rid", Integer.valueOf(user.getIdentnum()));
			map.put("createtime", new java.sql.Date(new Date().getTime()));
			this.userMapper.addUserRoles(map);
		}
	}

	@Override
	public void deleteUser(String ids) {
		// TODO Auto-generated method stub
		String [] arrayStr = ids.split(",");
		//删除用户
		this.userMapper.deleteUser(arrayStr);
	}

	@Override
	public void bindRoleforUser(int uid, int rid) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uid", uid);
		map.put("rid", rid);
		map.put("createtime", new java.sql.Date(new Date().getTime()));
		this.userMapper.bindRoleforUser(map);
	}

	@Override
	public List<Role> findRolesByUid(int uid) {
		// TODO Auto-generated method stub
		return this.userMapper.findRolesByUid(uid);
	}

	@Override
	public User findUserByUsername(String username) {
		// TODO Auto-generated method stub
		return this.userMapper.findUserByUsername(username);
	}

	@Override
	public void deleteUserRoles(String ids) {
		// TODO Auto-generated method stub
		String [] arrayStr = ids.split(",");
		//删除外键的角色信息
		this.userMapper.deleteUserRoles(arrayStr);
	}

	@Override
	public void editUser(User user) {
		// TODO Auto-generated method stub
		this.userMapper.editUser(user);
	}

	@Override
	public void resetPassword(User user) {
		// TODO Auto-generated method stub
		this.userMapper.resetPassword(user);
	}

	@Override
	public int findUserRoles(String ids) {
		// TODO Auto-generated method stub
		String [] arrayStr = ids.split(",");
		//删除外键的角色信息
		return this.userMapper.findUserRoles(arrayStr);
	}
}
