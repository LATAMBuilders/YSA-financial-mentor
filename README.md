# 🦅 YSA — Financial Discipline Infrastructure for LATAM Founders

> **YSA is an AI financial mentor that turns financial discipline into onchain reputation — and reputation into access to capital.**

---

## 💀 The Problem

**80% of LATAM startups fail** not because of lack of talent, but weak financial planning.

Vision builds startups. **Financial discipline keeps them alive.**

Most founders can pitch their dream in 60 seconds but can't explain their unit economics in 60 minutes. Investors know this. That's why capital doesn't flow.

## 🦅 The Solution

YSA is a **demanding AI financial mentor** — think ex-Deloitte CFO who worked in LATAM for 20 years, not a friendly chatbot. She guides founders through building **3 core financial documents** while training real financial literacy through daily quizzes.

But discipline has **economic consequences**:

1. **🔵 Stake to Start** — Founder stakes MON to begin a 7-day financial discipline cycle
2. **🟣 Earn Reputation Onchain** — Complete the cycle → recover stake + earn verifiable badge. Abandon → lose stake.
3. **🟢 Unlock Capital** — Badges = access to grant pools. Investors verify founder maturity onchain.

> *"If you can't commit 0.1 MON to your own financial education, why would anyone commit $100K to your startup?"*

---

## 🏗️ Architecture

```
┌─────────────┐     ┌──────────────────┐     ┌────────────────────────┐
│   Founder   │────▶│  Stake MON       │────▶│  YSA Discipline Cycle  │
│             │     │  (Smart Contract) │     │  (7 days)              │
└─────────────┘     └──────────────────┘     └───────────┬────────────┘
                                                         │
                                          ┌──────────────┴──────────────┐
                                          │                             │
                                    ✅ Complete                    ❌ Abandon
                                          │                             │
                              ┌───────────┴──────────┐      ┌──────────┴──────────┐
                              │ 📊 3 Financial Docs  │      │ 💸 Stake Slashed    │
                              │ 🧠 Quiz Score ≥ 80%  │      │ → Funds reward pool │
                              │ 🏅 Badge NFT Minted  │      └─────────────────────┘
                              └───────────┬──────────┘
                                          │
                              ┌───────────┴──────────┐
                              │ 🏦 Grant Pool Access  │
                              │ Investors verify      │
                              │ onchain reputation    │
                              └──────────────────────┘
```

### What YSA Builds With You

| Document | What It Proves |
|----------|---------------|
| 📊 **Income Statement (P&L)** | You understand your revenue, costs, and margins |
| 💰 **Cash Flow Statement** | You know where your money actually goes |
| 📋 **Balance Sheet** | You can see your financial position clearly |

---

## 📜 Smart Contracts (Monad Testnet)

| Contract | Address | Description |
|----------|---------|-------------|
| `YSADiscipline` | [`0x87ebf67244052c6d136f12fdfc9845b9b106e2dd`](https://testnet.monadexplorer.com/address/0x87ebf67244052c6d136f12fdfc9845b9b106e2dd) | Stake/release/slash cycle management |
| `YSABadge` | [`0x11276bbe88f4a39d24ad389f08949f7f550c2531`](https://testnet.monadexplorer.com/address/0x11276bbe88f4a39d24ad389f08949f7f550c2531) | Soulbound NFT with 4 reputation levels |
| `YSAGrantPool` | [`0xcbe59846fc43291a7d1828e77c3319ee43ad0e32`](https://testnet.monadexplorer.com/address/0xcbe59846fc43291a7d1828e77c3319ee43ad0e32) | Badge-gated grant distribution |

### 🏅 Reputation Levels

| Level | Title | Requirements |
|-------|-------|-------------|
| 1 | **Organized** | First cycle complete |
| 2 | **Disciplined** | 3+ cycles, consistent updates |
| 3 | **Capital Ready** | Full financial model validated |
| 4 | **Investor Grade** | Track record of financial discipline |

---

## 💰 Economic Model

| Revenue Stream | Description |
|---------------|-------------|
| **Staking fees** | Small fee on cycle start |
| **Slash pool** | Abandoned stakes fund completion rewards |
| **Grant pool fees** | Funds/DAOs pay for verified founder pipeline |
| **Premium badges** | Deep financial audits and advanced mentoring |

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **AI Agent** | YSA mentor — keyword-driven with structured financial knowledge |
| **Blockchain** | Monad Testnet (high throughput for frequent txs) |
| **Contracts** | Solidity 0.8.24, Foundry |
| **Frontend** | Vanilla JS + ethers.js |
| **Data** | Real business data from Hummus Máshu (CDMX 🇲🇽) |

---

## 🤖 Agent Capabilities

YSA isn't just a chatbot — it's a **financial intelligence agent** with four core capabilities:

| Capability | Description |
|-----------|-------------|
| 🔄 **Accountability Engine** | Tracks founder progress across 7-day cycles. No excuses accepted. |
| 🔗 **Onchain Reputation Oracle** | Any protocol can query `badge.levelOf(address)` and `discipline.completedCycles(address)` to verify founder maturity |
| 📊 **Autonomous Financial Analysis** | Guides founders through P&L, Cash Flow, and Balance Sheet construction with real business data |
| 🎯 **Adaptive Mentorship** | Pre-deposit: answers info questions only. Post-deposit: full financial mentorship unlocked |

### 📅 7-Day Achievement Roadmap

| Day | Focus | Deliverable |
|-----|-------|------------|
| 1 | Revenue & Costs | Income Statement (P&L) draft |
| 2 | Cash Flow Mapping | Where money actually goes |
| 3 | Balance Sheet | Assets, liabilities, equity snapshot |
| 4 | Unit Economics | Cost per unit, margins, break-even |
| 5 | Financial Projections | 3-month forecast |
| 6 | Risk Analysis | What could go wrong + mitigation |
| 7 | Final Review + Quiz | Score ≥ 80% → Badge minted onchain |

---

## 🎬 Demo

- 🔗 **[Live App](https://ysa-mentor.pages.dev)** — Connect wallet, deposit MON, start your cycle
- 🎭 **[Auto-Play Demo](https://ysa-mentor.pages.dev/demo/)** — Watch the full experience in 2 minutes
- 📹 Video — Coming soon

---

## 👥 Team

- **danielam** (LATAMBuilders) — Founder, product design, financial model
- **Aibus Dumbleclaw** — AI agent, smart contracts, web development

---

## 🏆 Built For

**Moltiverse Hackathon** by Nadfun & Monad
**Track:** Agent

---

## 🦅 Why Monad?

- **High throughput** — Daily check-ins and quiz submissions need fast, cheap transactions
- **EVM compatible** — Standard Solidity, no learning curve for builders
- **Growing ecosystem** — YSA badges become composable reputation across Monad DeFi/grants
- **Native MON staking** — Simple commitment deposit, no token overhead

---

## 🚀 Run Locally

```bash
# Clone
git clone https://github.com/LATAMBuilders/YSA-financial-mentor.git
cd YSA-financial-mentor

# Build & test contracts
cd contracts
forge build
forge test

# Run frontend
open web/index.html
# or
python3 -m http.server 8080 -d web/
```

---

<p align="center">
  <b>Built on Monad</b> 🟣 | Financial discipline is the new credit score.
</p>
