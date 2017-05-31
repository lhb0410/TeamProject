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
@RequestMapping("bc/") // �Խ��� ��Ʈ�ѷ�
public class BoardCont {

	@Autowired
	private BoardSVC svc;

	
	@RequestMapping(value = "main/boardList", method = RequestMethod.GET)
	public String getBoardList(BoardListVO blist, HttpSession session, Model model) {
		List<BoardListVO> list = svc.getBoardList(blist);
		List<BoardListVO> cntlist = svc.getCommentcnt(); // ��ۼ�

		System.out.println("��Ż" + list.get(0).getTotal());
		session.setAttribute("comment", cntlist);
		session.setAttribute("list", list);
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());

		return "Board/BoardList";
	}// ����Ʈ���� =(page)

	
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
	}// ������ =(page)

	
	@RequestMapping(value = "main/read", method = RequestMethod.GET)
	public String getRead(BoardListVO blist, HttpSession session) {
		System.out.println("��ȸ��: " + blist.getReadcnt());
		svc.setReadcnt(blist); // ��ȸ�� ����
		BoardListVO vo = svc.getRead(blist); // �ۺҷ�����
		BoardVO bvo = svc.getBfile(blist); // ���Ϻҷ�����
		BoardVO rvo = svc.getRipple(blist); // ��ۺҷ�����
		List<BoardListVO> clist = svc.getCommentcnt(); // ��ۼ��ҷ�����
		session.setAttribute("fname", bvo);
		session.setAttribute("read", vo);
		session.setAttribute("ripple", rvo);
		session.setAttribute("comment", clist);
		return "Board/BoardRead";
	}// ���б� =(num,readcnt)

	
	@RequestMapping(value = "main/search", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray search(BoardListVO blist, HttpSession session) {
		System.out.println("�˻����� :" + blist.getSearchI() + "�˻�ī�װ���" + blist.getSearchS() + "������" + blist.getPage());
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
	}// �˻�=(searchI,searchS,num)

	
	@RequestMapping(value = "main/write", method = RequestMethod.GET)
	public String writeview() {
		return "Board/BoardWrite";
	}// ���ۼ�

	
	@RequestMapping(value = "main/comment", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String comment(BoardListVO blist, HttpSession session) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println(blist.getAuthor());
		String res = svc.setcomment(blist);
		return res;
	}// ���=(title,num,contents,cat)

	
	@RequestMapping(value = "main/write", method = RequestMethod.POST)
	public String write(BoardListVO blist, HttpSession session, BfileVO fvo) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println("��Ʈ�ѷ� : " + blist.getCat());
		ArrayList<BfileVO> res = svc.write(blist, fvo);
		return "redirect:boardList?page=1&cat="+blist.getCat();
	}// ������/��������=(num,cat,author,title,contents)/(multipart)

	
	@RequestMapping(value = "main/edit", method = RequestMethod.GET)
	public String getEditPage(BoardListVO blist, HttpSession session) {
		BoardListVO bv = svc.getRead(blist);
		session.setAttribute("read", bv);
		return "Board/BoardEdit";
	}// �����������̵�

	
	@RequestMapping(value = "main/edit", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String setEdit(BoardListVO blist, HttpSession session) {
		String res = svc.setEdit(blist);
		return res;
	}// ��������=(author,contents,title,ref)

	@RequestMapping(value = "main/del", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	@ResponseBody
	public String del(BoardListVO blist) {
		String res = svc.setDel(blist);
		return res;
	}// ����=(num)

	
	@RequestMapping(value = "main/goodcnt", method = RequestMethod.POST)
	@ResponseBody
	public boolean setGoodcnt(GoodVO good, HttpSession session) {
		good.setGoodid((String) session.getAttribute("USERID"));
		System.out.println(good.getGoodid());
		boolean tf = svc.setGoodcnt(good); // ��õ�� �˻��� ����
		return tf;
	}// ��õ=(num,goodcnt)

	
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
	}// �ٿ�ε�=(fname2)

	
	@RequestMapping(value = "main/notice", method = RequestMethod.GET)
	public String getNoticeList(BoardListVO blist, HttpSession session) {
		System.out.println("�������׸���Ʈ?page=" + blist.getPage() + "&cat=" + blist.getCat());
		List<NoticeVO> list = svc.getNotice(blist).getNlist();
		session.setAttribute("list", list);
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());
		return "Board/NoticeList";
	}// �������׸���Ʈ =(page)

	
	@RequestMapping(value = "main/notice", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject getNoticepage(BoardListVO blist, HttpSession session) {
		System.out.println("�������׸���Ʈ?page=" + blist.getPage() + "&cat=" + blist.getCat());
		List<NoticeVO> list = svc.getNotice(blist).getNlist();
		JSONObject jlist = new JSONObject();
		jlist.put("list", list);
		session.setAttribute("total", list.get(0).getTotal());
		session.setAttribute("page", list.get(0).getPage());
		return jlist;
	}// �������������� =(page)

	
	@RequestMapping(value = "main/nread", method = RequestMethod.GET)
	public String getNoticeRead(NoticeVO nvo, HttpSession session) {
		NoticeVO vo = svc.getNoticeRead(nvo).getNlist().get(0); // �ۺҷ�����
		session.setAttribute("read", vo);
		return "Board/NoticeRead";
	}// �������� ���б� =(anum)

	
	@RequestMapping(value = "main/addcat", method = RequestMethod.GET)
	public String setAddCat(BoardListVO blist, HttpSession session) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println("addcat_ID�� : " + blist.getAuthor() + "cat��" + blist.getCat());
		List<CategoryVO> list = svc.setAddCat(blist); // ī�װ��� ����+���� ī�װ�������Ʈ
		session.setAttribute("cList", list);
		return "redirect:boardList?page=1&cat=" + blist.getCat();
	}// ī�װ��� �߰� =(cat)

	
	@RequestMapping(value = "main/delcat", method = RequestMethod.GET)
	public String setDelCat(BoardListVO blist, HttpSession session) {
		blist.setAuthor((String) session.getAttribute("USERID"));
		System.out.println("delcat_ID�� : " + blist.getAuthor());
		List<CategoryVO> list = svc.setDelCat(blist); // ī�װ��� ����+����ī�װ�������Ʈ
		session.setAttribute("cList", list);
		return "redirect:boardList?page=1&cat=" + blist.getCat();
	}// ī�װ��� ���� =(cat)

	
	@RequestMapping(value = "main/ssearch", method = RequestMethod.POST)
    public String sideSearch(BoardListVO blist,HttpSession session){
        String url = "Board/BoardList";
        System.out.println("�˻����� :" + blist.getSearchI()+"�˻�ī�װ���"+blist.getSearchS()+"������"+blist.getPage());
        BoardVO vo =svc.getSearch(blist);
        if(vo == null){return url="Board/ListSearchNull";}
        else{
        session.setAttribute("list", vo.getBlist());
        session.setAttribute("commend", svc.getCommentcnt());}
         return url;
     }//���̵�ٰ˻�=(searchI,searchS,page)
}