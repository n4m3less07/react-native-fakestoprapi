import api from "./api";

export async function getProducts() {
  const res = await api.get("/products");
  return res.data;
}

export async function getProduct(id) {
  const res = await api.get(`/products/${id}`);
  return res.data;
}

export async function createProduct(productData) {
  const res = await api.post("/products", productData);
  return res.data;
}

export async function updateProduct(id, productData) {
  const res = await api.put(`/products/${id}`, productData);
  return res.data;
}

export async function deleteProduct(id) {
  const res = await api.delete(`/products/${id}`);
  return res.data;
}
