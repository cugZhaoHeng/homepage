package cug.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import cug.entity.UserBean;
import cug.util.DBUtil;

public class UserDao {
	/**
	 * 通过用户名和密码查询用户是否登录成功
	 */
	public UserBean selectUserByUserName(Object[] obj) {
		String sql = "select * from user_info where username = ? and password=?";
		List<Map<String,String>> list = DBUtil.query(sql, obj);
		UserBean user = null;
		if(list!=null && list.size()>0) {
			Map<String, String> map = list.get(0);
			user = new UserBean();
			try {
				BeanUtils.populate(user, map);
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return user;
	}
	
	/**
	 * 通过用户ID访问用户详细信息
	 */
	public UserBean selectUserById(Object[] obj) {
		String sql = "select * from user_info where id = ?";
		List<Map<String, String>> list = DBUtil.query(sql, obj);
		UserBean user = null;
		if(list!=null && list.size()>0) {
			Map<String, String> map = list.get(0);
			user = new UserBean();
			try {
				BeanUtils.populate(user, map);
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return user;
	}
	
	/**
	 * 获取所有的用户对象
	 */
	public List<Map<String, String>> getAllUser() {
		return DBUtil.query("select * from user_info");
	}
	
	/**
	 * 修改用户的密码
	 */
	public int editPassword(Object[] obj) {
		return DBUtil.update("update user_info set password=? where id=?", obj);
	}
}
