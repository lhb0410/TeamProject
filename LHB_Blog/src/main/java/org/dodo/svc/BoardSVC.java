package org.dodo.svc;

import java.io.File;
import java.io.IOException;
import java.util.*;
import javax.servlet.http.HttpServletResponse;
import org.dodo.mybatis.*;
import org.dodo.vo.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BoardSVC {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private HttpServletResponse response;

	public List<BoardListVO> getBoardList(BoardListVO blist) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = dao.getBoardList(blist);
		List<BoardListVO> list = vo.getBlist();
		return list;
	}//리스트+페이지 =(page)
	
	public BoardListVO getRead(BoardListVO blist) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		System.out.println(blist.getNum()+"글제목"+blist.getTitle());
		BoardListVO vo = dao.getRead(blist);
		return vo;
	}//글읽기=(num)
	
	public ArrayList<BfileVO> write(BoardListVO blist, BfileVO fvo)
	{
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		System.out.println("파일변경전확인"+blist.getFenabled());
		if(!fvo.getFiles().get(0).getOriginalFilename().equals(""))
		{
			blist.setFenabled(1);
			System.out.println("파일변경후확인"+blist.getFenabled());
		}
		else{blist.setFenabled(0);}
		int i = dao.setWrite(blist);
		System.out.println("i값 : "+ i);
		ArrayList<BfileVO> fname = null;
		if(!fvo.getFiles().get(0).getOriginalFilename().equals(""))
		{
			int num = dao.getMaxnum();
			System.out.println("최근글번호"+num);
			System.out.println("이름"+fvo.getFiles().get(0).getOriginalFilename());
			fname = fileprocess(fvo);
			filesave(fname,num);
		}
		return fname;
	}//저장
	
	public String setcomment(BoardListVO blist) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		String res = "";
		int tf = dao.setWrite(blist);
		if(tf==1){res ="저장완료";}
		else{res = "저장실패";}
		return res;
	}//댓글 
	
	public BoardVO getSearch(BoardListVO blist)
	{
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = dao.getSearch(blist);
		return vo;
	}//검색
	
	public String setEdit(BoardListVO blist) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		String res = "";
		int tf = dao.setEdit(blist);
		if(tf==1){res ="수정완료";}
		else{res = "저장실패";}
		return res;
	}//수정저장
	
	public String setDel(BoardListVO blist)
	{
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		String res="";
		int conf = dao.setDel(blist);
		if(conf == 1){res = "삭제완료";}
		else{res = "삭제할 수 없음";}
		
		return res;
	}//삭제
	
	public List<BoardListVO> getCommentcnt() {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = dao.getcommentcnt();
		List<BoardListVO>cntlist = vo.getClist();
		return cntlist;
	}//댓글수
	
	public void setReadcnt(BoardListVO blist) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int cnt = blist.getReadcnt();
		blist.setReadcnt(cnt+1);
		dao.setReadcnt(blist);
	}//조회수
	
	public boolean setGoodcnt(GoodVO good) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		Boolean tf = getGoodidCheck(good);
		System.out.println("추천인 결과값 : "+tf);
		if(tf)
		{
			int cnt = good.getGoodcnt();
			good.setGoodcnt(cnt+1);
			dao.setGoodcnt(good);//추천수저장
			dao.setGoodid(good);//Good테이블저장
			return true;
		}
		return false;
	}//추천
	
	public Boolean getGoodidCheck(GoodVO good)
	{
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		Boolean tf = false;
		BoardVO vo = dao.getGoodlist(good);
		
		if(vo == null){	return tf=true;}
		
		List<GoodVO> glist = vo.getGlist();
		for(int i=0;i<glist.size();i++)
		{
			if(good.getNum()==glist.get(i).getNum())
			{return tf;}
		}
		return tf=true;
	}//추천인 검사
	
	
	public BoardVO getRipple(BoardListVO blist) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = dao.getRipple(blist);
		return vo;
	}//리플
	
	public BoardVO getgoodList(){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		System.out.println("서비스 진입 ");
		BoardVO vo = dao.getgoodList();
		return vo;
	}//최신글 6개(=메인용)
	
	
	
	
//------파일저장 메소드----------------	
		public void filesave(ArrayList<BfileVO> al,int num)
		{
			BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
				for(int i=0;i<al.size();i++)
				{al.get(i).setNum(num);}
				
				for(int i=0;i<al.size();i++)
				{dao.setFsave(al.get(i));}
		}//파일DB저장
		
		
		private ArrayList<BfileVO> fileprocess(BfileVO fvo){
			 String res,desc= "";
			 List items = null;
				    
			Iterator<MultipartFile> itr = fvo.getFiles().iterator();
			ArrayList<BfileVO> fname = new ArrayList<BfileVO>();
			
			while (itr.hasNext())
		    {
		        MultipartFile item = itr.next();
			    try 
			    {
			       String itemName = item.getName();//로컬 시스템 상의 파일경로 및 파일 이름 포함
			       if(itemName==null || itemName.equals("")) {continue;}
			       String fileName = item.getOriginalFilename();// 경로없이 파일이름만 추출함
			       // 전송된 파일을 서버에 저장하기 위한 절차
			       //String rootPath = getServletContext().getRealPath("/");
			       String sfileName = getFname(fileName);
			       File savedFile = new File("c:/Users/EKHB-PC/Desktop/test/"+sfileName);
			       item.transferTo(savedFile);// 지정 경로에 파일을 저장함
			       BfileVO fv = new BfileVO();
			       fv.setFname1(fileName);
			       fv.setFname2(sfileName);
			       fv.setFsize(getFilesize(fileName));
			       fname.add(fv);
			    } catch (Exception e) {   res = "서버에 파일 저장중 에러: ";}
		    }
			return fname;
		  }//파일저장
		
		
		private static String getFname(String orignFname){
		      File dir = new File("c:/Users/EKHB-PC/Desktop/test");
		      String[] fnames = dir.list();
		      String newFname = null;
		      
		      for(int i=0; i<fnames.length; i++){
		         if(fnames[i].equals(orignFname)){
		            // 동일한 내용이 있을시에 조치를 한다.
		            String tmp = orignFname.split("\\.")[0];
		            String ext = orignFname.split("\\.")[1];
		            tmp += new Date().getTime()+"."+ext;
		            newFname = tmp;
		            return newFname;
		         }
		      }
		      return orignFname;
		   }//파일검사
		
		
		
		private static long getFilesize(String orignFname){
		      File dir = new File("c:/Users/EKHB-PC/Desktop/test/"+orignFname);
		      long filesize = dir.length();
		      return filesize;
		   }//파일사이즈

		
        public BoardVO getBfile(BoardListVO blist)
        {
        	BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
        	BoardVO fvo = dao.getBfile(blist);
			return fvo;
        }//파일이름
        
        
        
        public List<String> getGoodfilename(BoardVO vo)
        {
        	List<String> flist = new ArrayList<String>();
        	String fname = "";
        	System.out.println("최신글 사이즈"+vo.getBlist().size());
    		for(int i=0;i<vo.getBlist().size();i++)
    		{	
    			BoardListVO blist = new BoardListVO();
    			blist.setNum(vo.getBlist().get(i).getNum());
    			System.out.println("파일불러오기"+blist.getNum());
    			String cat = vo.getBlist().get(i).getCat();
    			BoardVO bvo = getBfile(blist);
    			if(bvo == null)
    			{
    				int num = (int)((Math.random() * 9)+ 1);
    				if(cat.equalsIgnoreCase("game")){fname = "g/G"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("IT")){fname = "i/I"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("movie")){fname = "c/C"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("sports")){fname = "s/S"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("music")){fname = "m/M"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("fashion")){fname = "f/F"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("travel")){fname = "t/T"+num+".jpg";	flist.add(fname);}
    				else if(cat.equalsIgnoreCase("love")){fname = "l/L"+num+".jpg";	flist.add(fname);}
    			}
    			else if(bvo != null)
    			{
    				fname = bvo.getBflist().get(0).getFname1();
    				flist.add(fname);
				}
    		}
    		for(int i=0;i<flist.size();i++)
    		{
    			System.out.println("최신글파일명 "+i+"번째:"+flist.get(i));
    		}
    		return flist;
        }//최신글 7개 파일명(=BoardVO.num)
        
        
        
        
//------파일저장 메소드---------------------------------------------------------------------
        
        public BoardVO getNoticeBoard(){
        	BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
        	return dao.getNoticeBoard();
        }
        
        
//----------------------------------진영 end---------------------------------------------

        public BoardVO getNotice(BoardListVO blist)
        {
        	BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
			return dao.getNotice(blist);
        }//공지사항 리스트

		public BoardVO getNoticeRead(NoticeVO nvo) {
			BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
			return dao.getNoticeRead(nvo);
		}//공지사항 읽기

		public List<CategoryVO> setAddCat(BoardListVO blist) {
			BoardDAO bdao = sqlSessionTemplate.getMapper(BoardDAO.class);
			UserDAO udao = sqlSessionTemplate.getMapper(UserDAO.class);
			bdao.setAddCat(blist);//관심분야 추가
			List<CategoryVO> list = udao.getHobbyList(blist.getAuthor());
			return list;
		}//카테고리추가
		

	      public List<CategoryVO> setDelCat(BoardListVO blist) {
	          BoardDAO bdao = sqlSessionTemplate.getMapper(BoardDAO.class);
	          UserDAO udao = sqlSessionTemplate.getMapper(UserDAO.class);
	          bdao.setDelCat(blist);//관심분야 삭제
	          List<CategoryVO> list = udao.getHobbyList(blist.getAuthor());
	          return list;
	       }//카테고리삭제



		

		



		
}
