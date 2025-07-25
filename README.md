# 🔢 Assembly Language Scientific Calculator (8086 MASM)

This project is a text-based **Scientific Calculator** built in **x86 Assembly (8086)** using **MASM (Microsoft Macro Assembler)** syntax. It supports both basic arithmetic operations and advanced bitwise and trigonometric functions (using lookup tables). All calculations are done using integer and fixed-point arithmetic (no floating point unit required).

---

## 📋 Features

### ➕ Arithmetic Operations
- **1. Addition**
- **2. Subtraction**
- **3. Multiplication**
- **4. Division**
- **5. Modulus**

### ➗ Unary Operations
- **6. Negation**
- **7. Square**
- **8. Cube**

### 🧮 Bitwise Operations
- **9. Bitwise OR**
- **10. Bitwise AND**
- **11. Bitwise XOR**
- **12. Bitwise NOT**

### 🔢 Trigonometric Functions
- **13. Cosine (0–360° using lookup table)**
- **14. Sine (0–360° using lookup table)**

### ❌ Exit
- **0. Exit Program**

---

## 🧠 Program Flow

- Displays a menu with 14 operations + Exit.
- Takes user input using `INT 21h` services.
- Calls specific procedures for the selected operation.
- Displays result using formatted output, including operator symbol and result.
- Trigonometric values are returned in fixed-point format (accuracy up to 4 decimal places).

---
## 🖥️ Requirements

To build and run this program:

- MASM or TASM assembler
- DOS environment or emulator like:
  - **DOSBox**
  - **EMU8086**
- Optionally: any IDE that supports 8086 assembly (Turbo Assembler, Visual Studio with DOSBox plugin)

---

### Sample Flow:

#### 1️⃣ Menu Appears:

<img width="581" height="577" alt="image" src="https://github.com/user-attachments/assets/2d8d0648-e44f-4a67-83fe-ab1649b2911c" />



#### 2️⃣ User Chooses an Option:

<img width="530" height="591" alt="image" src="https://github.com/user-attachments/assets/a62ef018-fa78-469b-88ee-966ac2276901" />


####  Inputs Are Taken & Result is Displayed:

Example: For addition
<img width="831" height="667" alt="image" src="https://github.com/user-attachments/assets/be38bccb-83d5-40d6-ad66-818d3e263399" />

#### If user enters 1 the program menu will appear again
<img width="751" height="483" alt="image" src="https://github.com/user-attachments/assets/77bfdb2a-559f-42ac-9dee-0a585779f612" />


#### If the user enters 0 then the program will jump to exit function and then display the message and terminates the program.
<img width="865" height="152" alt="image" src="https://github.com/user-attachments/assets/715f323a-6a7d-4bdf-b6fe-0cd67bc7baff" />
