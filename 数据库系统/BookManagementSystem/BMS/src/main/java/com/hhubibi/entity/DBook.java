package com.hhubibi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description: 区间查询使用
 * @author: hhubibi
 * @create: 2021-04-05 12:20
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DBook extends Book{
    private Integer year2;
    private float price2;
}
