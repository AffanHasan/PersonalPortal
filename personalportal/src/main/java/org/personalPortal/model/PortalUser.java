package org.personalPortal.model;

import java.io.Serializable;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.logging.Logger;

import javax.inject.Inject;

import com.mongodb.BasicDBObject;

/**
 * <p>Abstract class for a portal user.</p>
 * 
 * @author AffanHasan
 */
public abstract class PortalUser extends BasicDBObject implements Serializable, IPortalUser {

	private static final long serialVersionUID = 1L;
	
	@Inject
	protected Logger logger;
	
	private Locale userLocale;
	
	/**
	 * @param lang A 2 character representation of user's language
	 * @param country A 2 character representation of user's country 
	 */
	public void setUserLocale(String lang, String country){
		try{
			this.userLocale = new Locale(lang, country);
		}catch(NullPointerException e){
			logger.severe("Language and country cannot be null & must be provided");
		}
	}

	@Override
	public Locale getUserLocale() {
		if(this.userLocale != null){
			return this.userLocale;
		}else{
			return this.userLocale = new Locale(super.getString("lang"), super.getString("country"));
		}
	}

	@Override
	public Set<PortalModules> getAllowedModulesSet() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isModuleAllowed(PortalModules module) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getUserLanguage() {
		return super.getString("lang");
	}
	
	@Override
	public String getId() {
		return super.getString("_id");
	}
	
	@Override
	public List<PortalPrincipals> getPrincipals() {
		 super.get(PortalUserAttributes.principals.name());
		return null;
	}
}