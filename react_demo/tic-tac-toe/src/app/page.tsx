'use client'
import React, { useState, useRef, useEffect } from 'react'
import SquareBtn from "@/app/components/SquareBtn";
import RightListStepItem from "@/app/components/RightListStepItem";



export default function Home() {
  const [isFinish, setIsFinish] = useState<boolean>(false); // 当前游戏是否结束
  // const [nowSymbol, setNowSymbol] = useState<string>("X"); // 当前行动符号；X先行
  // const [stepList, setStepList] = useState([{ symbol: "X", posIndex: 0 }, { symbol: "X", posIndex: 2 }]);
  const [posList, setPosList] = useState<number[]>([]); // 步骤记录数组；存放数字为格子下标；数组下标双数为X，单数为O
  const [winSymbol, setWinSymbol] = useState<string>("");  // 当前获胜符号
  const [oldPosList, setOldPostList] = useState<number[]>([]); // 记录所有步骤，返回对应步骤用
  const [winCom, setWinCom] = useState<number[]>([]); // 当前获胜格子组合
  const [posText, setPosText] = useState<string>("");  // 当前放置位置文字显示
  let nowSymbol = posList.length % 2 ? "O" : "X"; // 当前行动符号；X先行


  // 棋盘上方文字显示
  const getTopText = () => {
    if (isFinish) {
      return "Winner: " + winSymbol;
    } else {
      if (posList.length === 9) {
        return "Game End";
      }
      return "Next player: " + nowSymbol;
    }
  }
  
  // 显示当前放置位置
  const getPositionText = (posNum: number, list: number[] = []) => {
    return list.length || posList.length ? `(${Math.floor(posNum / 3) + 1}, ${posNum % 3 + 1})` : "";
  }


  // 棋盘和符号显示
  const getDisBoard = () => {
    let list = [];
    let showVal = false;
    let posListIndex = -1;
    for (let i = 0; i < 9; i++) {
      if (posList.includes(i)) {
        showVal = true;
        posListIndex = posList.indexOf(i);
      } else {
        showVal = false;
        posListIndex = -1;
      }
      list.push(
        <div className="step-wrapper basis-1/3" key={i}>
          <SquareBtn
            showVal={showVal}
            boardIndex={i} posListIndex={posListIndex}
            winCom={winCom}
            clickToSetSymbol={clickToSetSymbol}
          />
        </div>
      )
    }
    // debugger
    return list;
  }

  // 显示右侧步骤列表按钮
  const getStepList = () => {
    return oldPosList.map((item, index) => (
      <RightListStepItem key={index} itemIndex={index} backToStep={backToStep} />
    ))
  }


  // 点击格子放置对应符号
  const clickToSetSymbol = (boardIndex: number) => {
    // 如果当前格子已经有符号，或游戏已结束
    if (posList.includes(boardIndex) || isFinish) {
      return;
    }
    
    // debugger
    const list = [...posList];
    list.push(boardIndex);
    setPosList(list);
    setOldPostList(list);
    setPosText(getPositionText(boardIndex, list));
    // setMaxOperationNum(list.length);

    // 如果当前有胜利者，结束游戏
    if (isHasWinner(list)) {
      setIsFinish(true);
      setWinSymbol(nowSymbol);
      return;
    }

    // 游戏继续，切换符号
    // const nextSymbol = nowSymbol === 'X' ? "O" : "X";
    // setNowSymbol(nextSymbol);
  }

  // 重置游戏
  const resetGame = () => {
    backToStep(0);
    setPosText("");
  }

  // 返回指定步数
  const backToStep = (stepNum: number) => {
    let list = []
    if (stepNum > posList.length) {
      list = oldPosList.slice(0, stepNum);
    } else {
      list = posList.slice(0, stepNum);
    }
    
    setPosList(list);
    setPosText(getPositionText(list[list.length - 1], list));

    // 当前返回步数为所有步骤数组长度，说明返回了最后一步
    // console.log(stepNum, list, 'llllllllll')
    if (oldPosList.length === stepNum && isHasWinner(list)) {
      setIsFinish(true);
      // setWinSymbol(list.length % 2 ? "X" : "O");
    } else {
      setIsFinish(false);
      setWinCom([])
      // setNowSymbol(list.length % 2 ? "O" : "X");
    }
  }


  // 胜利格子组合数组是否包含在对应符号的下标数组中  
  const isPass = (comItem: number[], list: number[]) => {
    // debugger
    let arr = list;
    // 数组长度为单数时为X
    if (list.length % 2) {
      // 数组下标为双数存放的是X的位置
      arr = list.filter((item, index) => !(index % 2));
    } else {
      // 数组长度为双数时为O
      // 数组下标为单数存放的是O的位置
      arr = list.filter((item, index) => (index % 2));
    }
    // console.log(arr, comItem)

    return comItem.every(item => arr.includes(item));
  }


  // 当前是否已经有胜利者
  const isHasWinner = (list: number[]) => {
    let flag = false;

    // debugger

    // 所有的胜利格子组合
    const combination = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    // 放置超过4步才可能有胜者
    if (list.length > 4) {
      for (let i = 0; i < combination.length; i++) {
        flag = isPass(combination[i], list);
        // console.log(flag,'ffffffff')
        if (flag) {
          setWinCom(combination[i])
          break;
        }
      }
    }
    return flag;
  }

  return (
    <div className="main flex flex-row">
      <div className="left-part">
        <div className="top-text">
          {getTopText()}
        </div>
        <div className="board-wrapper flex flex-row">
          {getDisBoard()}
        </div>
        <div className="position-text">
          {posText}
        </div>
      </div>
      <div className="right-part">
        <div className="right-title">
          <button className='rounded-full py-1 px-3 bg-indigo-500 text-white'
            onClick={resetGame}
          >
            Reset game
          </button>
        </div>
        <div className="step-list-wrapper">
          {getStepList()}
          {/* <div className="step-item">
            <span>1</span>
            <button>ttttttttttttt</button>
          </div> */}
        </div>
      </div>
    </div>
  );
}
