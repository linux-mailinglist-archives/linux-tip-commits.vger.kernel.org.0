Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D971C1D02
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 May 2020 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgEASWe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 May 2020 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730746AbgEASWe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 May 2020 14:22:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634CC061A0C;
        Fri,  1 May 2020 11:22:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIr-0003gq-Nv; Fri, 01 May 2020 20:22:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BE3851C0813;
        Fri,  1 May 2020 20:22:22 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:22 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86,smap: Fix smap_{save,restore}() alternatives
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429101802.GI13592@hirez.programming.kicks-ass.net>
References: <20200429101802.GI13592@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158835734274.8414.9962898280238154655.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1ff865e343c2b59469d7e41d370a980a3f972c71
Gitweb:        https://git.kernel.org/tip/1ff865e343c2b59469d7e41d370a980a3f972c71
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 28 Apr 2020 19:57:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:31 +02:00

x86,smap: Fix smap_{save,restore}() alternatives

As reported by objtool:

  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x0: alternative modifies stack
  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x7: alternative modifies stack

the smap_{save,restore}() alternatives violate (the newly enforced)
rule on stack invariance. That is, due to there only being a single
ORC table it must be valid to any alternative. These alternatives
violate this with the direct result that unwinds will not be correct
when it hits between the PUSH and POP instructions.

Rewrite the functions to only have a conditional jump.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200429101802.GI13592@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/smap.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 27c47d1..8b58d69 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -57,8 +57,10 @@ static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
 
-	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
-				  X86_FEATURE_SMAP)
+	asm volatile ("# smap_save\n\t"
+		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
+		      "pushf; pop %0; " __ASM_CLAC "\n\t"
+		      "1:"
 		      : "=rm" (flags) : : "memory", "cc");
 
 	return flags;
@@ -66,7 +68,10 @@ static __always_inline unsigned long smap_save(void)
 
 static __always_inline void smap_restore(unsigned long flags)
 {
-	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+	asm volatile ("# smap_restore\n\t"
+		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
+		      "push %0; popf\n\t"
+		      "1:"
 		      : : "g" (flags) : "memory", "cc");
 }
 
