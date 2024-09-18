import React from 'react'



export default function RightListStepItem(props) {
  const { backToStep, itemIndex } = props;

  const clickBackBtn = () => {
    backToStep(itemIndex + 1)
  }

  return (
    <div className="step-item space-y-2 text-base" key={itemIndex}>
      <span className='mr-2'>{itemIndex + 1}.</span>
      <button className='rounded-full border-2 px-2'
        onClick={clickBackBtn}>
        Go to move #{itemIndex + 1}
      </button>
    </div>
  )
}
