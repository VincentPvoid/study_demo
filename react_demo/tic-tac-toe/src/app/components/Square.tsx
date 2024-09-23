import React from 'react'

interface SquareProps {
  value: string,
  onSquareClick: Function,
  hasColor: boolean,
}

export default function Square({ value, onSquareClick, hasColor}: SquareProps) {
  function btnClass() {
    let str = 'square rounded border-2 place-content-center ';
    if (hasColor) {
      str += "bg-sky-500 text-white"
    }
    return str;
  }

  return (
    <button className={btnClass()}
    // <button className="square rounded border-2 place-content-center "
      onClick={onSquareClick}>
      <span>{value}</span>
    </button>
  )
}
