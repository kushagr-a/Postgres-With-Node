import pool from "../db/dbConnecting.js";

export const getAllEmployess = async (req, res) =>{
     try {
    const result = await pool.query(
      "SELECT * FROM emloyees ORDER BY emp_id ASC"
    );
    console.log(result);
    res.status(200).json({
      success: true,
      message: "Data fetch of emloyees",
      data: result.rows,
      count: result.rowCount,
    });
  } catch (error) {
    console.error("Error fetching employess", error);
    res.status(500).json({
      success: false,
      message: "Error in fetching employess",
    });
  }
}