Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2534435178A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhDARmW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhDARi3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F42C00F7E8;
        Thu,  1 Apr 2021 08:09:02 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewilDfX8xZ5f96JbSoLPDUYRIp3UVVGWZNdgrnNzb74=;
        b=yydnilu1TpUapeFcGJaY7x5iJhHt0S/Z2lZaxRTx3qHqJfnx6cJcTJJhboXUlA/16CLdD4
        SWin7PB6NEBJ3vGqQMK094WL8Au/936Hb9nwZVE5c2He+zUJgPurJNNjmQHOdyRpvDtb6l
        9/rL69jPXDAVxkF5WvklQ0lsaVH7ZPptIERYI56J3mnpKZyVDaBlM7UvJCEqO8n1/GUgM/
        zzz9JuRoq3vdNudJu8OrtJfcVqBHyw0xqCSSy9NKuE43+36C2+SIeDpf2mHfgU4gIW+zvD
        XE6xWq6mUAf+9kAJmdXuDDAMJIlS8UCq68M3j6jPzg84joOOK/kX/HS6O+pLCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewilDfX8xZ5f96JbSoLPDUYRIp3UVVGWZNdgrnNzb74=;
        b=u0/VxmpA+RTBbsNbr8iiKT/REjiXT4T62+q2WH8DcYISpd9ToYya+IbZyvriNuspPhuIDY
        JH2ZSj/Yld6tSDAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add elf_create_undef_symbol()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.064743095@infradead.org>
References: <20210326151300.064743095@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973533.29796.18219156552513333991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     993b477acdb652c6134e5faae05e8a378911cbb3
Gitweb:        https://git.kernel.org/tip/993b477acdb652c6134e5faae05e8a378911cbb3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 13:12:48 +02:00

objtool: Add elf_create_undef_symbol()

Allow objtool to create undefined symbols; this allows creating
relocations to symbols not currently in the symbol table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
 
