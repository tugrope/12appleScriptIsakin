(*
制作日：2024.01.10
制作者：Isao Sasaki

機能概要：
1. 指定フォルダから"-地図ol.ai"で終わるファイルを検索
2. 検索したファイルを店舗地図フォルダへ移動（上書き可）

処理フロー：
1. フォルダ選択ダイアログを表示（デフォルト：チラシ念校部屋）
2. 選択フォルダ内のファイル検索（サブフォルダ含む）
3. 検索結果に応じたアラート表示
   - 0件：処理中止
   - 1件以上：移動確認
4. 確認OKで店舗地図フォルダへ移動
5. 完了アラート表示

エラー処理：
- 移動先フォルダ未接続時はエラーアラート
- ファイル移動時のエラーをキャッチして表示
*)

-- デフォルトフォルダのパスを設定
set defaultPath to "/Users/i-sasaki/Desktop/★★★S_作業場所/★チラシ念校部屋"
set destinationPath to "/Volumes/Syng/新店_再オープン_ご愛顧チラシ/99_使用画像とリンク用AI/03_店舗地図"

-- 移動先フォルダの存在確認
try
	tell application "Finder"
		if not (exists folder destinationPath as POSIX file) then
			display alert "03_店舗地図フォルダが見つかりません。サーバー接続して再度実行してください。"
			return
		end if
	end tell
on error
	display alert "03_店舗地図フォルダが見つかりません。サーバー接続して再度実行してください。"
	return
end try

-- フォルダ選択ダイアログを表示
try
	set selectedFolder to choose folder with prompt "フォルダを選択してください" default location (POSIX file defaultPath)
on error
	display alert "フォルダの選択がキャンセルされました。"
	return
end try

-- 選択されたフォルダ内のファイルを再帰的に検索
tell application "Finder"
	try
		set mapFiles to (every file of entire contents of selectedFolder whose name ends with "-地図ol.ai")
		set fileCount to count of mapFiles

		-- 検索結果に応じてアラートを表示
		if fileCount is 0 then
			display alert "該当ファイルは0個なので何もせえへんで。"
			return
		else
			set alertResult to display alert ("該当ファイルは" & fileCount & "個") message "【注意】同名ファイルは上書きします。店舗地図フォルダへエクスポート！" buttons {"キャンセル", "OK"} default button "OK" cancel button "キャンセル"

			if button returned of alertResult is "OK" then
				-- ファイルを移動
				set errorFiles to {}
				repeat with aFile in mapFiles
					try
						move aFile to POSIX file destinationPath with replacing
					on error errorMessage
						set end of errorFiles to (name of aFile) & ": " & errorMessage
					end try
				end repeat

				-- エラーの有無に応じた処理
				if (count of errorFiles) > 0 then
					set errorList to join of errorFiles with return
					display alert "一部のファイルの移動に失敗しました。" message errorList
				else
					-- エラーがない場合のみ、選択フォルダをゴミ箱へ移動
					try
						move selectedFolder to trash
						display alert "店舗地図エクスポート完了"
					on error errorMessage
						display alert "店舗地図エクスポート完了" message "ただし、選択フォルダのゴミ箱への移動に失敗しました。"
					end try
				end if
			end if
		end if
	on error errorMessage
		display alert "エラーが発生しました。" message errorMessage
	end try
end tell

-- リスト結合用のハンドラ
on join of theList with delimiter
	set AppleScript's text item delimiters to delimiter
	set theString to theList as string
	set AppleScript's text item delimiters to ""
	return theString
end join
