# 🌱 Adopt-a-Plot — Blockchain-based Organic Farming DApp

A decentralized application (DApp) running on the **Ethereum Sepolia testnet** that lets users adopt virtual organic farming plots on-chain. Each plot records its **owner**, **crop type**, and **growth status**. The frontend connects to MetaMask to read from and write to the smart contract using ethers.js.

## 🧱 Project Structure

| Path | Description |
|---|---|
| `contracts/AdoptAPlot.sol` | Solidity smart contract source code |
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

## 📄 License

For academic use.
