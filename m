Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C53353399
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhDCLLI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhDCLLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283DC061788;
        Sat,  3 Apr 2021 04:11:00 -0700 (PDT)
Date:   Sat, 03 Apr 2021 11:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tOrcOEYj+u0HKLrJrvqaLHOHmCQC3Odk2V5AxUtwZU=;
        b=WsBNgyYnnlqy0kTGGytLZYd8uzWnifJ6iFJ/9wfxOViEcBYn/x1s/efgMLceleouX6iCBJ
        WNVFjCYDU87Ohw6Ye2QtZaG+dIxJAz9cTcoEjzNbVEqezKg/w8IeUAvmBL+/q3vje9lePs
        jDVHRAXFQF1F7m1qslRGo8s4yVjFP9GzHnH8KHULCBVyS4xu6iB58BlrqWZd4Jp7ObVD3g
        Mn931l6GDwtRL/6UVT4Zj8ILuLVYtGRCtEz3HFUgbyIUUEo2KgWUA0bg9cbkbpNxv5RCI5
        YDEFlz15bPLSgdj4qcLzkTDRM5xmUZxFb+9xIGGItuWePKBGfTXl6VOsQaoBAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tOrcOEYj+u0HKLrJrvqaLHOHmCQC3Odk2V5AxUtwZU=;
        b=v5qlvEWipj5ad30kcsdWhux5uN09r/BwhKlv4qMLZZ+A+1O/fncEE6U36oPEGCHyiCk0xP
        KgXpl5FKH4jDUYDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Rework the elf_rebuild_reloc_section() logic
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.754213408@infradead.org>
References: <20210326151259.754213408@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825825.29796.6561168736890974336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3a647607b57ad8346e659ddd3b951ac292c83690
Gitweb:        https://git.kernel.org/tip/3a647607b57ad8346e659ddd3b951ac292c83690
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:43:32 +02:00

objtool: Rework the elf_rebuild_reloc_section() logic

Instead of manually calling elf_rebuild_reloc_section() on sections
we've called elf_add_reloc() on, have elf_write() DTRT.

This makes it easier to add random relocations in places without
carefully tracking when we're done and need to flush what section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.754213408@infradead.org
---
 tools/objtool/check.c               |  6 ------
 tools/objtool/elf.c                 | 20 ++++++++++++++------
 tools/objtool/include/objtool/elf.h |  1 -
 tools/objtool/orc_gen.c             |  3 ---
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8618d03..1d0415b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -542,9 +542,6 @@ static int create_static_call_sections(struct objtool_file *file)
 		idx++;
 	}
 
-	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
-		return -1;
-
 	return 0;
 }
 
@@ -614,9 +611,6 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		idx++;
 	}
 
-	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
-		return -1;
-
 	return 0;
 }
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 93fa833..374813e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, struct reloc *reloc)
 
 	list_add_tail(&reloc->list, &sec->reloc_list);
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+
+	sec->changed = true;
 }
 
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
@@ -558,7 +560,9 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 
-			elf_add_reloc(elf, reloc);
+			list_add_tail(&reloc->list, &sec->reloc_list);
+			elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+
 			nr_reloc++;
 		}
 		max_reloc = max(max_reloc, nr_reloc);
@@ -873,14 +877,11 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 	return 0;
 }
 
-int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
+static int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 {
 	struct reloc *reloc;
 	int nr;
 
-	sec->changed = true;
-	elf->changed = true;
-
 	nr = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list)
 		nr++;
@@ -944,9 +945,15 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	/* Update section headers for changed sections: */
+	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
+			if (sec->base &&
+			    elf_rebuild_reloc_section(elf, sec)) {
+				WARN("elf_rebuild_reloc_section");
+				return -1;
+			}
+
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
 				WARN_ELF("elf_getscn");
@@ -958,6 +965,7 @@ int elf_write(struct elf *elf)
 			}
 
 			sec->changed = false;
+			elf->changed = true;
 		}
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index e6890cc..fc576ed 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -142,7 +142,6 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
 			      struct reloc *reloc);
-int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 738aa50..f534708 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -254,8 +254,5 @@ int orc_create(struct objtool_file *file)
 			return -1;
 	}
 
-	if (elf_rebuild_reloc_section(file->elf, ip_rsec))
-		return -1;
-
 	return 0;
 }
