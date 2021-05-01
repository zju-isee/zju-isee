package com.hhubibi.controller;

import com.hhubibi.entity.Book;
import com.hhubibi.entity.Card;
import com.hhubibi.entity.Record;
import com.hhubibi.service.BorrowService;
import com.hhubibi.service.CardService;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.List;
import java.util.concurrent.Callable;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-05 17:34
 */
@Controller
public class CardController {
    @Autowired
    CardService cardService;

    @Autowired
    BorrowService borrowService;

    /**
     * @description 展示所有借书证
     * @return 展示所有借书证的网页
     */
    @RequestMapping("/card/list")
    public String listCard(Model model) {
        List<Card> cards = cardService.getAllCard();
        model.addAttribute("cards", cards);
        return "listCards";
    }

    /**
     * @describe 根据关键字进行精确查找
     * @return 展示查询页面
     */
    @RequestMapping("/card/queryResults")
    public String queryCard(Model model, HttpServletRequest request) {
        Card card = new Card();

        // 精确查找
        String cno = request.getParameter("cno");
        if(!StringUtils.isBlank(cno)) {
            card.setCno(cno);
        }

        String name = request.getParameter("name");
        if(!StringUtils.isBlank(name)) {
            card.setName(name);
        }

        List<Card> cards = cardService.queryCard(card);
        model.addAttribute("cards", cards);
        return "queryCard";
    }

    /**
     * @describe 插借书证前判断是否存在该编号，存在则不增加
     * @return 向前端反馈信息，停留在添加图书界面
     */
    @RequestMapping("/card/addOne")
    public String addCard(Card card, Model model) {
        if(cardService.getCard(card.getCno()) != null) {
            model.addAttribute("msg","卡号重复，增加失败");
            return "addCard";
        } else if (card.getType().equals("student") || card.getType().equals("teacher")) {
            cardService.addCard(card);
            model.addAttribute("msg","借书证添加成功");
            return "addCard";
        } else {
            model.addAttribute("msg","类型不正确，增加失败");
            return "addCard";
        }
    }

    /**
     * @describe 判断文件格式是否为excel，java解析错误则抛出异常，错误处理待完善，msg为向前端反馈的错误信息
     * @reference https://www.cnblogs.com/linjiqin/p/10975761.html
     * @return 重定向至全部借书证页面
     */
    @RequestMapping("/card/addBatch")
    public String addCardBatch(MultipartFile file, HttpServletRequest request, Model model) throws Exception{
        String fileName = file.getOriginalFilename();
        if (!fileName.matches("^.+\\.(?i)(xls)$") && !fileName.matches("^.+\\.(?i)(xlsx)$")) {
            model.addAttribute("msg","上传文件格式不正确，文件仅支持*.xls和*.xlsx");
            return "/addCard";
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
                    Card card = new Card();

                    //需要先将单元格的内容全部转化为字符串再进行格式转换
                    row.getCell(0).setCellType(CellType.STRING);
                    String cno = row.getCell(0).getStringCellValue();
                    row.getCell(1).setCellType(CellType.STRING);
                    String name = row.getCell(1).getStringCellValue();
                    row.getCell(2).setCellType(CellType.STRING);
                    String department = row.getCell(2).getStringCellValue();
                    row.getCell(3).setCellType(CellType.STRING);
                    String type = row.getCell(3).getStringCellValue();
                    System.out.println(type);

                    card.setCno(cno);
                    card.setName(name);
                    card.setDepartment(department);
                    card.setType(type);
                    cardService.addCard(card);
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg","parse excel exception: "+e.toString());
            return "addCard";
        } finally {
            if (workbook != null) {
                try {
                    workbook.close();
                } catch (Exception e) {
                    model.addAttribute("msg","parse excel exception: "+e.toString());
                    return "addCard";
                }
            }
        }
        //插入成功则返回界面
        return "redirect:/card/list";
    }

    @GetMapping("/card/update/{cno}")
    public String toUpdateCard(@PathVariable("cno") String cno, Model model) {
        Card card = cardService.getCard(cno);
        model.addAttribute("card", card);
        return "updateCard";
    }

    @PostMapping("/card/update")
    public String updateCard(Card card, Model model) {
        if (card.getType().equals("student") || card.getType().equals("teacher")) {
            cardService.editCard(card);
            return "redirect:/card/list";
        } else {
            model.addAttribute("msg", "类型不正确，修改失败");
            return "updateCard";
        }
    }

    @GetMapping("/card/delete/{cno}")
    public String deleteCard(@PathVariable("cno") String cno, RedirectAttributes attr) {
        List<Record> records = borrowService.getBorrowByCno(cno);
        if (records.size() != 0) {
            attr.addAttribute("msg","该借书证有借阅记录，不能删除");
            return "redirect:/card/list";
        }
        cardService.deleteCard(cno);
        return "redirect:/card/list";
    }
}
