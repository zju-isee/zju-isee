package com.hhubibi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description: 管理员类
 * @author: hhubibi
 * @create: 2021-04-03 13:31
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Manager {
    private String mno;
    private String name;
    private String password;
    private String phone_num;
}
