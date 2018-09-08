package com.panda.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.panda.system.model.Role;


public interface RoleMapper {
	List<Role> findPageRoles(@Param("map")Map<String, Object> map);

	int findPartRoles(@Param("map")Map<String, Object> map);

	int findAllRolers();

	List<Role> findAllRoles();

	Role findRoleByRolecode(String rolecode);

	void addRole(@Param("role")Role role);

	void editRole(@Param("role")Role role);
}
