const jwt = require("jsonwebtoken");

const User = require("../models/user");

const admin = async (request, response, next) => {
  try {
    const token = request.header("x-auth-token");
    if (!token)
      return response
        .status(401)
        .json({ message: "No auth token, access denied." });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return response
        .status(401)
        .json({ message: "Token verification failed, authorization denied." });

      const user = await User.findById(verified.id);
      if (user.type == 'user' || user.type == 'seller')
          return response.status(401).json({message: "You are not an admin!"})

    request.userId = verified.id;
    request.token = token;

    next();
  } catch (exception) {
    return response.status(500).json({ error: exception.message });
  }
};

module.exports = admin;
