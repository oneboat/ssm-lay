package com.panda.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
/**
 * 多角色自定义过滤
 * @DATE 2018年3月30日
 */
public class CustomRolesAuthorizationFilter  extends AuthorizationFilter{

	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		// TODO Auto-generated method stub
		Subject subject = getSubject(request, response);  
        String[] rolesArray = (String[]) mappedValue;  

        if (rolesArray == null || rolesArray.length == 0) 
        {  
            return true;  
        }  
        for(int i=0;i<rolesArray.length;i++)
        {
            if(subject.hasRole(rolesArray[i]))
            {  
                return true;  
            }  
        }  
        return false;  
	}

}
