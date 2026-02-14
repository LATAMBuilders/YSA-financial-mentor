# YSA — Mentora Financiera 🧠💰

**Tu disciplina financiera, verificada onchain.**

YSA is an AI financial mentor for LATAM founders that combines behavioral accountability with blockchain verification. Stake real value, complete financial challenges, earn soulbound reputation badges, and unlock grant funding — all onchain.

## Problem

LATAM founders struggle with financial discipline. Traditional mentorship is expensive, inconsistent, and unverifiable. Investors have no way to assess a founder's financial rigor before writing checks.

## Solution

YSA creates a **discipline-to-capital pipeline**:

1. **Stake** → Founder commits MON to a 7-day discipline cycle
2. **Challenge** → Complete 3 financial challenges guided by Ysa (AI CFO mentor)
3. **Badge** → Earn a soulbound NFT proving financial discipline level
4. **Grant** → Apply to grant pools that require verified badges

```
┌─────────────┐     ┌──────────────┐     ┌───────────┐     ┌────────────┐
│  Stake MON  │────▶│  3 Challenges │────▶│  Badge NFT │────▶│ Grant Pool │
│  (7 days)   │     │  (AI-guided)  │     │ (Soulbound)│     │  (Funding) │
└─────────────┘     └──────────────┘     └───────────┘     └────────────┘
       │                                       │
       │            ┌──────────┐               │
       └───abandon──▶│  Slashed  │              │
                    │  (-50%)   │              │
                    └──────────┘              │
                                              ▼
                                    Levels: Organized → Disciplined
                                         → CapitalReady → InvestorGrade
```

## Smart Contracts

| Contract | Description |
|----------|-------------|
| `YSADiscipline` | Stake-based 7-day discipline cycles with challenge tracking |
| `YSABadge` | Soulbound ERC-721 with 4 reputation levels |
| `YSAGrantPool` | Grant pools requiring minimum badge level to apply |

### Contract Addresses (Monad Testnet)

| Contract | Address |
|----------|---------|
| YSABadge | TBD |
| YSADiscipline | TBD |
| YSAGrantPool | TBD |

## Run Locally

### Smart Contracts

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Build & Test
cd ysa-financial-mentor
forge build
forge test -vv
```

### Web App

Just open `web/index.html` in your browser. No build step needed.

For contract interaction, connect MetaMask to Monad Testnet (Chain ID: 10143).

## Tech Stack

- **Smart Contracts:** Solidity 0.8.24, Foundry
- **Frontend:** Vanilla JS, ethers.js v6
- **Network:** Monad Testnet
- **AI Mentor:** Simulated in demo (production: LLM-powered)

## Team

- **danielam** (LATAMBuilders) — Founder, Product
- **Aibus Dumbleclaw** — AI Agent, Engineering

## License

MIT

---

*Built for the Moltiverse Hackathon on Monad* 🟣
