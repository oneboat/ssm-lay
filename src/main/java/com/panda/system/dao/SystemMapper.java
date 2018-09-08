package com.panda.system.dao;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.panda.system.model.Permission;
import com.panda.system.model.Role;
import com.panda.system.model.User;


public interface SystemMapper {

	int findAllPermissions();

	List<Permission> findPagePermissions(@Param("map")Map<String, Object> map);

	int findPartPermissions(@Param("map")Map<String, Object> map);

	int findAllUsers();

	List<User> findPageUsers(@Param("map")Map<String, Object> map);

	int findPartUsers(@Param("map")Map<String, Object> map);

	List<Role> findPageRoles(@Param("map")Map<String, Object> map);

	int findPartRoles(@Param("map")Map<String, Object> map);

	Permission getRoorPermission();

	List<Permission> findPersById(int id);

	List<Permission> findPersonalPersById(int mid);

	int findPersonalPer(@Param("map")Map<String, Object> map);

	Object addRolePers(@Param("map")Map<String, Object> map);

	void updateRolePers1(@Param("map")Map<String, Object> map);
	
	void updateRolePers0(int rid);

	List<Role> findAllRolePers(String url);

	List<Permission> findAllPers();

	Set<String> getRolesByUsername(String userName);

	Set<String> getPersByUsername(String userName);

	/*User getUserByUsername(String userName);*/
}
