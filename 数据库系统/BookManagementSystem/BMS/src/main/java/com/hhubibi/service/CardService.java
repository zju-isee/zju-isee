package com.hhubibi.service;

import com.hhubibi.entity.Card;

import java.util.List;

public interface CardService {
    //通过卡号得到借书卡
    Card getCard(String cno);

    List<Card> getAllCard();

    int deleteCard(String cno);

    int addCard(Card card);

    List<Card> queryCard(Card card);

    int editCard(Card card);
}
