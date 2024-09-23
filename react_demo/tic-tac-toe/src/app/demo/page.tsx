'use client'
import { useState } from 'react';
import Board from '@/app/components/Board';


export default function Game() {
  const [history, setHistory] = useState([Array(9).fill(null)]); // 棋盘和历史记录
  const [currentMove, setCurrentMove] = useState(0); // 当前移动（第几步）
  const xIsNext = currentMove % 2 === 0; // 下一个符合是否为X
  const currentSquares = history[currentMove]; // 嵌套数组，记录每一步的棋盘状态
  const [isFinish, setIsFinish] = useState<boolean>(false); // 当前游戏是否结束
  const [winCom, setWinCom] = useState<number[]>([]); // 当前获胜格子组合
  const [posText, setPosText] = useState<string>("");  // 当前放置位置文字显示


  // 点击格子放置符号
  function handlePlay(nextSquares: string[]) {
    const nextHistory = [...history.slice(0, currentMove + 1), nextSquares];
    setHistory(nextHistory);
    setCurrentMove(nextHistory.length - 1);
  }

  // 返回指定步的棋盘状态
  function jumpTo(nextMove: number) {
    setIsFinish(false);
    setPosText("");
    if (calculateWinner(history[nextMove]) || nextMove === 8) {
      setIsFinish(true);
    }
    setCurrentMove(nextMove);
  }

  // 右侧返回指定步骤按钮
  const moves = history.map((squares, move) => {
    let description;
    if (move > 0) {
      description = 'Go to move #' + move;
    } else {
      description = 'Go to game start';
    }
    return (
      <li key={move} className="step-item space-y-2 text-base">
        <span className='mr-2'>{move + 1}.</span>
        <button className='rounded-full border-2 px-2' onClick={() => jumpTo(move)}>
          {description}
        </button>
      </li>
    );
  });

  function getPosText(posNum: number) {
    return posNum > -1 ? `(${Math.floor(posNum / 3) + 1}, ${posNum % 3 + 1})` : "";
  }

  // 验证当前是否有胜利者
  function calculateWinner(squares: string[]) {
    let flag = false;
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (let i = 0; i < lines.length; i++) {
      const [a, b, c] = lines[i];
      if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
        setWinCom(lines[i])
        setIsFinish(true);
        return squares[a];
      }
    }
    setWinCom([])
    return flag;
  }

  // 棋盘上方显示提示文字
  function getTopText() {
    let status;
    // const winner = calculateWinner(squares);
    if (winCom.length) {
      status = 'Winner: ' + (xIsNext ? "O" : "X")
    } else if (currentMove === 9) {
      status = "Game End"
    } else {
      status = 'Next player: ' + (xIsNext ? 'X' : 'O');
    }
    return status;
  }

  function handleClick(i: number, squares: string[]) {
    // 如果当前已有胜利者，或当前格子已放置有符号
    if (isFinish || squares[i]) {
      return;
    }
    // console.log(i,'iiiiiiiii')
    const nextSquares = squares.slice();
    if (xIsNext) {
      nextSquares[i] = 'X';
    } else {
      nextSquares[i] = 'O';
    }

    handlePlay(nextSquares);
    setPosText(getPosText(i, squares));

    if (calculateWinner(nextSquares)) {
      setIsFinish(true);
      return;
    }
  }

  return (
    <div className="game main flex flex-row">
      <div className="left-part">
        <div className="top-text">{getTopText(history)}</div>
        <div className="game-board">
          <Board winCom={winCom}
            squares={currentSquares}
            onPlay={handleClick} />
        </div>
        <div className="position-text">
          {posText}
        </div>
      </div>
      <div className="right-part">
        <ol>{moves}</ol>
      </div>
    </div>
  );
}

