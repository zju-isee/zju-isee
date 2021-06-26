package com.hhubibi.config;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @description: 登录拦截器，未登录无法访问除首页外的其它网页
 * @author: hhubibi
 * @create: 2021-04-07 13:35
 */
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 登录成功之后，应该有用户的session
        Object manager = request.getSession().getAttribute("manager");

        if (manager == null) {
            // 没有登录，无法进入图书管理系统
            request.setAttribute("msg", "没有权限，请先登录");
            request.getRequestDispatcher("/index").forward(request, response);
            return false;
        } else {
            return true;
        }
    }
}
