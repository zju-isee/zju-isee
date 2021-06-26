package com.hhubibi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-03 21:18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Card {
    private String cno;
    private String name;
    private String department;
    private String type;
}
