window.addEventListener('load', function () {

    var carouselCon = document.querySelector('.carousel-con');
    var pointRight = document.querySelector('.point-right');
    var pointLeft = document.querySelector('.point-left');
    var imgsCon = document.querySelector('.imgs-con');
    var pagesCon = document.querySelector('.pages-con');
    // var spans = pagesCon.querySelectorAll('span');
    var num = 0;
    var dot = 0;


    // 生成翻页圆点并绑定点击事件
    for (var i = 0; i < imgsCon.children.length; i++) {
        var span = document.createElement('span');
        span.setAttribute('data-index', i);
        pagesCon.appendChild(span);
        span.addEventListener('click', function () {
            for (var i = 0; i < pagesCon.children.length; i++) {
                pagesCon.children[i].className = '';
            }
            this.className = 'choose';
            dot = this.getAttribute('data-index');
            num = dot;
            moveAni(imgsCon, -dot * carouselCon.clientWidth);
        })
    }
    pagesCon.children[0].className = 'choose';

    // 生成最后一张重复图片
    var addLi = imgsCon.children[0].cloneNode(true);
    imgsCon.appendChild(addLi);



    // 鼠标悬浮显示翻页按钮
    carouselCon.addEventListener('mouseenter', function () {
        pointRight.style.display = 'block';
        pointLeft.style.display = 'block';
        clearInterval(timer);
        timer = null;
    })
    carouselCon.addEventListener('mouseleave', function () {
        pointRight.style.display = 'none';
        pointLeft.style.display = 'none';
        if(!timer){
            timer = setInterval(function () {
                pointRight.click();
            }, 2000)
        }
    })


    var spans = pagesCon.querySelectorAll('span');

    // 翻页按钮点击切换图片
    pointRight.addEventListener('click', function () {
        resetImgs();
        num++;
        dot++;
        moveAni(imgsCon, -num * carouselCon.clientWidth);
        if (dot >= spans.length) {
            dot = 0;
        }
        for (var i = 0; i < spans.length; i++) {
            spans[i].className = '';
        }
        spans[dot].className = 'choose';

        function resetImgs() {
            if (num >= spans.length) {
                num = 0;
                // dot = 0;
                imgsCon.style.left = 0;
            }
        }
        // if(num >= imgsCon.children.length){
        //     num = 0;
        //     dot = 0;
        //     imgsCon.style.left = 0;
        //     // pointRight.click();
        // }      
    })

    pointLeft.addEventListener('click', function () {
        resetImgs();
        num--;
        dot--;
        moveAni(imgsCon, -num * carouselCon.clientWidth);
        if (dot < 0) {
            dot = spans.length - 1;
        }
        for (var i = 0; i < spans.length; i++) {
            spans[i].className = '';
        }
        spans[dot].className = 'choose';

        function resetImgs(){
            if (num <= 0) {
                num = spans.length;
                // dot = spans.length;
                imgsCon.style.left = -num * carouselCon.clientWidth + 'px';
            }
        }
        // if (num < 0) {
        //     num = imgsCon.children.length - 1;
        //     dot = spans.length;
        //     imgsCon.style.left = -imgsCon.offsetWidth + carouselCon.clientWidth + 'px';
        //     pointLeft.click();
        // }
    })


    var timer = setInterval(function () {
        pointRight.click();
    }, 2000)


    // 图片切换函数
    function moveAni(obj, target, callback) {
        clearInterval(obj.timer);
        obj.timer = setInterval(function () {
            if (obj.offsetLeft == target) {
                clearInterval(obj.timer);
                
                // 回调函数
                // if (callback) {
                //     callback();
                // }

                // 回调函数的简单写法
                callback && callback();
            } else {
                var step = (target - obj.offsetLeft) / 10;
                step = step > 0 ? Math.ceil(step) : Math.floor(step);
                obj.style.left = obj.offsetLeft + step + 'px';
            }
        }, 10)
    }

})






// 头尾图片复位函数
// function resetImgs() {
//     if (imgsCon.offsetLeft <= -3000) {
//         imgsCon.style.left = -750 + 'px';
//     } else if (imgsCon.offsetLeft >= 0) {
//         imgsCon.style.left = -2250 + 'px';
//     }
// }