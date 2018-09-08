package com.panda.system.controller;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.panda.system.model.Role;
import com.panda.system.model.User;
import com.panda.system.service.RoleService;
import com.panda.system.service.UserService;
import com.panda.util.MD5Utils;
import com.panda.util.StringUtil;
import com.panda.util.ValidateCode;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userService;
	@Autowired
	private SessionDAO sessionDAO;  
	@Resource
	private RoleService roleService;
	@RequestMapping(value="/show/login.do",method={RequestMethod.POST,RequestMethod.GET})
	public @ResponseBody  String login(Map<String, Object> map,HttpSession sessions,User user,HttpServletRequest request){
		JSONObject jo = new JSONObject();
		Subject subject= SecurityUtils.getSubject();
		//md5加密明文密码
		String md5Password = MD5Utils.getStrMD5(user.getPassword());
		UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), md5Password);
		try{
			subject.login(token);
			User suser = userService.findUserPassword(user.getUsername());
			String newSessionCreateDate = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
			sessions.setAttribute("userid", suser.getId());
			sessions.setAttribute("date", newSessionCreateDate);
			System.out.println(sessions.getMaxInactiveInterval());
			jo.put("ifsuc","true");
			return jo.toString();
		}catch (Exception e) {
			e.printStackTrace();
			jo.put("ifsuc","false");
			return jo.toString();
		}
	}
	//跳转主页面
		@RequestMapping(value="/show/loginToAdmin",method={RequestMethod.POST,RequestMethod.GET})
		public String loginToAdmin(Map<String, Object> map,User user,HttpSession sessions){
			User suser = userService.findUserPassword(user.getUsername());
			if(suser != null && sessions.getAttribute("userid") != null) {
				return "admin/admin_layui";
			}
			map.put("user", suser);
			return "login3";
		}
		//添加用户
		@RequestMapping(value="/show/addUser",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
		public @ResponseBody String addUser(Map<String, Object> map,User user,HttpSession sessions){
			JSONObject jo = new JSONObject();
			User user_0 = userService.findUserByUsername(user.getUsername());
			if(user_0 != null) {
				jo.put("msg", "用户名已存在，请重新输入！");
			}else {
				try {
					if(user.getPassword() == null) {
						user.setPassword(MD5Utils.getStrMD5("123456"));
					}else {
						user.setPassword(MD5Utils.getStrMD5(user.getPassword()));
					}
					user.setCreateTime(StringUtil.getStrByDate(new Date()));
					userService.addUser(user);
					jo.put("msg", "新增成功！");
				}catch(Exception e) {
					jo.put("msg", "新增失败！");
				}
			}
			return jo.toString();
		}
		//编辑用户
		@RequestMapping(value="/show/editUser",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
		public @ResponseBody String editUser(Map<String, Object> map,User user,HttpSession sessions){
			JSONObject jo = new JSONObject();
			try {
				user.setUpdateTime(StringUtil.getStrByDate(new Date()));
				userService.editUser(user);
				jo.put("msg", "编辑成功！");
			}catch(Exception e) {
				jo.put("msg", "编辑失败！");
			}
			return jo.toString();
		}
		//密码重置
		@RequestMapping(value="/show/resetPassword",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
		public @ResponseBody String resetPassword(Map<String, Object> map,User user,HttpSession sessions,@RequestParam("uid")int uid){
			JSONObject jo = new JSONObject();
			try {
				user.setPassword(MD5Utils.getStrMD5("123456"));
				user.setId(uid);
				userService.resetPassword(user);
				jo.put("msg", "密码重置成功！");
			}catch(Exception e) {
				jo.put("msg", "密码重置失败！");
			}
			return jo.toString();
		}
		//密码修改
		@RequestMapping(value="/show/pwdChange",method={RequestMethod.POST,RequestMethod.GET},produces={"application/text;charset=UTF-8"})
		public @ResponseBody String pwdChange(Map<String, Object> map,User user,HttpSession sessions,@RequestParam("npsw")String npsw){
			int userid=(int) sessions.getAttribute("userid");
			JSONObject jo = new JSONObject();
			try {
				user.setPassword(MD5Utils.getStrMD5(npsw));
				user.setId(userid);
				userService.resetPassword(user);
				jo.put("msg", "密码修改成功！");
			}catch(Exception e) {
				jo.put("msg", "密码修改失败！");
			}
			return jo.toString();
		}
		//删除用户
		@RequestMapping(value="/deleteUser",method={RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
		public @ResponseBody String deleteUser(Map<String, Object> map,User user,HttpSession sessions,@RequestParam("ids")String ids){
			
			JSONObject jo = new JSONObject();
			int count = userService.findUserRoles(ids);
			if(count > 0){
				jo.put("msg", "用户未解绑角色，不能删除。请先解绑角色信息！");
			}else{
				try {
					userService.deleteUser(ids);
					jo.put("msg", "删除成功！");
				}catch(Exception e) {
					jo.put("msg", "删除失败！");
				}
			}
			return jo.toString();
		}
		//解除绑定用户角色
		@RequestMapping(value="/deleteUserRoles",method={RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
		public @ResponseBody String deleteUserRoles(Map<String, Object> map,User user,HttpSession sessions,@RequestParam("ids")String ids){
			
			JSONObject jo = new JSONObject();
			try {
				userService.deleteUserRoles(ids);
				jo.put("msg", "解除绑定成功！");
			}catch(Exception e) {
				jo.put("msg", "解除绑定失败！");
			}
			return jo.toString();
		}
//		转入注册页面
		@RequestMapping(value="/regist.do",method={RequestMethod.POST,RequestMethod.GET})
		public String registPage(Map<String, Object> map){
				return "jsp/registUser";
		}
//		注册用户
		@RequestMapping(value="/show/regist",method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView regist(Map<String, Object> map,User user){
			map.put("user_name", user.getUsername());
			map.put("user_email",user.getEmail());
			map.put("user_password", MD5Utils.getStrMD5(user.getPassword()));
			String idcode = user.getIdent();
			String ident = null;
			if("teac".equals(idcode)) {
				ident = "教师";
			}else if("stud".equals(idcode)) {
				ident = "学生";
			}else {
				ident = "游客";
			}
			map.put("user_ident", ident);
			map.put("user_identnum", user.getIdentnum());
			userService.addUser(map);
			ModelAndView mv = new ModelAndView();
			mv.addObject("user", map);
			mv.setViewName( "jsp/registSucess");
			return mv;
		}
//	退出
	@RequestMapping(value="/logout")
	public String logout(){
		Subject subject= SecurityUtils.getSubject();
		subject.logout();
		return "login3";
	}
//	验证登录验证码
	@RequestMapping(value="/loginTestCode.do",method={RequestMethod.POST,RequestMethod.GET})
	public @ResponseBody Object loginTestCode(Map<String, Object> map,HttpSession sessions,
			@RequestParam("code")String submitCode,HttpServletRequest request){
		String code = (String) sessions.getAttribute("validateCode");
        JSONObject jo = new JSONObject();
        if (StringUtils.isEmpty(submitCode) || !StringUtils.equals(code,submitCode.toLowerCase())) {
            jo.put("message", "wrong");
        }else{
        	jo.put("message", "correct");
        }
		return jo.toString();
	}
	 /**
     * 生成验证码
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/validateCode.do")
    public void validateCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Cache-Control", "no-cache");
        String verifyCode = ValidateCode.generateTextCode(ValidateCode.TYPE_NUM_ONLY, 4, null);
        request.getSession().setAttribute("validateCode", verifyCode);
        response.setContentType("image/jpeg");
        BufferedImage bim = ValidateCode.generateImageCode(verifyCode, 90, 30, 3, true, Color.WHITE, Color.BLACK, null);
        ImageIO.write(bim, "JPEG", response.getOutputStream());
    }

//	获取session信息，查看是否过期
	@RequestMapping(value="/getSessionInfor.do",method={RequestMethod.POST,RequestMethod.GET})
	public @ResponseBody String getSessionInfor(HttpSession sessions,Map<String, Object> map,HttpServletRequest request){
		String isPast = "1";//0代表session已经过期，1代表未过期
		JSONObject jo = new JSONObject();
		/*if(null!=request.getSession(false)){   
		   if(request.getSession(false).isNew()){ 
			   System.out.println("session已经过期");
			   isPast = "0";
		   }else{   
				System.out.println("session未过期");   
				isPast = "1";
		   }   
		}else{
			isPast = "0";
		}*/
		try{
			int userid = (Integer) sessions.getAttribute("userid");
//			System.out.println("当前用户id:"+userid);
//			System.out.println("当前session的ID : "+request.getSession(true).getId());
			User user = userService.findUserById(userid);
			getSessionByUsername(user.getUsername());
		}catch(Exception a){
			isPast = "0";
			System.out.println("当前session已经过期！"+a.getMessage());
		}
		jo.put("ifTimeout",isPast);
		return jo.toString();
	}
	public void getSessionByUsername(String username){
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		List<Session> selist = new LinkedList<Session>();
		List<String> seDate = new ArrayList<String>();
		for(Session session : sessions){
			if(null != session && StringUtils.equals(String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)), username)){
				selist.add(session);
				seDate.add((String)session.getAttribute("date"));
			}
		}
		if(selist.size() > 1) {
			Collections.sort(seDate);
			for(Session se:selist) {
				//session中有重复登陆信息的，将先登陆的设为无效，使其过期
				if(!seDate.get(seDate.size()-1).equals((String)se.getAttribute("date"))) {
					se.setTimeout(0);
				}
			}
			System.out.println(selist.toString());
		}
	}
	//用户列表
	@RequestMapping(value="/userManage",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"application/text;charset=UTF-8"})
	public @ResponseBody Object userList(Map<String, Object> map,
			HttpServletRequest req,
			@RequestParam("page")int page,@RequestParam("limit")int rows){
		String name=req.getParameter("usernames");
		String address = req.getParameter("useraddress");
		List<User> userList = userService.findAllUsersByPage(rows,page,name,address);
		JSONArray json = new JSONArray();
        for(User a : userList){
            JSONObject jo = new JSONObject();
            jo.put("id", a.getId());
            jo.put("name", a.getName());
            jo.put("username", a.getUsername());
            jo.put("age", a.getAge());
            jo.put("phone", a.getPhone());
            jo.put("address", a.getAddress());
            jo.put("ident", a.getIdent());
            jo.put("identnum", a.getIdentnum());
            jo.put("email", a.getEmail());
            jo.put("cardid", a.getCardid());
            jo.put("createtime", a.getCreateTime());
            json.add(jo);
        }
        if((name == null || name == "") && (address == null || address == "")){
        	List<User> userLists = userService.getAllUsers();
        	map.put("count", userLists.size());  //total
        } else {
        	List<User> userListPart = userService.findPartUsers(name,address);
        	map.put("count", userListPart.size());  
        }
        map.put("data", json);
        map.put("msg", null);
        map.put("code", 0);
//        System.out.println(JSONObject.fromObject(map).toString());
		return JSONObject.fromObject(map).toString();//total
	}
	//用户
	@RequestMapping(value="/getUsers",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"application/text;charset=UTF-8"})
	public @ResponseBody Object getUsers(Map<String, Object> map,
			HttpServletRequest req){
		List<User> userList = userService.getAllUsers();
		JSONArray json = new JSONArray();
		for(User a : userList){
			JSONObject jo = new JSONObject();
			jo.put("id", a.getId());
			jo.put("name", a.getName());
			jo.put("username", a.getUsername());
			jo.put("age", a.getAge());
			jo.put("phone", a.getPhone());
			jo.put("address", a.getAddress());
			jo.put("ident", a.getIdent());
			jo.put("identnum", a.getIdentnum());
			jo.put("email", a.getEmail());
			jo.put("cardid", a.getCardid());
			json.add(jo);
		}
		map.put("count", userList.size());  //total
		map.put("data", json);
		map.put("msg", null);
		map.put("code", 0);
//        System.out.println(JSONObject.fromObject(map).toString());
		return JSONObject.fromObject(map).toString();//total
	}
	//获取当前登录用户信息
	@RequestMapping(value="/getPersonalInfo",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"application/text;charset=UTF-8"})
	public @ResponseBody Object getPersonalInfo(Map<String, Object> map,
			HttpServletRequest req,HttpSession sessionss){
		int userid=(int) sessionss.getAttribute("userid");
		User user = userService.findUserById(userid);
		JSONObject jo = new JSONObject();
		jo.put("id", user.getId());
		jo.put("name", user.getName());
		jo.put("username", user.getUsername());
		jo.put("age", user.getAge());
		jo.put("phone", user.getPhone());
		jo.put("address", user.getAddress());
		jo.put("ident", user.getIdent());
		jo.put("identnum", user.getIdentnum());
		jo.put("email", user.getEmail());
		jo.put("cardid", user.getCardid());
		return jo.toString();//total
	}
	//绑定角色
	@RequestMapping(value="/bindRoleForUser",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"application/text;charset=UTF-8"})
	public @ResponseBody Object bindRoleForUser(Map<String, Object> map,
			HttpServletRequest req,
			@RequestParam("uid")int uid,@RequestParam("rid")int rid){
		JSONObject jo = new JSONObject();
		try {
			userService.bindRoleforUser(uid,rid);
		jo.put("msg", "绑定成功！");
		}catch(Exception e) {
			jo.put("msg","绑定失败！" );
		}
		return jo.toString();
	}
	//绑定角色信息
	@RequestMapping(value="/userroleList",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object userroleList(Map<String, Object> map,HttpServletRequest req) {
		List<Role> rlist = roleService.findAllRoles();
		JSONArray json = new JSONArray();
		for(Role r:rlist) {
			JSONObject jo = new JSONObject();
			jo.put("id", r.getId());
			jo.put("rname", r.getRolename());
			jo.put("rcode", r.getRolecode());
			jo.put("rlevel", r.getLevel());
			jo.put("pid", r.getPid());
			json.add(jo);
		}
		map.put("data", json);
	    map.put("msg", null);
	    map.put("code", 0);
	    map.put("count", rlist.size());
		return JSONObject.fromObject(map).toString();
	}
	//绑定角色信息
	@RequestMapping(value="/userroles",
			method={RequestMethod.POST,RequestMethod.GET},
			produces={"text/html;charset=UTF-8;","application/x-www-form-urlencoded"})
	public @ResponseBody Object roleLists(Map<String, Object> map,HttpServletRequest req,@RequestParam("uid")int uid) {
		List<Role> urose = userService.findRolesByUid(uid);
		JSONArray json = new JSONArray();
		for(Role r:urose) {
			JSONObject jo = new JSONObject();
			jo.put("id", r.getId());
			jo.put("rname", r.getRolename());
			jo.put("rcode", r.getRolecode());
			jo.put("rlevel", r.getLevel());
			jo.put("pid", r.getPid());
			json.add(jo);
		}
		map.put("data", json);
		map.put("msg", null);
		map.put("code", 0);
		map.put("count", urose.size());
		return JSONObject.fromObject(map).toString();
	}
}
