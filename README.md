# feishu-knowledge-writer

一个面向飞书 / Lark 知识库写作与安全编辑的模块化 Codex Skill。

## 简介

`feishu-knowledge-writer` 用于帮助模型在处理飞书知识库文档时，按照更稳妥的流程完成创建、总结、扩写、格式整理、结构修复与安全更新。

它的重点不是“生成一篇文章”这么简单，而是让模型在面对不同输入来源、不同输出目标、不同文档风险结构时，优先选择合适且低风险的操作路径。

## 适用场景

- 将 PDF、Word / docx、Markdown、TXT、截图或聊天内容整理为飞书知识库文档
- 将已有材料总结为知识文章或教程
- 只调整格式，不改变原意、不重写术语、不改代码逻辑
- 安全修改已有飞书文档，尤其是包含原生 `sheet`、图片、附件等嵌入块的文档
- 批量处理多个文档或提纲类任务

## 核心能力

- 按来源类型路由：区分 PDF、Word、Markdown、TXT、聊天输入等来源
- 按输出意图路由：区分总结、扩写、提纲、PPT 提纲、仅格式整理
- 按风险优先处理：先判断目标文档是否已有高风险嵌入结构
- 原生 `sheet` 安全优先：避免把飞书原生表格误当成普通 Markdown 表格覆盖掉
- 模块化加载：只读取当前任务需要的说明文件，减少无关上下文

## 项目结构

```text
feishu-knowledge-writer/
|-- README.md
|-- SKILL.md
|-- modules/
|   |-- batch-doc-operations.md
|   |-- existing-doc-safe-edit.md
|   |-- expand-to-tutorial.md
|   |-- format-only.md
|   |-- markdown-to-feishu.md
|   |-- outline-generation.md
|   |-- pdf-to-feishu.md
|   |-- ppt-outline-generation.md
|   |-- sheet-table-handling.md
|   |-- summarize-to-feishu.md
|   `-- word-to-feishu.md
|-- references/
|   |-- recovery-playbook.md
|   `-- sheet-safety-rules.md
`-- templates/
    `-- knowledge-doc-template.md
```

## 文件说明

### `SKILL.md`

项目主入口，定义：

- 适用范围
- 全局规则
- 模块路由优先级
- 失败回退策略
- 最终校验要求

### `modules/`

按任务类型拆分的工作流模块：

- `format-only.md`：只调格式，不改内容含义
- `summarize-to-feishu.md`：总结材料到飞书文档
- `expand-to-tutorial.md`：扩写为教程风格内容
- `outline-generation.md`：生成结构化提纲
- `ppt-outline-generation.md`：生成 PPT 提纲
- `pdf-to-feishu.md`：处理 PDF 来源
- `word-to-feishu.md`：处理 Word / docx 来源
- `markdown-to-feishu.md`：处理 Markdown / TXT 来源
- `sheet-table-handling.md`：处理原生 `sheet` 或表格相关任务
- `existing-doc-safe-edit.md`：安全修改已有飞书文档
- `batch-doc-operations.md`：处理批量文档任务

### `references/`

用于高风险场景下的辅助规则：

- `sheet-safety-rules.md`：原生 `sheet` 的保护规则
- `recovery-playbook.md`：异常情况下的恢复手册

### `templates/`

用于新知识文章的结构模板：

- `knowledge-doc-template.md`

## 使用方式

1. 从 [SKILL.md](/E:/MyFinishProject/skills-repository/feishu-knowledge-writer/SKILL.md) 开始阅读
2. 先判断目标是“新建文档”还是“修改已有文档”
3. 再判断来源类型，例如 PDF、Word、Markdown、聊天输入
4. 再判断输出目标，例如总结、扩写、提纲、格式整理
5. 如果文档包含 `<sheet>`、`<image>`、`<file>` 等嵌入块，优先走安全编辑流程
6. 完成后执行结构和内容校验，确认没有误伤已有块或表格数据

