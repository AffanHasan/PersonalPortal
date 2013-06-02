package org.personalPortal.model;

import java.io.Serializable;
import java.security.Principal;

public class PortalUserPrincipal implements Principal, Serializable {

	private static final long serialVersionUID = 1L;
	
	private PortalPrincipals portalPrincipal;
	
	public PortalUserPrincipal(PortalPrincipals portalPrincipal) {
		this.portalPrincipal = portalPrincipal;
	}

	@Override
	public String getName() {
		return this.portalPrincipal.name();
	}

}
