# Personal Agent Skills

[English](./README.en.md) | 中文

这是我的个人 AI Agent 技能仓库，主要面向 **OpenAI Codex**。

它以 [mattpocock/skills](https://github.com/mattpocock/skills) 的结构和工程实践为基础，但并不是上游仓库的简单镜像。这里会逐步加入我的工程原则、日常工作流、个人 Skill，以及从真实使用经验中沉淀出的改进，最终形成一套可维护、可验证、可回滚、会持续成长的个人 Agent 工作系统。

## 为什么建立这个仓库

通用 Skill 能提供很好的起点，但每个人的项目、习惯、风险偏好和决策方式都不同。这个仓库希望解决四个问题：

- 复用成熟实践，而不是从零设计整套 Agent 工作流。
- 把个人偏好变成明确、可执行的规则，而不是每次对话重复说明。
- 从成功经验和失败教训中持续迭代，同时避免一次偶然反馈污染长期规则。
- 将 Skill 的源码、验证、部署和回滚统一管理，让 Codex 中实际使用的版本可追踪。

## 设计原则

- **上游与个人内容分离**：`mattpocock/skills` 作为固定版本的 Git submodule 保留，个人 Skill 独立维护。
- **源码是唯一事实来源**：只修改本仓库中的 Skill，不直接把 `~/.codex/skills` 下的安装副本当作源码。
- **渐进且可逆**：更新和部署先预览、再应用；覆盖前自动备份，并提供回滚脚本。
- **经验需要审核后沉淀**：候选教训先记录、去敏、归类和查重，经确认后才进入正式 Skill。
- **项目知识留在项目内**：客户信息、业务细节、私有代码和项目特例不进入全局个人 Skill。
- **保持人的控制权**：Agent 可以发现事实和提出建议，但重要决策、规则晋升和部署仍由我确认。
- **分层协作原则**：全局 `~/.codex/AGENTS.md` 约束日常交流效率，仓库 `AGENTS.md` 补充项目边界，代码任务再组合专用 Skill。

## 仓库结构

```text
personal-agent-skills/
├── AGENTS.md                       # Codex 在本仓库中的持久操作规则
├── skills/                         # 我维护的个人 Skills（源码）
│   ├── my-engineering/             # 自适应端到端工程交付工作流
│   ├── grill-my-design/            # 个性化的软件设计追问与压力测试
│   ├── karpathy-guidelines/        # 简洁、克制、可验证的代码实现准则
│   ├── personal-engineering-principles/ # 跨项目工程原则
│   └── evolve-my-skills/           # 从经验教训中审核并演化 Skills
├── upstream/mattpocock-skills/     # 固定版本的上游 Git submodule
├── config/skills.json              # 上游版本与个人 Skills 清单
├── lessons/                        # 经验候选与已晋升规则的生命周期记录
├── scripts/                        # 创建、验证、部署、更新和回滚工具
├── tests/                          # 行为场景与检查脚本
└── backups/                        # 部署前备份（本地生成，不提交）
```

## 当前的个人 Skills

| Skill | 用途 | 调用方式 |
| --- | --- | --- |
| `my-engineering` | 从理解现场到验证交付，按任务复杂度组合最小必要的工程 Skills | `$my-engineering` |
| `grill-my-design` | 基于仓库证据、领域建模和个人原则追问并检验设计 | `$grill-my-design` |
| `karpathy-guidelines` | 在编写、评审或重构代码时避免过度设计，保持改动聚焦并定义可验证目标 | 由 Codex 自动调用，也可使用 `$karpathy-guidelines` |
| `personal-engineering-principles` | 在工程建议和权衡中自动应用稳定的跨项目偏好 | 通常由 Codex 自动调用 |
| `evolve-my-skills` | 捕获、审核并在确认后晋升可复用的经验教训 | `$evolve-my-skills` |

上游 Skill 会与这些个人 Skill 一起部署；具体集合由 [`config/skills.json`](./config/skills.json) 管理。

### 自适应工程工作流

`$my-engineering` 负责把独立 Skills 串成完整交付生命周期：

```text
Orient -> Align -> Shape -> Build -> Verify -> Review -> Deliver -> Learn
```

阶段是门槛而不是固定仪式：明确的小改动可以走 `Orient -> Build -> Verify -> Deliver`；复杂或高风险工作才进入完整的对齐、规划和评审阶段。具体 Skill 在被调用期间拥有其内部流程，`$my-engineering` 负责阶段推进、路线选择和完成判断。

## 快速开始

### 1. 克隆仓库和上游 submodule

```powershell
git clone --recurse-submodules https://github.com/liam-gemini/personal-agent-skills.git
Set-Location personal-agent-skills
```

如果已经克隆但缺少上游内容：

```powershell
git submodule update --init --recursive
```

### 2. 检查配置

部署脚本优先使用 `$CODEX_HOME`；未设置时回退到当前 Windows 用户的 Codex 目录：

```text
$CODEX_HOME/skills
→ $USERPROFILE/.codex/skills
```

通常不需要修改共享配置。如果需要使用另一个 Codex 配置目录，请在运行脚本前设置 `CODEX_HOME`。

### 3. 验证

```powershell
./scripts/validate.ps1
./tests/behavior-checks.ps1
```

### 4. 预览并部署到 Codex

```powershell
# 只预览，不修改已安装 Skills
./scripts/deploy.ps1

# 确认后应用
./scripts/deploy.ps1 -Apply
```

部署会先验证内容，并将被覆盖的现有 Skill 备份到 `backups/`。

### 5. 必要时回滚

```powershell
# 预览最近一次备份的回滚范围
./scripts/rollback-deployment.ps1

# 确认后回滚
./scripts/rollback-deployment.ps1 -Apply
```

## 创建自己的 Skill

使用脚手架创建并自动注册新的个人 Skill：

```powershell
./scripts/new-personal-skill.ps1 `
  -Name "my-new-skill" `
  -DisplayName "My New Skill" `
  -ShortDescription "A focused workflow for a recurring personal task" `
  -DefaultPrompt "help me run this workflow" `
  -Resources "references,scripts"
```

创建后：

1. 完善 `skills/my-new-skill/SKILL.md` 及所需资源。
2. 添加能证明行为的测试场景。
3. 运行验证和行为检查。
4. 先预览部署，再使用 `-Apply` 安装到 Codex。
5. 在真实任务中观察效果，并将可复用经验送入演化流程。

## 让 Skills 根据经验持续演化

这个仓库不鼓励 Agent 无限制地“自动改写自己”。更可靠的闭环是：

```text
真实使用 → 捕获候选教训 → 去敏与归类 → 查重和冲突检查
        → 展示规则与差异 → 人工确认 → 修改源码 → 验证 → 部署
```

适合沉淀的内容包括：

- 多次出现的失败模式；
- 代价较高、值得防止重演的错误；
- 明确收到的纠正性反馈；
- 在多个项目中都有效的高价值做法。

不应直接沉淀为全局规则的内容包括：

- 单次任务中的临时偏好；
- 只对一个仓库成立的约定；
- 客户数据、内部代码、凭据或其他敏感信息；
- 尚未验证、只是假设未来会需要的复杂机制。

需要复盘时，可以在 Codex 中明确调用 `$evolve-my-skills`。候选项记录在 [`lessons/candidates.md`](./lessons/candidates.md)，正式修改必须经过确认。

经确认晋升的重要规则会登记在 [`lessons/rules.md`](./lessons/rules.md)，记录其来源、适用范围、目标 Skill、状态、最后验证日期以及替代或退役原因。正式 Skill 仍是可执行规则的事实来源，登记表负责保留决策历史。

## 更新上游 Skills

上游不会在后台自动漂移。先生成差异报告：

```powershell
./scripts/review-upstream-update.ps1
```

检查 `config/upstream-update-report.md` 后，再明确应用：

```powershell
./scripts/review-upstream-update.ps1 -Apply
./scripts/validate.ps1
./tests/behavior-checks.ps1
./scripts/deploy.ps1
./scripts/deploy.ps1 -Apply
```

这样可以在吸收上游改进的同时，避免未经审查的变化影响日常工作流。

## 推荐的后续方向

- 为每个个人 Skill 增加成功、失败和“不应触发”的行为场景。
- 用少量真实指标评估效果，例如返工次数、遗漏率、任务耗时和人工纠正次数。
- 定期清理重复或过时规则，避免 Skill 只增不减。
- 为重要规则记录来源、适用边界和最后验证日期。
- 在稳定后增加 CI，在提交或 Pull Request 中自动运行验证和行为检查。
- 保持个人 Skill 小而可组合；只有重复出现的工作流才值得抽象成新 Skill。

## 与上游的关系

本仓库感谢并复用了 [mattpocock/skills](https://github.com/mattpocock/skills) 的结构和实践。上游内容保留在 submodule 中，以便追踪来源、审查升级并减少与个人定制之间的混杂。

上游内容遵循其原始许可证；本仓库新增内容的许可证将以根目录许可证文件为准。
