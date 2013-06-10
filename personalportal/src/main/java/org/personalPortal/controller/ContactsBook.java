package org.personalPortal.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

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
				PrintWriter responseWriter = response.getWriter();
				responseWriter.println("[]");//Return am empty list of contacts groups
				responseWriter.close();
			}else {//If contacts book document for this user exists
				//Return the contacts groups list in any
//				System.out.println("contactsBook.keySet() : " + ((contactsBook.keySet().size() > 1) ? contactsBook.keySet() : "[]"));
				//Writing the response
				response.setContentType("application/json");
				PrintWriter responseWriter = response.getWriter();
				responseWriter.println(((contactsBook.keySet().size() > 1) ? contactsBook.keySet() : "[]"));//Return a list of contacts groups
				responseWriter.close();
			}
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