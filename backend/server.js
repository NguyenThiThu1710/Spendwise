import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { pool } from "./db.js";
import authRoutes from "./routes/auth.js";

dotenv.config();

const app = express();

// -------------------- CẤU HÌNH CORS CHO ĐA NỀN TẢNG --------------------
// Cho phép tất cả localhost, 127.0.0.1 và IP nội bộ (192.168.x.x)
app.use(
  cors({
    origin: (origin, callback) => {
      if (
        !origin ||                                // cho phép Postman / server nội bộ
        origin.startsWith("http://localhost") ||   // Flutter Web
        origin.startsWith("http://127.0.0.1") ||   // Trình duyệt khác
        origin.startsWith("http://10.0.2.2") ||    // Android emulator
        origin.startsWith("http://192.168.")       // Thiết bị thật trong mạng LAN
      ) {
        callback(null, true);
      } else {
        console.warn("❌ CORS blocked request from:", origin);
        callback(new Error("Not allowed by CORS"));
      }
    },
    credentials: true,
  })
);

// -------------------- CẤU HÌNH CƠ BẢN --------------------
app.use(express.json());

// -------------------- ROUTES --------------------
app.use("/auth", authRoutes);

// -------------------- TEST ROUTE --------------------
app.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");
    res.send(
      `Spendwise API is running! 🟢\nDatabase connected at: ${result.rows[0].now}`
    );
  } catch (err) {
    console.error(err);
    res.status(500).send("Database connection failed ❌");
  }
});

// -------------------- START SERVER --------------------
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`✅ Spendwise backend is running on port ${port}`);
});
