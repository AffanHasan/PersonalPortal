package org.personalPortal.resources;

import java.util.Properties;
import java.util.ResourceBundle;
import java.util.logging.Logger;

import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.inject.Inject;

import org.personalPortal.model.EnvProperty;
import org.personalPortal.model.EnvironmentProperties;
import org.personalPortal.model.LocaleProperty;
import org.personalPortal.model.LoggedInUser;
import org.personalPortal.model.PortalUser;

public class PropertyValues {
	
	@Inject
	private Logger logger;
	
	@Produces
	@EnvProperty("")
	private String getEnvProperty(InjectionPoint ip, @EnvironmentProperties Properties envProperties){
		return envProperties.getProperty(ip.getAnnotated().getAnnotation(EnvProperty.class).value());
	}
	
	@Produces
	@LocaleProperty("")
	private String getLocaleProperty(InjectionPoint ip, @LoggedInUser PortalUser user){
		//Since ResourceBundle instances produced by the ResourceBundle.getBundle() factory method
		//are cached by default therefore only one instance for a ResourceBundle will be used for every method call in the following line
//		logger.info("Injection point Info : " + ip.getMember());
		return ResourceBundle.getBundle("org.personalPortal.model.personalPortal", user.getUserLocale()).getString(ip.getAnnotated()
				.getAnnotation(LocaleProperty.class).value());
	}
}