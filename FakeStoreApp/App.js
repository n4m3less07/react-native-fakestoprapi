/* eslint-disable no-unused-vars */
import React, { useState } from "react";
import { View, Text, Button, ScrollView } from "react-native";
import { login } from "./src/services/auth";
import { getUsers, getUser } from "./src/services/users";
import { getProducts, getProduct } from "./src/services/products";
import { getCarts, getCart } from "./src/services/carts";

export default function App() {
  const [data, setData] = useState(null);

  const handleLogin = async () => {
    const token = await login("mor_2314", "83r5^_");
    setData(`✅ Logged in, token: ${token}`);
  };

  const handleGetUsers = async () => {
    const users = await getUsers();
    setData(users);
  };

  const handleGetProducts = async () => {
    const products = await getProducts();
    setData(products);
  };

  const handleGetCarts = async () => {
    const carts = await getCarts();
    setData(carts);
  };

  return (
    <ScrollView style={{ marginTop: 50, padding: 20 }}>
      <Button title="Login" onPress={handleLogin} />
      <Button title="Get Users" onPress={handleGetUsers} />
      <Button title="Get Products" onPress={handleGetProducts} />
      <Button title="Get Carts" onPress={handleGetCarts} />
      <Text>{JSON.stringify(data, null, 2)}</Text>
    </ScrollView>
  );
}
