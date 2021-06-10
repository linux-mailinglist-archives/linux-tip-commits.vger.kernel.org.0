Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4A3A250A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 09:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFJHLD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJHLC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 03:11:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE74C061574;
        Thu, 10 Jun 2021 00:09:06 -0700 (PDT)
Date:   Thu, 10 Jun 2021 07:09:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623308945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6U6xdWOxkx89xGsforOnu8yvR/5Ov7V6ehYrAu4K7g=;
        b=2gnd4GDTabfGWAQ9nZwRcZQNzwNSU/9rTHOPUEistQiJvcp4nwkk1qVFDccY+8l78M27s0
        NiD1R9nNjJyP6f+uk8fyk5Wl3iNj1fA0Vi2IppyFSqXoqDPJB6hV1VRbqgUWcdArFsF1/j
        4x5tJy5euEFFJgFDYGhPcX5HB+9RHAOR6Sz3c4ffzj0Jisv1RtMAzeVjQ6vBEGZ1+h4VVi
        Zu3cqIInUNJBOYHkfhReWOXOCDOUfW0WAeYG/nVd+xnWpsjJ0vfTFVdQEj3/oJg7zdm8fT
        +4zdrpF+a57xNb35Z/LxdtGv9xNlBz35NiNS59IOMp1qAp9EGLtjcPoe5XDPHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623308945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6U6xdWOxkx89xGsforOnu8yvR/5Ov7V6ehYrAu4K7g=;
        b=DBtX8pmWGcOqPrrPJRTA3WNpXIfaLlto6meo3/YycZg9hHdZXSopcNQvy6fdqKCYn471Yq
        WITQTunrBiwcnzAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix .symtab_shndx handling for
 elf_create_undef_symbol()
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <BA@hirez.programming.kicks-ass.net>
References: <BA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162330894430.29796.13585465645704694671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f17777cc267523a21815a4ae7489f0d796b1fc07
Gitweb:        https://git.kernel.org/tip/f17777cc267523a21815a4ae7489f0d796b1fc07
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 07 Jun 2021 11:45:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Jun 2021 20:04:02 +02:00

objtool: Fix .symtab_shndx handling for elf_create_undef_symbol()

When an ELF object uses extended symbol section indexes (IOW it has a
.symtab_shndx section), these must be kept in sync with the regular
symbol table (.symtab).

So for every new symbol we emit, make sure to also emit a
.symtab_shndx value to keep the arrays of equal size.

Note: since we're writing an UNDEF symbol, most GElf_Sym fields will
be 0 and we can repurpose one (st_size) to host the 0 for the xshndx
value.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net
---
 tools/objtool/elf.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 743c2e9..41bca1d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -717,7 +717,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 
 struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 {
-	struct section *symtab;
+	struct section *symtab, *symtab_shndx;
 	struct symbol *sym;
 	Elf_Data *data;
 	Elf_Scn *s;
@@ -769,6 +769,29 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	symtab->len += data->d_size;
 	symtab->changed = true;
 
+	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+	if (symtab_shndx) {
+		s = elf_getscn(elf->elf, symtab_shndx->idx);
+		if (!s) {
+			WARN_ELF("elf_getscn");
+			return NULL;
+		}
+
+		data = elf_newdata(s);
+		if (!data) {
+			WARN_ELF("elf_newdata");
+			return NULL;
+		}
+
+		data->d_buf = &sym->sym.st_size; /* conveniently 0 */
+		data->d_size = sizeof(Elf32_Word);
+		data->d_align = 4;
+		data->d_type = ELF_T_WORD;
+
+		symtab_shndx->len += 4;
+		symtab_shndx->changed = true;
+	}
+
 	sym->sec = find_section_by_index(elf, 0);
 
 	elf_add_symbol(elf, sym);
