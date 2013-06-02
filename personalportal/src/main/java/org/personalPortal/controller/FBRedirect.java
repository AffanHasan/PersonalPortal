package org.personalPortal.controller;
import java.io.IOException;
import java.util.logging.Logger;

import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.personalPortal.model.EnvProperty;
import org.personalPortal.model.FBookCallBackHandler;
import org.personalPortal.model.LocaleProperty;
import org.personalPortal.model.PortalSession;

@WebServlet(urlPatterns="/FBRedirect")
public class FBRedirect extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Inject
	@EnvProperty("afterLoginRedirectURL")
	private String afterLoginRedirectURL;

	@Named
	@Produces
	private String getFBAuthDialogURL(@EnvProperty("fBAuthDialogBaseURL") String fBAuthDialogBaseURL,
									  @EnvProperty("scope") String scope, @EnvProperty("client_id") String client_id
									  ,@EnvProperty("fBRedirectURL") String fBRedirectURL){
		return fBAuthDialogBaseURL + 
				 "?client_id=" + client_id + "&" + "redirect_uri=" + fBRedirectURL + "&"
				 	+ scope;
	}
	
	@Produces
	@Named("personalPortal_TXT")
	private String getSomeVal(@LocaleProperty("personalPortal") String message){
		return message;
	}
	
	@Inject
	private PortalSession portalSession;
	
	@Inject
	private Logger logger;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Attempting to login the user to PersonalPortal
		this.portalSession.loginUser("FaceBookLoginModule", new FBookCallBackHandler(request.getParameter("code")));
		
		//redirecting the response
		response.sendRedirect(afterLoginRedirectURL);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}