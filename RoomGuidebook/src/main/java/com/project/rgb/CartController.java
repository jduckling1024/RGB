package com.project.rgb;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import CartManagement.CartService;
import dto.MemberDTO;

@Controller
public class CartController {
	
	@Autowired
	CartService cartService;
	
	@RequestMapping(value = "/getCartList", method = RequestMethod.POST)
	public String list(Model model, HttpSession session) {
		String id = ((MemberDTO)session.getAttribute("member")).getId();
		System.out.println("CartController : " + id);
		try {
			List<Object[]> cartList = cartService.getList(id);
			model.addAttribute("cartList", cartList);
			
			return "cart/CartView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}