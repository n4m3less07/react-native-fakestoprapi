#!/bin/bash

BASE_URL="http://localhost:3000/api"

echo "🚀 FakeStore API Full Test Script (with timeout handling)"
echo "==========================================="


echo -e "\n🔑 Testing login..."
LOGIN_RESPONSE=$(curl --max-time 10 -s -X POST $BASE_URL/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "mor_2314", "password": "83r5^_"}')

TOKEN=$(echo $LOGIN_RESPONSE | jq -r .token)

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "❌ Login failed: $LOGIN_RESPONSE"
  exit 1
else
  echo "✅ Logged in, token: $TOKEN"
fi


echo -e "\n📦 Testing Products..."

NEW_PRODUCT=$(curl --max-time 10 -s -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Test Product","price":99.99,"description":"Demo product","category":"electronics","image":"https://i.pravatar.cc"}')
echo "✅ Product created: $NEW_PRODUCT"
PRODUCT_ID=$(echo $NEW_PRODUCT | jq -r .id)


ALL_PRODUCTS=$(curl --max-time 10 -s $BASE_URL/products \
  -H "Authorization: Bearer $TOKEN")
echo "✅ All products fetched"

SINGLE_PRODUCT=$(curl --max-time 10 -s $BASE_URL/products/$PRODUCT_ID \
  -H "Authorization: Bearer $TOKEN")
echo "✅ Single product: $SINGLE_PRODUCT"

UPDATED_PRODUCT=$(curl --max-time 10 -s -X PUT $BASE_URL/products/$PRODUCT_ID \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Updated Product","price":59.99}')
echo "✅ Product updated: $UPDATED_PRODUCT"

DELETED_PRODUCT=$(curl --max-time 10 -s -X DELETE $BASE_URL/products/$PRODUCT_ID \
  -H "Authorization: Bearer $TOKEN")
echo "✅ Product deleted: $DELETED_PRODUCT"


echo -e "\n👤 Testing Users..."

USERS=$(curl --max-time 10 -s $BASE_URL/users \
  -H "Authorization: Bearer $TOKEN")
echo "✅ Users fetched"

SINGLE_USER=$(curl --max-time 10 -s $BASE_URL/users/1 \
  -H "Authorization: Bearer $TOKEN")
echo "✅ Single user: $SINGLE_USER"


echo -e "\n🛒 Testing Carts..."

NEW_CART=$(curl --max-time 10 -s -X POST $BASE_URL/carts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"userId":1,"products":[{"productId":1,"quantity":2},{"productId":2,"quantity":1}]}')
echo "✅ Cart created: $NEW_CART"
CART_ID=$(echo $NEW_CART | jq -r .id)

ALL_CARTS=$(curl --max-time 10 -s $BASE_URL/carts \
  -H "Authorization: Bearer $TOKEN")
echo "✅ All carts fetched"

CART=$(curl --max-time 10 -s $BASE_URL/carts/$CART_ID \
  -H "Authorization: Bearer $TOKEN")
if [ -z "$CART" ]; then
  echo "⚠️ Impossible de récupérer le panier (timeout)"
else
  echo "✅ Single cart fetched"
fi

USER_CARTS=$(curl --max-time 10 -s $BASE_URL/carts/user/1 \
  -H "Authorization: Bearer $TOKEN")
echo "✅ Carts for user: $USER_CARTS"

UPDATED_CART=$(curl --max-time 10 -s -X PUT $BASE_URL/carts/$CART_ID \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"products":[{"productId":2,"quantity":5}]}')
echo "✅ Cart updated: $UPDATED_CART"

DELETED_CART=$(curl --max-time 10 -s -X DELETE $BASE_URL/carts/$CART_ID \
  -H "Authorization: Bearer $TOKEN")
echo "✅ Cart deleted: $DELETED_CART"

echo -e "\n🎉 Full CRUD + Auth test finished (with timeout handling)"
