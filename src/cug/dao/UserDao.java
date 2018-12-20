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
	 * @param userName
	 * @param obj
	 * @return
	 */
	public UserBean selectUserByUserName(String userName, Object[] obj) {
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
	 * 获取所有的用户对象
	 * @return
	 */
	public List<Map<String, String>> getAllUser() {
		return DBUtil.query("select * from user_info");
	}
}
