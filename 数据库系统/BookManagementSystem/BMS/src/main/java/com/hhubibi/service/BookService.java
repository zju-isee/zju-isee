package com.hhubibi.service;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.DBook;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BookService {
    //查询所有书籍
    List<Book> getAllBook();

    //通过书号获得图书
    Book getBook(String bno);

    //删除图书
    int deleteBook(String bno);

    //增加图书
    int addBook(Book book);

    //查找图书
    List<Book> queryBook(DBook dBook);

    //修改图书
    int editBook(Book book);

    //获取图书库存
    int getBookStock(String bno);
}
