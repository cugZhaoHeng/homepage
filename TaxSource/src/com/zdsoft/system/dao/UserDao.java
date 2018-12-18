package com.zdsoft.system.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.zdsoft.system.entity.UserBean;
import com.zdsoft.util.DBUtil;

/**
 * 用封装了对用户表的增删改查操作
 * @author 赵恒
 *
 * 2017年12月13日
 */
public class UserDao {
	/**
	 * 通过参数userName查询用户对象，并返回UserBean
	 * @param userName
	 * @return
	 */
	public UserBean queryUserByUserName(String userName) {
		UserBean userBean = null;
		Object[] obj = {userName};
		List<Map<String, String>> list = DBUtil.query("select * from tb_user where username=?", obj);
		if(list!=null && list.size()>0) {
			Map<String, String> map = list.get(0);
			userBean = new UserBean();
			try {
				BeanUtils.populate(userBean, map);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return userBean;
	}
	/**
	 * 通过用户名查询密码
	 * @param userName
	 * @return
	 */
	public String queryPasswordByName(String userName) {
		Object[] obj = {userName};
		String password = null;
		List<Map<String, String>> list = DBUtil.query("select password from tb_user where username=?", obj);
		if(list!=null && list.size()>0) {
			password = list.get(0).get("password");
		}
		return password;
	}
	/**
	 * 返回用户表中所有的user记录
	 * @return
	 */
	public List<Map<String, String>> queryAllUser() {
		return DBUtil.query("select * from tb_user");
	}
	/**
	 * 通过用户名获取用户的id
	 * @param userName
	 * @return
	 */
	public Integer getIdByName(String userName) {
		Object[] obj = {userName};
		Integer userId = 0;
		List<Map<String, String>> list = DBUtil.query("SELECT * FROM tb_user WHERE username=?", obj);
		if(list!=null && list.size()>0) {
			Map<String, String> map = list.get(0);
			String id = map.get("id");
			userId = Integer.parseInt(id);
		}
		return userId;
	}
	/**
	 * 修改用户名为userName的密码，密码为newPassword
	 * @param newPassword
	 * @param userName
	 * @return
	 */
	public int updatePassword(String newPassword, String userName) {
		Object[] obj = {newPassword, userName};
		return DBUtil.update("update tb_user set password=? where username=?", obj);
	}
}
