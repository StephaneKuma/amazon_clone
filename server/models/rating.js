const mongoose = require("mongoose");

const ratingSchema = mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  value: {
    type: Number,
    required: true,
  },
});


// const Rating = mongoose.model("Rating", ratingSchema);

module.exports = ratingSchema;
