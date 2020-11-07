package com.project.rgb;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import CartManagement.CartService;
import dto.CartDTO;
import dto.MemberDTO;
import dto.ProductDTO;

@Controller
public class CartController {
	
	@Autowired
	CartService cartService;
	
	static int FREE_DELEVARY_STANDARD = 50000;
	
	@RequestMapping(value = "/registerCart", method = RequestMethod.POST)
	public String register(CartDTO cartDTO, RedirectAttributes ra) {
		System.out.print("registerCart : " + cartDTO.getProductId());
		try {
			cartService.register(cartDTO);
			ra.addFlashAttribute("registerCartResult", "success");
			return "redirect:/getFurniture?id=" + cartDTO.getProductId(); // 원래 당연히 redirect 써서 어디로 넘거갈지 창으로 물어봐야지
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ra.addFlashAttribute("registerCartResult", "fail");
		return "redirect:/getFurniture?id=" + cartDTO.getProductId(); 
	}
	
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public String delete(HttpServletRequest request, RedirectAttributes ra) {		
		try {
			String[] targets = request.getParameterValues("checked");
			for(int i = 0; i < targets.length; i++) {
				System.out.print(targets[i] + " ");
			}
			cartService.delete(targets);
			ra.addFlashAttribute("deleteCartResult", "success");
			return "redirect:/getCartList";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ra.addFlashAttribute("deleteCartResult", "fail");
		return "redirect:/getCartList";
	}
	
	@RequestMapping(value = "/getCartList", method = RequestMethod.GET)
	public String list(Model model, HttpSession session) {
		String id = ((MemberDTO)session.getAttribute("member")).getId();
		try {
			List<Object[]> cartList = cartService.getList(id);
			model.addAttribute("cartList", cartList);
			
			int productSum = 0; // 상품 가격 합
			int delevaryFee = 2500;
			int priceSum;
			for(int i = 0; i < cartList.size(); i++) {
				productSum += ((ProductDTO) cartList.get(i)[1]).getPrice();
			}
			
			if(productSum >= FREE_DELEVARY_STANDARD) {
				delevaryFee = 0;
			}
			
			priceSum = productSum + delevaryFee;
			
			model.addAttribute("productSum", productSum);
			model.addAttribute("delevaryFee", delevaryFee);
			model.addAttribute("priceSum", priceSum);
			
			return "cart/CartView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}