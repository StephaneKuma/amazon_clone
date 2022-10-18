const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const ordersRouter = require("./routes/orders");
const productRouter = require("./routes/products");

const DB = "mongodb://localhost:27017/amazone-clone";
const PORT = 3000;

const app = express();

app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(ordersRouter);

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
