package org.dodo.mybatis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.dodo.vo.*;

public interface BoardDAO {

/*불러오기*/
	public BoardVO getBoardList(BoardListVO blist); //리스트+페이지
	
	public BoardListVO getRead(BoardListVO blist); //글읽기
	
	public int getMaxnum(); //최신글번호
	
	public BoardVO getBfile(BoardListVO blist); //파일이름
	
	public BoardVO getcommentcnt(); //댓글수
	
	public BoardVO getGoodlist(GoodVO good); //추천인 리스트
	
	public BoardVO getRipple(BoardListVO blist);  //댓글리스트
	
	public BoardVO getSearch(BoardListVO blist); //검색
	
	public BoardVO getgoodList(); //최신글 6개(=메인용)
/*불러오기*/
	
	
	
/*저장하기*/
	public int setWrite(BoardListVO blist); //글저장+댓글
	
	public void setFsave(BfileVO fvo);  //파일저장

	public int setEdit(BoardListVO blist);  //글수정

	public int setDel(BoardListVO blist);  //글삭제

	public void setGoodcnt(GoodVO good);  //글추천

	public void setGoodid(GoodVO good); //추천인저장

	public void setReadcnt(BoardListVO blist);
/*저장하기*/

	public BoardVO getNoticeBoard();

	public BoardVO getNotice(BoardListVO blist); //공지사항리스트 전체

	public BoardVO getNoticeRead(NoticeVO nvo); //공지사항읽기

	public void setAddCat(BoardListVO blist); //관심분야 추가

	public void setDelCat(BoardListVO blist);

	


	


	





}
