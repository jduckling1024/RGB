package com.project.rgb;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.MemberDTO;
import dto.UserDTO;
import memberManagement.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;

	@RequestMapping(value = "/registerMemberView", method = RequestMethod.GET)
	public String requestRegisterMemberView() {
		return "/member/MemberRegisterView";
	}

	@RequestMapping(value = "/registerMember", method = RequestMethod.POST)
	public String register(@ModelAttribute("member") MemberDTO member, RedirectAttributes ra) {
		try {
			memberService.register(member);

			ra.addFlashAttribute("result", "registerMemberSucceeded");
			return "redirect:/main"; 
		} catch (SQLException e) {
			e.printStackTrace();
			ra.addFlashAttribute("result", "registerMemberFailed");
			return "redirect:/registerMemberView"; 
		}
	}

	@RequestMapping(value = "/updateMemberView", method = RequestMethod.POST)
	public String updateMemberView(HttpSession session, @ModelAttribute("member")MemberDTO member, Model model,
			RedirectAttributes ra) {
		
		System.out.println(((MemberDTO) session.getAttribute("member")).getPassword());
		System.out.println(member.getPassword());
		
		if ((((MemberDTO) session.getAttribute("member")).getPassword()).equals(member.getPassword())) {
			model.addAttribute("member", member);
			System.out.println(member.getName());
			return "/member/MemberUpdateView";
		}
		ra.addFlashAttribute("result", "wrong");
		return "redirect:/getMember";
	}

	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public String update(@ModelAttribute("member") MemberDTO member, RedirectAttributes ra) {
		try {
			System.out.println("update");
			System.out.println(member.getName());
			memberService.update(member);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ra.addFlashAttribute("result", "updateMemberSucceeded");
		return "redirect:/main";
	}

	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public String delete(HttpSession session, RedirectAttributes ra) {
		try {
			String id = ((MemberDTO) session.getAttribute("member")).getId();
			memberService.delete(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		session.invalidate();
		ra.addFlashAttribute("result", "deleteMemberSucceed");
		return "redirect:/main";
	} // 회원탈퇴 시 세션도 끊겨야 하므로 매개변수로 session을 두는게 더 좋을 것 같습니다

	@RequestMapping(value = "/getMember", method = RequestMethod.GET)
	public String get(HttpSession session, Model model, RedirectAttributes ra) {
		
		if(session.getAttribute("member") == null) {
			//ra.addFlashAttribute("result", "failed");
		}else {
			String id = ((MemberDTO) session.getAttribute("member")).getId();
			MemberDTO member;
			try {
				member = memberService.get(id);
				model.addAttribute("member", member);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return "/member/MemberView";
	}
}
