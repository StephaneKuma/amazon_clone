const express = require("express");
const bcryptjs = require("bcryptjs");

const User = require("../../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (request, response) => {
  try {
    const { name, email, password } = request.body;

    const userExist = await User.findOne({ email });

    if (userExist) {
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

module.exports = authRouter;
