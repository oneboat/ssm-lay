package com.panda.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.panda.system.model.Role;
import com.panda.system.model.User;


public interface UserMapper {

	User findUserPassword(@Param("username")String username);

	void addUser(@Param("map")Map<String, Object> map);

	User findUserById(@Param("id")int userid);

	List<User> findAllUsersByPage(@Param("map")Map<String, Object> map);

	List<User> findAllUsers();

	List<User> findPartUsers(@Param("map")Map<String, Object> map);

	void addUserOnly(@Param("user")User user);

	void deleteUser(@Param("ids")String[] ids);

	void bindRoleforUser(@Param("map")Map<String, Object> map);

	List<Role> findRolesByUid(@Param("uid")int uid);

	void addUserRoles(@Param("map")Map<String, Object> map);

	User findUserByUsername(@Param("username")String username);

	void deleteUserRoles(@Param("arrayStr")String[] arrayStr);

	void editUser(@Param("user")User user);

	void resetPassword(@Param("user")User user);

	int findUserRoles(@Param("arrayStr")String[] arrayStr);

}
