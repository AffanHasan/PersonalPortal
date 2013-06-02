package org.personalPortal.model;

import java.util.List;
import java.util.Locale;
import java.util.Set;

/**
 * <p>Describes what a portal user must do; such as returning it's current locale & list of allowed modules</p>
 * 
 * @author AffanHasan
 */
public interface IPortalUser {
	
	public Locale getUserLocale();
	
	/**
	 * <p>Returns the id of a user. Subclasses may override to provide different implementations</p>
	 */
	public String getId();
	
	/**
	 * @return A 2 character code for a user's language; en for English, ar for Arabic etc.
	 */
	public String getUserLanguage();
	
	public String getUserEmail();
	
	public Gender getGender();
	
	/**
	 * <p>Returns the list of 'PortalModules' accessible to this user</p>
	 * @param module
	 * @return
	 */
	public Set<PortalModules> getAllowedModulesSet();
	
	/**
	 * <p>Checks whether a module is allowed to a user</p>
	 * @param module
	 * @return
	 */
	public boolean isModuleAllowed(PortalModules module);
	
	/**
	 * It returns a set of principals granted to this user
	 */
	public List<PortalPrincipals> getPrincipals();
}