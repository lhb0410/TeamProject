package org.dodo.mybatis;

import java.util.*;

import org.dodo.vo.*;

public interface UserDAO {

	public int setUserSave(UserVO uvo);

	public UserVO getUserIdFind(UserVO uvo);
	
	public int getUserPwdFind(UserVO uvo);

	public UserVO getIdCheck(String id);

	public UserVO getUserModify(String id);

	public int getUserDrawal(HashMap<String,Object> hs);

	public UserVO getUserPwd(UserVO uvo);

	public int getUserModf(UserVO uvo);

	public int setNewPwdChange(UserVO uvo);

	public UserVO getUserNum(String id);

	public List<CategoryVO> getHobbyList(String id);

	public void setUserHobby(Map<String, String> map);

	/*public void fileSave(DownloadVO downloadVO);

	public void boardSave(BoardVO bvo);

	public BoardVO getRecent(String owner);

	public BoardListVO getBoardList(int num);

	public BoardListVO getBoardPage(int page);

	public BoardVO getBoardRead(int readnum);

	public BoardListVO getBoardFileread(int readnum);

	public void setBoardReple(BoardVO bvo);

	public void setBoardEdit(BoardVO bvo);

	public int setBoardDel(int delnum);

	public BoardListVO getBoardSearch(HashMap<String, Object> hm);

	public void setBoardGood(BoardVO bvo);*/

}
