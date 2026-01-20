// Used for establish data-base and in your server
import "../config/env.js";

import pkg from "pg";
const { Pool } = pkg;

// Database configuration
const pool = new Pool({
  user: process.env.DB_USER || "postgres",
  host: process.env.DB_HOST || "localhost",
  database: process.env.DB_NAME || "company_db",
  password: process.env.DB_PASS,
  port: parseInt(process.env.DB_PORT || "5432"),
});

// Error handling for pool
pool.on("error", (err) => {
  console.error("Database error:", err);
});

// Database connection test function
export const testConnection = async () => {
  try {
    const client = await pool.connect();
    console.log("✅ Database connected successfully");
    client.release();
    return true;
  } catch (err) {
    console.error("❌ Database connection failed:", err.message);
    return false;
  }
};

// Default export
export default pool;
