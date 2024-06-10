package com.lyh.franc.main;

import java.util.ArrayList;

import com.lyh.franc.reservation.Reservation;
import com.lyh.franc.restaurant.Restaurant;

public class Controller {
	// MVC 패턴 의 C - 실행과 코드의 흐름을 관리
//	if (번호 == 1) {
//		consolescreen.예약하기 기능 (입력)
//		dao.db관련 예약기능 (insert)
//		결과보여주기 (성공 or 실패)
//	}
	public static void main(String[] args) {
		int menu = 0;
		String result = null;
		Reservation rsv = null;
		Restaurant rst = null;
		ArrayList<Reservation> rsvResult = null;
		ArrayList<Restaurant> arst = null;
		
		System.out.println("<< 예약 프로그램 >>");
		while (true) {
			try {
				menu = ConsoleScreen.showMainMenu();
				if (menu == 9) {
					System.out.println("프로그램을 종료합니다.");
					break;
				} else if (menu == 1) {
					rsv = ConsoleScreen.showRsvMenu();
					result = DAO.book(rsv);
					ConsoleScreen.printResult(result);
				}else if (menu == 2) {
					rst = ConsoleScreen.showRstMenu();
					result = DAO.register(rst);
					ConsoleScreen.printResult(result);
				}else if (menu == 3) {
//					DAO.checkRsv();
					rsvResult = DAO.checkRsv();
					ConsoleScreen.showRsvResultMenu(rsvResult);
				}else if (menu == 4) {
					DAO.checkRst();
				}else if (menu == 5) {
					
//					DAO.searchRst();
					arst = DAO.searchRst();
					ConsoleScreen.showRstResult(arst);
				}else if (menu == 6) {
					rsv = ConsoleScreen.showSearchRsvMenu();
					rsvResult = DAO.searchRsv(rsv);
					ConsoleScreen.showRsvResultMenu(rsvResult);
				}else if (menu == 7) {
					rsvResult = DAO.checkRsv();
					ConsoleScreen.showRsvResultMenu(rsvResult);
					
					rsv = ConsoleScreen.showUpdateRsvMenu();
					result = DAO.updateRsv(rsv);
					ConsoleScreen.printResult(result);
					
					rsvResult = DAO.checkRsv();
					ConsoleScreen.showRsvResultMenu(rsvResult);
				}else if (menu == 8) {
					rsvResult = DAO.checkRsv();
					ConsoleScreen.showRsvResultMenu(rsvResult);
					
//					DAO.cancleRsv();
					rsv = ConsoleScreen.showDeleteRsvMenu();
					result = DAO.deleteRsv(rsv);
					ConsoleScreen.showRsvResultMenu(rsvResult);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
				
	}
}
























