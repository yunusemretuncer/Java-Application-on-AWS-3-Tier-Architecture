package com.yunus.loginapp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Java App Running on AWS 3-Tier Architecture 🚀";
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
