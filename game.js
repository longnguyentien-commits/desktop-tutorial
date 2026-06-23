const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");

const ROWS = 5;
const COLS = 9;
const PLACE_COLS = 5;
const CELL_W = canvas.width / COLS;
const CELL_H = canvas.height / ROWS;
const FRAME_W = 64;
const FRAME_H = 64;
const FRAME_COUNT = 12;
const ANIM_FPS = 12;
const DRAGON_SHEET = "dragon_attack_spritesheet.png";

const sheet = new Image();
sheet.src = DRAGON_SHEET;

const state = {
  dragons: [],
  fireballs: [],
  nextDragonId: 1,
  lastTime: 0,
  money: Infinity,
  selectedElement: "Fire",
  metaLoaded: false,
  frameWidth: FRAME_W,
  frameHeight: FRAME_H,
  frameCount: FRAME_COUNT,
};

const fireElements = {
  Fire: {
    color: "#ff6b4a",
    name: "Enemy Fire Dragon",
  },
};

async function loadSpriteMeta() {
  try {
    const res = await fetch("dragon_attack_spritesheet.json");
    const meta = await res.json();
    state.frameWidth = meta.frameWidth || FRAME_W;
    state.frameHeight = meta.frameHeight || FRAME_H;
    state.frameCount = meta.frameCount || FRAME_COUNT;
    state.metaLoaded = true;
    log(`Loaded ${meta.animation}: ${state.frameCount} frames, ${state.frameWidth}x${state.frameHeight}.`);
  } catch {
    state.metaLoaded = false;
    log("Using built-in spritesheet metadata: 12 frames, 64x64.");
  }
}

function makeDragon(row, col) {
  const x = col * CELL_W + CELL_W / 2;
  const y = row * CELL_H + CELL_H / 2;
  return {
    id: state.nextDragonId++,
    row,
    col,
    x,
    y,
    frameTimer: 0,
    frame: 0,
    attackCycle: 0,
    shotFrame: 6,
    shotThisCycle: false,
    scale: 1.35,
  };
}

function spawnFireball(dragon) {
  state.fireballs.push({
    x: dragon.x + 32,
    y: dragon.y + 4,
    vx: 360,
    radius: 9,
    life: 2.8,
    trail: [],
  });
}

function log(msg) {
  document.getElementById("messageLog").textContent = msg;
}

function renderUi() {
  document.getElementById("waveText").textContent = "Test";
  document.getElementById("hpText").textContent = "∞";
  document.getElementById("goldText").textContent = "∞";
  document.getElementById("levelText").textContent = "MAX";
  document.getElementById("capText").textContent = `${state.dragons.length} / ∞`;
  document.getElementById("xpText").textContent = "∞";
  document.getElementById("buyXpBtn").disabled = true;
  document.getElementById("startWaveBtn").textContent = "Add Dragon";

  const card = document.getElementById("carouselCard");
  card.className = "dragon-card selected";
  card.innerHTML = `
    <div class="card-row">
      <div class="sheet-thumb"></div>
      <div>
        <div class="card-title" style="color:${fireElements.Fire.color}">Enemy Fire Dragon</div>
        <div class="card-meta">Attack spritesheet - unlimited test mode</div>
      </div>
    </div>
  `;

  document.getElementById("nextQueue").innerHTML = `
    <div class="mini sheet-mini"></div>
    <div class="mini sheet-mini"></div>
    <div class="mini sheet-mini"></div>
  `;

  document.getElementById("stackList").innerHTML = `
    <div class="stack-item"><span style="color:${fireElements.Fire.color}">Placed Dragons</span><strong>${state.dragons.length}</strong></div>
    <div class="stack-item"><span>Fireballs</span><strong>${state.fireballs.length}</strong></div>
    <div class="stack-item"><span>Frame Size</span><strong>${state.frameWidth}x${state.frameHeight}</strong></div>
    <div class="stack-item"><span>Total Frames</span><strong>${state.frameCount}</strong></div>
  `;

  document.getElementById("benchCount").textContent = "∞ / ∞";
  document.getElementById("discardSlot").textContent = "Clear Test";
  const bench = document.getElementById("bench");
  bench.innerHTML = "";
  for (let i = 0; i < 10; i++) {
    const slot = document.createElement("div");
    slot.className = "bench-slot empty";
    slot.innerHTML = i === 0 ? "<div class='card-meta'>Testing mode: bench disabled</div>" : "";
    bench.appendChild(slot);
  }
}

function addDragonAt(row, col) {
  if (col >= PLACE_COLS) {
    log("Place dragons in the green area on the left.");
    return;
  }
  state.dragons.push(makeDragon(row, col));
  log("Placed an enemy dragon. It will loop attack frames and shoot fireballs to the right.");
  renderUi();
}

function update(dt) {
  for (const d of state.dragons) {
    d.frameTimer += dt;
    const frameDuration = 1 / ANIM_FPS;
    while (d.frameTimer >= frameDuration) {
      d.frameTimer -= frameDuration;
      const prevFrame = d.frame;
      d.frame = (d.frame + 1) % state.frameCount;
      if (d.frame < prevFrame) d.shotThisCycle = false;
      if (d.frame >= d.shotFrame && !d.shotThisCycle) {
        spawnFireball(d);
        d.shotThisCycle = true;
      }
    }
  }

  for (const f of state.fireballs) {
    f.trail.push({ x: f.x, y: f.y, life: 0.2 });
    if (f.trail.length > 10) f.trail.shift();
    f.x += f.vx * dt;
    f.life -= dt;
    for (const p of f.trail) p.life -= dt;
    f.trail = f.trail.filter((p) => p.life > 0);
  }
  state.fireballs = state.fireballs.filter((f) => f.life > 0 && f.x < canvas.width + 80);
}

function drawBoard() {
  ctx.fillStyle = "#23311f";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  for (let r = 0; r < ROWS; r++) {
    for (let c = 0; c < COLS; c++) {
      ctx.fillStyle = c < PLACE_COLS ? (r + c) % 2 ? "#2f4a2a" : "#34512e" : (r + c) % 2 ? "#3b3325" : "#423929";
      ctx.fillRect(c * CELL_W, r * CELL_H, CELL_W, CELL_H);
      ctx.strokeStyle = "rgba(255,255,255,.08)";
      ctx.strokeRect(c * CELL_W, r * CELL_H, CELL_W, CELL_H);
    }
  }

  ctx.fillStyle = "rgba(112,214,255,.18)";
  ctx.fillRect(0, 0, PLACE_COLS * CELL_W, canvas.height);

  ctx.fillStyle = "rgba(255,255,255,.75)";
  ctx.font = "700 18px system-ui";
  ctx.fillText("Click green cells to place unlimited attack dragons", 18, 30);
}

function drawDragon(d) {
  const sx = d.frame * state.frameWidth;
  const sy = 0;
  const size = 88 * d.scale;
  const x = d.x - size / 2;
  const y = d.y - size / 2;

  ctx.save();
  ctx.imageSmoothingEnabled = false;
  ctx.drawImage(sheet, sx, sy, state.frameWidth, state.frameHeight, x, y, size, size);
  ctx.restore();

  ctx.fillStyle = "rgba(12,17,22,.7)";
  ctx.fillRect(x + 20, y - 16, size - 40, 20);
  ctx.fillStyle = "#ffd66b";
  ctx.font = "900 15px system-ui";
  ctx.textAlign = "center";
  ctx.fillText(`Frame ${d.frame + 1}/${state.frameCount}`, d.x, y - 1);
  ctx.textAlign = "left";
}

function drawFireball(f) {
  for (const p of f.trail) {
    ctx.beginPath();
    ctx.fillStyle = `rgba(255, 120, 36, ${Math.max(0, p.life / 0.2) * 0.45})`;
    ctx.arc(p.x, p.y, f.radius * 0.75, 0, Math.PI * 2);
    ctx.fill();
  }

  const glow = ctx.createRadialGradient(f.x, f.y, 2, f.x, f.y, f.radius * 2.4);
  glow.addColorStop(0, "#fff3a3");
  glow.addColorStop(0.35, "#ff8a28");
  glow.addColorStop(1, "rgba(255, 50, 0, 0)");
  ctx.fillStyle = glow;
  ctx.beginPath();
  ctx.arc(f.x, f.y, f.radius * 2.4, 0, Math.PI * 2);
  ctx.fill();

  ctx.fillStyle = "#ffcb4a";
  ctx.beginPath();
  ctx.arc(f.x, f.y, f.radius, 0, Math.PI * 2);
  ctx.fill();
}

function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  drawBoard();
  for (const d of state.dragons) drawDragon(d);
  for (const f of state.fireballs) drawFireball(f);
}

function loop(ts) {
  const dt = Math.min(0.05, (ts - state.lastTime) / 1000 || 0);
  state.lastTime = ts;
  update(dt);
  draw();
  renderUi();
  requestAnimationFrame(loop);
}

canvas.addEventListener("click", (ev) => {
  const rect = canvas.getBoundingClientRect();
  const x = ((ev.clientX - rect.left) / rect.width) * canvas.width;
  const y = ((ev.clientY - rect.top) / rect.height) * canvas.height;
  addDragonAt(Math.floor(y / CELL_H), Math.floor(x / CELL_W));
});

document.getElementById("startWaveBtn").addEventListener("click", () => {
  const row = state.dragons.length % ROWS;
  const col = Math.floor(state.dragons.length / ROWS) % PLACE_COLS;
  addDragonAt(row, col);
});

document.getElementById("discardSlot").addEventListener("click", () => {
  state.fireballs = [];
  state.dragons = [];
  log("Cleared all test dragons and fireballs.");
  renderUi();
});

document.getElementById("carouselCard").addEventListener("click", () => {
  log("Click a green board cell or press Add Dragon to spawn a test dragon.");
});

document.getElementById("bench").addEventListener("click", () => {
  log("Bench is disabled in unlimited spritesheet test mode.");
});

document.getElementById("buyXpBtn").addEventListener("click", () => {});

loadSpriteMeta().then(() => {
  addDragonAt(2, 1);
  renderUi();
  requestAnimationFrame(loop);
});
