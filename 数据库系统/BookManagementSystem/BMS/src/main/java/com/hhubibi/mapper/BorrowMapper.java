package com.hhubibi.mapper;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.Record;

import java.util.List;

public interface BorrowMapper {
    //通过借书卡号获取借阅记录
    List<Record> getBorrowByCno(String cno);

    int borrowBook(String cno, String bno, String mno);

    int returnBook(String cno, String bno, String mno);

    List<Record> getBorrowByBno(String bno);
}
