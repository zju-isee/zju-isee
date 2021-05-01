package com.hhubibi.controller;

import com.hhubibi.entity.Manager;
import com.hhubibi.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ManagerController {
    @Autowired
    ManagerService managerService;

    @RequestMapping("/manager/update")
    public String updateManager(Manager manager, Model model, HttpServletRequest request) {
        managerService.editManager(manager);
        request.getSession().setAttribute("manager", manager);
        model.addAttribute("msg", "修改成功");
        return "updateManager";
    }
}
