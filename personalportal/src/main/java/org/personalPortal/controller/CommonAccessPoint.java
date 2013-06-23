package org.personalPortal.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.personalPortal.model.LoggedInUser;
import org.personalPortal.model.PortalUser;

import com.mongodb.util.JSON;

/**
 * Servlet implementation class CommonAccessPoint
 */
@WebServlet(description = "Intended for those requests which are common in all modules such as getting applicaiton wide common UI data", urlPatterns = { "/CommonAccessPoint" })
public class CommonAccessPoint extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Inject @LoggedInUser
	private PortalUser loggedInUser;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommonAccessPoint() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("action") != null && this.loggedInUser != null){
			PrintWriter responseWriter = response.getWriter();
			switch (request.getParameter("action")) {
			case "getLoggedInUserLocale":
				//Writing the response
				response.setContentType("text/plain");
				responseWriter = response.getWriter();
				responseWriter.println(this.loggedInUser.getUserLocale().toString());
				responseWriter.close();
				return;
			case "getPortalWideCommUIData":
					ResourceBundle bundle = ResourceBundle.getBundle("org.personalPortal.model.personalPortal", 
							loggedInUser.getUserLocale());
					Map<String, String> responseObject = new LinkedHashMap<String, String>();
					for(String key : bundle.keySet()){
						responseObject.put(key, bundle.getString(key));
					}
					//Writing the response
					response.setContentType("application/json");
					responseWriter.println(JSON.serialize(responseObject));
					responseWriter.close();
					return;
			default:
				break;
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
