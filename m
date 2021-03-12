Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8698E33874C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 09:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhCLI1y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 03:27:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhCLI1f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 03:27:35 -0500
Date:   Fri, 12 Mar 2021 08:27:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615537654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtQUOdFp/TI7ISqO4fhhTKETyEkEd2iGeOF2ESD0ijY=;
        b=ZdNVZL73X3wVK9NRlh+GEKPZ41ZyXfAxj1spWzIb8ap4EzRmx4n2NRWuFvIYUYbfkFy7k9
        sIFxPhR6WSdlOqMaK8U2i3+zy8j3Rj2hHlFc6FCJudxrF40W3NGcnIndsFjfAKbvz5uj09
        9M4hHbzavlvEYBsurogfWiyB8CNXXypYYM7oNr4EsJVAri4Twg3hqBoMtD64iA4kqMbuhL
        CTaIL2ytjNIknMB0jK2pqgqhuFWnH9Kmy9V2IPJK27l8JfU7X9b42w9xOCJrl7tgdLlamL
        XegxPDnCX5AmrFEmZICTdeXh2+r6y4nm6JREcxtYQlBcN+Ra0wdyGqPkI8L4Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615537654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtQUOdFp/TI7ISqO4fhhTKETyEkEd2iGeOF2ESD0ijY=;
        b=WptMiTvpJFCPCTVRZGd7eLidrP4llzGhbcVolhsAO5LCGK4+takYZEuHBbHJgJq5NOJpMp
        i5WO/2A5qAGPc1Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool,x86: Fix uaccess PUSHF/POPF validation
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YEY4rIbQYa5fnnEp@hirez.programming.kicks-ass.net>
References: <YEY4rIbQYa5fnnEp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161553765304.398.16269370690914866894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ba08abca66d46381df60842f64f70099d5482b92
Gitweb:        https://git.kernel.org/tip/ba08abca66d46381df60842f64f70099d5482b92
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 08 Mar 2021 15:46:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 12 Mar 2021 09:15:49 +01:00

objtool,x86: Fix uaccess PUSHF/POPF validation

Commit ab234a260b1f ("x86/pv: Rework arch_local_irq_restore() to not
use popf") replaced "push %reg; popf" with something like: "test
$0x200, %reg; jz 1f; sti; 1:", which breaks the pushf/popf symmetry
that commit ea24213d8088 ("objtool: Add UACCESS validation") relies
on.

The result is:

  drivers/gpu/drm/amd/amdgpu/si.o: warning: objtool: si_common_hw_init()+0xf36: PUSHF stack exhausted

Meanwhile, commit c9c324dc22aa ("objtool: Support stack layout changes
in alternatives") makes that we can actually use stack-ops in
alternatives, which means we can revert 1ff865e343c2 ("x86,smap: Fix
smap_{save,restore}() alternatives").

That in turn means we can limit the PUSHF/POPF handling of
ea24213d8088 to those instructions that are in alternatives.

Fixes: ab234a260b1f ("x86/pv: Rework arch_local_irq_restore() to not use popf")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/YEY4rIbQYa5fnnEp@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/smap.h | 10 ++++------
 tools/objtool/check.c       |  3 +++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 8b58d69..0bc9b08 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -58,9 +58,8 @@ static __always_inline unsigned long smap_save(void)
 	unsigned long flags;
 
 	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
-		      "pushf; pop %0; " __ASM_CLAC "\n\t"
-		      "1:"
+		      ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC "\n\t",
+				  X86_FEATURE_SMAP)
 		      : "=rm" (flags) : : "memory", "cc");
 
 	return flags;
@@ -69,9 +68,8 @@ static __always_inline unsigned long smap_save(void)
 static __always_inline void smap_restore(unsigned long flags)
 {
 	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
-		      "push %0; popf\n\t"
-		      "1:"
+		      ALTERNATIVE("", "push %0; popf\n\t",
+				  X86_FEATURE_SMAP)
 		      : : "g" (flags) : "memory", "cc");
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 068cdb4..5e5388a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2442,6 +2442,9 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 		if (update_cfi_state(insn, &state->cfi, op))
 			return 1;
 
+		if (!insn->alt_group)
+			continue;
+
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
 				state->uaccess_stack = 1;
