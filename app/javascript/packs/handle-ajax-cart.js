$(document).ready(function () {
  $(".input-quantity").change(function() {
    quantity_cart = $(this).attr("id");
    quantity_change = $(this).val();
    quantity = quantity_change - quantity_cart
    id = $(this).attr("data-id");
    $(".minus-product").attr("href", "/carts/minus-item-cart/" + id + "/" + Math.abs(quantity));
    $(".plus-product").attr("href", "/carts/add-to-cart/" + id + "/" + quantity);
  });
});
