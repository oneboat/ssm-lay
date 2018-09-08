package com.panda.test;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class Test001 {
	public static void main(String [] args){  
		String name = "xiaoming";
//        String str = "{\"result\":\"success\",\"message\":\""+name+"\",\"data\":[{\"name\":\"Tom\",\"age\":\"20\"}]}";  
		int x = 123;
		int y = 123;
        String sx = "{\'x\':"+x+",\'y\':"+y+"}";
        JSONObject json = JSONObject.fromObject(sx);  
        System.out.println(json);  
//        JSONArray jsonArray = JSONArray.fromObject(json.getString("data"));  
//        System.out.println(jsonArray.toString());  
    } 
}
