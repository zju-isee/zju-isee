package com.hhubibi.controller;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.Borrow;
import com.hhubibi.entity.Card;
import com.hhubibi.entity.Record;
import com.hhubibi.service.BookService;
import com.hhubibi.service.BorrowService;
import com.hhubibi.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @description: 借书控制
 * @author: hhubibi
 * @create: 2021-04-05 13:27
 */
@Controller
public class BorrowController {
    @Autowired
    BorrowService borrowService;

    @Autowired
    BookService bookService;

    @Autowired
    CardService cardService;

    @RequestMapping("/book/borrow/cardInfo")
    public String borrowCardInfo(HttpServletRequest request, Model model) {
        String cno = request.getParameter("cno");
        if(cardService.getCard(cno) == null) {
            model.addAttribute("msg", "借书证不存在");
            return "borrowBook";
        }
        List<Record> records = borrowService.getBorrowByCno(cno);
        model.addAttribute("cno", cno);
        model.addAttribute("records", records);
        return "borrowBook";
    }

    @RequestMapping("/book/borrow")
    public String borrowBook(HttpServletRequest request, Model model) {
        String cno = request.getParameter("cno");
        String bno = request.getParameter("bno");
        String mno = request.getParameter("mno");
        if(bookService.getBook(bno) == null) {
            model.addAttribute("bmsg", "图书不存在，不能借阅");
            return "borrowBook";
        } else if (bookService.getBookStock(bno) == 0) {
            model.addAttribute("bmsg", "图书库存为0，不能借阅");
            List<Record> records = borrowService.getBorrowByBno(bno);
            model.addAttribute("cno", cno);
            model.addAttribute("records", records);
            return "returnDate";
        }else {
            model.addAttribute("bmsg", "借书成功");
            borrowService.borrowBook(cno, bno, mno);
            return "borrowBook";
        }
    }

    @RequestMapping("/book/return/cardInfo")
    public String borrowListForReturn(HttpServletRequest request, Model model) {
        String cno = request.getParameter("cno");
        if(cardService.getCard(cno) == null) {
            model.addAttribute("msg", "借书证不存在");
            return "returnBook";
        }
        List<Record> records = borrowService.getBorrowByCno(cno);
        model.addAttribute("cno", cno);
        model.addAttribute("records", records);
        return "returnBook";
    }

    @RequestMapping("/book/return")
    public String returnBook(HttpServletRequest request, Model model) {
        String cno = request.getParameter("cno");
        String bno = request.getParameter("bno");
        String mno = request.getParameter("mno");
        if(bookService.getBook(bno) == null) {
            model.addAttribute("bmsg", "图书不存在，不能还书");
            return "returnBook";
        } else if (borrowService.returnBook(cno, bno, mno) == 0) {
            model.addAttribute("bmsg", "图书库借阅记录不存在，还书失败");
            return "returnBook";
        }else {
            model.addAttribute("bmsg", "还书成功");
        }
        return "returnBook";
    }
}
