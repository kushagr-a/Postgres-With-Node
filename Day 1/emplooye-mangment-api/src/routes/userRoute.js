import { Router } from "express";
import { getAllEmployess } from "../controller/userRoute.js";

const userRouter = Router();

userRouter.route("/employess").get(getAllEmployess);

export default userRouter;
