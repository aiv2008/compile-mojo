# Mojo AI 编译器学习资源

> 海外英文原版教程精选 · 面向自研 AI 编译器方向  
> 技术栈：Mojo · MLIR · LLVM · MAX Engine · PyTorch · ONNX

---

## 目录

- [一、Udemy 专项课（AI 编译器定向）](#一udemy-专项课ai-编译器定向)
- [二、Modular 官方免费教程](#二modular-官方免费教程)
- [三、底层前置教程](#三底层前置教程)
- [四、补充 Udemy 课程](#四补充-udemy-课程)
- [五、YouTube 实战博主](#五youtube-实战博主)
- [六、分阶段学习路线](#六分阶段学习路线)
- [七、避坑提示](#七避坑提示)

---

## 一、Udemy 专项课（AI 编译器定向）

### Mojo Programming Training: Powering High-Performance AI

| | |
|---|---|
| **链接** | [Udemy 课程页](https://www.udemy.com/course/mojo-programming-training-powering-high-performance-ai/) |
| **定位** | 截图红框核心付费专项课，AI 编译器定向 |
| **适合人群** | 有 Python 基础，想系统搭建完整 AI 编译链路，但缺少 IR / 编译优化知识的开发者 |

#### 编译器相关核心内容

- Mojo 完整编译器分层架构：前端语法解析 → MLIR 中间层优化 → LLVM 代码生成后端
- Mojo 内嵌 MLIR 语法 `__mlir_type`、自定义张量 Dialect 开发（AI 算子 IR 核心）
- 完整 AI 推理编译管线：ONNX / PyTorch 模型导入、算子融合、自动硬件调度
- CPU / GPU / NPU 多后端编译、显存调度、SIMD 张量向量化优化
- Mojo 与 Python 混合编译调试、自定义 Kernel 算子编译、性能调优流水线
- MAX Engine（Modular 官方 AI 编译器内核）二次开发扩展

---

## 二、Modular 官方免费教程

工业级权威资料，**必学**。

| # | 主题 | 链接 | 说明 |
|---|------|------|------|
| 1 | **内嵌 MLIR 底层开发** | [Inline MLIR 文档](https://mojolang.org/docs/reference/inline-mlir/) | 在 Mojo 中编写、操作 MLIR 张量算子，搭建中间表示层；支持 NVVM / GPU 硬件 IR、自定义计算图 Op |
| 2 | **MAX Graph 入门** | [Get Started with MAX Graph](https://docs.modular.com/nightly/max/tutorials/get-started-with-max-graph/) | PyTorch / ONNX → Mojo Graph IR → MLIR Pass → CPU / GPU 二进制；可基于 MAX 二次开发私有编译器 |
| 3 | **自定义算子实战** | [Build Custom Ops](https://docs.modular.com/max/tutorials/build-custom-ops/) | 卷积、矩阵乘、Transformer 算子实现，集成进 MAX，自动算子融合与显存优化 |
| 4 | **MLIR 交互 Notebook** | [BoolMLIR Notebook](https://docs.modular.com/nightly/mojo/notebooks/BoolMLIR/) | Jupyter 可视化 MLIR 层级变换，直观理解图优化底层原理 |

#### MAX Graph 编译流程一览

```
PyTorch / ONNX 模型
        ↓
   Mojo Graph IR
        ↓
   MLIR 优化 Pass
        ↓
 CPU / GPU 推理二进制
```

---

## 三、底层前置教程

> 无 MLIR / LLVM 基础，无法有效开发 AI 编译器。以下资料建议**优先学习**。

| # | 主题 | 链接 | 说明 |
|---|------|------|------|
| 1 | **MLIR Toy 编译器** | [Toy Tutorial](https://mlir.llvm.org/docs/Tutorials/Toy/) | 6 章实操：自定义 Dialect、Pass 优化、IR 降级 LLVM；Mojo 底层完全复用这套体系 |
| 2 | **Mojo 编译器架构** | [LLVM Dev Meeting PPT](https://llvm.org/devmtg/2025-10/slides/technical_talks/lattner_zhu.pdf) | Lattner 讲解 Mojo 基于 MLIR 重构 AI 编译栈的整体设计 |
| 3 | **高级编译原理** | [Cornell CS6120](https://www.cs.cornell.edu/courses/cs6120/2023fa/self-guided/) | 数据流分析、IR 优化、并行代码生成；打通 TVM / IREE / Mojo 通用优化逻辑 |

---

## 四、补充 Udemy 课程

### Mojo Programming: Basic to Expert with AI Use Cases

| | |
|---|---|
| **链接** | [Udemy 课程页](https://www.udemy.com/course/mojo-programming-basic-to-expert-with-ai-use-cases/) |
| **定位** | Mojo 基础 + 简易 AI 编译器 Demo |
| **适合人群** | 零基础，先补齐语法再进阶编译器开发 |

#### 课程侧重点

- Mojo 内存模型、SIMD 张量底层实现
- 小型简易 AI 编译器 Demo：手写张量图解析器、编译至 CPU

---

## 五、YouTube 实战博主

| 频道 / 博主 | 检索关键词 | 内容 |
|-------------|-----------|------|
| **Modular Official** | `MAX Engine Compiler`、`Mojo MLIR Tutorial` | 官方工程师演示完整模型编译流水线、自定义编译器扩展 |
| **Lambdaclass** | `Mojo Custom MLIR Dialect` | 硬核底层：手写张量 Dialect、图优化 Pass，实现迷你 AI 编译器 |
| **Simon Boehm** | Mojo + Triton | GPU 算子编译横向对比，混合开发高性能推理内核 |

---

## 六、分阶段学习路线

**目标：自研 Mojo AI 编译器**

### 阶段 1 · 前置基础（1–2 周）

- [ ] Cornell CS6120 编译原理自学课
- [ ] MLIR Toy 官方教程 — 吃透 IR、Dialect、Pass 三大核心概念

### 阶段 2 · Mojo 语言 + 内置编译能力（1 周）

- [ ] Modular Mojo 官方入门文档
- [ ] Udemy《Mojo Programming Training》前半段：编译器分层架构、inline MLIR 语法

### 阶段 3 · AI 编译核心实战（2–3 周）⭐ 核心

- [ ] Udemy《Mojo Programming Training》后半段：MAX 引擎、多后端编译、自定义算子
- [ ] Modular MAX Graph 教程 + Custom Ops 算子实战
- [ ] **动手 Demo**：导入 ONNX 模型 → 算子融合优化 → 输出可执行推理二进制

### 阶段 4 · 进阶自研（长期）

- [ ] LLVM Dev Mojo 架构 PPT、EuroLLVM Mojo 编译时 IR 技术分享
- [ ] 融合 IREE / TVM 设计思路，扩展 Mojo 后端，适配 NPU / 边缘硬件

---

## 七、避坑提示

| 误区 | 正确理解 |
|------|----------|
| Mojo 是独立编译器框架 | Mojo 是基于 MLIR / LLVM 的高性能系统语言；AI 编译器核心依赖 MLIR，**切勿跳过 MLIR 入门** |
| 从零自研全套编译器 | 商用落地推荐基于 **Modular MAX Engine** 二次开发，从零成本极高 |
| 教程语言 / 栈过时 | 全部为海外原版英文资源，兼容现代 AI 技术栈（PyTorch、ONNX 等） |

---

*最后更新：2026 · compile-mojo 项目文档*
