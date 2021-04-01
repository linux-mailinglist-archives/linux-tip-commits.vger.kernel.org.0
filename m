Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC68935178F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhDARmX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhDARkx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42CC00F7DF;
        Thu,  1 Apr 2021 08:08:59 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7PX5AnAr8nq3pYt8IX3dW6sMpPFXAd/ofQR1KSuruY=;
        b=O69gGr4PQ2IAMx3ttd4I4gjKlQeME+0xJw+b5yTny7NcTxnmhB2asaNdFy35WrorEOrboz
        LgRHgURYZQR+wN8svX3RI21FzHZgrem+vUaxQL3beueEwwvIWjgTfdtRf9sQYJSNI4fueW
        KzgJ3G/uigIaUj+X9UCcZLRCG1TTYHy7CTFAiKpwtIwNEaj+E4RulrQsnVr0gsfrLrx+GS
        6YbHaWQFw0VPelDDRWtV/onJjWp7sezBlIgx1m1JQrIqs3Gmhl7f17e/mQQrBd7WliQZ8G
        Ky9G0vf8lBf8v+UrXqwBqRjU9q3nKAC1KLXQFohWqtfGQkKtDSMFrU/0PXlQsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7PX5AnAr8nq3pYt8IX3dW6sMpPFXAd/ofQR1KSuruY=;
        b=1rpAaK62LjlP2lplOcroBJMkCnk7xxlWhdza0QGqi3nAFJJFVgYWF4FFFhzNwOM36TIKbI
        ESjUsNrXsPbNH2AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Implicitly create reloc sections
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.880174448@infradead.org>
References: <20210326151259.880174448@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973626.29796.13144377125307470696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     aef0f13e96db08f31be6b96d28e761df46d86ff4
Gitweb:        https://git.kernel.org/tip/aef0f13e96db08f31be6b96d28e761df46d86ff4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 13:01:15 +02:00

objtool: Implicitly create reloc sections

Have elf_add_reloc() create the relocation section implicitly.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.880174448@infradead.org
---
 tools/objtool/check.c               |  6 ------
 tools/objtool/elf.c                 |  9 ++++++++-
 tools/objtool/include/objtool/elf.h |  1 -
 tools/objtool/orc_gen.c             |  2 --
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 61fe29a..600fa67 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -459,9 +459,6 @@ static int create_static_call_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
-		return -1;
-
 	idx = 0;
 	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
 
@@ -547,9 +544,6 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
-		return -1;
-
 	idx = 0;
 	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0ab52ac..7b65ae3 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -447,11 +447,18 @@ err:
 	return -1;
 }
 
+static struct section *elf_create_reloc_section(struct elf *elf,
+						struct section *base,
+						int reltype);
+
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, int addend)
 {
 	struct reloc *reloc;
 
+	if (!sec->reloc && !elf_create_reloc_section(elf, sec, SHT_RELA))
+		return -1;
+
 	reloc = malloc(sizeof(*reloc));
 	if (!reloc) {
 		perror("malloc");
@@ -829,7 +836,7 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 	return sec;
 }
 
-struct section *elf_create_reloc_section(struct elf *elf,
+static struct section *elf_create_reloc_section(struct elf *elf,
 					 struct section *base,
 					 int reltype)
 {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 825ad32..463f329 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -122,7 +122,6 @@ static inline u32 reloc_hash(struct reloc *reloc)
 
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
-struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, int addend);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 1b57be6..dc9b7dd 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -225,8 +225,6 @@ int orc_create(struct objtool_file *file)
 	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
 	if (!sec)
 		return -1;
-	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
-		return -1;
 
 	/* Write ORC entries to sections: */
 	list_for_each_entry(entry, &orc_list, list) {
