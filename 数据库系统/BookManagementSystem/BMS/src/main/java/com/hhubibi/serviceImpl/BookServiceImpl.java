package com.hhubibi.serviceImpl;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.DBook;
import com.hhubibi.mapper.BookMapper;
import com.hhubibi.service.BookService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-03 16:38
 */
@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<Book> getAllBook() {
        return bookMapper.getAllBook();
    }

    @Override
    public Book getBook(String bno) {
        return bookMapper.getBook(bno);
    }

    @Override
    public int deleteBook(String bno) {
        return bookMapper.deleteBook(bno);
    }

    @Override
    public List<Book> queryBook(DBook dBook) { return bookMapper.queryBook(dBook); }

    @Override
    public int addBook(Book book) {
        return bookMapper.addBook(book);
    }

    @Override
    public int editBook(Book book) {
        return bookMapper.editBook(book);
    }

    @Override
    public int getBookStock(String bno) {
        return bookMapper.getBookStock(bno);
    }
}
