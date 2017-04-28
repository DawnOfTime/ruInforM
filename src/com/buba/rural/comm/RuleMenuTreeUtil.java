package com.buba.rural.comm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.buba.rural.pojo.Menu;

import net.sf.json.JSONArray;


public class RuleMenuTreeUtil {
	//存放转换后数据的集合
List<Map<String,Object>> comboTreeList  =new ArrayList<Map<String,Object>>(); 
	
	/** 
	 * 返回 treeGrid(树形表格)需要的json格式数据 
	 * 前端调用的就是这个方法 
	 */
	@SuppressWarnings("unchecked")  
	public String backComboTreeTreeRole(List list){  
	    //调用方法实现菜单树
	    createComboTreeTree(list,"root");  
	    //将集合转换为json输出到页面
	    String json = JSONArray.fromObject(comboTreeList)+"";
	    return json;  
	}  
	
	/** 
	 * 将Menu封装成树开始
	 * @param list 
	 * @param  
	 */  
	private void createComboTreeTree(List<Menu> list, String fid) {  
	    for (int i = 0; i < list.size(); i++) {  
	        Map<String, Object> map = null;  
	        Menu menu = (Menu) list.get(i);  
	        if (menu.getFather_num().equals(fid)) {  
	            map = new HashMap<String, Object>();  
	            //这里必须要将对象角色的id、name转换成ComboTree在页面的显示形式id、text  
	            //ComboTree,不是数据表格，没有在页面通过columns转换数据的属性
	            map.put("id", list.get(i).getNum());
	            map.put("text",list.get(i).getName());
	            map.put("checked", list.get(i).getChecked());
	            map.put("children", createComboTreeChildren(list, menu.getNum()));  
	        }  
	        if (map != null)  
	            comboTreeList.add(map);  
	    }  
	}
	/** 
	 * 递归设置Menu树
	 * @param list 
	 * @param fid 
	 * @return 
	 */ 
	private List<Map<String, Object>> createComboTreeChildren(List<Menu> list, String fid) {  
	    List<Map<String, Object>> childList = new ArrayList<Map<String, Object>>();  
	    for (int j = 0; j < list.size(); j++) {  
	        Map<String, Object> map = null;  
	        Menu treeChild = (Menu) list.get(j);  
	        if (treeChild.getFather_num().equals(fid)) {  
	            map = new HashMap<String, Object>();  
	            //这里必须要将对象角色的id、name转换成ComboTree在页面的显示形式id、text  
	            //ComboTree,不是数据表格，没有在页面通过columns转换数据的属性 
	            map.put("id", list.get(j).getNum());
	            map.put("text",list.get(j).getName());
	            map.put("checked", list.get(j).getChecked());//�Ƿ�ѡ��
	            map.put("children", createComboTreeChildren(list, treeChild.getNum()));  
	        }  
	          
	        if (map != null)  
	            childList.add(map);  
	    }  
	    return childList;  
	}
}
