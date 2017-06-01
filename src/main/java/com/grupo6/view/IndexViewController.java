package com.grupo6.view;


import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
	
@Controller
@RequestMapping("/{tenantId}")
public class IndexViewController {
	@RequestMapping(path = "/index")
	public String index(@PathVariable String tenantId, Map<String, Object> model) {
		return "index";
	}
	
	@RequestMapping(path = "/login")
	public String login(@PathVariable String tenantId, Map<String, Object> model) {
		return "login";
	}
	
	@RequestMapping(path = "/register")
	public String register(@PathVariable String tenantId, Map<String, Object> model) {
		return "register";
	}
}