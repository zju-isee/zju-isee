package com.hhubibi.controller;

import com.hhubibi.entity.Manager;
import com.hhubibi.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @description: 管理员登录和退出系统控制
 * @author: hhubibi
 * @create: 2021-04-03 13:32
 */
@Controller
public class LoginController {

    @Autowired
    ManagerService managerService;

    /**
     * @description 登录控制
     * @return 登录之后的页面
     */
    @RequestMapping("/manager/loginIn")
    public String loginIn(Model model, HttpServletRequest request) {
        String mno = request.getParameter("mno");
        String password = request.getParameter("password");
        // 先进行账号密码是否为空的判断
        if(mno == null) {  // 账号为空
            model.addAttribute("msg", "账号不能为空");
            return "index";
        }
        if(password == null) { // 密码为空
            model.addAttribute("msg", "密码不能为空");
            return "index";
        }
        //从数据库中寻找管理员
        Manager manager = managerService.findManager(mno);
        if(manager != null) {  //找到了管理员
            if(manager.getPassword().equals(password)) { // 账号密码匹配
                model.addAttribute("manager", manager);
                request.getSession().setAttribute("manager", manager);
                return "main";
            } else {  // 密码错误
                model.addAttribute("msg", "密码错误");
                return "index";
            }
        } else {
            model.addAttribute("msg", "账号不存在");
            return "index";
        }
    }

    /**
     * @description 退出操作
     * @return 主页面
     */
    @RequestMapping("/manager/loginOut")
    public String loginOut(HttpServletRequest request) {
        request.getSession().removeAttribute("manager");
        return "redirect:/index";
    }
}
