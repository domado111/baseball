<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>	
	<body>
		<div class="w3-modal-content" style="width: 500px;">
			<div class="w3-container w3-center" style="background-color: #2E2E2E; padding: 30px 20px;">
				<div class="w3-section">
					<label class="w3-left w3-text-orange">���̵�</label>										
					<div class="w3-cell-row">														
						<input type="text" value="${user.id }" class="w3-input w3-border w3-round w3-grey" readonly style="cursor: default;"/>														
					</div>
				</div>	
				<div class="w3-section">
					<label class="w3-left w3-text-orange">�г���</label>
					<div class="w3-cell-row">
						<input type="text" value="${user.nickname }" class="w3-input w3-border w3-round w3-grey" readonly style="cursor: default;"/>
					</div>
				</div>
				<div class="w3-section">
					<label class="w3-left w3-text-orange">���� ����</label>
					<div class="w3-cell-row">														
						<div class="w3-cell">														
							<input type="text" value="${user.win_count }�� ${user.lose_count }��" class="w3-input w3-border w3-round w3-grey" readonly style="cursor: default;"/>
						</div>
					</div>
				</div>
				<div class="w3-section">
				<label class="w3-left w3-text-orange">����Ʈ</label>
					<div class="w3-cell-row">
						<input type="text" value="${user.point } point" class="w3-input w3-border w3-round w3-grey" readonly style="cursor: default;"/>																													
					</div>
				</div>
				<div class="w3-row">
					<button class="simple_btn w3-round" onclick="closeInfo()" >Ȯ��</button>
				</div>		
			</div>		
		</div>
	</body>
</html>