-- ���̃X�N���v�g�̖ړI:
-- �I�����ꂽFinder���ڂɉ����āA�ȉ��̂悤�ɐV�����t�H���_���쐬���܂��B

-- 1. �����I������Ă��Ȃ��ꍇ:
--    - �A�N�e�B�u��Finder�E�C���h�E�̃t�H���_���ɐV�����t�H���_���쐬���܂��B

-- 2. �t�H���_�݂̂��I������Ă���ꍇ:
--    - �I�����ꂽ���ׂẴt�H���_���ɐV�����t�H���_���쐬���܂��B

-- 3. �t�H���_�ƃt�@�C�������݂��đI������Ă���ꍇ:
--    - �t�H���_�݂̂�Ώۂɂ��A���ꂼ��̃t�H���_���ɐV�����t�H���_���쐬���܂��B
--    - �t�@�C���͖������܂��B

-- 4. �t�@�C���݂̂��I������Ă���ꍇ:
--    - �I�����ꂽ�t�@�C���Ɠ����K�w�ɐV�����t�H���_���쐬���܂��B

-- ���ӎ���:
-- - �쐬����V�����t�H���_�̖��O�́uNewFolder�v�Ƃ��Ă��܂����A�K�v�ɉ����ĕύX�\�ł��B
-- - �������O�̃t�H���_�����ɑ��݂���ꍇ�̓X�L�b�v���܂��B
-- - �G���[�n���h�����O���܂�ł���A�s���ȑ�����O��ʒm���܂��B

try
	-- Finder�A�v���P�[�V������Ώۂɂ���
	tell application "Finder"
		-- �A�N�e�B�u��Finder�E�C���h�E�̑I�����ڂ��擾
		set selectedItems to selection

		-- �I������Ă��邩�`�F�b�N
		if length of selectedItems is 0 then
			-- �����I������Ă��Ȃ��ꍇ�A�A�N�e�B�u�ȃt�H���_���ɐV�����t�H���_���쐬
			set activeFolder to target of front Finder window
			-- =============================
			-- �t�H���_����" "��������������
			set newFolderName to "�v�E��"
			-- =============================
			make new folder at activeFolder with properties {name:newFolderName}
			-- display dialog "�V�����t�H���_�w" & newFolderName & "�x���쐬���܂����B" buttons {"OK"} default button "OK"
		else
			-- �t�H���_�ƃt�@�C���𕪂���
			set folderItems to {}
			set fileItems to {}
			repeat with anItem in selectedItems
				if kind of anItem is "�t�H���_" then
					set end of folderItems to anItem
				else
					set end of fileItems to anItem
				end if
			end repeat

			-- �t�H���_���I������Ă���ꍇ
			if length of folderItems > 0 then
				-- =============================
				-- �t�H���_����" "��������������
				set newFolderName to "�v�E��"
				-- =============================
				repeat with aFolder in folderItems
					if not (exists folder newFolderName of aFolder) then
						make new folder at aFolder with properties {name:newFolderName}
					end if
				end repeat
				-- display dialog "�I�������t�H���_���ɐV�����t�H���_�w" & newFolderName & "�x���쐬���܂����B" buttons {"OK"} default button "OK"
			end if

			-- �t�@�C�����I������Ă��āA�t�H���_���I������Ă��Ȃ��ꍇ
			if length of folderItems is 0 and length of fileItems > 0 then
				-- =============================
				-- �t�H���_����" "��������������
				set newFolderName to "�v�E��"
				-- =============================
				repeat with aFile in fileItems
					set parentFolder to container of aFile
					if not (exists folder newFolderName of parentFolder) then
						make new folder at parentFolder with properties {name:newFolderName}
					end if
				end repeat
				-- display dialog "�I�������t�@�C���Ɠ����K�w�ɐV�����t�H���_�w" & newFolderName & "�x���쐬���܂����B" buttons {"OK"} default button "OK"
			end if
		end if
	end tell
on error errMsg
	-- �G���[���b�Z�[�W�̕\��
	display dialog "�G���[: " & errMsg buttons {"OK"} default button "OK"
end try
