package com.panda.shiro;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.spring.web.ShiroFilterFactoryBean;

import com.panda.system.model.Permission;
import com.panda.system.model.Role;
import com.panda.system.service.SystemService;


public class MyFilterChains extends ShiroFilterFactoryBean{
    @Resource
	private SystemService systemService;
	@Override
	public void setFilterChainDefinitionMap(Map<String, String> filterChainDefinitionMap) {
		 Map<String, String> filterMap = new HashMap<>();
		 filterMap.put("/admin/**", "authc");
		 filterMap.put("/login.jsp", "anon");
		 filterMap.put("/show/addStudent.do", "perms[P001_002_001_add]");
		 filterMap.put("/system/**", "roleOrFilter[R001,R002]");
        List<Permission> plist = systemService.findAllPers();
        for(Permission per:plist) {
        	String roles = "roleOrFilter[";
        	List<Role> rolelist = systemService.findAllRolePers(per.getUrl());
        	for(Role role:rolelist) {
        		roles+=role.getRolecode()+",";
        	}
        	roles = roles.substring(0,roles.length()-1);
        	roles+="]";
        	filterMap.put(per.getUrl(), roles);
        }
//        filterMap.put("/**", "anon");
		super.setFilterChainDefinitionMap(filterMap);
	}
}
