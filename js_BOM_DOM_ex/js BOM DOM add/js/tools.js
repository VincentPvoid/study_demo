
// 动画函数
// 缓动动画函数，使用offset方法
function moveAniSet(obj, attr, target, callback) {
    clearInterval(obj.timer);
    obj.timer = setInterval(function () {
        // 移动方向（属性值）首字母大写
        var sBig = attr.substring(0, 1).toUpperCase() + attr.substring(1);
        // 获取元素当前的offset值
        var oldValue = obj['offset' + sBig];
        var step = (target - oldValue) / 10;
        step = step > 0 ? Math.ceil(step) : Math.floor(step);
        obj.style[attr] = oldValue + step + 'px';

        if (oldValue == target) {
            clearInterval(obj.timer);
            callback && callback();
        }
    }, 30)
}

// 缓动动画函数，不使用offset的方法
function moveAni(obj, attr, target, callback) {
    clearInterval(obj.timer);
    obj.timer = setInterval(function () {
        var oldValue = parseInt(getStyle(obj, attr));
        var step = (target - oldValue) / 10;
        step = step > 0 ? Math.ceil(step) : Math.floor(step);
        obj.style[attr] = oldValue + step + 'px';
        if (oldValue == target) {
            clearInterval(obj.timer);
            callback && callback();
        }
    }, 30)
}

// 获取元素当前显示样式的兼容性函数
function getStyle(obj, sName) {
    if (window.getComputedStyle) {
        return getComputedStyle(obj, null)[sName];
    } else {
        return obj.currentStyle[sName];
    }
}

// 匀速运动函数（需要使用获取当前显示样式的函数，即不使用offset）
function moveLinear(obj, attr, target, speed, callback) {
    clearInterval(obj.timer);
    var temp = parseInt(getStyle(obj, attr));
    if (temp >= target) {
        speed = -speed;
    }
    obj.timer = setInterval(function () {
        var oldValue = parseInt(getStyle(obj, attr));
        var newValue = oldValue + speed;
        if ((newValue > target && speed > 0) || (newValue < target && speed < 0)) {
            newValue = target;
        }
        obj.style[attr] = newValue + 'px';
        if (newValue == target) {
            clearInterval(obj.timer);
            callback && callback();
        }
    }, 30)
}

// 匀速运动函数，使用offset
function moveLinearSet(obj, attr, target, speed, callback) {
    clearInterval(obj.timer);
    var attrBig = attr.substring(0, 1).toUpperCase() + attr.substring(1);
    if (obj['offset' + attrBig] > target) {
        speed = -speed;
    }
    obj.timer = setInterval(function () {
        var oldValue = obj['offset' + attrBig];
        var newValue = oldValue + speed;
        if ((newValue > target && speed > 0) || (newValue < target && speed < 0)) {
            newValue = target;
        }
        obj.style[attr] = newValue + 'px';
        if (newValue == target) {
            clearInterval(obj.timer);
            callback && callback();
        }
    }, 30)
}


// 类名操作函数
// 检查是否含有该类名
function hasClass(obj, cn) {
    var reg = new RegExp('\\b' + cn + '\\b');
    return reg.test(obj.className);
}

// 添加指定的类名
function addClass(obj, cn) {
    if (!hasClass(obj, cn)) {
        obj.className += ' ' + cn;
    }
}

// 移除指定的类名
function removeClass(obj, cn) {
    // 注意单词边界和空格
    // 加空格是为了避免反复切换时空格过多
    var reg = new RegExp('\\b\\s*' + cn + '\\s*\\b');
    obj.className = obj.className.replace(reg, ' ');
}

// 切换指定的类名（如果有该类名，就删除；如果没有，则添加）
function toggleClass(obj, cn) {
    if (hasClass(obj, cn)) {
        removeClass(obj, cn);
    } else {
        addClass(obj, cn);
    }
}