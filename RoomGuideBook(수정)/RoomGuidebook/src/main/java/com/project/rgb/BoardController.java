package com.project.rgb;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import boardAndCommentManagement.BoardService;
import dto.BoardDTO;
import dto.ImageDTO;
import dto.MemberDTO;
import dto.SellerDTO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;

	@Resource(name = "defaultPath")
	private String defaultPath;

	/* ---------- Test ---------- */

	@RequestMapping(value = "/uploadExample", method = RequestMethod.GET)
	public String uploadForm() {
		return "/board/imageUploadExample";
	}

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	public String upload(MultipartFile file, Model model) throws IOException {
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());
		System.out.println(file.getContentType());

		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		model.addAttribute("savedName", savedName); // 뷰로 뿌려줄건가...

		return "/board/tempView";
	}

	/* ---------- Test ---------- */

	@RequestMapping(value = "/registerBoardView", method = RequestMethod.GET)
	public String getRegisterBoardForm() {
		return "/board/BoardRegisterView";
	}
	
	@RequestMapping(value = "/registerBoard", method = RequestMethod.POST)
	public String register(HttpSession session, BoardDTO boardDTO, @RequestParam(value = "myfile", required = false) MultipartFile myfile, RedirectAttributes ra) {
			try {
				String memberId = ((MemberDTO) session.getAttribute("member")).getId();
				String savedName = uploadFile(myfile.getOriginalFilename(), myfile.getBytes());
				System.out.println(savedName);
				ImageDTO imageDTO = new ImageDTO();
				boardDTO.setCommentCnt(0);
				boardDTO.setLikeCnt(0);
				imageDTO.setPath(savedName);
				boardService.register(memberId, boardDTO, imageDTO);
				ra.addFlashAttribute("boardRegisterResult", "succeeded");
			}catch(IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				ra.addFlashAttribute("boardRegisterResult", "fail");
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				ra.addFlashAttribute("boardRegisterResult", "fail");
			}
		
			
		return "redirect:/getBoardList";
	}
	
	public String uploadFile(String originalName, byte[] fileData) throws IOException {
		UUID uid = UUID.randomUUID(); //
		String savedName = uid.toString() + "_" + originalName; // 얘네 두 줄을 가져다가 컨트롤러로 둬야겠지 진짜 등록까지 하려면???

		String folderPath = "\\resources\\image_board";
		File target = new File(defaultPath + folderPath, savedName);
		FileCopyUtils.copy(fileData, target); // 이 과정으로 인해 파일저장이 이루어지는 듯
		return folderPath + "\\" + savedName;		
	}
	

	@RequestMapping(value = "/getBoardList", method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session,
			RedirectAttributes ra, Model model) {
		try {
			MemberDTO memberSession = (MemberDTO) session.getAttribute("member");
			if (memberSession == null) {

				ra.addFlashAttribute("result", "needLogin");
				return "redirect:/main";
			}

			String id = memberSession.getId();
			List<Object[]> boardList = boardService.getList(id, page);

			int boardCnt = boardList.size();
			int lastId = ((BoardDTO) boardList.get(0)[0]).getBoardId();
			System.out.println(page + " " + boardCnt + " " + lastId);

			System.out.println("페이지" + page);
			model.addAttribute("boardList", boardList);
			model.addAttribute("nowPage", page);
			model.addAttribute("boardCnt", boardCnt);
			model.addAttribute("lastId", lastId);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "/board/BoardListView";
	}

	@RequestMapping(value = "/getBoard", method = RequestMethod.GET)
	public String get(@RequestParam(value = "no") int no, Model model) {
		try {
			Object[] board = boardService.get(no);
			model.addAttribute("board", (BoardDTO) board[0]);
			model.addAttribute("image", (ImageDTO) board[1]);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return "/board/BoardView";
	}
}
