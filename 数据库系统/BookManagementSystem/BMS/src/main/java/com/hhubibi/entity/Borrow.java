package com.hhubibi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-03 21:18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Borrow {
    private String bno;
    private String cno;
    private Date borrow_date;
    private Date return_date;
    private String mno;
}
