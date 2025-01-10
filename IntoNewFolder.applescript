--[このAppleScriptの機能説明]
-- このスクリプトは、以下の操作を実行します:
-- 1. Finderで選択されている項目がある場合:
--    ・選択された項目の親フォルダに新規フォルダ「yourNameFolder（好きな名前に書き換えてください）」を作成します。
--    ・新規フォルダ「yourNameFolder（好きな名前に書き換えてください）」の中に選択された項目を移動します。
-- 2. Finderで何も選択されていない場合:
--    ・アクティブなFinderウインドウのターゲットフォルダ内に新規フォルダ「yourNameFolder（好きな名前に書き換えてください）」を作成します。
-- このスクリプトは、Finderの選択状態に応じて動作します。

tell application "Finder"
	try
		-- アクティブなFinderウインドウで選択されている項目を取得
		set theSelection to selection

		-- =======================================
		--"　" 内をお好みのフォルダ名を設定してください。
		set newFolderName to "没・済"
		-- =======================================

		if theSelection ≠ {} then
			-- 何かが選択されている場合
			-- 選択された項目の親フォルダを取得
			set parentFolder to container of item 1 of theSelection

			-- 新規フォルダを作成
			set newFolder to make new folder at parentFolder with properties {name:newFolderName}

			-- 選択された各項目を新しいフォルダに移動
			repeat with selectedItem in theSelection
				move selectedItem to newFolder
			end repeat

			-- 成功メッセージを表示
			-- display dialog "新しいフォルダ '" & newFolderName & "' を作成し、選択した項目を内包しました。" buttons {"OK"} default button "OK"
		else
			-- 何も選択されていない場合
			-- アクティブなFinderウインドウのターゲットフォルダを取得
			set targetFolder to target of Finder window 1

			-- ターゲットフォルダに新規フォルダを作成
			set newFolder to make new folder at targetFolder with properties {name:newFolderName}

			-- 成功メッセージを表示
			-- display dialog "新しいフォルダ '" & newFolderName & "' を作成しました。" buttons {"OK"} default button "OK"
		end if

	on error errMsg
		-- エラーハンドリング
		display dialog "エラーが発生しました: " & errMsg buttons {"OK"} default button "OK"
	end try
end tell
