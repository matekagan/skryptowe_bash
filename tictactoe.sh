#!/bin/bash

BOARD=('0' '1' '2' '3' '4' '5' '6' '7' '8')
PLAYER='X'
ROWS=(0 3 6)
COLS=(0 1 2)
GAME_FINISHED='F'
TURN_COUNT=0

function showBoard {
    echo "PLayer $PLAYER turn"
    for CELL in ${ROWS[@]}; do
        echo "${BOARD[$CELL]}|${BOARD[$CELL + 1]}|${BOARD[$CELL + 2]}"
    done
}

function checkWinner {
    for CELL in ${ROWS[@]}; do
        if [ ${BOARD[CELL]} == $PLAYER ] && [ ${BOARD[CELL + 1]} == $PLAYER ] && [ ${BOARD[CELL + 2]} == $PLAYER ]; then
            echo "Player ${PLAYER} has won"
            GAME_FINISHED="T"
        fi
    done

    for CELL in ${COLS[@]}; do
        if [ ${BOARD[CELL]} == $PLAYER ] && [ ${BOARD[CELL + 3]} == $PLAYER ] && [ ${BOARD[CELL + 6]} == $PLAYER ]; then
            echo "Player ${PLAYER} has won"
            GAME_FINISHED="T"
        fi
    done

    if [ ${BOARD[0]} == $PLAYER ] && [ ${BOARD[4]} == $PLAYER ] && [ ${BOARD[8]} == $PLAYER ]; then
        echo "Player ${PLAYER} has won"
        GAME_FINISHED="T"
    fi

    if [ ${BOARD[2]} == $PLAYER ] && [ ${BOARD[4]} == $PLAYER ] && [ ${BOARD[6]} == $PLAYER ]; then
        echo "Player ${PLAYER} has won"
        GAME_FINISHED="T"
    fi
}

function changePlayer {
    if [ $PLAYER == 'X' ]; then
        PLAYER='O'
    else
        PLAYER='X'
    fi
}

while [ $GAME_FINISHED == 'F' ] && [ $TURN_COUNT -le 8 ]; do
    changePlayer
    showBoard
    read INPUT
    if [ $INPUT == ${BOARD[$INPUT]} ]; then
        BOARD[$INPUT]=$PLAYER
        checkWinner
        ((TURN_COUNT += 1))
    else
        echo "Invalid Field plese try again"
        changePlayer
    fi
done

if [ $GAME_FINISHED == 'F' ]; then
    echo "DRAW!"
fi