package com.hhubibi.controller;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.DBook;
import com.hhubibi.entity.Record;
import com.hhubibi.service.BookService;
import com.hhubibi.service.BorrowService;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.List;

/**
 * @description: 图书操作
 * @author: hhubibi
 * @create: 2021-04-03 17:00
 */
@Controller
public class BookController {

    @Autowired
    BookService bookService;

    @Autowired
    BorrowService borrowService;

    /**
     * @description 展示所有图书
     * @return 展示所有图书的网页
     */
    @RequestMapping("/book/list")
    public String listBook(Model model) {
        List<Book> books = bookService.getAllBook();
        model.addAttribute("books", books);
        return "listBooks";
    }

    /**
     * @describe 根据关键字进行模糊查找，必须包括关键字
     * @return 展示查询页面
     */
    @RequestMapping("/book/queryResults")
    public String queryBook(Model model, HttpServletRequest request) {
        DBook dbook = new DBook();

        //均为模糊查找，结果按书名排序
        String category = request.getParameter("category");
        if(!StringUtils.isBlank(category)) {
            dbook.setCategory("%"+category+"%");
        }
        String title = request.getParameter("title");
        if(!StringUtils.isBlank(title)) {
            dbook.setTitle("%"+title+"%");
        }
        String press = request.getParameter("press");
        if(!StringUtils.isBlank(press)) {
            dbook.setPress("%"+press+"%");
        }
        String author = request.getParameter("author");
        if(!StringUtils.isBlank(author)) {
            dbook.setAuthor("%"+author+"%");
        }
        String prices = request.getParameter("price");
        if(!StringUtils.isBlank(prices)) {
            String[] priceArray = prices.split("-");
            if(priceArray.length == 2) {
                dbook.setPrice(Float.parseFloat(priceArray[0]));
                dbook.setPrice2(Float.parseFloat(priceArray[1]));
            }
        }
        String years = request.getParameter("year");
        if(!StringUtils.isBlank(years)) {
            String[] yearArray = years.split("-");
            if(yearArray.length == 2) {
                dbook.setYear(Integer.parseInt(yearArray[0]));
                dbook.setYear2(Integer.parseInt(yearArray[1]));
            }
        }
        List<Book> books = bookService.queryBook(dbook);
        model.addAttribute("books", books);
        return "queryBook";
    }

    /**
     * @describe 插入图书前判断是否存在该编号，存在则不增加
     * @return 向前端反馈信息，停留在添加图书界面
     */
    @RequestMapping("/book/addOne")
    public String addBookOne(Book book, Model model) {
        if(bookService.getBook(book.getBno()) != null) {
            model.addAttribute("msg","图书编号重复，增加失败");
            return "addBook";
        }
        book.setStock(book.getTotal());
        bookService.addBook(book);
        model.addAttribute("msg","图书添加成功");
        return "addBook";
    }

    /**
     * @describe 判断文件格式是否为excel，java解析错误则抛出异常，错误处理待完善，msg为向前端反馈的错误信息
     * @reference https://www.cnblogs.com/linjiqin/p/10975761.html
     * @return 重定向至全部图书页面
     */
    @RequestMapping("/book/addBatch")
    public String addBookBatch(MultipartFile file, HttpServletRequest request, Model model) throws Exception{
        String fileName = file.getOriginalFilename();
        if (!fileName.matches("^.+\\.(?i)(xls)$") && !fileName.matches("^.+\\.(?i)(xlsx)$")) {
            model.addAttribute("msg","上传文件格式不正确，文件仅支持*.xls和*.xlsx");
            return "addBook";
        }
        Workbook workbook = null;

        try {
            InputStream is = file.getInputStream();
            if (fileName.endsWith("xlsx")) {
                workbook = new XSSFWorkbook(is);
            }
            if (fileName.endsWith("xls")) {
                workbook = new HSSFWorkbook(is);
            }
            if(workbook != null) {
                //默认读取第一个sheet
                Sheet sheet = workbook.getSheetAt(0);
                for(int i = sheet.getFirstRowNum(); i <= sheet.getLastRowNum(); ++i) {
                    Row row = sheet.getRow(i);
                    if(row == null) {
                        continue;
                    }
                    Book book = new Book();

                    // 需要先将单元格的内容全部转化为字符串再进行格式转换
                    row.getCell(0).setCellType(CellType.STRING);
                    String bno = row.getCell(0).getStringCellValue();
                    row.getCell(1).setCellType(CellType.STRING);
                    String category = row.getCell(1).getStringCellValue();
                    row.getCell(2).setCellType(CellType.STRING);
                    String title = row.getCell(2).getStringCellValue();
                    row.getCell(3).setCellType(CellType.STRING);
                    String press = row.getCell(3).getStringCellValue();
                    row.getCell(4).setCellType(CellType.STRING);
                    Integer year = NumberUtils.toInt(row.getCell(4).getStringCellValue());
                    row.getCell(5).setCellType(CellType.STRING);
                    String author = row.getCell(5).getStringCellValue();
                    row.getCell(6).setCellType(CellType.STRING);
                    float price = NumberUtils.toFloat(row.getCell(6).getStringCellValue());
                    row.getCell(7).setCellType(CellType.STRING);
                    Integer total = NumberUtils.toInt(row.getCell(7).getStringCellValue());

                    book.setBno(bno);
                    book.setCategory(category);
                    book.setTitle(title);
                    book.setPress(press);
                    book.setYear(year);
                    book.setAuthor(author);
                    book.setPrice(price);
                    book.setTotal(total);
                    book.setStock(total);
                    bookService.addBook(book);
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg","parse excel exception: "+e.toString());
            return "addBook";
        } finally {
            if (workbook != null) {
                try {
                    workbook.close();
                } catch (Exception e) {
                    model.addAttribute("msg","parse excel exception: "+e.toString());
                    return "addBook";
                }
            }
        }
        //插入成功则返回界面
        return "redirect:/book/list";
    }

    /**
     * @describe 更新图书信息
     * @return 重定向至全部图书页面
     */
    @RequestMapping("/book/update/{bno}")
    public String toUpdateBook(@PathVariable("bno") String bno, Model model) {
        Book book = bookService.getBook(bno);
        model.addAttribute("book", book);
        return "updateBook";
    }

    @RequestMapping("/book/update")
    public String updateBook(Book book) {
        bookService.editBook(book);
        return "redirect:/book/list";
    }

    @RequestMapping("/book/delete/{bno}")
    public String deleteBook(@PathVariable("bno") String bno, RedirectAttributes attr) {
        List<Record> records = borrowService.getBorrowByBno(bno);

        if (records.size() != 0) {
            attr.addAttribute("msg","该书有借阅记录，不能删除");
            return "redirect:/book/list";
        }
        bookService.deleteBook(bno);
        return "redirect:/book/list";
    }
}
