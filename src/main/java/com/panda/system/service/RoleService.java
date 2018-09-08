package com.panda.system.service;

import java.util.List;

import com.panda.system.model.Role;

public interface RoleService {

	List<Role> findPageRoles(String name, String level, int page, int rows);

	int findAllRolers();

	int findPartRoles(String name, String level);

	List<Role> findAllRoles();

	Role findRoleByRolecode(String rolecode);

	void addRole(Role role);

	void editRole(Role role);

}
