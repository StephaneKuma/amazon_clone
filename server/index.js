const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const ordersRouter = require("./routes/orders");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");

// const DB = "mongodb://localhost:27017/amazone-clone";
// const DB =
//   "mongodb+srv://stekos:<password>@cluster0.otykfs4.mongodb.net/?retryWrites=true&w=majority";
const DB =
  "mongodb+srv://stekos:bebechou@cluster0.otykfs4.mongodb.net/?retryWrites=true&w=majority";
const PORT = 3000;

const app = express();

app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(ordersRouter);
app.use(userRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected successfuly to MongoDB");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at port ${PORT}`);
});
