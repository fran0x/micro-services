package com.flopezlasanta.app.service;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.flopezlasanta.app.domain.App;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/app")
@Slf4j
public class AppService {

	// sample usage: curl $HOST:$PORT/app/1
	@RequestMapping("/{id}")
	public Product getApp(@PathVariable Long id) {
		log.info("/app called");
		return new Product(id, "name", "category");
	}
}
