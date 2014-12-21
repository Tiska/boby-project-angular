package com.jordan.eventstudio;

import com.jordan.async.AbstractRequestContext;

public class RequestContext extends AbstractRequestContext {


	public RequestContext(String token) {
		super(token);
	}


	public static RequestContext get() {
		return (RequestContext) AbstractRequestContext.get();
	}


}
