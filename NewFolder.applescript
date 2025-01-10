-- このスクリプトの目的:
-- 選択されたFinder項目に応じて、以下のように新しいフォルダを作成します。

-- 1. 何も選択されていない場合:
--    - アクティブなFinderウインドウのフォルダ内に新しいフォルダを作成します。

-- 2. フォルダのみが選択されている場合:
--    - 選択されたすべてのフォルダ内に新しいフォルダを作成します。

-- 3. フォルダとファイルが混在して選択されている場合:
--    - フォルダのみを対象にし、それぞれのフォルダ内に新しいフォルダを作成します。
--    - ファイルは無視します。

-- 4. ファイルのみが選択されている場合:
--    - 選択されたファイルと同じ階層に新しいフォルダを作成します。

-- 注意事項:
-- - 作成する新しいフォルダの名前は「NewFolder」としていますが、必要に応じて変更可能です。
-- - 同じ名前のフォルダが既に存在する場合はスキップします。
-- - エラーハンドリングを含んでおり、不正な操作や例外を通知します。

try
	-- Finderアプリケーションを対象にする
	tell application "Finder"
		-- アクティブなFinderウインドウの選択項目を取得
		set selectedItems to selection

		-- 選択されているかチェック
		if length of selectedItems is 0 then
			-- 何も選択されていない場合、アクティブなフォルダ内に新しいフォルダを作成
			set activeFolder to target of front Finder window
			-- =============================
			-- フォルダ名は" "内を書き換える
			set newFolderName to "没・済"
			-- =============================
			make new folder at activeFolder with properties {name:newFolderName}
			-- display dialog "新しいフォルダ『" & newFolderName & "』を作成しました。" buttons {"OK"} default button "OK"
		else
			-- フォルダとファイルを分ける
			set folderItems to {}
			set fileItems to {}
			repeat with anItem in selectedItems
				if kind of anItem is "フォルダ" then
					set end of folderItems to anItem
				else
					set end of fileItems to anItem
				end if
			end repeat

			-- フォルダが選択されている場合
			if length of folderItems > 0 then
				-- =============================
				-- フォルダ名は" "内を書き換える
				set newFolderName to "没・済"
				-- =============================
				repeat with aFolder in folderItems
					if not (exists folder newFolderName of aFolder) then
						make new folder at aFolder with properties {name:newFolderName}
					end if
				end repeat
				-- display dialog "選択したフォルダ内に新しいフォルダ『" & newFolderName & "』を作成しました。" buttons {"OK"} default button "OK"
			end if

			-- ファイルが選択されていて、フォルダが選択されていない場合
			if length of folderItems is 0 and length of fileItems > 0 then
				-- =============================
				-- フォルダ名は" "内を書き換える
				set newFolderName to "没・済"
				-- =============================
				repeat with aFile in fileItems
					set parentFolder to container of aFile
					if not (exists folder newFolderName of parentFolder) then
						make new folder at parentFolder with properties {name:newFolderName}
					end if
				end repeat
				-- display dialog "選択したファイルと同じ階層に新しいフォルダ『" & newFolderName & "』を作成しました。" buttons {"OK"} default button "OK"
			end if
		end if
	end tell
on error errMsg
	-- エラーメッセージの表示
	display dialog "エラー: " & errMsg buttons {"OK"} default button "OK"
end try
