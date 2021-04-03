Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9D35338E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhDCLLA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhDCLLA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:00 -0400
Date:   Sat, 03 Apr 2021 11:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0fixkZJENBwXKV8o90u04RTZuEfdfpqCNClHgFW1Yg=;
        b=uX6VZAgmZp6TO7vBycL/LvRWY2/0vKgNKkbH268Hvd2ECWNuN1OMzmO5yrvFLikINydAeL
        E3yowiBLXYFnE9lGcWdem/gt2Z7VJbpFeS4WORDhsuEFaoMz3FOy9D6X4ew3UedUe9ryhV
        61jwDfYMRf39WaeD9TuHR9cFqDw4kiOr9EB7qZJPN+bIfRvmP+yF3Ki2rcmbhguRZ4gRrb
        iq90KxbUh75x0Nxog9OhCQh9WBrpCc67iCLCzLvb41bbqtCwfcGbJO9jFbnTtvLUfeqRmK
        7+nXMjO69XH+Qnjk3QvHRjpb0M2Uh3C20MNC5QAstxoN9FR7+1iuM1TkTTLuHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0fixkZJENBwXKV8o90u04RTZuEfdfpqCNClHgFW1Yg=;
        b=e828VCXxMdBedPMpvloKSCW3cm+I1tvL5D2YHmeMKXlQOJWDUDlMMIw4mG31iTD6Fil2N7
        1O43v1ps3MdG3nAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add elf_create_undef_symbol()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.064743095@infradead.org>
References: <20210326151300.064743095@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825631.29796.1260339436416929491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2f2f7e47f0525cbaad5dd9675fd9d8aa8da12046
Gitweb:        https://git.kernel.org/tip/2f2f7e47f0525cbaad5dd9675fd9d8aa8da12046
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:45:05 +02:00

objtool: Add elf_create_undef_symbol()

Allow objtool to create undefined symbols; this allows creating
relocations to symbols not currently in the symbol table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151300.064743095@infradead.org
---
 tools/objtool/elf.c                 | 60 ++++++++++++++++++++++++++++-
 tools/objtool/include/objtool/elf.h |  1 +-
 2 files changed, 61 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8457218..d08f5f3 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -715,6 +715,66 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 	return len;
 }
 
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
+{
+	struct section *symtab;
+	struct symbol *sym;
+	Elf_Data *data;
+	Elf_Scn *s;
+
+	sym = malloc(sizeof(*sym));
+	if (!sym) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(sym, 0, sizeof(*sym));
+
+	sym->name = strdup(name);
+
+	sym->sym.st_name = elf_add_string(elf, NULL, sym->name);
+	if (sym->sym.st_name == -1)
+		return NULL;
+
+	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);
+	// st_other 0
+	// st_shndx 0
+	// st_value 0
+	// st_size 0
+
+	symtab = find_section_by_name(elf, ".symtab");
+	if (!symtab) {
+		WARN("can't find .symtab");
+		return NULL;
+	}
+
+	s = elf_getscn(elf->elf, symtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return NULL;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return NULL;
+	}
+
+	data->d_buf = &sym->sym;
+	data->d_size = sizeof(sym->sym);
+	data->d_align = 1;
+
+	sym->idx = symtab->len / sizeof(sym->sym);
+
+	symtab->len += data->d_size;
+	symtab->changed = true;
+
+	sym->sec = find_section_by_index(elf, 0);
+
+	elf_add_symbol(elf, sym);
+
+	return sym;
+}
+
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 463f329..45e5ede 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -133,6 +133,7 @@ int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
 int elf_write_reloc(struct elf *elf, struct reloc *reloc);
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
