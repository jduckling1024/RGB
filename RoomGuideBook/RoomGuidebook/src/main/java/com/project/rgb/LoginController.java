package com.project.rgb;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.fabric.Response;

import dto.MemberDTO;
import dto.SellerDTO;
import dto.UserDTO;
import loginManagement.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;

	final static int MEMBER = 1;
	final static int SELLER = 2;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "/login/login";
	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public String login(HttpSession session, @ModelAttribute("user") UserDTO user, RedirectAttributes ra)
			throws IOException {
		UserDTO userDTO;
		try {
			userDTO = loginService.login(user);
			if(userDTO != null) {
				if (userDTO.getId() != null) {
					if (userDTO.getAutority() == MEMBER) {
						MemberDTO memberDTO = (MemberDTO) userDTO;
						session.setAttribute("member", memberDTO);
						ra.addFlashAttribute("result", "loginSucceeded");
						return "redirect:/main";
					} else if(userDTO.getAutority() == SELLER){
						SellerDTO sellerDTO = (SellerDTO) userDTO;
						session.setAttribute("seller", sellerDTO);
						ra.addFlashAttribute("result", "loginSucceeded");
						return "redirect:/getProductList";
						// 판매자 페이지
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ra.addFlashAttribute("result", "fail");
		return "redirect:login"; 
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes ra) {
		session.invalidate();
		ra.addFlashAttribute("result", "logout");
		return "redirect:/main";
	}
}
