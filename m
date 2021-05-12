Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8637E37BE03
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhELNVB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhELNVA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:21:00 -0400
Date:   Wed, 12 May 2021 13:19:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT6fAHEXU9MTVtnC/lsWmh5tFdzKinjeCcQPLCu/Ecg=;
        b=lvFaqpX407BieTEmew4hlCtgYwhXI9kHsL2xAY1VFvLivDqv3aKfw2T37Bx0b0rQq45ae0
        ZOjghVSwyWvvWaLy8yR9I3JDrI35o2T0HKpTi5JEfrBy0o/mDnEY3nxwULgrWlRV74V4W5
        f8PCogH+h5lA1rUUCC+tikY0VQTDR2tbFF1ndcGep/2nH4mEIDhaInvgx8fr2FEgGinzeI
        Q163J20EdEJZU+UirON7N35g1KVk+kgoBEi+CugrVbTO8tlwmwZgYVNaQ37A+e66qiWWzH
        3/ZRfuae1Wk4rQTc/SiRtB7jfpvX1Zoe/IP13PNEpXoXLeu26KpiDoZrHaTX5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT6fAHEXU9MTVtnC/lsWmh5tFdzKinjeCcQPLCu/Ecg=;
        b=RLPSrRV4te631NYoCjie/3Q9p2mnmna0qn7/pmPr7Cdo50VqTZskOkhQCZ+198EPLZBwbH
        yEzN3d2kN5n+kNAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Improve error when we fail expected text
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.726939027@infradead.org>
References: <20210506194157.726939027@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559123.29796.6175093223438979415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f9510fa9caaf8229381d5f86ba0774bf1a6ca39b
Gitweb:        https://git.kernel.org/tip/f9510fa9caaf8229381d5f86ba0774bf1a6ca39b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label, x86: Improve error when we fail expected text

There is only a single usage site left, remove the function and extend
the print to include more information, like the expected text and the
patch type.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.726939027@infradead.org
---
 arch/x86/kernel/jump_label.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 6a2eb62..638d3b9 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,37 +16,32 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-static void bug_at(const void *ip, int line)
-{
-	/*
-	 * The location is not an op that we were expecting.
-	 * Something went wrong. Crash the box, as something could be
-	 * corrupting the kernel.
-	 */
-	pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph) %d\n", ip, ip, ip, line);
-	BUG();
-}
-
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
 {
 	const void *expect, *code;
 	const void *addr, *dest;
-	int line;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
 	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
-	if (type == JUMP_LABEL_JMP) {
-		expect = x86_nops[5]; line = __LINE__;
-	} else {
-		expect = code; line = __LINE__;
-	}
+	if (type == JUMP_LABEL_JMP)
+		expect = x86_nops[5];
+	else
+		expect = code;
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
-		bug_at(addr, line);
+	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE)) {
+		/*
+		 * The location is not an op that we were expecting.
+		 * Something went wrong. Crash the box, as something could be
+		 * corrupting the kernel.
+		 */
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) type:%d\n",
+				addr, addr, addr, expect, type);
+		BUG();
+	}
 
 	if (type == JUMP_LABEL_NOP)
 		code = x86_nops[5];
