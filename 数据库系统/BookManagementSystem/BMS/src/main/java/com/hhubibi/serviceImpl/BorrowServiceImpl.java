package com.hhubibi.serviceImpl;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.Record;
import com.hhubibi.mapper.BorrowMapper;
import com.hhubibi.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-05 13:46
 */
@Service
public class BorrowServiceImpl implements BorrowService {

    @Autowired
    BorrowMapper borrowMapper;

    @Override
    public List<Record> getBorrowByCno(String cno) {
        return borrowMapper.getBorrowByCno(cno);
    }

    @Override
    public int returnBook(String cno, String bno, String mno) {
        return borrowMapper.returnBook(cno, bno, mno);
    }

    @Override
    public List<Record> getBorrowByBno(String bno) {
        return borrowMapper.getBorrowByBno(bno);
    }

    @Override
    public int borrowBook(String cno, String bno, String mno) {
        return borrowMapper.borrowBook(cno, bno, mno);
    }
}
