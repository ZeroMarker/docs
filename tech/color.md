# 色彩系统

## 色彩基础

### 色彩模型

| 模型 | 说明 | 用途 |
|------|------|------|
| RGB | 红绿蓝（加色混合） | 屏幕显示、CSS |
| HSL | 色相、饱和度、亮度 | 设计直觉友好 |
| HSV/HSB | 色相、饱和度、明度 | 取色器常用 |
| CMYK | 青、品红、黄、黑（减色混合） | 印刷 |
| LAB | 明度、a（绿-红）、b（蓝-黄） | 感知均匀、色彩校正 |
| LCH / OKLCH | 基于 LAB 的圆柱坐标 | 现代 CSS、设计系统 |

### CSS 颜色格式

```css
/* 命名色 */
color: red;

/* 十六进制 */
color: #FF5733;
color: #F53;           /* 简写 */

/* RGB / RGBA */
color: rgb(255 87 51);
color: rgb(255 87 51 / 0.8);  /* 带透明度 */

/* HSL / HSLA */
color: hsl(14 100% 60%);
color: hsl(14 100% 60% / 0.8);

/* OKLCH（推荐用于设计系统） */
color: oklch(70% 0.15 30);

/* color-mix（CSS 原生混合） */
color: color-mix(in oklch, #FF5733 50%, #3366FF);
```

---

## 色彩理论

### 色轮与配色方案

```
              0° 红
             /    \
        330° 紫    30° 橙
           |        |
        270° 蓝    90° 黄
           \        /
        210° 青    150° 绿
             \    /
             180°
```

| 方案 | 定义 | 效果 | 示例 |
|------|------|------|------|
| 单色 (Monochromatic) | 同一色相，不同明度/饱和度 | 和谐、统一 | 蓝的深浅变化 |
| 互补 (Complementary) | 色轮对面 180° | 高对比、活力 | 蓝 + 橙 |
| 类似 (Analogous) | 相邻 30° 范围 | 柔和、自然 | 蓝 + 青 + 绿 |
| 三元 (Triadic) | 等距 120° | 丰富、平衡 | 红 + 黄 + 蓝 |
| 分裂互补 (Split-Comp.) | 互补色两侧各 30° | 对比但不刺眼 | 蓝 + 黄橙 + 红橙 |
| 四元 (Tetradic) | 两对互补色 | 丰富但需谨慎 | 红 + 蓝 + 黄 + 绿 |

---

## 设计系统色彩架构

### 典型结构

```
Design Token
├── Primitive（原始色）
│   ├── blue-50, blue-100, ... blue-900
│   ├── red-50 ... red-900
│   └── neutral-50 ... neutral-900
├── Semantic（语义色）
│   ├── primary / secondary / tertiary
│   ├── success / warning / error / info
│   ├── background / surface / card
│   └── text-primary / text-secondary / text-disabled
└── Component（组件色）
    ├── button-primary-bg
    ├── input-border
    └── navbar-bg
```

### Tailwind CSS 色阶系统

| 色阶 | 用途 | 对应关系 |
|------|------|---------|
| 50 | 极浅背景 | hover/selected 背景 |
| 100 | 浅背景 | 标签、徽章背景 |
| 200 | 边框、分隔线 | 输入框边框 |
| 300 | 禁用态、占位符 | placeholder |
| 400 | 次要图标、文本 | 说明文字 |
| 500 | 默认态 | 主要强调色 |
| 600 | hover 态 | 交互反馈 |
| 700 | active/pressed 态 | 按下状态 |
| 800 | 深色文本 | 深色模式文本 |
| 900 | 极深/标题 | 标题、强调 |
| 950 | 黑色 | 深色模式背景 |

---

## 无障碍 (WCAG)

### 对比度要求

| 等级 | 普通文本 | 大文本 (≥18pt/14pt bold) | 用途 |
|------|---------|------------------------|------|
| AA | ≥ 4.5:1 | ≥ 3:1 | 最低标准 |
| AAA | ≥ 7:1 | ≥ 4.5:1 | 增强标准 |

### 常见对比度参考

```
黑 #000000 on 白 #FFFFFF — 21:1 ✓ AAA
灰 #767676 on 白 #FFFFFF — 4.5:1 ✓ AA
蓝 #0066CC on 白 #FFFFFF — 5.9:1 ✓ AA
红 #D32F2F on 白 #FFFFFF — 5.6:1 ✓ AA
```

### 实用工具

- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- Chrome DevTools → Rendering → Emulate vision deficiencies
- Figma 插件：Stark、A11y

---

## 主流设计系统色彩对比

### Material Design 3 (Google)

```
Primary:     oklch(0.55 0.20 265)  — 从 dynamic color 提取
On Primary:  oklch(0.98 0.00 0)
Primary Container: oklch(0.85 0.12 265)
Surface:     oklch(0.98 0.00 0)
```

特点：dynamic color（壁纸/图片提取品牌色）、tonal palette（13 级色调）

### Fluent UI 2 (Microsoft)

```
Brand Primary:   #0078D4
Neutral Primary: #242424
Stroke 1:        #D1D1D1
Surface:         #FFFFFF
```

特点：中性为主、品牌色克制使用、强调可访问性

### Apple HIG

```
System Blue:    #007AFF
Label:          #000000
Secondary Label: #3C3C4399
Separator:      #3C3C4349
System Gray:    #8E8E93
```

特点：语义色命名、不强调品牌色、依赖系统自动适配深浅模式

---

## 深色模式设计

### 核心原则

1. **不要简单反转**：白底黑字反转成黑底白字会太刺眼
2. **降低饱和度**：深色背景上高饱和色会"发光"
3. **使用灰色层级**：#121212 → #1E1E1E → #2C2C2C → #383838
4. **阴影变光晕**：深色模式用发光（glow）替代阴影（shadow）

### 色彩调整策略

| 场景 | 浅色模式 | 深色模式 | 调整 |
|------|---------|---------|------|
| 背景 | #FFFFFF | #121212 | — |
| 表面 | #F5F5F5 | #1E1E1E | — |
| 主色 | blue-500 | blue-300 | 提高亮度 |
| 强调 | red-600 | red-400 | 降低饱和度 |
| 文本 | #1A1A1A | #E0E0E0 | — |
| 次要文本 | #666666 | #9E9E9E | — |

---

## CSS 色彩工具函数

```css
/* oklch — 感知均匀，最适合设计系统 */
:root {
  --primary: oklch(0.55 0.20 265);
  --primary-hover: oklch(0.48 0.22 265);  /* 更暗 */
  --primary-light: oklch(0.85 0.12 265);  /* 更亮 */
}

/* color-mix — 原生混合，无需预计算 */
.btn-primary:hover {
  background: color-mix(in oklch, var(--primary) 80%, black);
}

/* light-dark() — 浅深模式自动切换 */
:root {
  color-scheme: light dark;
}
body {
  color: light-dark(#1a1a1a, #e0e0e0);
  background: light-dark(#ffffff, #121212);
}

/* relative color syntax — 相对色彩变换 */
:root {
  --primary-h: oklch(from var(--primary) h s l);
  --primary-saturate: oklch(from var(--primary) h calc(s * 1.2) l);
}
```

---

## 调色工具

| 工具 | 用途 | 链接 |
|------|------|------|
| Realtime Colors | 实时预览配色在真实 UI 上的效果 | realtimecolors.com |
| Huemint | AI 生成配色方案 | huemint.com |
| ColorBox (Lyft) | 色阶生成器 | colorbox.io |
| Tints.dev | Tailwind 色阶生成 | tints.dev |
| Pigment (StackBlitz) | AI 配色 + 代码导出 | pigment.supply |
| Leonardo (Adobe) | 基于对比度的调色 | leonardocolor.io |

---

## 配色实践

### 快速建立品牌色

```
1. 选定一个主色（Primary）
2. 基于主色生成 10 级色阶（50–950）
3. 选择互补或类似色作为 Secondary
4. 灰色中性色（Neutral）用于文本和背景
5. 语义色：Success (绿)、Warning (橙)、Error (红)、Info (蓝)
6. 验证对比度（WCAG AA 最低）
7. 测试深色模式
```

### 常见错误

| 错误 | 正确做法 |
|------|---------|
| 纯黑 #000 作为文本色 | 使用 #1A1A1A 或 #212121 |
| 深色模式直接反转颜色 | 降低饱和度、提高亮度 |
| 只用一个主色 | 至少准备 primary + neutral |
| 忽略无障碍对比度 | 至少满足 WCAG AA |
| 硬编码颜色值 | 使用 CSS 变量 / Design Token |

---

## 参考资料

- [Material Design 3 — Color System](https://m3.material.io/styles/color)
- [WCAG 2.1 — Understanding Contrast](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum)
- [OKLCH 在 CSS 中的使用](https://oklch.com/)
- [A Guide To Color Accessibility](https://www.smashingmagazine.com/2024/01/guide-to-accessible-colors/)
