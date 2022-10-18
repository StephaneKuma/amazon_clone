const express = require("express");
const userRouter = express.Router();
const auth = require("../../middlewares/auth");
const Order = require("../../models/order");
const { Product } = require("../../models/product");
const User = require("../../models/user");

userRouter.post("/api/add-to-cart", auth, async (request, response) => {
  try {
    const { id } = request.body;
    const product = await Product.findById(id);
    let user = await User.findById(request.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let productIsFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          productIsFound = true;
        }
      }

      if (productIsFound) {
        let foundedProduct = user.cart.find((prod) =>
          prod.product._id.equals(product._id)
        );
        foundedProduct.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    response.json(user);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

userRouter.delete("/api/remove-from-cart/:id", auth, async (request, response) => {
  try {
    const { id } = request.params;
    const product = await Product.findById(id);
    let user = await User.findById(request.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    response.json(user);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

// save user address
userRouter.post("/api/save-user-address", auth, async (request, response) => {
  try {
    const { address } = request.body;
    let user = await User.findById(request.user);
    user.address = address;
    user = await user.save();
    response.json(user);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

// order product
userRouter.post("/api/order", auth, async (request, response) => {
  try {
    const { cart, totalPrice, address } = request.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return response
          .status(400)
          .json({ msg: `${product.name} is out of stock!` });
      }
    }

    let user = await User.findById(request.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: request.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    response.json(order);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

userRouter.get("/api/orders/me", auth, async (request, response) => {
  try {
    const orders = await Order.find({ userId: request.user });
    response.json(orders);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
