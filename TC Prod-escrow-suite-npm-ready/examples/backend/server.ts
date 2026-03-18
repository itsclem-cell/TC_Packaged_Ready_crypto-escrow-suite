import express from "express";

const app = express();

app.get("/health", (_req, res) => {
  res.json({ ok: true });
});

app.listen(3000, () => {
  console.log("Example backend listening on port 3000");
});
