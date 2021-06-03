Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A039A375
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jun 2021 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhFCOkM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Jun 2021 10:40:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOkK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Jun 2021 10:40:10 -0400
Date:   Thu, 03 Jun 2021 14:38:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622731104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sm2ggrAef4nSUjwqaeqwSUsiU9l5NxvixZEowSXC6xY=;
        b=M6O8j3CkD/GLOrbRvkV29Bjf0SIXoEcsfPgpET5/bWhMlwfK8NdXi4jQjjk4fAE4o46KR0
        bU37tdGOrhNl9Q/gjPg+CWb2rXylGShtZdScllLTUhjDGb1TqRQ/82XBkSdRzv/ZY/04pr
        pI+GxW6yJbXJWYa2yzCfATeSjLtqEc5W2QfiZcP/TGU6szRJst/Hh2eVHVKq5PAQqul+fC
        tCYb1/3B7FyU37H5Gk/8jgsI9tTUu6q1p4SPOUMfGQZibEH7vN5clOUIzT+ILERu0mo0Ni
        g2tD1HuTRmmWb4qyvyzSX71diR8ATtGooFo+2NfyV0WxXPVhmxKEr3FbYLxaBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622731104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sm2ggrAef4nSUjwqaeqwSUsiU9l5NxvixZEowSXC6xY=;
        b=BEM5Vnd0cwWJhyu+0q6Zp7IPVj5ekok6uiv/rE8Ge/tckyy9hrIztevBrptCYBSS6sJFHW
        SFeRxgea7qHacCCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Optimize single-byte NOPs at an
 arbitrary position
Cc:     Richard Narron <richard@aaazen.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601212125.17145-1-bp@alien8.de>
References: <20210601212125.17145-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <162273110395.29796.14379457953065896336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2b31e8ed96b260ce2c22bd62ecbb9458399e3b62
Gitweb:        https://git.kernel.org/tip/2b31e8ed96b260ce2c22bd62ecbb9458399e3b62
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 01 Jun 2021 17:51:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Jun 2021 16:33:09 +02:00

x86/alternative: Optimize single-byte NOPs at an arbitrary position

Up until now the assumption was that an alternative patching site would
have some instructions at the beginning and trailing single-byte NOPs
(0x90) padding. Therefore, the patching machinery would go and optimize
those single-byte NOPs into longer ones.

However, this assumption is broken on 32-bit when code like
hv_do_hypercall() in hyperv_init() would use the ratpoline speculation
killer CALL_NOSPEC. The 32-bit version of that macro would align certain
insns to 16 bytes, leading to the compiler issuing a one or more
single-byte NOPs, depending on the holes it needs to fill for alignment.

That would lead to the warning in optimize_nops() to fire:

  ------------[ cut here ]------------
  Not a NOP at 0xc27fb598
   WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:211 optimize_nops.isra.13

due to that function verifying whether all of the following bytes really
are single-byte NOPs.

Therefore, carve out the NOP padding into a separate function and call
it for each NOP range beginning with a single-byte NOP.

Fixes: 23c1ad538f4f ("x86/alternatives: Optimize optimize_nops()")
Reported-by: Richard Narron <richard@aaazen.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213301
Link: https://lkml.kernel.org/r/20210601212125.17145-1-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 64 ++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b51..6fe5b44 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -183,41 +183,69 @@ done:
 }
 
 /*
+ * optimize_nops_range() - Optimize a sequence of single byte NOPs (0x90)
+ *
+ * @instr: instruction byte stream
+ * @instrlen: length of the above
+ * @off: offset within @instr where the first NOP has been detected
+ *
+ * Return: number of NOPs found (and replaced).
+ */
+static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
+{
+	unsigned long flags;
+	int i = off, nnops;
+
+	while (i < instrlen) {
+		if (instr[i] != 0x90)
+			break;
+
+		i++;
+	}
+
+	nnops = i - off;
+
+	if (nnops <= 1)
+		return nnops;
+
+	local_irq_save(flags);
+	add_nops(instr + off, nnops);
+	local_irq_restore(flags);
+
+	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
+
+	return nnops;
+}
+
+/*
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
 static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
 {
-	unsigned long flags;
 	struct insn insn;
-	int nop, i = 0;
+	int i = 0;
 
 	/*
-	 * Jump over the non-NOP insns, the remaining bytes must be single-byte
-	 * NOPs, optimize them.
+	 * Jump over the non-NOP insns and optimize single-byte NOPs into bigger
+	 * ones.
 	 */
 	for (;;) {
 		if (insn_decode_kernel(&insn, &instr[i]))
 			return;
 
+		/*
+		 * See if this and any potentially following NOPs can be
+		 * optimized.
+		 */
 		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
-			break;
-
-		if ((i += insn.length) >= a->instrlen)
-			return;
-	}
+			i += optimize_nops_range(instr, a->instrlen, i);
+		else
+			i += insn.length;
 
-	for (nop = i; i < a->instrlen; i++) {
-		if (WARN_ONCE(instr[i] != 0x90, "Not a NOP at 0x%px\n", &instr[i]))
+		if (i >= a->instrlen)
 			return;
 	}
-
-	local_irq_save(flags);
-	add_nops(instr + nop, i - nop);
-	local_irq_restore(flags);
-
-	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
-		   instr, nop, a->instrlen);
 }
 
 /*
