-- set scriptPath to "/Users/ethan_air/Library/CloudStorage/Dropbox/VSC/00GitHub/02Nenko/ol_Renewal.jsx"
set scriptPath to "/Users/i-sasaki/Desktop/DeckTopAppleScript/MoveMapToDesignatedFolder.scpt"

-- �t�@�C�������݂��邩�m�F
if not (do shell script "test -f " & quoted form of scriptPath & "; echo $?") is "0" then
	display alert "�w��t�H���_��Script��p�ӂ��Ă�������"
else
	try
		-- �X�N���v�g�t�@�C����POSIX�p�X����G�C���A�X�ɕϊ����Ď��s
		set scriptAlias to (POSIX file scriptPath) as alias
		run script scriptAlias
	on error errMsg number errNum
		display alert "�X�N���v�g���s�G���[" message "�G���[�ԍ�: " & errNum & " - " & errMsg
	end try
end if
