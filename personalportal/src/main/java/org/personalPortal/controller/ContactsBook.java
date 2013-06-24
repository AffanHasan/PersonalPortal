package org.personalPortal.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.personalPortal.model.LoggedInUser;
import org.personalPortal.model.PersonalPortalDBCollections;
import org.personalPortal.model.PortalUser;
import org.personalPortal.services.DocumentCRUDService;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

/**
 * Servlet implementation class ContactsBook
 */
@WebServlet(description = "This servlet will serve the data requests for Contacts Book SPA", urlPatterns = { "/ContactsBook" })
public class ContactsBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Inject @LoggedInUser
	private PortalUser loggedInUser;
	
	@Inject
	DocumentCRUDService documentCRUDService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactsBook() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#getServletConfig()
	 */
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see Servlet#getServletInfo()
	 */
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null; 
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter responseWriter = response.getWriter();
		if(request.getParameter("action") != null && this.loggedInUser != null)
		switch (request.getParameter("action")) {
		case "getContactsGroupList":
			DBObject contactsBook = this.documentCRUDService.findOneById(PersonalPortalDBCollections.contactsBooks.name(), 
					BasicDBObject.class, this.loggedInUser.getId());
			//Checking if the contacts book for this user exist or not
			if(contactsBook == null){//If contacts book do not exist
				contactsBook = new BasicDBObject();//Create a new contacts book document
				contactsBook.put("_id", this.loggedInUser.getId());
				this.documentCRUDService.persist(contactsBook, PersonalPortalDBCollections.contactsBooks.name());//Persist the empty contacts book
				//Writing the response
				response.setContentType("application/json");
				responseWriter.println("[]");//Return am empty list of contacts groups
				responseWriter.close();
			}else {//If contacts book document for this user exists
				//Writing the response
				Set<String> groupNames = new LinkedHashSet<String>();
				for(String group : contactsBook.keySet()){
					if(!group.equals("_id")){
						groupNames.add(group);
					}
				}
				response.setContentType("application/json");
				responseWriter.println(((contactsBook.keySet().size() > 1) ? JSON.serialize(groupNames) : "[]"));//Return a list of contacts groups
				responseWriter.close();
			}
			break;
		case "getCBLocaleWiseData"://Get locale wise data for contacts book
			ResourceBundle bundle = ResourceBundle.getBundle("org.personalPortal.model.contacts_book", 
					loggedInUser.getUserLocale());
			Map<String, String> responseObject = new LinkedHashMap<String, String>();
			for(String key : bundle.keySet()){
				responseObject.put(key, bundle.getString(key));
			}
			//Writing the response
			response.setContentType("application/json");
			responseWriter = response.getWriter();
			responseWriter.println(JSON.serialize(responseObject));
			responseWriter.close();
			break;
		case "getContactsListForAGroup"://Getting a list of contacts documents for a group
			response.setContentType("application/json");
			responseWriter.println(JSON.serialize(((BasicDBObject) this.documentCRUDService.findOneById("contactsBooks", BasicDBObject.class, this.loggedInUser.getId()))
					.get(request.getParameter("groupName"))));//Return a list of contacts in the requested group
			responseWriter.close();
			break;
		default:
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("action") != null && this.loggedInUser != null)
		switch (request.getParameter("action")) {
		case "addSingleContact":
			String zAPIInputStringP = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(
			                request.getInputStream()));
			String line = in.readLine();
			while (line != null) {
			    zAPIInputStringP += line;
			    line = in.readLine();
			}
			System.out.println(zAPIInputStringP);
			//Parse the request JSON into object
			BasicDBObject requestJSON = (BasicDBObject) JSON.parse(zAPIInputStringP);
	    	BasicDBObject query = new BasicDBObject();
	    	query.append("_id", this.loggedInUser.getId());
	    	BasicDBObject operationDoc = new BasicDBObject();
	    	operationDoc.append("$push", ( new BasicDBObject() ).append(requestJSON.get("groupName").toString()
	    			, requestJSON.get("contactDocument")));
			if(this.documentCRUDService.update(query, operationDoc, "contactsBooks")){
				//Writing the response
				response.setContentType("text/plain");
				PrintWriter responseWriter = response.getWriter();
				responseWriter.println("saved");
				responseWriter.close();
			}else{
				//Writing the response
				response.setContentType("text/plain");
				PrintWriter responseWriter = response.getWriter();
				responseWriter.println("not_saved");
				responseWriter.close();
			}
			break;
		default:
			break;
		}
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doHead(HttpServletRequest, HttpServletResponse)
	 */
	protected void doHead(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doOptions(HttpServletRequest, HttpServletResponse)
	 */
	protected void doOptions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doTrace(HttpServletRequest, HttpServletResponse)
	 */
	protected void doTrace(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}