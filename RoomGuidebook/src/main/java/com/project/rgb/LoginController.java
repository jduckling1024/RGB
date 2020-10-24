package com.project.rgb;

import java.io.IOException;

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
import dto.UserDTO;
import loginManagement.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "/login/login";
	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public String login(HttpSession session, @ModelAttribute("user") UserDTO user, RedirectAttributes ra) throws IOException {
		UserDTO userDTO = loginService.login(user);

		if (userDTO.getId() != null) {
			if(userDTO.getAutority() == 0) {
				MemberDTO memberDTO = (MemberDTO)userDTO;
				session.setAttribute("member", memberDTO);
//				ra.addFlashAttribute("result", "success");
				return "redirect:/main";
			}else {
				//판매자 페이지
			}
		}

		ra.addFlashAttribute("result", "fail");
		return "redirect:login"; // 사실 null이 아니라 다른거 보내줘야 할 듯.
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
}
