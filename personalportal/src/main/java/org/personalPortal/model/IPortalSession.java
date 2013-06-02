package org.personalPortal.model;

/**
 * Describes basic responsibilities of a portal session
 * 
 * @author AffanHasan
 *
 */
public interface IPortalSession {
	
	/**
	 * @param portalUser
	 * @return true is login succeed false if failed
	 */
	public boolean loginUser();
	
	/**
	 * @return true if logout succeed false if failed
	 */
	public boolean logoutUser();
	
	public boolean isUserLoggedIn();
	
	/**
	 * <p>It searches for the an 'PortalUser' in the LoginContext.subject credentials and returns it if found.</p>
	 * @return PortalUser if a user is logged in else return null
	 */
	public PortalUser getLoggedInUser();
	
}