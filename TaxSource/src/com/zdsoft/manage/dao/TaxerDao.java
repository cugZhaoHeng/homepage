package com.zdsoft.manage.dao;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.zdsoft.manage.entity.TaxerBean;
import com.zdsoft.util.DBUtil;
/**
 * 
 * @author �Ժ�
 *
 * 2017��12��14��
 */
public class TaxerDao {
	/**
	 * ͨ��id��ѯ˰����Ա����Ϣ
	 * @param id
	 * @return
	 */
	public List<Map<String, String>> queryTaxerById(Integer id) {
		Object[] obj = {id};
		return DBUtil.query("select * from tb_taxer where id=?", obj);
	}
	
	/**
	 * ͨ��id��ȡ��ǰ˰����Ա��ʵ�������
	 * @param id
	 * @return
	 */
	public TaxerBean getTaxerById(Integer id) {
		Object[] obj = {id};
		TaxerBean taxerBean = null;
		List<Map<String, String>> list = DBUtil.query("select * from tb_taxer where id=?", obj);
		if(list!=null && list.size() > 0) {
			Map<String, String> map = list.get(0);
			taxerBean = new TaxerBean();
			try {
				BeanUtils.populate(taxerBean, map);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return taxerBean;
	}
	
	/**
	 * ��ȡ���ݱ������е�Taxer��¼
	 * @return
	 */
	public List<Map<String, String>> queryAllTaxer() {
		return DBUtil.query("select * from tb_taxer where state=0");
	}
	
	/**
	 * ���ݲ�����ѯ˰����Ա�ļ�¼
	 * @param taxerCode
	 * @param taxerName
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<Map<String, String>> queryTaxer(String taxerCode, String taxerName, Integer page, Integer rows) {
		List<Map<String, String>> list = null;
		String preStr = "SELECT taxer.*, organ.organName, taxer1.taxerName as mgrName, taxer2.taxerName as recordName FROM tb_taxer AS taxer "
				+"LEFT JOIN tb_tax_organ AS organ ON taxer.OrganId = organ.id "
				+"LEFT JOIN tb_taxer AS taxer1 ON taxer.mgr = taxer1.id "
				+"left join tb_taxer as taxer2 on taxer.recordUserId = taxer2.id "
				+"where ";
		String lastStr = " taxer.state=0 limit "+(page - 1) * rows +","+ rows;
		String sql = "";
		if(!taxerCode.equals("") && taxerName.equals("")) {
			sql = preStr+"taxer.taxerCode="+taxerCode+" and "+ lastStr;
		} else if(taxerCode.equals("") && !taxerName.equals("")) {
			sql = preStr+"taxer.taxerName='"+taxerName+"' and "+ lastStr;
		} else if(!taxerCode.equals("") && !taxerName.equals("")) {
			sql = preStr + "taxer.taxerCode="+taxerCode +" or taxer.taxerName='" + taxerName + "' and " + lastStr;
		} else {
			sql = preStr + lastStr;
		}
		list = DBUtil.query(sql);
		return list;
	}
	
	/**
	 * ���ص�ǰ��ѯ���ܼ�¼��
	 * @param taxerCode
	 * @param taxerName
	 * @return
	 */
	public int getTotal(String taxerCode, String taxerName) {
		List<Map<String, String>> list = null;
		if(!taxerCode.equals("") && taxerName.equals("")) {
			list = DBUtil.query("select * from tb_taxer where taxerCode="+taxerCode);
		} else if(taxerCode.equals("") && !taxerName.equals("")) {
			list = DBUtil.query("select * from tb_taxer where taxerName='"+taxerCode+"'");
		} else if(!taxerCode.equals("") && !taxerName.equals("")) {
			list = DBUtil.query("select * from tb_taxer where taxerCode="+taxerCode + " or taxerName='"+taxerName+"'");
		} else {
			list = DBUtil.query("select * from tb_taxer");
		}
		return list.size();
	}
	
	/**
	 * �����ݱ��в�������
	 * @param obj
	 * @return
	 */
	public int addTaxer(Object[] obj) {
		return DBUtil.update("INSERT INTO tb_taxer(taxerCode, taxerName, mobile, address, sex, birthday, email, organId, mgr, recordDate, recordUserId) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)", obj);
	}
	
	/**
	 * ͨ��idɾ��˰����Ա
	 * @param id
	 * @return
	 */
	public int removeById(Integer id) {
		Object[] obj = {id};
		return DBUtil.update("update tb_taxer set state=1 where id=?", obj);
	}
	/**
	 * �޸�˰����Ա����Ϣ
	 * @param obj
	 * @return
	 */
	public int editTaxer(Object[] obj) {
		return DBUtil.update("UPDATE tb_taxer SET taxerCode = ?, taxerName = ?, mobile = ?, address = ?, sex = ?, birthday = ?, email = ?, organId = ?, admin = ? WHERE id = ?", obj);
		
	}
	/**
	 * �ж�taxerCode�Ƿ���������ݿ���
	 * @param taxerCode
	 * @return
	 */
	public boolean hasTaxer(String taxerCode) {
		Object[] obj = {taxerCode};
		List<Map<String, String>> list = DBUtil.query("select * from tb_taxer where taxerCode=", obj);
		if(list.size() > 0) {
			return true;
		}
		return false;
	}
}
