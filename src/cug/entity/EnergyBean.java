package cug.entity;

public class EnergyBean {
	private int id;
	private int userId;
	private String date;
	private int energy;

	public EnergyBean(int id, int userId, String date, int energy) {
		super();
		this.id = id;
		this.userId = userId;
		this.date = date;
		this.energy = energy;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getEnergy() {
		return energy;
	}

	public void setEnergy(int energy) {
		this.energy = energy;
	}

	@Override
	public String toString() {
		return "EnergyBean [id=" + id + ", userId=" + userId + ", date=" + date + ", energy=" + energy + "]";
	}

}
