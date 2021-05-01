package com.hhubibi.mapper;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.Manager;

public interface ManagerMapper {
    // 根据id查找是否存在该管理者
    Manager findManager(String mno);

    // 修改管理员
    int editManager(Manager manager);
}
