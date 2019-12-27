require 'pp'

def find_item_by_name_in_collection(name, collection)
  #Returns element for only the first occurence of name in collection
  if collection then
    for i in 0...collection.length
      if collection[i][:item] == name then
        return collection[i]
      end
    end
  end

  return nil
end

def find_index_by_name_in_collection(name, collection)
  #Returns index for only the first occurence of name in collection
  if collection then
    for i in 0...collection.length
      if collection[i][:item] == name then
        return i
      end
    end
  end

  return nil
end

def remove_quantity_zero_items (cart)
  cart_item = {}
  i = 0

  if cart then
    while i<cart.length
      cart_item = cart[i]

      if cart_item[:count] == 0 then
        cart.delete_at(i)
      else
        i = i + 1
      end
    end
  end

  return cart
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  consolidated_cart = []
  item_in_consolidated_cart = {}
  item_name = ""
  cart_item = {}

  for i in 0...cart.length
    cart_item = cart[i]
    item_name = cart_item[:item]

    item_in_consolidated_cart = find_item_by_name_in_collection(item_name, consolidated_cart)

    if item_in_consolidated_cart then
      item_in_consolidated_cart[:count] = item_in_consolidated_cart[:count] + 1
      consolidated_cart[find_index_by_name_in_collection(item_name, consolidated_cart)] = item_in_consolidated_cart
    else
      cart_item[:count] = 1
      consolidated_cart.push(cart_item)
    end

  end

  return consolidated_cart
end

def apply_coupons(cart, coupons)
  pp coupons
  pp cart
  coupon_cart = cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon = {}
  coupon_item_name = ""
  coupon_applied_text = " W/COUPON"
  coupon_applied_item_name = ""
  coupon_quantity = 0
  coupon_cost_per_item = 0.0

  item_in_cart = {}
  item_in_cart_index = 0
  item_in_cart_quantity = 0

  applied_item_in_cart = {}
  applied_item_in_cart_index = 0
  applied_item_in_cart_quantity = 0

  if coupons then
    #pp coupon_cart

    for i in 0...coupons
      coupon = coupons[i]
      coupon_item_name = coupon[:item]
      coupon_applied_item_name = coupon_item_name + coupon_applied_text
      coupon_quantity = coupon[:num]
      coupon_cost_per_item = (coupon[:cost] / coupon_quantity).round(2)

      item_in_cart = find_item_by_name_in_collection(coupon_item_name, coupon_cart)

      if item_in_cart then
        item_in_cart_index = find_index_by_name_in_collection(coupon_item_name, coupon_cart)
        item_in_cart_quantity = item_in_cart[:count]

        while item_in_cart_quantity >= coupon_quantity
          item_in_cart_quantity = item_in_cart_quantity - coupon_quantity
          item_in_cart[:count] = item_in_cart_quantity
          coupon_cart[item_in_cart_index] = item_in_cart

          applied_item_in_cart = find_item_by_name_in_collection(coupon_applied_item_name, coupon_cart)
          if applied_item_in_cart then
            applied_item_in_cart_index = find_index_by_name_in_collection(coupon_applied_item_name, coupon_cart)
            applied_item_in_cart_quantity = applied_item_in_cart[:count]

            applied_item_in_cart_quantity = applied_item_in_cart_quantity + 2
            applied_item_in_cart[:count] = applied_item_in_cart_quantity
            coupon_cart[applied_item_in_cart_index] = applied_item_in_cart
          else
            coupon_cart.push({
              :item => coupon_applied_item_name,
              :price => coupon_cost_per_item,
              :clearance => item_in_cart[:clearance],
              :count => coupon_quantity
              })
          end

          item_in_cart = find_index_by_name_in_collection(coupon_item_name, coupon_cart)
          item_in_cart_index = find_index_by_name_in_collection(coupon_item_name, coupon_cart)
          item_in_cart_quantity = item_in_cart[:count]
        end
      end
    end
  end

  #coupon_cart = remove_quantity_zero_items (coupon_cart)
  #pp coupon_cart
  return coupon_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  clearance_cart = nil
  cart_item = {}

  if clearance_cart then
    clearance_cart = cart

    for i in 0...clearance_cart.length
      cart_item = clearance_cart[i]
      if cart_item[:clearance] then
        cart_item[:price] = (cart_item[:price] * 0.8).round(2)
        clearance_cart[i] = cart_item
      end
    end
  end

  return clearance_cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
