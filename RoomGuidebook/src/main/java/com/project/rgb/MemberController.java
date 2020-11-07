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
			return "redirect:/main"; // Ȥ�ó� ��Ʈ��ũ ������ �����ϸ� �� â ������ �ְ� �ϰ�ʹ� ����...
			// ���� �޽��� ���� �������� ���°� �α���â���� ���°�?
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
	} // ȸ��Ż�� �� ���ǵ� ���ܾ� �ϹǷ� �Ű������� session�� �δ°� �� ���� �� �����ϴ�
	
	@RequestMapping(value = "/getMember", method = RequestMethod.POST)
	public String get(HttpSession session, Model model) { 
		// �ءءءءءءءءءء� ���ǿ��� ���̵� �������� ���� �� ���� �� ���� �Ķ���͸� �ٲ���ϴ�. �ءءءءءءءءءء�
		String id = ((MemberDTO)session.getAttribute("member")).getId();
		MemberDTO member;
		try {
			member = memberService.get(id);
			System.out.println("��ȭ��ȣ ��� : " + member.getPhoneNum());
			model.addAttribute("member", member);
			return "/member/MemberView";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return null; // �ǹ� ������...
	}
}
