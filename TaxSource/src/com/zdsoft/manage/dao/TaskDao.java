package com.zdsoft.manage.dao;

import java.util.List;
import java.util.Map;

import com.zdsoft.util.DBUtil;
/**
 * 
 * @author �Ժ�
 *
 * 2017��12��26��
 */
public class TaskDao {
	/**
	 * ��ѯtb_tax_source���ݱ�����м�¼
	 * @return
	 */
	public List<Map<String, String>> queryAllTask() {
		return DBUtil.query("SELECT * FROM tb_tax_source where removeState=0");
	}
	/**
	 * ���ݲ���������˰Դ������Ϣ������м�¼
	 * @param payerCode
	 * @param payerName
	 * @param organId
	 * @param industryId
	 * @param startDate
	 * @param endDate
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<Map<String, String>> queryTask(String payerCode, String payerName, String organId, String industryId, String startDate, String endDate, Integer page, Integer rows) {
		String preStr = "SELECT source.*, payer.payerCode, payer.payerName, industry.industryName, "
				+"payer.bizScope, organ.organName, taxer0.taxerName AS approverName, taxer1.taxerName AS executeName, "
				+"user0.username AS recordName, (source.recordTaskDate - source.executeTime) AS overDays "
				+"FROM tb_tax_source AS source "
				+"LEFT JOIN tb_tax_payer AS payer ON source.payerId = payer.id "
				+"LEFT JOIN tb_tax_organ AS organ ON source.subOrganId = organ.id "
				+"LEFT JOIN tb_taxer AS taxer0 ON source.approverId = taxer0.id " 
				+"LEFT JOIN tb_taxer AS taxer1 ON source.executeId = taxer1.id "
				+"LEFT JOIN (SELECT DISTINCT tb_tax_payer.industryId, tb_industry.industryName FROM tb_tax_payer LEFT JOIN tb_industry ON tb_tax_payer.industryId = tb_industry.id) AS industry ON industry.industryId = payer.industryId "
				+"LEFT JOIN tb_user AS user0 ON source.recordUserId = user0.id where ";
		String lastStr = " source.removeState=0 limit "+(page - 1) * rows +","+ rows;
		if(!payerCode.equals("")) {
			preStr += " payer.payerCode="+payerCode + " and ";
		}
		if(!payerName.equals("")) {
			preStr += " payer.payerName like '%"+payerName + "%' and ";
		}
		if(!organId.equals("")) {
			preStr += " source.subOrganId=" + organId + " and ";
		}
		if(!industryId.equals("")) {
			preStr += " payer.industryId=" + industryId + " and ";
		}
		if(!startDate.equals("")) {
			preStr += "source.executeTime='" + startDate + "' and ";
		}
		if(!endDate.equals("")) {
			preStr += "source.recordDate='" + endDate + "' and ";
		}
		return DBUtil.query(preStr + lastStr);
	}
	/**
	 * ��ȡ��¼��
	 * @return
	 */
	public int getTotal(String payerCode, String payerName, String organId, String industryId, String startDate, String endDate) {
		String preStr = "SELECT source.*, payer.payerCode, payer.payerName, payer.industryId AS industryName, "
				+"payer.bizScope, organ.organName, taxer0.taxerName AS approverName, taxer1.taxerName AS executeName, "
				+"user0.username AS recordName, (source.recordTaskDate - source.executeTime) AS overDays "
				+"FROM tb_tax_source AS source "
				+"LEFT JOIN tb_tax_payer AS payer ON source.payerId = payer.id "
				+"LEFT JOIN tb_tax_organ AS organ ON source.subOrganId = organ.id "
				+"LEFT JOIN tb_taxer AS taxer0 ON source.approverId = taxer0.id " 
				+"LEFT JOIN tb_taxer AS taxer1 ON source.executeId = taxer1.id "
				+"LEFT JOIN tb_user AS user0 ON source.recordUserId = user0.id where ";
		String lastStr = " source.removeState=0";
		if(!payerCode.equals("")) {
			preStr += " payer.payerCode="+payerCode + " and ";
		}
		if(!payerName.equals("")) {
			preStr += " payer.payerName='"+payerName + "' and ";
		}
		if(!organId.equals("")) {
			preStr += " source.subOrganId=" + organId + " and ";
		}
		if(!industryId.equals("")) {
			preStr += " payer.industryId=" + industryId + " and ";
		}
		if(!startDate.equals("")) {
			preStr += "source.executeTime='" + startDate + "' and ";
		}
		if(!endDate.equals("")) {
			preStr += "source.recordDate='" + endDate + "' and ";
		}
		return DBUtil.query(preStr + lastStr).size();
	}
	/**
	 * ɾ������
	 * @param id
	 * @return
	 */
	public int removeById(Integer id) {
		Object[] obj = {id};
		return DBUtil.update("update tb_tax_source set removeState = 1 where id=?", obj);
	}
	/**
	 * �����������Ӽ�¼
	 * @param obj
	 * @return
	 */
	public int addTask(Object[] obj) {
		return DBUtil.update("INSERT INTO tb_tax_source(payerId, taskName, subOrganId, approverId, executeId, executeTime, taskFrom, taskState, idea, riskLevel, recordTaskDate, recordUserId) VALUES(?, ?, ?, ?, ?, ?, '�ϼ�����', ?, ?, ?, NOW(), ?)", obj);
	}
	/**
	 * �޸������ļ�¼
	 * @param obj
	 * @return
	 */
	public int editTask(Object[] obj) {
		return DBUtil.update("UPDATE tb_tax_source SET payerId=?, taskName=?, subOrganId=?, approverId=?, executeId=?, executeTime=?, taskState=?, idea=?, riskLevel=?, recordUserId=? WHERE id=?", obj);
	}
}
