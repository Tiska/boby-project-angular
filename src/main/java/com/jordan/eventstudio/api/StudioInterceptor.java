package com.jordan.eventstudio.api;

import com.jordan.api.JordanInterceptor;
import com.jordan.async.AbstractRequestContext;
import com.jordan.auth.Secure;
import com.jordan.eventstudio.RequestContext;

public class StudioInterceptor extends JordanInterceptor {

	@Override
	protected AbstractRequestContext createContext(Secure secure, String token) {
		RequestContext context = new RequestContext(token);
		// TODO
		return context;
	}
}
