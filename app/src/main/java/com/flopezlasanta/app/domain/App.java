package com.flopezlasanta.app.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class App {

	private Long id;
	private String name;
	private String category;
}
