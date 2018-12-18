package com.zdsoft.manage.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.zdsoft.manage.entity.PayerBean;
import com.zdsoft.util.DBUtil;
/**
 * 
 * @author �Ժ�
 *
 * 2017��12��26��
 */
public class PayerDao {
	/**
	 * ��ѯ���е�payer��¼
	 * 
	 * @return
	 */
	public List<Map<String, String>> queryAllPayer() {
		return DBUtil.query("select * from tb_tax_payer where removeState=0");
	}

	/**
	 * ����id��������ѯָ������˰�ˣ���ҳ��ѯ
	 * @param payerCode
	 * @param payerName
	 * @return
	 */
	public List<Map<String, String>> queryPayer(String payerCode, String payerName, Integer page, Integer rows) {
		List<Map<String, String>> list = null;
		String preStr = "select payer.*, organ.organName, industry.industryName from tb_tax_payer AS payer LEFT JOIN tb_tax_organ AS organ ON payer.taxOrganId = organ.id LEFT JOIN tb_industry AS industry ON payer.industryId = industry.id where ";
		String lastStr = " and removeState=0 limit "+(page - 1) * rows +","+ rows;
		String sql = "";
		//�����û��ڲ�ѯ���������Ϣ�����ز�ͬ�Ľ��
		if(payerCode.equals("") && !payerName.equals("")) {
			sql = preStr+"payerName like '%"+payerName+"%'"+lastStr;
		} else if(!payerCode.equals("") && payerName.equals("")) {
			sql = preStr+"payerCode="+payerCode+lastStr;
		} else if(!payerCode.equals("") && !payerName.equals("")) {
			sql = preStr+"payerCode="+payerCode+" or payerName like '%"+payerName+"%'"+ lastStr;
		} else {
			sql = preStr+ " removeState=0 limit "+(page - 1) * rows +","+ rows;
		}
		list = DBUtil.query(sql);
		return list;
	}
	/**
	 * ��ѯδ��ͳ�Ƶ���ҵ����Ϣ
	 * @param payerCode
	 * @param payerName
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<Map<String, String>> queryStatisticalPayer(String payerCode, String payerName, Integer page, Integer rows) {
		List<Map<String, String>> list = null;
		String preStr = "select payer.*, organ.organName, industry.industryName from tb_tax_payer AS payer LEFT JOIN tb_tax_organ AS organ ON payer.taxOrganId = organ.id LEFT JOIN tb_industry AS industry ON payer.industryId = industry.id LEFT JOIN tb_tax_source as source ON payer.id = source.payerId where ";
		String lastStr = " and payer.removeState=0 limit "+(page - 1) * rows +","+ rows;
		String sql = "";
		//�����û��ڲ�ѯ���������Ϣ�����ز�ͬ�Ľ��
		if(payerCode.equals("") && !payerName.equals("")) {
			sql = preStr+"payer.payerName like '%"+payerName+"%'"+lastStr;
		} else if(!payerCode.equals("") && payerName.equals("")) {
			sql = preStr+"payer.payerCode="+payerCode+lastStr;
		} else if(!payerCode.equals("") && !payerName.equals("")) {
			sql = preStr+"payer.payerCode="+payerCode+" or payer.payerName like '%"+payerName+"%'"+ lastStr;
		} else {
			sql = preStr+ " payer.removeState=0 and payer.id NOT IN (SELECT DISTINCT payerId FROM tb_tax_source) limit "+(page - 1) * rows +","+ rows;
		}
		list = DBUtil.query(sql);
		return list;
	}
	
	/**
	 * ��ȡ��˰�˵��ܼ�¼��
	 * @param payerCode
	 * @param payerName
	 * @return
	 */
	public int getTotal(String payerCode, String payerName) {
		List<Map<String, String>> list = null;
		String preStr = "select payer.*, organ.organName, industry.industryName from tb_tax_payer AS payer LEFT JOIN tb_tax_organ AS organ ON payer.taxOrganId = organ.id LEFT JOIN tb_industry AS industry ON payer.industryId = industry.id where ";
		String lastStr = " and removeState=0";
		String sql = "";
		//�����û��ڲ�ѯ���������Ϣ�����ز�ͬ�Ľ��
		if(payerCode.equals("") && !payerName.equals("")) {
			sql = preStr+"payerName like '%"+payerName+"%'"+lastStr;
		} else if(!payerCode.equals("") && payerName.equals("")) {
			sql = preStr+"payerCode="+payerCode+lastStr;
		} else if(!payerCode.equals("") && !payerName.equals("")) {
			sql = preStr+"payerCode="+payerCode+" or payerName like '%"+payerName+"%'"+ lastStr;
		} else {
			sql = preStr+ " removeState=0";
		}
		list = DBUtil.query(sql);
		return list.size();
	}

	/**
	 * ͨ����˰��ʶ���ɾ����˰��
	 * 
	 * @param payerCode
	 * @return
	 */
	public int deletePayerById(Integer id) {
		Object[] obj = { id };
		return DBUtil.update("UPDATE tb_tax_payer SET removeState=1 WHERE id=?", obj);
	}
	
	/**
	 * �޸���˰��Ա��Ϣ
	 * @param obj
	 * @return
	 */
	public int editPayer(Object[] obj) {
		return DBUtil.update(
				"UPDATE tb_tax_payer SET payerCode=?, payerName=?, bizAddress=?, taxOrganId=?, industryId=?, bizScope=?, invoiceType=?,legalPerson=?, legalIdCard=?, legalMobile=?, legalIdCardImageURL=?, finaceName=?, finaceIdCard=?, finaceMobile=?,finaceIdCardImageURL=?, taxerName=?,taxerIdCard=?,taxerMobile=?,taxerIdCardImageURL=?, bizAddressPhone=?, userId=? where id=?",
				obj);
	}
	
	/**
	 * ͨ��id��ѯ��˰�˵ļ�¼��������PayerBeanʵ����
	 * @param id
	 * @return
	 */
	public PayerBean getPayerById(Integer id) {
		Object[] obj = {id};
		PayerBean payerBean = null;
		List<Map<String, String>> list = DBUtil.query("select * from tb_tax_payer where id=?", obj);
		if(list!=null && list.size()>0) {
			Map<String, String> map = list.get(0);
			payerBean = new PayerBean();
			try {
				BeanUtils.populate(payerBean, map);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return payerBean;
	}
	
	/**
	 * ��ѯpayerCode�Ƿ��Ѿ�����
	 * @param payerCode
	 * @return
	 */
	public boolean hasPayer(String payerCode) {
		Object[] obj = {payerCode};
		 List<Map<String, String>> list = DBUtil.query("select * from tb_tax_payer where payerCode=?", obj);
		 if(list.size() > 0) {
			 return true;
		 }
		 return false;
	}
	/**
	 * �����ݿ��в�������
	 * @param obj
	 * @return
	 */
	public int addTaxer(Object[] obj) {
		return DBUtil.update("INSERT INTO tb_tax_payer (payerCode, payerName, bizAddress, taxOrganId,industryId, bizScope, invoiceType, legalPerson, legalIdCard, legalMobile, legalIdCardImageURL, finaceName, finaceIdCard, finaceMobile, finaceIdCardImageURL, taxerName, taxerIdCard, taxerMobile, taxerIdCardImageURL, bizAddressPhone, recordDate, userId) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)", obj);
	}
	
	/**
	 * ��ȡ��˰�˱������е�invoiceType�ֶΣ�ȥ���ظ�
	 * @return
	 */
	public List<Map<String, String>> queryAllInvoiceType() {
		return DBUtil.query("SELECT DISTINCT invoiceType FROM tb_tax_payer");
	}
	public String getIdByCode(String code) {
		String id = "";
		Object[] obj = {code};
		List<Map<String, String>> list = DBUtil.query("select id from tb_tax_payer where payerCode=?", obj);
		if(list!=null && list.size() > 0) {
			id = list.get(0).get("id").toString();
		}
		return id;
	}
	
}
