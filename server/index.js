const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");

const DB = "mongodb://localhost:27017/amazone-clone";
const PORT = 3000;

const app = express();

app.use(express.json())
app.use(authRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected successfuly to MongoDB");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, () => {
  console.log(`Connected at port ${PORT}`);
});
