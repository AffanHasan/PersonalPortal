package org.personalPortal.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.personalPortal.model.FBookUser;
import org.personalPortal.model.LoggedInUser;
import org.personalPortal.model.PersonalPortalDBCollections;
import org.personalPortal.model.PortalUser;
import org.personalPortal.services.DocumentCRUDService;

import com.mongodb.BasicDBList;
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
		
		if(request.getParameter("action") != null && this.loggedInUser != null)
		switch (request.getParameter("action")) {
		case "getContactsGroupList":
			
			//TODO : check if the contacts book for this user exist or not if not then create one
			if(this.documentCRUDService.findOneById(PersonalPortalDBCollections.contactsBooks.name(), 
					DBObject.class, this.loggedInUser.getId()) == null){//If contacts book do not exist
				DBObject contactsBook = new BasicDBObject();//Create a new contacts book document
				contactsBook.put("_id", this.loggedInUser.getId());
				this.documentCRUDService.persist(contactsBook, PersonalPortalDBCollections.contactsBooks.name());
				//Writing the response
				response.setContentType("application/json");
				PrintWriter responseWriter = response.getWriter();
				responseWriter.println("[]");
				responseWriter.close();
			}else{
				//TODO : load the user contacts book from the data base and check if it contains any contact group
			}
			
			//TODO : If no contact group is present there then return an empty list
			
			//TODO : If groups exist then return a json list of group names
			
			break;

		default:
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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