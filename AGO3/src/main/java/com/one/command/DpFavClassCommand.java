package com.one.command;

public class DpFavClassCommand extends ClassCommand{
	private boolean fav = false;
	private int count = 0;

	public Boolean getFav() {
		return fav;
	}

	public void setFav(boolean fav) {
		this.fav = fav;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
}
