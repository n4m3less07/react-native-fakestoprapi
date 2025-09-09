import api from "./api";
import AsyncStorage from "@react-native-async-storage/async-storage";

export async function login(username, password) {
  const res = await api.post("/auth/login", { username, password });
  const token = res.data.token;

  await AsyncStorage.setItem("token", token);

  return token;
}
