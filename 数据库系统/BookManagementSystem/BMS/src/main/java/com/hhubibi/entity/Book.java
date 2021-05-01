package com.hhubibi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description: 书类
 * @author: hhubibi
 * @create: 2021-04-03 16:14
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Book {
    private String bno;
    private String category;
    private String title;
    private String press;
    private Integer year;
    private String author;
    private float price;
    private Integer total;
    private Integer stock;
}
