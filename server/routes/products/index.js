const express = require("express");
const admin = require("../../middlewares/admin");
const auth = require("../../middlewares/auth");
const { Product } = require("../../models/product");

const productsRouter = express.Router();

productsRouter.post("api/products/store", admin, async (request, response) => {
  try {
    const { name, description, images, quantity, price, category } =
      request.body;

    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });

    product = await product.save();

    return response.json(product);
  } catch (error) {
    return response.status(500).json({ error: error.message });
  }
});

productsRouter.get("api/products", admin, async (request, response) => {
  try {
    const products = await Product.find({});
    response.json(products);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

productsRouter.get("api/category/products", auth, async (request, response) => {
  try {
    const products = await Product.find({ category: request.query.category });
    response.json(products);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

productsRouter.get(
  "api/products/search/:name",
  auth,
  async (request, response) => {
    try {
      const products = await Product.find({
        name: { $regex: request.params.name, $options: "i" },
      });
      response.json(products);
    } catch (e) {
      response.status(500).json({ error: e.message });
    }
  }
);

productsRouter.get(
  "api/rate-product",
  auth,
  async (request, response) => {
    try {
      const { id, value } = request.body;
      let product = await Product.findById(id);

      for (let i = 0; i < product.ratings.length; i++) {
        if (product.ratings[i].userId == request.user) {
          product.ratings.splice(i, 1);
          break;
        }
      }

      const ratingSchema = {
        userId: request.user,
        value,
      };

      product.ratings.push(ratingSchema);
      product = await product.save();
      response.json(product);
    } catch (e) {
      response.status(500).json({ error: e.message });
    }
  }
);

productsRouter.get("api/deal-of-the-day", auth, async (request, response) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].value;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].value;
      }
      return aSum < bSum ? 1 : -1;
    });

    response.json(products[0]);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

productsRouter.get("api/products/delete", admin, async (request, response) => {
  try {
    const { id } = request.body;
    let product = await Product.findByIdAndDelete(id);
    response.json(product);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

module.exports = productsRouter;
