package com.project.rgb;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.hc.client5.http.fluent.Request;
import org.apache.hc.core5.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import boardAndCommentManagement.BoardService;
import dto.BoardDTO;
import dto.ImageDTO;
import dto.LikeDTO;
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
	
	@RequestMapping(value = "/updateBoardView", method = RequestMethod.GET)
	public String getUpdateBoardForm(int boardId, Model model) {
		try {
			Object[] obj = boardService.getInfoForUpdate(boardId);
			model.addAttribute("board", (BoardDTO) obj[0]);
			model.addAttribute("image", (ImageDTO) obj[1]);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "board/BoardUpdateView";
	}
	
	@RequestMapping(value = "/updateBoard", method = RequestMethod.POST)
	public String update(HttpServletRequest  request, Model model, BoardDTO boardDTO, @RequestParam(value = "myfile", required = false) MultipartFile myfile, RedirectAttributes ra) {
		try {
			System.out.println(boardDTO.getContent());
			//boardDTO.setContent((String)request.getAttribute("content"));
			String savedName = uploadFile(myfile.getOriginalFilename(), myfile.getBytes());
			System.out.println(savedName);
			ImageDTO imageDTO = new ImageDTO();
			imageDTO.setPath(savedName);
			
			boardService.update(boardDTO, imageDTO);
			ra.addFlashAttribute("boardUpdateResult", "succeed");
		}catch(IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ra.addFlashAttribute("boardUpdateResult", "fail");
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			ra.addFlashAttribute("boardUpdateResult", "fail");
		}
	
	return "redirect:/getBoard?no=" + boardDTO.getBoardId(); // 여기로 말고 본인이 수정한 게시물쪽으로 리다이렉트하기
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
				ra.addFlashAttribute("boardRegisterResult", "succeed");
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
	

	@RequestMapping(value = "/deleteBoard", method = RequestMethod.POST)
	public String delete(BoardDTO boardDTO, RedirectAttributes ra) {
		try {
			boardService.delete(boardDTO);
			ra.addFlashAttribute("boardDeleteResult", "succeed");
		} catch (SQLException e) {
			ra.addFlashAttribute("boardDeleteResult", "failed");
		}
		
		return "redirect:/getBoardList";
	}
	
	
	public String uploadFile(String originalName, byte[] fileData) throws IOException {
		UUID uid = UUID.randomUUID(); //
		String savedName = uid.toString() + "_" + originalName; // 얘네 두 줄을 가져다가 컨트롤러로 둬야겠지 진짜 등록까지 하려면???

		String folderPath = "\\resources\\image_board";
		File target = new File(defaultPath + folderPath, savedName);
		FileCopyUtils.copy(fileData, target); // 이 과정으로 인해 파일저장이 이루어지는 듯
		return savedName;		
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
			model.addAttribute("like", (LikeDTO) board[2]);
			
			System.out.println("좋아요? : " + ((LikeDTO) board[2]).getBoardId());
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return "/board/BoardView";
	}
	
	@RequestMapping(value = "/likeIt", method = RequestMethod.POST)
	public ResponseEntity<String> likeIt(@RequestBody LikeDTO likeDTO, HttpSession session, Model model) {
		
		
		System.out.println("아이디" + likeDTO.getBoardId());
		
		ResponseEntity<String> entity = null;
		MemberDTO memberSession = (MemberDTO) session.getAttribute("member");
		if(memberSession == null) {
			// 로그인 필요하다고 돌려보내기
			System.out.println("로그인 필요합니다.");
		}else {
			likeDTO.setMemberId(memberSession.getId());
			try {
				Object[] obj = boardService.likeIt(likeDTO);
				
				int likeCnt = (Integer) obj[0];
				boolean likeIt = (Boolean) obj[1];
				
				System.out.println("좋아요 몇 개? " + likeCnt);
				if(likeIt) {
					// 좋아요 눌렀을 때
					model.addAttribute("likeCnt", likeCnt);
					entity = new ResponseEntity<String>("LIKE", HttpStatus.OK);
				}else {
					// 좋아요 취소했을 때
					model.addAttribute("likeCnt", likeCnt);
					entity = new ResponseEntity<String>("DONT_LIKE", HttpStatus.OK);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return entity;
	}
}
