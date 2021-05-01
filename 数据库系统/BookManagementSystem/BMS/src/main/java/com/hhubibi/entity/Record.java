package com.hhubibi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Date;

/**
 * @description: 借阅记录
 * @author: hhubibi
 * @create: 2021-04-07 21:02
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Record extends Book{
    private Date borrow_date;
    private Date return_date;
}
