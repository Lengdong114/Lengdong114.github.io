ArrayList<Particle> particles;
int maxParticles = 1000; // 最大粒子数量
boolean mouseIsMoving = false;
int fireworkCenterX, fireworkCenterY;
int lastMoveTime;

void setup() {
  size(800, 600); // 设置画布大小
  particles = new ArrayList<Particle>();
  fireworkCenterX = width / 2;
  fireworkCenterY = height / 2;
  lastMoveTime = millis();
}

void draw() {
  background(0); // 设置背景颜色为黑色
  
  // 更新粒子状态
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.isFinished()) {
      particles.remove(i);
    }
  }
  
  // 生成追随鼠标的粒子
  if (mouseIsMoving) {
    for (int i = 0; i < 5; i++) {
      particles.add(new Particle(mouseX, mouseY, false));
    }
    mouseIsMoving = false;
  }
  
  // 生成中心烟花效果
  if (millis() - lastMoveTime > 200) {
    for (int i = 0; i < 50; i++) {
      particles.add(new Particle(fireworkCenterX, fireworkCenterY, true));
    }
    lastMoveTime = millis();
  }
  
  // 限制粒子数量
  if (particles.size() > maxParticles) {
    particles.subList(0, particles.size() - maxParticles).clear();
  }
}

void mouseMoved() {
  mouseIsMoving = true;
  fireworkCenterX = mouseX;
  fireworkCenterY = mouseY;
  lastMoveTime = millis(); // 更新鼠标最后移动时间
}

class Particle {
  float x, y; // 粒子位置
  float xSpeed, ySpeed; // 粒子速度
  float size; // 粒子大小
  color col; // 粒子颜色
  float lifespan; // 粒子寿命
  boolean isFirework; // 是否为烟花粒子
  
  Particle(float startX, float startY, boolean firework) {
    x = startX;
    y = startY;
    isFirework = firework;
    if (isFirework) {
      xSpeed = random(-3, 3); // 烟花粒子的随机速度
      ySpeed = random(-3, 3);
      size = random(3, 7); // 烟花粒子的随机大小
      col = color(255, 140, 0, 255); // 设置橙色
      lifespan = 255; // 烟花粒子的寿命
    } else {
      xSpeed = random(-1, 1); // 普通粒子的随机速度
      ySpeed = random(-1, 1);
      size = random(3, 7); // 普通粒子的随机大小
      col = color(255, 140, 0, 200); // 设置橙色
      lifespan = 100; // 普通粒子的寿命
    }
  }
  
  void update() {
    x += xSpeed; // 更新x位置
    y += ySpeed; // 更新y位置
    lifespan -= 2; // 逐渐减少寿命
  }
  
  void display() {
    noStroke();
    fill(col, lifespan);
    ellipse(x, y, size, size); // 绘制粒子
  }
  
  boolean isFinished() {
    return lifespan < 0; // 判断粒子是否消失
  }
}
