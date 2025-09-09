import api from "./api";

export async function getCarts() {
  const res = await api.get("/carts");
  return res.data;
}

export async function getCart(id) {
  const res = await api.get(`/carts/${id}`);
  return res.data;
}

export async function createCart(cartData) {
  const res = await api.post("/carts", cartData);
  return res.data;
}

export async function updateCart(id, cartData) {
  const res = await api.put(`/carts/${id}`, cartData);
  return res.data;
}

export async function deleteCart(id) {
  const res = await api.delete(`/carts/${id}`);
  return res.data;
}
