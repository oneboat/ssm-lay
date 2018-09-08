package com.panda.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.filter.mgt.PathMatchingFilterChainResolver;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.springframework.stereotype.Controller;

import com.panda.shiro.MyFilterChains;
import com.panda.system.model.Permission;
import com.panda.system.model.Role;
import com.panda.system.service.SystemService;

import net.sf.json.JSONObject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/filter")
public class FilterManageController {
	Logger logger = Logger.getLogger(FilterManageController.class);

    //加载自定义的拦截工厂
	@Resource
    private MyFilterChains MyFilterChains;
    @Resource
	private SystemService service;

    @RequestMapping(value="/change",
	method={RequestMethod.POST,RequestMethod.GET},
	produces={"text/html;charset=UTF-8;","application/json;"})
    public @ResponseBody String updateFilter() {
        Map<String, String> filterMap = new HashMap<>();
        List<Permission> plist = service.findAllPers();
        for(Permission per:plist) {
        	String roles = "roleOrFilter[";
        	List<Role> rolelist = service.findAllRolePers(per.getUrl());
        	for(Role role:rolelist) {
        		roles+=role.getRolecode()+",";
        	}
        	roles = roles.substring(0,roles.length()-1);
        	roles+="]";
        	filterMap.put(per.getUrl(), roles);
        }
        updatePermission(filterMap);

        return JSONObject.fromObject(MyFilterChains.getFilterChainDefinitionMap()).toString();
    }

    /**
     * 动态更新新的权限
     * @param filterMap
     */
    private synchronized void updatePermission(Map<String, String> filterMap) {

        AbstractShiroFilter shiroFilter = null;
        try {
            shiroFilter = (AbstractShiroFilter) MyFilterChains.getObject();

            // 获取过滤管理器
            PathMatchingFilterChainResolver filterChainResolver = (PathMatchingFilterChainResolver) shiroFilter
                    .getFilterChainResolver();
            DefaultFilterChainManager filterManager = (DefaultFilterChainManager) filterChainResolver.getFilterChainManager();

            //清空拦截管理器中的存储
            filterManager.getFilterChains().clear();
            /*
            	清空拦截工厂中的存储,如果不清空这里,还会把之前的带进去
            ps:如果仅仅是更新的话,可以根据这里的 map 遍历数据修改,重新整理好权限再一起添加
             */
            MyFilterChains.getFilterChainDefinitionMap().clear();

            // 相当于新建的 map, 因为已经清空了
            Map<String, String> chains = MyFilterChains.getFilterChainDefinitionMap();
            //把修改后的 map 放进去
            chains.putAll(filterMap);

            //这个相当于是全量添加
            for (Map.Entry<String, String> entry : filterMap.entrySet()) {
                //要拦截的地址
                String url = entry.getKey().trim().replace(" ", "");
                //地址持有的权限
                String chainDefinition = entry.getValue().trim().replace(" ", "");
                //生成拦截
                filterManager.createChain(url, chainDefinition);
            }
        } catch (Exception e) {
            logger.error("updatePermission error,filterMap=" + filterMap, e);
        }
}
}
