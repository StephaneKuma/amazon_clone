const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const User = require("../../models/user");
const auth = require("../../middlewares/auth");

const authRouter = express.Router();

authRouter.post("/api/signup", async (request, response) => {
  try {
    const { name, email, password } = request.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return response.status(400).json({
        message: "User with the same email already exists!",
      });
    }

    let hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
    });

    user = await user.save();

    return response.json(user);
  } catch (exception) {
    return response.status(500).json({ error: exception.message });
  }
});

authRouter.post("api/signin", async (request, response) => {
  try {
    const { email, password } = request.body;

    const user = await User.findOne({ email });

    if (!user) {
      return response
        .status(400)
        .json({ message: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return response.status(400).json({ message: "Incorrect password" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");

    return response.json({ token, ...user._doc });
  } catch (exception) {
    return response.status(500).json({ error: exception.message });
  }
});

authRouter.post("/tokenIsValid", async (request, response) => {
  try {
    const token = request.header("x-auth-token");

    if (!token) return response.json(false);

    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return response.json(false);

    const user = await User.findById(verified.id);
    if (!user) return response.json(false);

    response.json(true);
  } catch (exception) {
    response.status(500).json({ error: exception.message });
  }
});

authRouter.get("/", auth, async (request, response) => {
  const user = await User.findById(request.userId);
  response.json({ ...user._doc, token: request.token });
});

module.exports = authRouter;
