package com.zdsoft.system.entity;
/**
 * �û���ʵ���࣬��Ӧ�����ݿ��е��û���
 * @author �Ժ�
 *
 * 2017��12��13��
 */
public class UserBean {
	/*
	 * �û���ID
	 */
	private Integer id;
	/*
	 * �û���
	 */
	private String userName;
	/*
	 * �û�����
	 */
	private String password;
	/*
	 * ˰����Ա���
	 */
	private Integer taxerId;
	/*
	 * �û���ֵ���û�md5����
	 */
	private String salt;
	/*
	 * �û�Ȩ��
	 */
	private Integer permissionId;
	/*
	 * �û�״̬
	 */
	private Integer state;
	/*
	 * �û��Ĺ�������
	 */
	private String email;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getTaxerId() {
		return taxerId;
	}
	public void setTaxerId(Integer taxerId) {
		this.taxerId = taxerId;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public Integer getPermissionId() {
		return permissionId;
	}
	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
