package com.project.rgb;

import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.ImageDTO;
import dto.MemberDTO;
import dto.OrderDTO;
import dto.PaymentDTO;
import dto.SellerDTO;
import orderManagement.OrderService;

@Controller
public class OrderController {

	@Autowired
	OrderService orderService;

	@RequestMapping(value = "/purchase", method = RequestMethod.POST)
	public String purchase(HttpServletRequest request, HttpSession session, PaymentDTO paymentDTO, int priceSum, RedirectAttributes ra) {
		
		String userId = ((MemberDTO) session.getAttribute("member")).getId();
		
		String[] productIdArr = request.getParameterValues("productId");
		String[] amountArr = request.getParameterValues("amount");
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();
		
		for(int i = 0; i < productIdArr.length; i++) {
			OrderDTO orderDTO = new OrderDTO();
			orderDTO.setProductId(Integer.parseInt(productIdArr[i]));
			orderDTO.setAmount(Integer.parseInt(amountArr[i]));
			orderDTO.setUserId(userId);
			orderList.add(orderDTO);
		}
		
		try {
			orderService.purchase(userId, orderList, paymentDTO, priceSum);
			ra.addFlashAttribute("result", "orderSucceed");
			System.out.println("완료!");
			return "redirect:/main"; 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return null; // 여기는 리다이렉트죠
	}
	
	@RequestMapping(value = "/getListForMember", method = RequestMethod.GET)
	public String listForMember(HttpSession session, Model model) {
		String memberId = ((MemberDTO) session.getAttribute("member")).getId();
		try {
			List<Object[]> list =  orderService.getPaymentList(memberId);
			model.addAttribute("list", list);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/order/MemberOrderView";
	}
	
	
	@RequestMapping(value = "/getListForSeller", method = RequestMethod.GET)
	public String listForSeller(HttpSession session, Model model) {
		try {
			String id = ((SellerDTO) session.getAttribute("seller")).getId();
			System.out.println("Seller : " + id);
			List<Object[]> list = orderService.listForSeller(id);

			model.addAttribute("list", list);
			return "/order/SellerOrderView";

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	// 일단 장바구니에서 오는 애들 기준으로 구현 중
	@RequestMapping(value = "/getOrderView", method = RequestMethod.POST)
	public String listForMember(HttpSession session, Model model, int productId, int amount, int productSum, int delevaryFee,
			int priceSum) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if (productId == -1) { // 장바구니에서 넘어옴 
			try {
				
				List<Object[]> list = orderService.listForMember(member.getId());
				System.out.println(productSum + " " + delevaryFee + " " + priceSum);
				model.addAttribute("list", list);
				model.addAttribute("productSum", productSum);
				model.addAttribute("delevaryFee", delevaryFee);
				model.addAttribute("priceSum", priceSum);

				return "/order/PurchaseView";

			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else { // 구매창에서 넘어옴
			try {
				System.out.println("구매용 : " + productId);
				List<Object[]> list = orderService.getFurnitureForOrder(member.getId(), productId);
				model.addAttribute("list", list);
				model.addAttribute("productSum", productSum * amount);
				model.addAttribute("delevaryFee", delevaryFee);
				model.addAttribute("priceSum", productSum * amount + delevaryFee);
				
				return "/order/PurchaseView";
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	
	@RequestMapping(value = "/cancelOrder", method = RequestMethod.POST)
	public String cancel(HttpServletRequest request, RedirectAttributes ra) {
	
			String[] checked = request.getParameterValues("checked");
			try {
				orderService.cancel(checked);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ra.addFlashAttribute("result", "success");
			return "redirect:/getListForMember";
	}
	

//	@RequestMapping(value = "/getListForMember", method = RequestMethod.GET)
//	public String listForMember(HttpSession session, HttpServletRequest request) {
//		MemberDTO member = (MemberDTO) session.getAttribute("member");
//		
//	
//		return null;
//	}
}
