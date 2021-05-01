package com.hhubibi.service;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.Record;

import java.util.List;

public interface BorrowService {
    List<Record> getBorrowByCno(String cno);

    int borrowBook(String cno, String bno, String mno);

    int returnBook(String cno, String bno, String mno);

    List<Record> getBorrowByBno(String bno);
}
