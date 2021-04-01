Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6A351D27
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhDAS1S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhDASRD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 14:17:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19492C00F7E6;
        Thu,  1 Apr 2021 08:09:02 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0zDfszPMzVD4e7e1uk3V4RHtYjezhTwgdZ2JqUzdcQ=;
        b=E0ivD/olUHzmIk3ezFKUp1P3igmIQ+M9kpHbU5DlFxwNuXwyGrmONJCScO/JiY0x0YLBP2
        /1gBvQxhIww9K9h3HJ9nIubmLMncDc5lx1QFPGbEErFLFHDWLZwiykUgWv/S6iE+TjF3z4
        Ic0XVxebgfcodyJ2xJ/hAZGhQicvfCzxIuU6lUG43D3vLZTD8A2E/gv5tcU08Ej+zWIjDk
        oVUQf7mSWnHwPY+Rq+1Z7xwFSaYz8xvuM7fqS2XB5HSlhp++F2BansmKPIG5+CkhU57nMI
        b2y7o1oN+pmED1QZhKQm1mQMheufv0k+GXfdLS9DI2kJGL3xZbzcouMo2hOuZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0zDfszPMzVD4e7e1uk3V4RHtYjezhTwgdZ2JqUzdcQ=;
        b=7otdZnEoMf0dYBsgWxrO8k78XLK9cdxGIVd/cMJYUclQE/wzDc0c4bKciHybH//IhecedZ
        BNX1COYdAaXFGKCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Cache instruction relocs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.195441549@infradead.org>
References: <20210326151300.195441549@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973469.29796.15437583715279384112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4ecdc0265dc911adba0772fd6e816d48da678fe7
Gitweb:        https://git.kernel.org/tip/4ecdc0265dc911adba0772fd6e816d48da678fe7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:13 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 13:25:38 +02:00

objtool: Cache instruction relocs

Track the reloc of instructions to avoid having to look them up again
later.

(Technically x86 instructions can have two relocations, but not jumps
and calls, for which we're using this.)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151300.195441549@infradead.org
---
 tools/objtool/check.c                 | 28 ++++++++++++++++++++------
 tools/objtool/include/objtool/check.h |  1 +-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 77074db..1f4154f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -797,6 +797,25 @@ __weak bool arch_is_retpoline(struct symbol *sym)
 	return false;
 }
 
+#define NEGATIVE_RELOC	((void *)-1L)
+
+static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
+{
+	if (insn->reloc == NEGATIVE_RELOC)
+		return NULL;
+
+	if (!insn->reloc) {
+		insn->reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+						       insn->offset, insn->len);
+		if (!insn->reloc) {
+			insn->reloc = NEGATIVE_RELOC;
+			return NULL;
+		}
+	}
+
+	return insn->reloc;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -811,8 +830,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (!is_static_jump(insn))
 			continue;
 
-		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-						 insn->offset, insn->len);
+		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_sec = insn->sec;
 			dest_off = arch_jump_destination(insn);
@@ -944,8 +962,7 @@ static int add_call_destinations(struct objtool_file *file)
 		if (insn->type != INSN_CALL)
 			continue;
 
-		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					       insn->offset, insn->len);
+		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_call_destination(insn->sec, dest_off);
@@ -1144,8 +1161,7 @@ static int handle_group_alt(struct objtool_file *file,
 		 * alternatives code can adjust the relative offsets
 		 * accordingly.
 		 */
-		alt_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-						   insn->offset, insn->len);
+		alt_reloc = insn_reloc(file, insn);
 		if (alt_reloc &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index e5528ce..56d50bc 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -56,6 +56,7 @@ struct instruction {
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
 	struct reloc *jump_table;
+	struct reloc *reloc;
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
