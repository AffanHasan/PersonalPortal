package org.jboss.samples.webservices;

import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/HelloWorld")
public class HelloWorld {

	@GET()
	@Produces("text/plain")
	public String sayHello() {
	    return "Hello World!";
	}
}
