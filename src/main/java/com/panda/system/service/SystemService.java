package com.panda.system.service;

import java.util.List;
import java.util.Set;

import com.panda.system.model.Permission;
import com.panda.system.model.Role;
public interface SystemService {

	Permission getRoorPermission();

	List<Permission> findPersById(int id);

	List<Permission> findPersonalPersById(int mid);

	int findPersonalPer(int rid, String mid);

	void addRolePers(int rid, String mid);

	void changePers(int rid, String ids);
	
	List<Role> findAllRolePers(String url);

	List<Permission> findAllPers();

	Set<String> getRolesByUsername(String userName);

	Set<String> getPersByUsername(String userName);

	/*User getUserByUsername(String userName);*/

}
