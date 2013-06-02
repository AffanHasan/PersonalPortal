package org.personalPortal.resources;

import java.net.UnknownHostException;
import java.util.Properties;
import java.util.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.faces.context.FacesContext;
import javax.security.auth.callback.CallbackHandler;
import javax.servlet.http.HttpServletRequest;

import org.personalPortal.model.EnvironmentProperties;

import com.mongodb.MongoClient;

/**
 * This class uses CDI to alias Java EE resources, such as the persistence context, to CDI beans
 * 
 * @author AffanHasan
 */
public class Resources {
	
	@Produces
	@RequestScoped
	@EnvironmentProperties
	private Properties getEnvironmentProperties(){
		Properties environmentProperties = new Properties();
		try {
			//Loading the property file
			environmentProperties.load(Resources.class.getResourceAsStream("environmentProperties.properties"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return environmentProperties;
	}
	
   @Produces
   private Logger produceLog(InjectionPoint injectionPoint) {
      return Logger.getLogger(injectionPoint.getMember().getDeclaringClass().getName());
   }
   
   @Produces
   @ApplicationScoped
   private MongoClient getMongoClient(){
	   try {
		   System.out.println("Returning Application Scoped MongoClient");
		return new MongoClient();
	} catch (UnknownHostException e) {
		e.printStackTrace();
		return null;
	}
   }
   
}