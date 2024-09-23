import React from 'react'

export default function SquareBtn(props) {
  /*
    showVal 是否显示符号；false为空白格
    boardIndex 棋盘下标
    posListIndex 步骤记录数组下标，根据单双判断要显示的符号
    clickToSetSymbol 点击格子执行函数
   */
  const { showVal, boardIndex, posListIndex, clickToSetSymbol, winCom } = props;
  
  const getDisSymbol = () => {
    if (showVal) {
      return posListIndex % 2 ? "O" : "X";
    }
    return "";
    
  }
  
  const btnClass = () => {
    let str = 'square rounded border-2 place-content-center ';
    if(winCom.length && winCom.includes(boardIndex)){
      str += "bg-sky-500 text-white"
    }
    return str;
  }
  
  // const clickBoard = () => {
  //   clickToSetSymbol(boardIndex)
  // }

  return (
    <button className={btnClass()} 
      onClick={() => clickToSetSymbol(boardIndex)}>
      <span>{getDisSymbol()}</span>
    </button>
  )
}
