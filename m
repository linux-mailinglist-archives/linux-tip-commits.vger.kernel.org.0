Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFA3993DE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Jun 2021 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFBTvM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Jun 2021 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFBTvL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Jun 2021 15:51:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B855C06174A;
        Wed,  2 Jun 2021 12:49:23 -0700 (PDT)
Date:   Wed, 02 Jun 2021 19:49:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622663361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lp2Y5wx0iqo2HC0iRocMtGYFHQn2iXsaY+8jbxG4AA=;
        b=B45GbaCL7mw5ULKgwWxEtF8fSrDM4pCRTtI/viVyWlt0g/fq2m0Ar7jStphVufr/M+rO8b
        JWKUZ2coQgROFLptBXmjbyevEw7cdCuN628wxwEKlsyigiZRKMsWG+ghpULZMVYkQXG/Kz
        AQJLeeZ4pzlWI2SwxBeS2cB6LQMkvqlmX0R62X0IzS+nZ5r9HqMtIQyAP9bctoSvhhZWW1
        MH9q3pFPqEUCDYkI9lLFPk5ODpUhDYOdfB6vjtfXBQK95T7BA7V2zcE9K5N24agZrEY+xG
        8Metfw6BapIW8yXcFbXk6FyH/TtTGVaiZRnMb6MDmT2ceNSS8q7SVyU9RF/rZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622663361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lp2Y5wx0iqo2HC0iRocMtGYFHQn2iXsaY+8jbxG4AA=;
        b=Om8loLBwyDtqWmvydcHLo3o3C8YJfnd0b1plK1AR8jj5kympgta1xsTUsxAnOIMRwE7Oiq
        N/WMhLWuJWwnX2BQ==
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
Message-ID: <162266336021.29796.17637756185975839432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f01775b09efa3b9d1f4a2519678f11d274362da9
Gitweb:        https://git.kernel.org/tip/f01775b09efa3b9d1f4a2519678f11d274362da9
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 01 Jun 2021 17:51:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Jun 2021 12:36:07 +02:00

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
