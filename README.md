# 🌱 Adopt-a-Plot — Blockchain-based Organic Farming DApp

A decentralized application (DApp) running on the **Ethereum Sepolia testnet** that lets users adopt virtual organic farming plots on-chain. Each plot records its **owner**, **crop type**, and **growth status**. The frontend connects to MetaMask to read from and write to the smart contract using ethers.js.

## 🧱 Project Structure

| Path | Description |
|---|---|
| `contracts/AdoptAPlot.sol` | Solidity smart contract source code |
| `contracts/AdoptAPlot.json` | Contract ABI (JSON) |
| `index.html` | DApp frontend (HTML + JavaScript + ethers.js v5) |
| `README.md` | Project documentation |

## 🚀 Live Demo

**https://liu302580-svg.github.io/Adopt-a-Plot-DAppAdopt-a-Plot-DApp/**

## ⛓️ Smart Contract — Sepolia Testnet

| Item | Value |
|---|---|
| **Contract address** | `0xc90Fd53ec8F7B729b75c2E969A63f1181990b11f` |
| Network | Ethereum Sepolia (`chainId` 11155111) |
| Solidity | `^0.8.20` (deployed bytecode compiled with solc `0.8.34`) |
| Explorer | https://sepolia.etherscan.io/address/0xc90Fd53ec8F7B729b75c2E969A63f1181990b11f |

## 📜 Contract Functions

| Function | Type | Description |
|---|---|---|
| `adoptPlot(string _cropType)` | write | Adopt a new plot; the new plot starts with status `"Seedling"` |
| `updatePlotStatus(uint _id, string _newStatus)` | write | Update a plot's status (only the plot owner) |
| `getPlot(uint _id)` | read | Get a plot's id, owner, crop type, and status |
| `plotCount()` | read | Total number of plots adopted so far |
| `plots(uint _id)` | read | Full plot struct (public mapping getter) |

### Plot struct

```solidity
struct Plot {
    uint256 id;        // Unique plot id (starts at 1)
    address owner;     // Address that adopted the plot
    string cropType;   // Crop being grown (e.g. "Organic Tomato")
    string status;     // Growth status (e.g. "Seedling", "Growing", "Harvested")
    bool isActive;     // Whether the plot exists
}
```

## 🖥️ How to Use

1. Install the [MetaMask](https://metamask.io/) browser extension.
2. Switch MetaMask to the **Sepolia** test network and get free SepoliaETH from a Sepolia faucet.
3. Open the **Live Demo** link and click **Connect MetaMask Wallet**.
4. Adopt a plot, read plot details, or update the plot status.

> ⚠️ Write operations (`adoptPlot`, `updatePlotStatus`) consume gas and require SepoliaETH.

## 🛠️ Local Development

1. Clone the repository.
2. Open `index.html` in a browser (or serve it, e.g. `python -m http.server 8000`).
3. Make sure MetaMask is installed, unlocked, and on the **Sepolia** network.
   The frontend automatically requests the wallet connection and will prompt to switch to Sepolia if another network is selected.

## ✅ Verification

- The contract's public functions, storage layout, revert messages, and default status (`"Seedling"`) were verified against the **deployed on-chain bytecode** at `0xc90Fd53ec8F7B729b75c2E969A63f1181990b11f` (Sepolia) via `eth_call`/`eth_getCode`.
- The frontend includes multi-CDN ethers.js fallback, automatic Sepolia network switching, account/network change listeners, and always-visible error reporting.

## 🎯 Design & Rationale (for the demo / Q&A)

### Why blockchain?

- **Immutable ownership record.** Who adopted a plot, and when, is recorded on-chain and can never be altered or deleted by any party — no central database can be rewritten.
- **Transparency & verifiability.** Anyone can verify every plot, every status change, and every owner directly on Sepolia Etherscan without trusting a server.
- **User-controlled accounts.** Users interact through their own MetaMask wallet, so they hold their identity and their data (not a company account).

### What data is stored on-chain?

| Field | Why on-chain |
|---|---|
| `id` | Unique plot identifier issued by the contract |
| `owner` | Immutable proof of who adopted the plot |
| `cropType` | What is grown on the plot (public record) |
| `status` | Growth lifecycle (Seedling → Growing → Harvested), auditable history |
| `isActive` | Marks whether the plot still exists (checked before updates) |
| `plotCount` | Total adopted plots, also used to issue the next plot id |

### Why was the smart contract designed this way?

- **Struct + public mapping** (`plots(uint)`) gives a cheap, readable per-plot record and a free getter.
- **`plotCount` counter** issues sequential ids (1, 2, 3, …) without the need for an input id, keeping adoption simple and collision-free.
- **Owner-only status updates** — `require(plots[_id].owner == msg.sender, ...)` — enforce that only the plot owner can change its status, which is the core trust rule of the DApp.
- **Default status `"Seedling"`** — new plots start at a fixed lifecycle point, so status is always meaningful.
- **`isActive` guard** — prevents updating a non-existent plot (protects against wrong inputs).

### Challenges & limitations

- **Testnet only.** Runs on Sepolia, so it demonstrates the concept but carries no real value.
- **No on-chain verification of "real farming".** Crop type and status are entered by users; the contract cannot verify real-world farming activity (would need oracles / IoT sensors).
- **Manual status updates.** Status is updated manually by the owner instead of being automatically derived (e.g., time-based).
- **Gas costs & speed.** Every write costs SepoliaETH and waits for block confirmation.
- **Simple data model.** No plot history array, no token/NFT integration, no marketplace — kept minimal for a working prototype.

## 🎬 Demo Walkthrough (~7 min)

1. **Open the website** → https://liu302580-svg.github.io/Adopt-a-Plot-DAppAdopt-a-Plot-DApp/
2. **Connect MetaMask** → click "Connect MetaMask Wallet", approve the connection, network switches to Sepolia automatically; the wallet address and on-chain plot count appear.
3. **Transaction 1 — Adopt a plot** → enter a crop type (e.g. "Organic Tomato"), click "Adopt Plot", approve in MetaMask, wait for confirmation; the transaction link on Sepolia Etherscan is shown and `Total Plots` increases.
4. **Read** → enter the new plot ID, click "Get Details" → show owner (= your wallet), crop type, status (`Seedling`).
5. **Transaction 2 — Update status** → update your plot's status to "Growing" (owner-only), approve in MetaMask; show the second Etherscan link.
6. **Show the deployed contract** → open https://sepolia.etherscan.io/address/0xc90Fd53ec8F7B729b75c2E969A63f1181990b11f and point out the contract address.
7. **Explain design** → why blockchain, what is stored on-chain, design decisions, and limitations (see section above).

## 📄 License

For academic use.
