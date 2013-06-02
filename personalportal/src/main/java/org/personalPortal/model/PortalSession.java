package org.personalPortal.model;

import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.inject.Named;
import javax.security.auth.Subject;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.login.AppConfigurationEntry;
import javax.security.auth.login.AppConfigurationEntry.LoginModuleControlFlag;
import javax.security.auth.login.Configuration;
import javax.security.auth.login.LoginContext;
import javax.security.auth.login.LoginException;

import org.personalPortal.services.DocumentCRUDService;

import com.restfb.types.User;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Logger;

@Named
@SessionScoped
public class PortalSession implements IPortalSession, Serializable {

	private static final long serialVersionUID = 1L;
	
	@Inject
	private Logger logger;
	
	private UserAuthenticationTypes userAuthenticationType;
	
	/**
	 * <p>Contains subject inside it.</p>
	 */
	private LoginContext loginContext;
	
	@Inject
	DocumentCRUDService documentCRUDService;
	
	public PortalSession(){
	}
	
	@Override
	public boolean loginUser() {
		//TODO : Implement login using this.loginContext, May be we need to pass the user type FB,Google or general etc.
		return false;
	}
	
	public boolean loginUser(String loginModule, CallbackHandler callBackHandler){
		try {
			this.loginContext = new LoginContext(loginModule, new Subject(), callBackHandler, new AuthConfiguration());
//			this.loginContext = new LoginContext("FaceBookLoginModule"
//					, new Subject(), callBackHandler, new Configuration() {
//				
//				@Override
//				public AppConfigurationEntry[] getAppConfigurationEntry(String name) {
//					AppConfigurationEntry[] entries = new AppConfigurationEntry[1];
//					entries[0] = new AppConfigurationEntry("org.personalPortal.model.FBookAuthenticationModule",
//							LoginModuleControlFlag.REQUISITE, new HashMap());
//					return entries;
//				}
//			});
			this.loginContext.login();//Attempting to login the user
		} catch (LoginException le) {
		    System.err.println("Cannot create LoginContext. "
			        + le.getMessage());
		    return false;
		} catch (SecurityException se) {
			    System.err.println("Cannot create LoginContext. "
			        + se.getMessage());
			    return false;
		}
		//If here it means login attempt was a success
		if(persistLoggedInUser())
			return true;
		else{
			logger.severe("User was successfully authenticated but the application is unable to persist it into the MongoDB");
			return false;
		}
	}

	@Override
	public boolean logoutUser() {
		try {
			this.loginContext.logout();
		} catch (LoginException e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public boolean isUserLoggedIn() {
		if(this.loginContext.getSubject().getPublicCredentials().isEmpty() 
				&& this.loginContext.getSubject().getPrivateCredentials().isEmpty() && this.loginContext.getSubject().getPrincipals().isEmpty()){
			return false;
		}
		else
			return true;
	}

	@Override
	@Produces
	@LoggedInUser
	public PortalUser getLoggedInUser() {
		if(this.isUserLoggedIn()){
			for(Object credential : this.loginContext.getSubject().getPublicCredentials()){
				if(credential instanceof PortalUser){
					return (PortalUser)credential;
				}
			}
			return null;
		}
		else
			return null;
	}
	
	private boolean persistLoggedInUser(){
		//If the user is of FaceBook Authentication type
		if(this.getLoggedInUser() instanceof FBookUser){
			FBookUser fBookUser = (FBookUser) this.documentCRUDService.findOneById(PersonalPortalDBCollections.users.name(), 
												FBookUser.class, "FB" + ((FBookUser)this.getLoggedInUser()).getfBDetails().getId());
			if(fBookUser != null){
				//Setting the logged in FBookUser internal map
				((FBookUser) this.getLoggedInUser()).putAll(fBookUser.toMap());
				return true;
			}else{//If user do not exist in the DB then insert it into the DB
				User user = ((FBookUser) this.getLoggedInUser()).getfBDetails();
				fBookUser = new FBookUser(user);
				fBookUser.put(PortalUserAttributes._id.name(), "FB" + user.getId());
				fBookUser.put(PortalUserAttributes.lang.name(), (user.getLocale() != null && !user.getLocale().equals("")) ? user.getLocale().substring(0, 2) : "en");
				fBookUser.put(PortalUserAttributes.country.name(), (user.getLocale() != null && !user.getLocale().equals("")) ? user.getLocale().substring(3, 5) : "PK");
				//Setting Modules; TODO 'Dynamically decide which modules are permitted to this user'
				ArrayList<String> portalModules = new ArrayList<String>();
				for(PortalModules module : PortalModules.values()){
					portalModules.add(module.name());
				}
				fBookUser.put(PortalUserAttributes.modules.name(), portalModules);
				//Setting Principals; TODO 'Dynamically decide which principals/permissions should be granted to this user'
				ArrayList<String> portalPrincipals = new ArrayList<String>();
				portalPrincipals.add(PortalPrincipals.PORTAL_USER.name());
				fBookUser.put(PortalUserAttributes.principals.name(), portalPrincipals);
//				Persisting the newly created user into the MongoDB
				this.documentCRUDService.persist(fBookUser, PersonalPortalDBCollections.users.name());
				//Setting the logged in FBookUser internal map
				((FBookUser) this.getLoggedInUser()).putAll(fBookUser.toMap());
				return true;
			}
		}
		//TODO: Implement the case for Google authentication type
		
		//TODO: Implement the case for general authentication type
		return false;
	}
	
	public UserAuthenticationTypes getUserAuthenticationType() {
		return userAuthenticationType;
	}

	public void setUserAuthenticationType(
			UserAuthenticationTypes userAuthenticationType) {
		this.userAuthenticationType = userAuthenticationType;
	}
}