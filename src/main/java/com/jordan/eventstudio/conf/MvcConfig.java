package com.jordan.eventstudio.conf;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.validation.MessageCodesResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.jordan.eventstudio.api.StudioInterceptor;

@Configuration
public class MvcConfig extends WebMvcConfigurerAdapter {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// registry.addInterceptor(getBootstrapInterceptor());
		super.addInterceptors(registry);
	}

	@Override
	public MessageCodesResolver getMessageCodesResolver() {
		return super.getMessageCodesResolver();
	}

	@Bean
	public StudioInterceptor getBootstrapInterceptor() {
		return new StudioInterceptor();
	}
}
