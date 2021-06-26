package com.hhubibi.service;

import com.hhubibi.entity.Manager;

public interface ManagerService {
    Manager findManager(String mno);
    // 修改管理员
    int editManager(Manager manager);
}
