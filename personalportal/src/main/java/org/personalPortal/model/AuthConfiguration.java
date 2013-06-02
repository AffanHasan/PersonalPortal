package org.personalPortal.model;

import java.util.HashMap;

import javax.security.auth.login.AppConfigurationEntry;
import javax.security.auth.login.Configuration;
import javax.security.auth.login.AppConfigurationEntry.LoginModuleControlFlag;

/**
 * <p>The getAppConfigurationEntry() returns the Login module entries for PersonalPortal.</p>
 * @author AffanHasan
 *
 */
public class AuthConfiguration extends Configuration {

	@Override
	public AppConfigurationEntry[] getAppConfigurationEntry(String name) {
		AppConfigurationEntry[] entries = new AppConfigurationEntry[1];
		
		if(name.equals("FaceBookLoginModule"))//For FaceBookAuthenticationModule
			entries[0] = new AppConfigurationEntry(FBookAuthenticationModule.class.getName(),
				LoginModuleControlFlag.REQUISITE, new HashMap());
		else if(name.equals("GoogleAuthenticationModule")){//For GoogleAuthenticationModule
			//TODO : Return GoogleAuthenticationModule
		}
		else if(name.equals("GeneralAuthenticationModule")){//For GeneralAuthenticationModule
			//TODO : Return GeneralAuthenticationModule
		}
		else if(name.equals("other")){//For GeneralAuthenticationModule
			//TODO : Return GeneralAuthenticationModule
		}
		return entries;
	}
}