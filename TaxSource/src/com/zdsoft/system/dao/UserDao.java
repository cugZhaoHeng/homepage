package com.zdsoft.system.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.zdsoft.system.entity.UserBean;
import com.zdsoft.util.DBUtil;

/**
 * �÷�װ�˶��û������ɾ�Ĳ����
 * @author �Ժ�
 *
 * 2017��12��13��
 */
public class UserDao {
	/**
	 * ͨ������userName��ѯ�û����󣬲�����UserBean
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
	 * ͨ���û�����ѯ����
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
	 * �����û��������е�user��¼
	 * @return
	 */
	public List<Map<String, String>> queryAllUser() {
		return DBUtil.query("select * from tb_user");
	}
	/**
	 * ͨ���û�����ȡ�û���id
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
	 * �޸��û���ΪuserName�����룬����ΪnewPassword
	 * @param newPassword
	 * @param userName
	 * @return
	 */
	public int updatePassword(String newPassword, String userName) {
		Object[] obj = {newPassword, userName};
		return DBUtil.update("update tb_user set password=? where username=?", obj);
	}
}
