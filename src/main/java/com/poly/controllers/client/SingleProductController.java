package com.poly.controllers.client;

import com.poly.entities.*;
import com.poly.repositories.*;
import com.poly.services.ParamService;
import com.poly.services.SessionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class SingleProductController {
    // 123
    @Autowired
    SessionService sessionService;
    @Autowired
    ProductItemRepository productItemRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    CartRepository cartRepository;
    @Autowired
    CartItemRepository cartItemRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    ColorRepository colorRepository;
    @Autowired
    ParamService paramService;
    @Autowired
    ReviewRepository reviewRepository;
    @Autowired
    OrderRepository orderRepository;

    @GetMapping("/single-product")
    public String singleProduct(Model model,
                                @RequestParam("product_id") Long id) {
        ProductItem productItem = productItemRepository.findProductItemByProductProductId(id).get(0);
        model.addAttribute("productItem", productItem);
        String msgComment = (String) model.asMap().get("msgComment");
        if (msgComment != null) {
            model.addAttribute("msgComment", msgComment);
        }
        model.addAttribute("page", "single-product.jsp");
        return "client/index";
    }

    @PostMapping("/add-to-cart")
    public String addToCart(Model model,
                            @RequestParam("product_id") Long id) {

        ProductItem productItem = productItemRepository.findProductItemByProductProductId(id).get(0);
        model.addAttribute("productItem", productItem);

        Long productId = productItem.getProduct().getProductId();
        String colorId = paramService.getString("color", "");
        String sizeId = paramService.getString("size", "");
        String quantityStr = paramService.getString("quantity", "");

        if (colorId == null || colorId.isEmpty() || sizeId == null || sizeId.isEmpty()) {
            if (colorId == null || colorId.isEmpty()) {
                model.addAttribute("msgColor", "Please select a color.");
            }
            if (sizeId == null || sizeId.isEmpty()) {
                model.addAttribute("msgSize", "Please select a size.");
            }
            model.addAttribute("page", "single-product.jsp");
            return "client/index";
        }

        ProductItem productItemAddToCart = productItemRepository.findByProductAndColorAndSize(
                productId,
                Long.parseLong(colorId),
                Long.parseLong(sizeId)
        );

        int quantity = Integer.parseInt(quantityStr);
        if (quantity > productItemAddToCart.getQuantity()) {
            model.addAttribute("outOfStock", "The quantity only has " + productItemAddToCart.getQuantity() + " in stock.");
        } else {
            Customer customer = sessionService.get("customer");
            Cart cart = cartRepository.findCartByCustomerCustomerId(customer.getCustomerId());
            if (cart == null) {
                cart = new Cart();
            }
            cart.setCustomer(customer);
            cartRepository.save(cart);

            // Kiểm tra nếu mục hàng đã tồn tại trong giỏ hàng
            CartItem existingCartItem = cartItemRepository.findByCartAndProductItem(cart, productItemAddToCart);

            if (existingCartItem != null) {
                // Cập nhật số lượng nếu mục hàng đã tồn tại
                existingCartItem.setQuantity(existingCartItem.getQuantity() + quantity);
                cartItemRepository.save(existingCartItem);
            } else {
                // Tạo mới nếu mục hàng chưa tồn tại
                CartItem cartItem = new CartItem();
                cartItem.setCart(cart);
                cartItem.setProductItem(productItemAddToCart);
                cartItem.setQuantity(quantity);
                cartItemRepository.save(cartItem);

                Long itemNumber = cartItemRepository.count();
                sessionService.set("itemNumber", itemNumber);
            }

            model.addAttribute("outOfStock", "Add to cart success.");
        }

        model.addAttribute("page", "single-product.jsp");
        return "client/index";
    }

    @PostMapping("/post-review")
    public String postReview(@RequestParam("product_id") Long productId,
                             @RequestParam("rating") Integer rating,
                             @RequestParam("review") String comment,
                             RedirectAttributes redirectAttributes) {

        Customer customer = sessionService.get("customer");
        if (customer == null) {
            return "redirect:/cart";
        }
        List<Order> orders = orderRepository.findOrderByCustomerCustomerId(customer.getCustomerId());
        if (!orders.isEmpty()) {
            Review review = new Review();
            review.setProduct(productRepository.findById(productId).orElse(null));
            review.setCustomer(customer);
            review.setRating(rating);
            review.setComment(comment);
            reviewRepository.save(review);
            return "redirect:/single-product?product_id=" + productId;
        }
        redirectAttributes.addFlashAttribute("msgComment", "You can't comment because you haven't purchased the product.");
        return "redirect:/single-product?product_id=" + productId;
    }

    @ModelAttribute("colors")
    public Set<Color> getAllColors(@RequestParam("product_id") Long id) {
        List<ProductItem> productItemList = productItemRepository.findProductItemByProductProductId(id);
        Set<Color> colors = new HashSet<>();
        for (ProductItem pi : productItemList) {
            colors.add(pi.getColor());
        }
        return colors;
    }

    @ModelAttribute("sizes")
    public Set<Size> getAllSizes(@RequestParam("product_id") Long id) {
        List<ProductItem> productItemList = productItemRepository.findProductItemByProductProductId(id);
        Set<Size> sizes = new HashSet<>();
        for (ProductItem pi : productItemList) {
            sizes.add(pi.getSize());
        }
        return sizes;
    }

    @ModelAttribute("reviews")
    public List<Review> getAllReviews(@RequestParam("product_id") Long id) {
        return reviewRepository.findReviewByProductProductId(id);
    }
}
