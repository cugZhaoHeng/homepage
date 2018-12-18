package com.zdsoft.manage.dao;

import java.util.List;
import java.util.Map;


import com.zdsoft.util.DBUtil;
/**
 * 
 * @author 赵恒
 *
 * 2017年12月14日
 */
public class IndustryDao {
	/**
	 * 查询所有的行业
	 * @return
	 */
	public List<Map<String, String>> queryAllIndustry() {
		return DBUtil.query("select * from tb_industry");
	}
}
