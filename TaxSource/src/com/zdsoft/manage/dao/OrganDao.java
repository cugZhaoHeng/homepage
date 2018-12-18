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
public class OrganDao {
	/**
	 * 返回所有的organ记录
	 * @return
	 */
	public List<Map<String, String>> queryAllOrgan() {
		return DBUtil.query("select * from tb_tax_organ");
	}
	/**
	 * 通过地址返回相应的Organ记录
	 * @param address
	 * @return
	 */
	public List<Map<String, String>> queryOrganByAddress(String address) {
		Object[] obj = {address};
		return DBUtil.query("select * from tb_tax_organ where address=?", obj);
	}
}
