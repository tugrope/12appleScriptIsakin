-- set scriptPath to "/Users/ethan_air/Library/CloudStorage/Dropbox/VSC/00GitHub/02Nenko/ol_Renewal.jsx"
set scriptPath to "/Users/i-sasaki/Desktop/DeckTopAppleScript/MoveMapToDesignatedFolder.scpt"

-- ファイルが存在するか確認
if not (do shell script "test -f " & quoted form of scriptPath & "; echo $?") is "0" then
	display alert "指定フォルダにScriptを用意してください"
else
	try
		-- スクリプトファイルをPOSIXパスからエイリアスに変換して実行
		set scriptAlias to (POSIX file scriptPath) as alias
		run script scriptAlias
	on error errMsg number errNum
		display alert "スクリプト実行エラー" message "エラー番号: " & errNum & " - " & errMsg
	end try
end if
