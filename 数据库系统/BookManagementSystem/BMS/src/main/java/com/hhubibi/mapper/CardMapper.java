package com.hhubibi.mapper;

import com.hhubibi.entity.Card;

import java.util.List;

public interface CardMapper {
    Card getCard(String cno);

    List<Card> getAllCard();

    int deleteCard(String cno);

    int addCard(Card card);

    List<Card> queryCard(Card card);

    int editCard(Card card);
}
