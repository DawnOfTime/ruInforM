package com.buba.rural.comm;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

public class HttpUtil {
	//拼接URL的同时解码
		//	pattern="/student.do?"
		public static String getParameterUrl(Map parameterMap, HttpServletRequest request,String pattern) throws UnsupportedEncodingException{
			String url = "";
			Set<String> set = parameterMap.keySet();
			for(String name : set){
				String [] arr = (String[]) parameterMap.get(name);
				if(!"pagecode".equals(name)){
					if(!"".equals(url)){
						url += "&";
					}
				arr[0] = URLDecoder.decode(arr[0], "utf-8");
				url += name+"="+arr[0];
				}
			}
			return request.getContextPath()+pattern+url;
		}
}
