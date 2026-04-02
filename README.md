# all-agents-skill

> 在同时使用多个 AI CLI 工具的项目中，用一份 `ALL_AGENTS.md` 统一管理项目说明，并自动同步到 Claude Code、OpenAI Codex、Gemini CLI 各自的配置文件。

## 解决什么问题

同时使用 Claude Code、Codex、Gemini CLI 时，每个工具都有自己的项目说明文件（`CLAUDE.md` / `AGENTS.md` / `GEMINI.md`），需要分别维护。这个 skill 让你只维护一份 `ALL_AGENTS.md`，其余文件自动同步。

## 安装

```bash
# Claude Code（原生 plugin）
/plugin install JiaYF1@your-github-username

# 通用安装器（支持 Claude Code / Codex / Gemini CLI / Cursor 等）
npx openskills install JiaYF1/all-agents-skill

# 或用 Vercel skills CLI
npx skills install JiaYF1/all-agents-skill
```

## 使用方式

安装后，在任意 AI CLI 工具中说：

| 说什么 | 执行什么 |
|--------|----------|
| 使用 all_agents_skill 来帮我 init | 交互式采访 → 生成 ALL_AGENTS.md → 同步 |
| 使用 all_agents_skill 来帮我 sync | 将 ALL_AGENTS.md 同步到各工具配置 |
| 使用 all_agents_skill 来帮我 check | 检查各配置文件是否与 ALL_AGENTS.md 一致 |

Claude Code 还支持斜杠命令：`/all-agents-init`、`/all-agents-sync`

## 文件说明

```
all-agents-skill/
├── SKILL.md                   # skill 定义（触发逻辑、执行步骤）
└── scripts/
    └── all-agents-init.sh     # 交互式初始化脚本
```

生成到项目中的文件：

```
your-project/
├── ALL_AGENTS.md              # 唯一真相来源，只编辑这个
├── CLAUDE.md                  # ← 自动同步
├── AGENTS.md                  # ← 自动同步
├── GEMINI.md                  # ← 自动同步
├── sync-agents.sh             # 同步脚本
└── scripts/
    └── all-agents-init.sh     # 初始化脚本
```

## License

MIT
