-- set scriptPath to "/Users/ethan_air/Library/CloudStorage/Dropbox/VSC/00GitHub/02Nenko/ol_Renewal.jsx"
set scriptPath to "/Users/i-sasaki/Desktop/DeckTopAppleScript/MoveMapToDesignatedFolder.applescript"

-- ファイルが存在するか確認
if not (do shell script "test -f " & quoted form of scriptPath & "; echo $?") is "0" then
	display alert "指定フォルダにScriptを用意してください"
else
	try
		-- Adobe Illustratorをアクティブにしてスクリプトを実行
		tell application "Adobe Illustrator"
			activate
			do javascript file scriptPath
		end tell
	on error errMsg number errNum
		display alert "スクリプト実行エラー" message "エラー番号: " & errNum & " - " & errMsg
	end try
end if
