package com.duc.vnpaydemo.Config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.duc.vnpaydemo.repository")
public class JpaConfig {
}
