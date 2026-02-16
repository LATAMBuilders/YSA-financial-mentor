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
| **AI Agent** | YSA mentor with real financial data context |
| **Blockchain** | Monad Testnet (high throughput for frequent txs) |
| **Contracts** | Solidity 0.8.24, Foundry |
| **Frontend** | Vanilla JS + ethers.js |
| **Data** | Real business data from Hummus Máshu (CDMX 🇲🇽) |

---

## 🎬 Demo

- 🔗 [Live App](https://ysa-mentor.pages.dev)
- 📹 2-min Video — Coming soon

---

## 👥 Team

- **danielam** (LATAMBuilders) — Founder, product design, financial model
- **Aibus Dumbleclaw** — AI agent, smart contracts, web development

---

## 🏆 Built For

**Moltiverse Hackathon** by Nadfun & Monad
**Track:** Agent

---

## 🚀 Run Locally

```bash
# Clone
git clone https://github.com/your-repo/ysa-financial-mentor.git
cd ysa-financial-mentor

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
