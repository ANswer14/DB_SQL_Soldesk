package com.lyh.franc.restaurant;

public class Restaurant {
	private String location;
	private String ceo;
	private int seat;
	
	public Restaurant() {
		// TODO Auto-generated constructor stub
	}

	public Restaurant(String location, String ceo, int seat) {
		super();
		this.location = location;
		this.ceo = ceo;
		this.seat = seat;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCeo() {
		return ceo;
	}

	public void setCeo(String ceo) {
		this.ceo = ceo;
	}

	public int getSeat() {
		return seat;
	}

	public void setSeat(int seat) {
		this.seat = seat;
	}
	
	
	
}
