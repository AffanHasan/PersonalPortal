package org.personalPortal.model;

import java.util.Set;

import com.restfb.types.User;

public class FBookUser extends PortalUser {

	private static final long serialVersionUID = 1L;
	
	private User fBDetails;
	
	public FBookUser(){
		
	}
	
	public FBookUser(User user){
		this.fBDetails = user;
	}
	
	@Override
	public String getUserEmail() {
		return this.fBDetails.getEmail();
	}

	@Override
	public Gender getGender() {
		switch (this.fBDetails.getGender()) {
		case "male":
			return Gender.MALE;
		case "female":
			return Gender.FEMALE;
		default:
			return null;
		}
	}
	
	/**
	 * @return The private fBDetails field; this field is of 'com.restfb.types.User' type
	 */
	public User getfBDetails() {
		return fBDetails;
	}

	/**
	 * @param fBDetails; This field is of 'com.restfb.types.User' type
	 */
	public void setfBDetails(User fBDetails) {
		this.fBDetails = fBDetails;
	}
}