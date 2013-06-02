package org.personalPortal.model;

import java.io.IOException;
import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.TextInputCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.FailedLoginException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;

public class FBookAuthenticationModule implements LoginModule{
	
	private Subject subject;
	
	private CallbackHandler callbackHandler;
	
	private FBookUser fBookUser = null;
	
	@Override
	public boolean abort() throws LoginException {
		return false;
	}
	
	public FBookAuthenticationModule(){
		
	}
	

	@Override
	public void initialize(Subject subject, CallbackHandler callbackHandler,
			Map<String, ?> sharedState, Map<String, ?> options) {
		this.subject = subject;
		this.callbackHandler = callbackHandler;
	}

	/* It only checks whether the access token is correct or not if correct then it means the authentication succeeds else authentication fails
	 * If authentication succeeds then it populates the 'this.fBookUser' property
	 * It is the responsibility of the caller to persist the user into the data base if it was not present into the DB 
	 * @see javax.security.auth.spi.LoginModule#login()
	 */
	@Override
	public boolean login() throws LoginException {

		if(this.callbackHandler != null){
			String accessToken = null;
			FacebookClient fBClient = null;
			Callback[] callbacks = new Callback[1];
			callbacks[0] = new TextInputCallback("Prompt!...");
			try {
				this.callbackHandler.handle(callbacks);
				accessToken = ((TextInputCallback) callbacks[0]).getText();
				//If unable to get an access token
				if(accessToken == null || accessToken.equals("")){//Authentication fails
					throw new FailedLoginException("Access token is null or unable to get an access token");
				}
				if(accessToken != null && !accessToken.equals("")){
					fBClient = new DefaultFacebookClient(accessToken.substring(0, accessToken.indexOf("&")));//Fetching FB client from FaceBook using the retrieved token from callback handler
					
					if(fBClient != null){//If fBClient is not null then it means authentication is successfull
						//Fetching the user's FaceBook information
						User user = fBClient.fetchObject("me", User.class);
						this.fBookUser = new FBookUser(user);
						return true;
					}
				}
				
				
			} catch (IOException | FailedLoginException | UnsupportedCallbackException e) {
				e.printStackTrace();
				throw new LoginException("Unable To Perform authentication");
			}
			
		}
		return false;
	}

	/* 
	 * This method will be called after the over all authentication of the loginContext succeeds
	 * i.e. (the relevant REQUIRED, REQUISITE, SUFFICIENT and OPTIONAL LoginModules succeeded).
	 *  
	 * @see javax.security.auth.spi.LoginModule#commit()
	 */
	@Override
	public boolean commit() throws LoginException {
		//Starting the login process
		this.subject.getPrincipals().add(new PortalUserPrincipal(PortalPrincipals.PORTAL_USER));//Adding principal PORTAL_USER to the subject
		this.subject.getPublicCredentials().add(fBookUser);//Adding 'fBookUser' to subject's public credentials
		//Done login
		return true;
	}
	
	@Override
	public boolean logout() throws LoginException {
		this.subject.getPrincipals().clear();
		this.subject.getPublicCredentials().clear();
		this.subject.getPrivateCredentials().clear();
		return false;
	}
	
}
