const express = require('express');
const app = express();
const port = 3000;

// Define the /status endpoint
app.get('/status', (req, res) => {
  res.status(200).json({
    status: "ok",
    message: "API is running successfully"
  });
});

// Start the server
app.listen(port, () => {
  console.log(`API listening at http://localhost:${port}`);
});