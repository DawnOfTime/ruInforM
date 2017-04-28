package com.buba.rural.comm;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;

public class FenYe {
	private static String pagecode;
	public static String getParameterUrl(Map parameterMap, HttpServletRequest request,String lujing)
	throws UnsupportedEncodingException {
		String url = "";
		Set<String> set = parameterMap.keySet();
		for (String stuid : set) {
			String[] arr = (String[]) parameterMap.get(stuid);
			if (!"pagecode".equals(stuid)) {
				if (!"".equals(url)) {
					url += "&";
				}
				arr[0] = URLDecoder.decode(arr[0], "utf-8");
				url += stuid + "=" + arr[0];
			}
		}
		String s = request.getContextPath() + lujing;
		return s + "?" + url;
		}
}
