import api from "./api";

export async function getUsers() {
  const res = await api.get("/users");
  return res.data;
}

export async function getUser(id) {
  const res = await api.get(`/users/${id}`);
  return res.data;
}

export async function createUser(userData) {
  const res = await api.post("/users", userData);
  return res.data;
}

export async function updateUser(id, userData) {
  const res = await api.put(`/users/${id}`, userData);
  return res.data;
}

export async function deleteUser(id) {
  const res = await api.delete(`/users/${id}`);
  return res.data;
}
