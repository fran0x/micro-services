package com.flopezlasanta.app;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@Controller
@EnableDiscoveryClient
@Slf4j
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
		log.info("App Service started!");
	}
	
    @RequestMapping("/home")
    public String home(Model model){
        final InetAddress localHost;
        try {
            localHost = InetAddress.getLocalHost();
            model.addAttribute("host", localHost.getHostName());
            model.addAttribute("ip", localHost.getHostAddress());
        } catch (UnknownHostException e) {
            log.warn("An exception occurred while trying to determine the host and IP address: {}", e);
        }
        return "home";
    }
}
