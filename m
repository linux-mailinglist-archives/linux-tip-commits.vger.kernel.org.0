Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD635338F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbhDCLLB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhDCLLA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E7CC0613E6;
        Sat,  3 Apr 2021 04:10:57 -0700 (PDT)
Date:   Sat, 03 Apr 2021 11:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLFM8o8BM5TPKuGZaQWtz3Nmqq72mes2FyBxBcRiNxw=;
        b=xov0gSOVidxQDKVxHrzkJe4/s6puFmBxSlhzdWITO43opQX7QVJt8Uc0+z9NaetPTP5K1z
        4WFBD8DbBKUBKHdf+Wxl9YYAr70XhQM9Dxpf1DcIIpPael8iyKIhm8NfTHb0QFSBsZH6O9
        XT/j2azX1q9lG+5WWIFhUQsAMcqWomQY+JTPq551WxF9VMEr/70s9OFXhACn7QqlQ0SBAP
        Yg5ger3NcZz3jjpbzEoyD30NmPIMpO76v/14sR8GuIz42bTnLdfDL1/MiFs3VoOnYuVsl9
        cyg1QLwG7X0WYsZSeoe4yqA83e4lLAYTKE2KjiNOY1HYflgUIFp5xikJMSkZLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLFM8o8BM5TPKuGZaQWtz3Nmqq72mes2FyBxBcRiNxw=;
        b=1bO27sSUn16b1it7iu7FYVAVh4VzXn1yelsW3Y1oe+dKMRLj9uK3FOeBqN987fSMRKKEY5
        FkTg6iLJenhdXOAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Cache instruction relocs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.195441549@infradead.org>
References: <20210326151300.195441549@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825558.29796.194998706687659843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7bd2a600f3e9d27286bbf23c83d599e9cc7cf245
Gitweb:        https://git.kernel.org/tip/7bd2a600f3e9d27286bbf23c83d599e9cc7cf245
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:46:15 +02:00

objtool: Cache instruction relocs

Track the reloc of instructions in the new instruction->reloc field
to avoid having to look them up again later.

( Technically x86 instructions can have two relocations, but not jumps
  and calls, for which we're using this. )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
