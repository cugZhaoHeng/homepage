package com.zdsoft.system.entity;
/**
 * 用户的实体类，对应于数据库中的用户表
 * @author 赵恒
 *
 * 2017年12月13日
 */
public class UserBean {
	/*
	 * 用户的ID
	 */
	private Integer id;
	/*
	 * 用户名
	 */
	private String userName;
	/*
	 * 用户密码
	 */
	private String password;
	/*
	 * 税务人员编号
	 */
	private Integer taxerId;
	/*
	 * 用户盐值，用户md5加密
	 */
	private String salt;
	/*
	 * 用户权限
	 */
	private Integer permissionId;
	/*
	 * 用户状态
	 */
	private Integer state;
	/*
	 * 用户的工作邮箱
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
