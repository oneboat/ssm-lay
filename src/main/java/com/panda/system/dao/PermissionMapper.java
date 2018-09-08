package com.panda.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.panda.system.model.Permission;

public interface PermissionMapper {

	int findAllPermissions();

	List<Permission> findPagePermissions(@Param("map")Map<String, Object> map);

	int findPartPermissions(@Param("map")Map<String, Object> map);

	Permission findPermissionByPcode(@Param("pCode")String pCode);

	void addPermission(@Param("permission")Permission permission);

	void editPermission(@Param("permission")Permission permission);
}
