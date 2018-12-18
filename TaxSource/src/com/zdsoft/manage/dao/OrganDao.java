package com.zdsoft.manage.dao;

import java.util.List;
import java.util.Map;

import com.zdsoft.util.DBUtil;

/**
 * 
 * @author �Ժ�
 *
 * 2017��12��14��
 */
public class OrganDao {
	/**
	 * �������е�organ��¼
	 * @return
	 */
	public List<Map<String, String>> queryAllOrgan() {
		return DBUtil.query("select * from tb_tax_organ");
	}
	/**
	 * ͨ����ַ������Ӧ��Organ��¼
	 * @param address
	 * @return
	 */
	public List<Map<String, String>> queryOrganByAddress(String address) {
		Object[] obj = {address};
		return DBUtil.query("select * from tb_tax_organ where address=?", obj);
	}
}
