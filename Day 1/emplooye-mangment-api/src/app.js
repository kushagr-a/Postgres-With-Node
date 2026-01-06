import express from "express";
import pool, { testConnection } from "./db/dbConnecting.js";

//import Route api
import userRoute from "./routes/userRoute.js";

const app = express();
const PORT = process.env.PORT;

// Middleware
app.use(express.json({ limit: "5kb" }));
app.use(express.urlencoded({ extended: true }, { limit: "5kb" }));

// Routes
app.get("/health", (req, res) => {
  res.status(200).json({
    success: true,
    status: "OK",
    message: "Server is running",
    timestamp: new Date().toISOString(),
  });
});

// Api 
app.use("/api", userRoute)

// Server Start
const server = app.listen(PORT, async () => {
  console.log(`Server running on http://localhost:${PORT}`);
  await testConnection();
});

// Graceful Shutdown
const Shutdown = async (signal) => {
  console.log(`\n${signal} receive. Shutting down...`);

  server.close(async () => {
    try {
      await pool.end();
      console.log("✅ Database disconnected");
      process.exit(0);
    } catch (error) {
      console.error("❌ Shutdown error:", error.message);
      process.exit(1);
    }
  });
};

process.on("SIGINT", Shutdown);
process.on("SIGTERM", Shutdown);
