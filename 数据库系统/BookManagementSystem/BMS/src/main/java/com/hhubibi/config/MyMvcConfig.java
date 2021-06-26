package com.hhubibi.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @description: 个性化配置，设置了页面跳转和拦截器
 * @author: hhubibi
 * @create: 2021-04-04 09:03
 */
@Configuration
public class MyMvcConfig implements WebMvcConfigurer {
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
        registry.addViewController("/index").setViewName("index");
        registry.addViewController("/login").setViewName("index");
        registry.addViewController("/book/query").setViewName("queryBook");
        registry.addViewController("/book/add").setViewName("addBook");
        registry.addViewController("/card/query").setViewName("queryCard");
        registry.addViewController("/card/add").setViewName("addCard");
        registry.addViewController("/manager/toupdate").setViewName("updateManager");
        registry.addViewController("/borrow").setViewName("borrowBook");
        registry.addViewController("/return").setViewName("returnBook");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/index", "/", "/manager/loginIn", "/css/*", "/js/*", "/img/*");
    }
}
