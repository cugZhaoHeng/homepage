package cug.dao;

import java.util.List;
import java.util.Map;

import cug.util.DBUtil;

public class EnergyDao {
	/**
	 * 根据用户的id查询其能量记录并返回
	 * @param obj
	 * @return
	 */
	public List<Map<String, String>> getEnergyById(Object[] obj) {
		return DBUtil.query("select * from energy_info where userId = ?", obj);
	}
}
