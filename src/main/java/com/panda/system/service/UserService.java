package com.panda.system.service;

import java.util.List;
import java.util.Map;

import com.panda.system.model.Role;
import com.panda.system.model.User;


public interface UserService {

	User findUserPassword(String username);

	void addUser(Map<String, Object> map);

	User findUserById(int userid);

	List<User> findAllUsersByPage(int rows, int page, String name, String address);

	List<User> getAllUsers();

	List<User> findPartUsers(String name, String address);

	void addUser(User user);

	void deleteUser(String ids);

	void bindRoleforUser(int uid, int rid);

	List<Role> findRolesByUid(int uid);

	User findUserByUsername(String username);

	void deleteUserRoles(String ids);

	void editUser(User user);

	void resetPassword(User user);

	int findUserRoles(String ids);

}
