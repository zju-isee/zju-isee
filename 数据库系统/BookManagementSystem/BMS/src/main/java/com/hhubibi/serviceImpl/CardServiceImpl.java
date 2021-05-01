package com.hhubibi.serviceImpl;

import com.hhubibi.entity.Card;
import com.hhubibi.mapper.CardMapper;
import com.hhubibi.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: hhubibi
 * @create: 2021-04-05 13:58
 */
@Service
public class CardServiceImpl implements CardService {
    @Autowired
    CardMapper cardMapper;

    @Override
    public List<Card> getAllCard() {
        return cardMapper.getAllCard();
    }

    @Override
    public int deleteCard(String cno) {
        return cardMapper.deleteCard(cno);
    }

    @Override
    public int addCard(Card card) {
        return cardMapper.addCard(card);
    }

    @Override
    public List<Card> queryCard(Card card) {
        return cardMapper.queryCard(card);
    }

    @Override
    public int editCard(Card card) {
        return cardMapper.editCard(card);
    }

    @Override
    public Card getCard(String cno) {
        return cardMapper.getCard(cno);
    }
}
