-- set scriptPath to "/Users/ethan_air/Library/CloudStorage/Dropbox/VSC/00GitHub/02Nenko/ol_Renewal.jsx"
set scriptPath to "/Users/i-sasaki/Desktop/DeckTopAppleScript/MoveMapToDesignatedFolder.applescript"

-- �t�@�C�������݂��邩�m�F
if not (do shell script "test -f " & quoted form of scriptPath & "; echo $?") is "0" then
	display alert "�w��t�H���_��Script��p�ӂ��Ă�������"
else
	try
		-- Adobe Illustrator���A�N�e�B�u�ɂ��ăX�N���v�g�����s
		tell application "Adobe Illustrator"
			activate
			do javascript file scriptPath
		end tell
	on error errMsg number errNum
		display alert "�X�N���v�g���s�G���[" message "�G���[�ԍ�: " & errNum & " - " & errMsg
	end try
end if
