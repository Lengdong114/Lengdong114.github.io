function setup() {
    let canvas = createCanvas(windowWidth, windowHeight);
    canvas.parent('sketch-holder');
    clear(); // 清除画布
}

function draw() {
    clear(); // 清除画布内容

    // 获取interaction-box的位置和大小
    let box = select('#interaction-box');
    let boxPos = box.position();
    let boxWidth = box.width;
    let boxHeight = box.height;

    // 检查鼠标是否在interaction-box内
    if (mouseX > boxPos.x && mouseX < boxPos.x + boxWidth &&
        mouseY > boxPos.y && mouseY < boxPos.y + boxHeight) {
        noFill();
        stroke(255);
        strokeWeight(2);
        drawingContext.setLineDash([5, 15]); // 设置虚线
        ellipse(mouseX, mouseY, 50, 50);
    }
}

function windowResized() {
    resizeCanvas(windowWidth, windowHeight);
    clear(); // 确保在调整窗口大小时清除画布
}
