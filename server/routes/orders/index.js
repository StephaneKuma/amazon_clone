const express = require("express");
const admin = require("../../middlewares/admin");
const Order = require("../../models/order");

const ordersRouter = express.Router();

ordersRouter.get("/api/orders", admin, async (request, response) => {
  try {
    const orders = await Order.find({});
    response.json(orders);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

ordersRouter.post("/api/order/change-status", admin, async (request, response) => {
  try {
    const { id, status } = request.body;
      let order = await Order.findById(id);
      
    order.status = status;
      order = await order.save();
      
    response.json(order);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

ordersRouter.get("/api/analytics", admin, async (request, response) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // CATEGORY WISE ORDER FETCHING
    let mobileEarnings = await fetchCategoryWiseProduct("Mobiles");
    let essentialEarnings = await fetchCategoryWiseProduct("Essentials");
    let applianceEarnings = await fetchCategoryWiseProduct("Appliances");
    let booksEarnings = await fetchCategoryWiseProduct("Books");
    let fashionEarnings = await fetchCategoryWiseProduct("Fashion");

    let earnings = {
      totalEarnings,
      mobileEarnings,
      essentialEarnings,
      applianceEarnings,
      booksEarnings,
      fashionEarnings,
    };

    response.json(earnings);
  } catch (e) {
    response.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = ordersRouter;
