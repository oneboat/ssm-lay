package com.panda.system.service;

import java.util.List;
import com.panda.system.model.Permission;

public interface PermissionService {

	List<Permission> findPagePermissions(String name, String plevel, int page, int rows);

	int findAllPermissions();

	int findPartPermissions(String name, String plevel);

	Permission findPermissionByPcode(String getpCode);

	void addPermission(Permission permission);

	void editPermission(Permission permission);


}
