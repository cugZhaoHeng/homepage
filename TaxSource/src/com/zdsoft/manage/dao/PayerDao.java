package com.zdsoft.manage.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.zdsoft.manage.entity.PayerBean;
import com.zdsoft.util.DBUtil;
/**
 * 
 * @author 赵恒
 *
 * 2017年12月26日
 */
public class PayerDao {
	/**
	 * 查询所有的payer记录
	 * 
	 * @return
	 */
	public List<Map<String, String>> queryAllPayer() {
		return DBUtil.query("select * from tb_tax_payer where removeState=0");
	}

	/**
	 * 根据id和姓名查询指定的纳税人，分页查询
	 * @param payerCode
	 * @param payerName
	 * @return
	 */
	public List<Map<String, String>> queryPayer(String payerCode, String payerName, Integer page, Integer rows) {
		List<Map<String, String>> list = null;
		String preStr = "select payer.*, organ.organName, industry.industryName from tb_tax_payer AS payer LEFT JOIN tb_tax_organ AS organ ON payer.taxOrganId = organ.id LEFT JOIN tb_industry AS industry ON payer.industryId = industry.id where ";
		String lastStr = " and removeState=0 limit "+(page - 1) * rows +","+ rows;
		String sql = "";
		//根据用户在查询栏输入的信息，返回不同的结果
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
	 * 查询未被统计的企业的信息
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
		//根据用户在查询栏输入的信息，返回不同的结果
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
	 * 获取纳税人的总记录数
	 * @param payerCode
	 * @param payerName
	 * @return
	 */
	public int getTotal(String payerCode, String payerName) {
		List<Map<String, String>> list = null;
		String preStr = "select payer.*, organ.organName, industry.industryName from tb_tax_payer AS payer LEFT JOIN tb_tax_organ AS organ ON payer.taxOrganId = organ.id LEFT JOIN tb_industry AS industry ON payer.industryId = industry.id where ";
		String lastStr = " and removeState=0";
		String sql = "";
		//根据用户在查询栏输入的信息，返回不同的结果
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
	 * 通过纳税人识别号删除纳税人
	 * 
	 * @param payerCode
	 * @return
	 */
	public int deletePayerById(Integer id) {
		Object[] obj = { id };
		return DBUtil.update("UPDATE tb_tax_payer SET removeState=1 WHERE id=?", obj);
	}
	
	/**
	 * 修改纳税人员信息
	 * @param obj
	 * @return
	 */
	public int editPayer(Object[] obj) {
		return DBUtil.update(
				"UPDATE tb_tax_payer SET payerCode=?, payerName=?, bizAddress=?, taxOrganId=?, industryId=?, bizScope=?, invoiceType=?,legalPerson=?, legalIdCard=?, legalMobile=?, legalIdCardImageURL=?, finaceName=?, finaceIdCard=?, finaceMobile=?,finaceIdCardImageURL=?, taxerName=?,taxerIdCard=?,taxerMobile=?,taxerIdCardImageURL=?, bizAddressPhone=?, userId=? where id=?",
				obj);
	}
	
	/**
	 * 通过id查询纳税人的记录，并返回PayerBean实体类
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
	 * 查询payerCode是否已经存在
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
	 * 向数据库中插入数据
	 * @param obj
	 * @return
	 */
	public int addTaxer(Object[] obj) {
		return DBUtil.update("INSERT INTO tb_tax_payer (payerCode, payerName, bizAddress, taxOrganId,industryId, bizScope, invoiceType, legalPerson, legalIdCard, legalMobile, legalIdCardImageURL, finaceName, finaceIdCard, finaceMobile, finaceIdCardImageURL, taxerName, taxerIdCard, taxerMobile, taxerIdCardImageURL, bizAddressPhone, recordDate, userId) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)", obj);
	}
	
	/**
	 * 获取纳税人表中所有的invoiceType字段，去除重复
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
