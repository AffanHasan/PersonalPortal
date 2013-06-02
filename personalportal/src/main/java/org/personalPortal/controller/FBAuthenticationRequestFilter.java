package org.personalPortal.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import org.personalPortal.model.PortalSession;
import org.personalPortal.model.UserAuthenticationTypes;

/**
 * <p>The sole purpose of this filter is to intercept the /FBRedirect servlet request</p>
 * @author AffanHasan
 *
 */
@WebFilter(urlPatterns = {"/FBRedirect"})
public class FBAuthenticationRequestFilter implements Filter {
	
	@Inject
	private PortalSession portalSession;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		portalSession.setUserAuthenticationType(UserAuthenticationTypes.FACE_BOOK_AUTHENTICATION);
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
