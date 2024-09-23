import React, { useState } from 'react';
import Square from "@/app/components/Square";

interface BoardProps {
  // xIsNext: boolean,
  // currentMove: number,
  // isFinish: boolean,
  squares: string[],
  winCom: number[],
  onPlay: Function
}

export default function Board({ squares, winCom, onPlay }: BoardProps) {

  const disBoard = squares.map((item, index) => (
    <div className="step-wrapper basis-1/3" key={index}>
      <Square value={item}
        hasColor={winCom.includes(index)}
        onSquareClick={() => onPlay(index, squares)} />
    </div>
  ))

  return (
    <div className="board-wrapper flex flex-row">
      {disBoard}
    </div>
  );
}
