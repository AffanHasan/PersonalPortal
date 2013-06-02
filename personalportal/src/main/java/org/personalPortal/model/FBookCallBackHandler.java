package org.personalPortal.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Properties;

import javax.inject.Inject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.TextInputCallback;
import javax.security.auth.callback.UnsupportedCallbackException;

import org.personalPortal.resources.Resources;

/**
 * <p>The purpose of this CallBackHandler is to retrieve the FBook access token in the 'handle' method from the code which is passed in it's constructor.</p>
 * @author AffanHasan
 */
public class FBookCallBackHandler implements CallbackHandler {
	
	@Inject
	@EnvProperty("fBAccessTokenBaseURL")
	private String fBAccessTokenBaseURL;
	
	@Inject
	@EnvProperty("client_id")
	private String client_id;
	
	@Inject
	@EnvProperty("client_secret")
	private String client_secret;
	
	@Inject
	@EnvProperty("fBRedirectURL")
	private String fBRedirectURL;
	
	private String code;
	
	public FBookCallBackHandler(String code) {
		this.code = code;
	}

	@Override
	public void handle(Callback[] callbacks) throws IOException,
			UnsupportedCallbackException {
		if(callbacks[0] instanceof TextInputCallback){
			Properties environmentProperties = new Properties();
			try {
				//Loading the property file
				environmentProperties.load(Resources.class.getResourceAsStream("environmentProperties.properties"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			TextInputCallback tICB = (TextInputCallback) callbacks[0];
			String accessTokenURL = environmentProperties.getProperty("fBAccessTokenBaseURL") + "?client_id=" +
									environmentProperties.getProperty("client_id") + "&redirect_uri="+ environmentProperties.getProperty("fBRedirectURL")
					+ "&client_secret=" + environmentProperties.getProperty("client_secret") + "&code=" + this.code;
			URL fBAccessTokenURL = new URL(accessTokenURL);
	        BufferedReader in = new BufferedReader(new InputStreamReader(fBAccessTokenURL.openStream()));
	        String token = in.readLine();//in.readLine() will return the access token
	        token = token.substring(13);
			tICB.setText(token);
		}
	}
}