````
# 微信表情开放平台配套图片设计规范与 AI 提示词指南

本指南根据微信表情开放平台最新官方规范整理，涵盖 **表情主图/缩略图**、**详情页横幅**、**表情封面图**、**聊天页图标** 及文案规范的完整参数要求、设计要点、避坑指南及 AI 提示词模板。

---

## 目录

1. [素材规范速查表](#1-素材规范速查表)
2. [表情主图与缩略图规范](#2-表情主图与缩略图规范)
3. [三图配套规范（横幅 / 封面 / 图标）](#3-三图配套规范横幅--封面--图标)
4. [文案填写规范](#4-文案填写规范)
5. [AI 生成提示词模板 (Prompt Library)](#5-ai-生成提示词模板-prompt-library)
   - [5.1 三图一体生成模板](#51-三图一体生成模板banner--cover--tab-icon-一次输出)
   - [5.2 单图提示词模板](#52-单图提示词模板按需单独生成)
6. [文件命名与打包规范](#6-文件命名与打包规范)
7. [后期处理与避坑要点 (Checklist)](#7-后期处理与避坑要点-checklist)

---

## 1. 素材规范速查表

| 素材名称 | 数量 | 格式 | 尺寸（px） | 文件大小 | 背景 | 文字 |
|:---|:---:|:---|:---:|:---:|:---|:---|
| 表情主图 | 8～24 | 静态：PNG/JPG/GIF<br>动态：GIF | 240×240 | ≤500KB | 建议透明 | 可含标注文字 |
| 表情缩略图 | 与主图同数 | PNG | 120×120 | ≤50KB | 建议透明 | 与主图一致 |
| 详情页横幅 | 1 | PNG/JPG | 750×400 | ≤500KB | **非透明彩色**，忌白色 | **严禁文字** |
| 表情封面图 | 1 | PNG | 240×240 | ≤500KB | **透明**，忌白色/白描边 | **严禁文字** |
| 聊天面板图标 | 1 | PNG | 50×50 | ≤100KB | **透明**，忌白色/白边框 | **严禁文字** |
| 赞赏引导图（可选） | 1 | GIF/PNG | 750×560 | ≤100KB | 非透明彩色，忌白色 | 引导文字清晰 |
| 赞赏致谢图（可选） | 1 | GIF/PNG | 750×750 | ≤200KB | 非透明彩色，忌白色 | 致谢文字 |

> ⚠️ 同一套专辑的表情主图**必须统一为动态 GIF 或统一为静态**，不可混用。

---

## 2. 表情主图与缩略图规范

### 表情主图（聊天中发送的图片）

1. 尺寸：`240 × 240 px`，正方形
2. 格式：静态表情 PNG/JPG/GIF；动态表情 GIF（循环播放，节奏流畅不卡顿，建议时长 ≤3 秒，帧率 8-15fps）
3. 文件大小：每张 **≤ 500 KB**
4. 数量：8～24 张（必须为整数套，8/16/24 张最常见）
5. 背景：建议透明背景（PNG 带 Alpha），GIF 需加 2px 白色描边防锯齿
6. 布局：合理安排布局，**不宜有过多留白**；同一套表情风格统一、表情之间有足够差异
7. 文字标注：可含文字，但建议使用白色字配黑色描边（或反之），字号占画面高度 10-15% 以保证清晰度

### 表情缩略图（面板和详情页的小图）

1. 尺寸：`120 × 120 px`，正方形
2. 格式：**PNG**（静态）
3. 文件大小：每张 **≤ 50 KB**
4. 与主图**一一对应**（构图、表情、角度一致，缩小版）
5. 背景：建议透明背景

### 表情含义词

1. 每张表情配一条含义词，说明该表情传达的情绪/场景
2. **不超过 4 个汉字**，不含标点
3. **必须使用普通话**（方便更多用户理解），即使画面标注是方言
4. 同一套表情中含义词**不能重复**
5. 口语化、与画面情绪直接对应

---

## 3. 三图配套规范（横幅 / 封面 / 图标）

| 维度 / 项目 | 1. 详情页横幅 (Banner) | 2. 表情封面图 (Cover) | 3. 聊天页图标 (Tab Icon) |
| :--- | :--- | :--- | :--- |
| **应用场景** | 表情专辑详情页顶部 | 艺术家主页 / 列表页专辑展示 | 微信聊天输入框表情列表栏 |
| **像素尺寸** | `750 × 400 px` (约 15:8) | `240 × 240 px` (1:1 正方形) | `50 × 50 px` (1:1 正方形) |
| **格式与大小** | JPG / PNG，< 500 KB | **PNG**，< 500 KB | **PNG**，< 100 KB |
| **背景透明度** | **非透明**（明亮彩色底色） | **必须透明**（Alpha通道） | **必须透明**（Alpha通道） |
| **背景色禁忌** | 避免纯白背景，严禁透明底 | 避免白色背景，严禁纯白底 | 避免白色背景，严禁方框底 |
| **画面主体** | 场景化、具故事性、角色互动 | 半身像或全身像（代表性姿态） | **仅头部正面大特写** |
| **构图要求** | 饱满丰富，元素勿拉伸变形 | 居中饱满，无过多留白 | 极简、轮廓清晰、无方形硬边 |
| **边框与描边** | 自由适配背景 | **严禁白色描边**，无锯齿 | **严禁白色描边**，无正方形边框 |
| **文字规则** | **严禁出现任何文字** | **严禁出现文字** | **严禁出现文字** |

---

## 4. 文案填写规范

| 文案项 | 字数限制 | 说明 |
|:---|:---|:---|
| 表情名称 | ≤8 汉字（建议 ≤5） | 不含标点、无空格、不与已有专辑重名 |
| 表情介绍 | ≤80 汉字 | 充分展现形象特点或故事情节 |
| 版权信息 | ≤10 汉字 | 设计师/工作室真实姓名或名称，可简写 |
| 表情含义词 | ≤4 汉字/张 | 普通话，不含标点，同套不重复 |
| 赞赏引导语（可选） | 5～15 汉字 | 诙谐幽默，引导用户赞赏 |

> ⚠️ 文案尽量使用中文，方言需用汉字音译；**禁止使用表情符号和特殊字符**。

---

## 5. AI 生成提示词模板 (Prompt Library)

> **⚠️ 参考图与输出形态约定（重要，同会话多轮生成必读）**
> 1. **参考图仅作角色/风格来源**：会话内上传的参考图（如 9 张角色图）一律只用于提取一致的角色形象、服饰、配色与风格，**参考图本身绝不作为输出内容，不重绘、不逐张拆解展示**。
> 2. **每轮只输出一种形态**：每一轮生成开始前，先明确本轮形态（仅一种）：**①一张 24 格套图**、**②三图一体（750×400 + 240×240 + 50×50）**、或 **③单格表情**。模型仅按本轮形态输出，**不叠加、不再额外派生多张变体图**。
> 3. **输出数量写死关键词**：如要一张套图，写"输出且仅输出 1 张图片，为 4×6 网格内含 24 个表情"；如要三图一体，写"仅输出 3 张"。**不要同时描述两种形态**。
> 4. **参考图 ≠ 轮次指令**：同一会话里多次生成时，之前轮次的输出/指令不构成当前轮的形态要求；每轮以最新一条指令为准。

> **使用说明**：将括号内的 `[角色特征描述 / Character Description]` 替换为您具体的角色形象（例如：*a cute chubby white rabbit wearing a red scarf* 或 *绿色长耳朵小狗，扁平粗线条卡通风格*）。
>
> **一次性生成三图**：如需单次得到三个配套尺寸（横幅 / 封面 / 图标），可直接使用下方「三图一体生成模板」，让模型按规格分别输出 `750×400`、`240×240`、`50×50` 三张图。

---

## 5.1 三图一体生成模板（Banner + Cover + Tab Icon 一次输出）

* **目标**：一次请求生成微信表情平台所需的全部三张配套图，每张直接对应规范像素尺寸。
* **输出约定**：横幅 `750×400` 明亮彩色底；封面 `240×240` 透明底、半身/全身；图标 `50×50` 透明底、仅头部正面特写。

#### 英文 Prompt
```text
Generate a complete WeChat sticker album asset set of the same character, outputting three separate images with EXACT pixel dimensions below, all in flat 2D cartoon sticker style with bold clean lines and vibrant colors, NO text, no words, no letters, no watermark:
Image 1 - Album banner: 750x400 pixels, wide horizontal, lively storytelling scene, bright colorful NON-transparent background (not pure white).
Image 2 - Album cover: 240x240 pixels, square, [Character Description, e.g. a cute green puppy], front-facing half/full-body most recognizable pose, centered, isolated on solid background for transparent cutout, NO white outline, NO text.
Image 3 - Chat tab icon: 50x50 pixels, square, front-facing close-up headshot ONLY, ultra simple iconic thick-outline shape, high contrast, isolated for transparent cutout on alpha channel, NO square frame, NO white outline, NO text.
Return each image at its exact specified size: a 750x400 banner, a 240x240 cover, and a 50x50 icon.
```

#### 中文 Prompt
```text
为同一角色生成一套完整的微信表情专辑配套图，按下方像素尺寸分别输出三张图，统一采用扁平2D卡通贴纸风格、粗线条、色彩鲜艳，三张画面均无任何文字、无字母、无水印：
图1 - 专辑横幅：750×400像素，横向宽幅，生动有故事感的互动场景，明亮彩色非透明背景（避免纯白）。
图2 - 专辑封面：240×240像素，正方形，[角色特征描述]，正面半身或全身经典动作、高辨识度，居中构图，纯色背景便于抠图透明化，严禁白色描边，无文字。
图3 - 聊天栏图标：50×50像素，正方形，仅头部正面大特写，极致简洁粗线条轮廓、高对比度，透明背景（保留Alpha通道），无方形边框、无白色描边、无文字。
请将三张图分别精确输出为：750×400 的横幅、240×240 的封面、50×50 的图标。
```

> **注意**：多数图像模型按正方形/固定比例生成。若一次不能强制三种混宽高比，请**分别按三种比例各生成一次**（Banner `--ar 15:8`、Cover `--ar 1:1`、Icon `--ar 1:1`），再按上表裁切到精确像素；横幅与封面的 `750/240` 非整倍关系，务必等比裁切后再缩放到目标尺寸，避免拉伸变形。

---

## 5.2 单图提示词模板（按需单独生成）

### 1. 详情页横幅 (Banner)
* **设计目标**：横向宽幅、强故事性、动态互动场景、色彩明亮饱满、无文字。
* **画面比例**：`--ar 15:8` 或 `--ar 16:9`

#### 英文 Prompt (Midjourney / Stable Diffusion / DALL-E 3)
```text
A vibrant horizontal banner illustration featuring [Character Description, e.g. a cute green puppy and a white bunny] interacting happily in a lively scene, storytelling composition, dynamic poses, bright and colorful background (non-white), flat 2D cartoon style, clean line art, high detail, no text, no words, no letters, no watermark --ar 15:8 --v 6.0
```

#### 中文 Prompt
```text
横版专辑横幅插画，[角色特征描述]，生动有趣的互动场景，富有故事感与动态，明快活泼的彩色背景（非纯白），扁平2D卡通插画风格，干净平滑的线条，色彩鲜艳饱满，画面无任何文字、无字母、无水印。
```

---

### 2. 表情封面图 (Cover)
* **设计目标**：方形居中、半身/全身代表性动作、高辨识度、纯透明背景、无白边。
* **画面比例**：`--ar 1:1`

#### 英文 Prompt (Midjourney / Stable Diffusion / DALL-E 3)
```text
An iconic sticker design of [Character Description, e.g. a cute green puppy], front-facing full body or half-body pose, most recognizable expression, centered composition, flat 2D vector style, bold clean dark outlines, vibrant colors, isolated on solid white background for easy transparent cutout, no white border, no stroke, no text, no watermark --ar 1:1 --v 6.0
```

#### 中文 Prompt
```text
表情专辑代表封面图，[角色特征描述]，正面半身或全身经典动作，高辨识度与代表性，居中饱满构图，扁平矢量贴纸风格，清晰深色轮廓线，纯色背景便于抠图透明化，严禁白色外描边，画面无文字、无水印。
```

---

### 3. 聊天页图标 (Tab Icon)
* **设计目标**：50x50 极小尺寸下极致清晰、仅头部正面大特写、粗线条、去装饰化、无直角边框。
* **画面比例**：`--ar 1:1`

#### 英文 Prompt (Midjourney / Stable Diffusion / DALL-E 3)
```text
A minimalist app tab icon of [Character Description, e.g. a cute green puppy's head], front-facing close-up headshot only, ultra simple and iconic shape, thick bold dark outlines, high contrast, flat colors, minimal details, isolated on plain background for transparent cutout, no square box frame, no white outline, no text --ar 1:1 --v 6.0
```

#### 中文 Prompt
```text
极简聊天栏Tab图标，[角色特征描述]的头部正面大特写，仅头部特写，极致简洁清晰的轮廓造型，加粗深色线条，高对比度，适合50x50微小尺寸显示，无任何方形边框，无生硬直角，无白色描边，透明背景，无文字。
```

---

## 6. 文件命名与打包规范

### 命名规则

所有文件使用**两位数字序号**命名（不足补零），主图与缩略图序号一一对应：

```
表情包素材包/
├── 主图/                    （24张，静态PNG或动态GIF）
│   ├── 01.png
│   ├── 02.png
│   ├── ...
│   └── 24.png
├── 缩略图/                  （24张，PNG格式）
│   ├── 01.png
│   ├── 02.png
│   ├── ...
│   └── 24.png
├── 详情页横幅.png            （1张，750×400）
├── 表情封面图.png            （1张，240×240，透明）
├── 聊天面板图标.png          （1张，50×50，透明）
├── 赞赏引导图.png            （1张，可选，750×560）
├── 赞赏致谢图.png            （1张，可选，750×750）
└── 表情文案.xls              （含义词表，含义词≤4汉字/条）
```

- 表情主图排序：**从左至右、从上至下**，按文件名序号排列
- 动态表情用 `.gif` 后缀，静态表情统一用 `.png`
- 横幅建议用 `.jpg`（体积更小，不支持透明）

### 打包方式

将所有文件放入同一文件夹，压缩为 ZIP 包上传（或按平台要求逐个上传）。

---

## 7. 后期处理与避坑要点 (Checklist)

在上传至微信表情开放平台前，请对照以下清单逐项检查：

**表情主图（24张）**
- [ ] 尺寸统一为 `240 × 240 px`，每张 ≤ 500 KB
- [ ] 全部为静态 PNG 或全部为动态 GIF，不混用
- [ ] 动态 GIF 循环播放、节奏流畅、时长 ≤3 秒
- [ ] 风格统一、表情之间有足够差异、无过多留白

**表情缩略图（24张）**
- [ ] 尺寸统一为 `120 × 120 px`，每张 ≤ 50 KB
- [ ] PNG 格式，与主图一一对应（构图一致）

**详情页横幅（1张）**
- [ ] 尺寸 `750 × 400 px`，≤ 500 KB，JPG/PNG 格式
- [ ] **非透明彩色背景**，避免白色背景，色调活泼明朗
- [ ] **无任何文字**，画面有故事性，元素不变形

**表情封面图（1张）**
- [ ] 尺寸 `240 × 240 px`，≤ 500 KB，PNG 格式
- [ ] **透明背景**，无白色描边/锯齿/白色背景/正方形边框
- [ ] 正面半身/全身像（非仅头部），居中饱满，**无文字、无装饰元素**

**聊天面板图标（1张）**
- [ ] 尺寸 `50 × 50 px`，≤ 100 KB，PNG 格式
- [ ] **透明背景**，无白色描边/锯齿/白色背景/正方形边框
- [ ] **仅头部正面大特写**，轮廓清晰极简，**无文字、无装饰元素**

**文案**
- [ ] 表情名称 ≤8 汉字，无标点空格
- [ ] 表情介绍 ≤80 汉字
- [ ] 版权信息 ≤10 汉字
- [ ] 每张表情含义词 ≤4 汉字，**使用普通话**，同套不重复

**通用检查**
- [ ] **严禁白色描边/杂边**：AI 抠图易留 1~2px 白边，需在 PS 中修边消除
- [ ] **透明通道检查**：封面、图标导出为 32 位带 Alpha 的 PNG
- [ ] **无文字检查**：横幅/封面/图标严禁出现任何文字（含乱码字符）
- [ ] **文件命名**：主图/缩略图按 `01.png~24.png` 顺序命名，与表情排序一致（从左到右、从上到下）
````