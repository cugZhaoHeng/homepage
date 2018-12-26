package cug.dao;

import java.util.List;
import java.util.Map;

import cug.util.DBUtil;

public class EnergyDao {
	/**
	 * 根据用户的id查询其能量记录并返回
	 */
	public List<Map<String, String>> getEnergyById(Object[] obj) {
		return DBUtil.query("select * from energy_info where userId = ? order by date", obj);
	}
	/**
	 * 向能量表中添加数据
	 */
	public int addEnergy(Object[] obj) {
		return DBUtil.update("insert into energy_info(userId, date, energy) values(?, ?, ?)", obj);
	}
	
	/**
	 * 删除能量表中的数据
	 */
	public int removeEnergy(Object[] obj) {
		return DBUtil.update("delete from energy_info where userId=? and date=?", obj);
	}
	
	/**
	 * 检验某用户的日期是否存在
	 */
	public boolean dateExist(Object[] obj) {
		List<Map<String,String>> list = DBUtil.query("select * from energy_info where userId=? and date=?", obj);
		if(list!=null && list.size()>0) {
			return true;
		} else {
			return false;
		}
	}
}
