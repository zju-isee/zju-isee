package com.hhubibi.serviceImpl;

import com.hhubibi.entity.Manager;
import com.hhubibi.mapper.ManagerMapper;
import com.hhubibi.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-03 13:33
 */
@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerMapper managerMapper;

    @Override
    public Manager findManager(String mno) {
        return managerMapper.findManager(mno);
    }

    @Override
    public int editManager(Manager manager) {
        return managerMapper.editManager(manager);
    }
}
