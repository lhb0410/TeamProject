package org.dodo.cont;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.*;

import org.dodo.svc.*;
import org.dodo.vo.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("bc/") // 게시판 컨트롤러
public class BoardCont {

	@Autowired
	private BoardSVC svc;

	
	@RequestMapping(value = "main/boardList", method = RequestMethod.GET)
	public String getBoardList(BoardListVO blist, HttpSession session, Model model) {
		List<BoardListVO> list = svc.getBoardList(blist);
		List<BoardListVO> cntlist = svc.getCommentcnt(); // 댓글수

		System.out.println("토탈" + list.get(0).getTotal());
		session.setAttribute("comment", cntlist);
		session.setAttribute("list", list);
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());

		return "Board/BoardList";
	}// 리스트보기 =(page)

	
	@RequestMapping(value = "main/boardList", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray getPage(BoardListVO blist, HttpSession session) {
		List<BoardListVO> list = svc.getBoardList(blist);
		List<BoardListVO> cntlist = svc.getCommentcnt();
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());
		JSONObject jsonCist = new JSONObject();
		JSONObject jsonCntlist = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		jsonCist.put("list", list);
		jsonCntlist.put("commend", cntlist);
		jsonArr.add(jsonCist);
		jsonArr.add(jsonCntlist);
		return jsonArr;
	}// 페이지 =(page)

	
	@RequestMapping(value = "main/read", method = RequestMethod.GET)
	public String getRead(BoardListVO blist, HttpSession session) {
		System.out.println("조회수: " + blist.getReadcnt());
		svc.setReadcnt(blist); // 조회수 저장
		BoardListVO vo = svc.getRead(blist); // 글불러오기
		BoardVO bvo = svc.getBfile(blist); // 파일불러오기
		BoardVO rvo = svc.getRipple(blist); // 댓글불러오기
		List<BoardListVO> clist = svc.getCommentcnt(); // 댓글수불러오기
		session.setAttribute("fname", bvo);
		session.setAttribute("read", vo);
		session.setAttribute("ripple", rvo);
		session.setAttribute("comment", clist);
		return "Board/BoardRead";
	}// 글읽기 =(num,readcnt)

	
	@RequestMapping(value = "main/search", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray search(BoardListVO blist, HttpSession session) {
		System.out.println("검색내용 :" + blist.getSearchI() + "검색카테고리" + blist.getSearchS() + "페이지" + blist.getPage());
		BoardVO vo = svc.getSearch(blist);
		List<BoardListVO> list = vo.getBlist();
		List<BoardListVO> cntlist = svc.getCommentcnt();
		JSONObject jsonCist = new JSONObject();
		JSONObject jsonCntlist = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		jsonCist.put("list", list);
		jsonCntlist.put("commend", cntlist);
		jsonArr.add(jsonCist);
		jsonArr.add(jsonCntlist);
		return jsonArr;
	}// 검색=(searchI,searchS,num)

	
	@RequestMapping(value = "main/write", method = RequestMethod.GET)
	public String writeview() {
		return "Board/BoardWrite";
	}// 글작성

	
	@RequestMapping(value = "main/comment", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String comment(BoardListVO blist, HttpSession session) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println(blist.getAuthor());
		String res = svc.setcomment(blist);
		return res;
	}// 댓글=(title,num,contents,cat)

	
	@RequestMapping(value = "main/write", method = RequestMethod.POST)
	public String write(BoardListVO blist, HttpSession session, BfileVO fvo) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println("컨트롤러 : " + blist.getCat());
		ArrayList<BfileVO> res = svc.write(blist, fvo);
		return "redirect:boardList?page=1&cat="+blist.getCat();
	}// 글저장/파일저장=(num,cat,author,title,contents)/(multipart)

	
	@RequestMapping(value = "main/edit", method = RequestMethod.GET)
	public String getEditPage(BoardListVO blist, HttpSession session) {
		BoardListVO bv = svc.getRead(blist);
		session.setAttribute("read", bv);
		return "Board/BoardEdit";
	}// 수정페이지이동

	
	@RequestMapping(value = "main/edit", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String setEdit(BoardListVO blist, HttpSession session) {
		String res = svc.setEdit(blist);
		return res;
	}// 수정저장=(author,contents,title,ref)

	@RequestMapping(value = "main/del", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String del(BoardListVO blist) {
		String res = svc.setDel(blist);
		return res;
	}// 삭제=(num)

	
	@RequestMapping(value = "main/goodcnt", method = RequestMethod.POST)
	@ResponseBody
	public boolean setGoodcnt(GoodVO good, HttpSession session) {
		good.setGoodid((String) session.getAttribute("USERID"));
		System.out.println(good.getGoodid());
		boolean tf = svc.setGoodcnt(good); // 추천인 검사결과 리턴
		return tf;
	}// 추천=(num,goodcnt)

	
	@RequestMapping("main/download")
	@ResponseBody
	public byte[] getImage(HttpServletResponse response, @RequestParam String filename) throws IOException {
		File file = new File("c:/Users/EKHB-PC/Desktop/test/" + filename);
		byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
		String fn = new String(file.getName().getBytes(), "iso_8859_1");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);
		response.setContentType("image/jpeg");

		return bytes;
	}// 다운로드=(fname2)

	
	@RequestMapping(value = "main/notice", method = RequestMethod.GET)
	public String getNoticeList(BoardListVO blist, HttpSession session) {
		System.out.println("공지사항리스트?page=" + blist.getPage() + "&cat=" + blist.getCat());
		List<NoticeVO> list = svc.getNotice(blist).getNlist();
		session.setAttribute("list", list);
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());
		return "Board/NoticeList";
	}// 공지사항리스트 =(page)

	
	@RequestMapping(value = "main/notice", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject getNoticepage(BoardListVO blist, HttpSession session) {
		System.out.println("공지사항리스트?page=" + blist.getPage() + "&cat=" + blist.getCat());
		List<NoticeVO> list = svc.getNotice(blist).getNlist();
		JSONObject jlist = new JSONObject();
		jlist.put("list", list);
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());
		return jlist;
	}// 공지사항페이지 =(page)

	
	@RequestMapping(value = "main/nread", method = RequestMethod.GET)
	public String getNoticeRead(NoticeVO nvo, HttpSession session) {
		NoticeVO vo = svc.getNoticeRead(nvo).getNlist().get(0); // 글불러오기
		session.setAttribute("read", vo);
		return "Board/NoticeRead";
	}// 공지사항 글읽기 =(anum)

	
	@RequestMapping(value = "main/addcat", method = RequestMethod.GET)
	public String setAddCat(BoardListVO blist, HttpSession session) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println("addcat_ID값 : " + blist.getAuthor() + "cat값" + blist.getCat());
		List<CategoryVO> list = svc.setAddCat(blist); // 카테고리 저장+유저 카테고리리스트
		session.setAttribute("cList", list);
		return "redirect:boardList?page=1&cat=" + blist.getCat();
	}// 카테고리 추가 =(cat)

	
	@RequestMapping(value = "main/delcat", method = RequestMethod.GET)
	public String setDelCat(BoardListVO blist, HttpSession session) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println("delcat_ID값 : " + blist.getAuthor());
		List<CategoryVO> list = svc.setDelCat(blist); // 카테고리 삭제+유저카테고리리스트
		session.setAttribute("cList", list);
		return "redirect:boardList?page=1&cat=" + blist.getCat();
	}// 카테고리 삭제 =(cat)

	
	@RequestMapping(value = "main/ssearch", method = RequestMethod.POST)
    public String sideSearch(BoardListVO blist,HttpSession session){
        String url = "Board/BoardList";
        System.out.println("검색내용 :" + blist.getSearchI()+"검색카테고리"+blist.getSearchS()+"페이지"+blist.getPage());
        BoardVO vo =svc.getSearch(blist);
        if(vo == null){return url="Board/ListSearchNull";}
        else{
        session.setAttribute("list", vo.getBlist());
        session.setAttribute("commend", svc.getCommentcnt());}
         return url;
     }//사이드바검색=(searchI,searchS,page)
}
