package com.jordan.eventstudio.conf;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import com.jordan.conf.Config;


@Component
@ConfigurationProperties(prefix = "module")
public class StudioConfig extends Config {


	private String foo;

	private String bar;


	private List<String> servers = new ArrayList<>();


	public String getFoo() {
		return foo;
	}

	public void setFoo(String foo) {
		this.foo = foo;
	}

	public List<String> getServers() {
		return this.servers;
	}

	public String getBar() {
		return bar;
	}

	public void setBar(String bar) {
		this.bar = bar;
	}

}
