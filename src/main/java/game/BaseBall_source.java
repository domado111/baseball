package game;

import java.util.Scanner;
/*
baseball game
1) 중복되지않은 4자를 만들어 base로 넣는다
2) 중복되지않은 4자리를 받아  ball과 strike를 확인 한다 
   4자리입력이 아니라 중복된 숫자가 들어 올때는 메세지를 에러 메세지를 보여준다
3)4 strike  이면 게임이 종료 된다 
  base: 5736
1234
스트라이크:1  볼:0
4567
스트라이크:0  볼:3
7234
스트라이크:1  볼:1
111
중복된수가 있거나 4자리수 가 아닙니다 
1123
중복된수가 있거나 4자리수 가 아닙니다 
5736
스트라이크:4  볼:0
End


*/

public class BaseBall_source {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String base = "";
		int temp = 0;
		// 4자리 중복없는 숫자 랜덤선택
		while (base.length() < 4) {
			temp = (int) (Math.random() * 9) + 1; // 1~9까지
			if (!base.contains(temp + ""))
				base = base + temp;
		}
		System.out.println("base: " + base);

		// 게임 시작
		String input = "";
		while (base != input) {
			input = sc.nextLine();
			boolean chk = true;

			// 입력자리수 4자리 확인

			if (input.length() != 4) {
				System.out.println("4자리를 입력하세요 ");
				chk = false;
				continue;
			}
			// 중복있는지 확인 한다
			for (int i = 0; i < 4; i++) {
				String str = input.replace(input.charAt(i) + "", "");
				if (str.length() < 3) {
					System.out.println("중복된수가 있습니다 ");
					chk = false;
					break;
				}
			}

			if (!chk)
				continue;

			int strick = 0;
			int ball = 0;

			for (int i = 0; i < 4; i++) {
				if (input.charAt(i) == base.charAt(i))
					strick++;
				else if (base.indexOf(input.charAt(i)) != -1) {
					ball++;
				}

			}

			System.out.println("스트라이크:" + strick + "  " + "볼:" + ball);

			if (strick == 4) {
				System.out.println("End");
				System.exit(0);
			}

		}

	}

}
