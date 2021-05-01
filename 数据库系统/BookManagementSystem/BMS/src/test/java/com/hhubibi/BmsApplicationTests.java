package com.hhubibi;

import com.hhubibi.entity.Manager;
import com.hhubibi.service.ManagerService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.Reader;

@RunWith(SpringRunner.class)
@SpringBootTest
class BmsApplicationTests {

	@Autowired
	ManagerService managerService;

	@Test
	void contextLoads() {

	}
}
