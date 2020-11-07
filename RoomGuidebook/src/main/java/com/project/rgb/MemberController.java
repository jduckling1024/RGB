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
		
			ra.addAttribute("result", "registerMemberSucceeded");
			return "redirect:/main"; // 혹시나 네트워크 문제로 실패하면 그 창 가만히 있게 하고싶다 흐음...
			// 성공 메시지 띄우고 메인으로 가는가 로그인창으로 가는가?
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ra.addAttribute("result", "registerMemberFailed");
		return null;
	}
	
	@RequestMapping(value = "/updateMemberView", method = RequestMethod.POST)
	public String updateMemberView(@ModelAttribute("member") MemberDTO member, Model model) {
		model.addAttribute("member", member);
		System.out.println(member.getPhoneNum());
		return "/member/MemberUpdateView";
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
		
		ra.addAttribute("result", "success");
		return "redirect:/main";
	}
	
	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public String delete(HttpSession session, RedirectAttributes ra) {
		String id = ((MemberDTO)session.getAttribute("member")).getId();
		memberService.delete(id);
		session.invalidate();
		return "redirect:/main";
	} // 회원탈퇴 시 세션도 끊겨야 하므로 매개변수로 session을 두는게 더 좋을 것 같습니다
	
	@RequestMapping(value = "/getMember", method = RequestMethod.POST)
	public String get(HttpSession session, Model model) { 
		// ※※※※※※※※※※※ 세션에서 아이디 가져오는 것이 더 좋을 것 같아 파라미터를 바꿨습니다. ※※※※※※※※※※※
		String id = ((MemberDTO)session.getAttribute("member")).getId();
		MemberDTO member;
		try {
			member = memberService.get(id);
			System.out.println("전화번호 출력 : " + member.getPhoneNum());
			model.addAttribute("member", member);
			return "/member/MemberView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return null; // 의미 있을까...
	}
}
