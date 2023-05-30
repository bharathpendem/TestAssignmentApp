package com.rest.api.controller;

import java.time.Clock;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/utc")
public class Controller {

	@GetMapping("/time")
	public String getTime() {
		
		DateTimeFormatter dtf= DateTimeFormatter.ofPattern("HH:mm:ss");
		LocalDateTime now =LocalDateTime.now(Clock.systemUTC());
		String time=dtf.format(now);
		
		return "Current UTC Time is " + time +"  Automate All The Things";
	}

}
