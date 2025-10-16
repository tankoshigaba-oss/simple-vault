Simple Vault — A Minimal STX Deposit & Withdrawal Smart Contract

Overview
The **Simple Vault** is a Clarity smart contract that allows users to **deposit**, **withdraw**, and **check** their STX balances securely on the **Stacks blockchain**.  
It’s a beginner-friendly project built with **Clarinet**, designed to demonstrate basic smart contract logic such as balance tracking, ownership checks, and error handling.

---

Features

-  Deposit STX into your personal vault  
-  Withdraw STX anytime (if you have sufficient balance)  
-  View your current balance  
-  View the total STX stored in the contract  
-  Safe arithmetic and error handling (no overflows)  
-  Fully testable in Clarinet console

---

Smart Contract Structure

| Function | Type | Description |
|-----------|------|-------------|
| `deposit` | Public | Deposit STX into your personal vault |
| `withdraw` | Public | Withdraw STX from your vault |
| `get-balance` | Read-only | View your vault balance |
| `get-total-vault` | Read-only | View total STX stored in the contract |

---

Requirements

- [Clarinet](https://docs.hiro.so/clarinet/getting-started) installed locally  
- VS Code (recommended)  
- Basic knowledge of Clarity syntax

