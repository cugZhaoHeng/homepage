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
public class IndustryDao {
	/**
	 * ��ѯ���е���ҵ
	 * @return
	 */
	public List<Map<String, String>> queryAllIndustry() {
		return DBUtil.query("select * from tb_industry");
	}
}
