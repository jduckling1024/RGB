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

import dto.MemberDTO;
import dto.SellerDTO;
import orderManagement.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	OrderService orderService;
	
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
	
	
	// �ϴ� ��ٱ��Ͽ��� ���� �ֵ� �������� ���� ��
//	@RequestMapping(value = "/getListForMember", method = RequestMethod.GET)
//	public String listForMember(HttpSession session, HttpServletRequest request) {
//		MemberDTO member = (MemberDTO) session.getAttribute("member");
//		
//		
//		if(request.getAttribute("myList") == null) {
//			System.out.println("���Դϴ�.");
//		}else {
//			System.out.println("�� �ƴմϴ�.");
//		}
//		// ��� ��ĥ �ʿ� ���� �ʳ� �� �ִ� �ֵ��ε�???
//		return null;
//	}
	
	@RequestMapping(value = "/getListForMember", method = RequestMethod.GET)
	public String listForMember(HttpSession session, HttpServletRequest request) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		
	
		return null;
	}
}
