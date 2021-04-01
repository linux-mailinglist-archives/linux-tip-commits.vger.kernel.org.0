Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8183519F3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhDAR5J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbhDARxQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:53:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED2BC00F7E5;
        Thu,  1 Apr 2021 08:09:01 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjRFEWz5jlKzHFAwL9EZIVomiKiocU9NSXbM4K7hlx4=;
        b=giz6qPpYLdbLdveNYdDifusuwujUoXE7bif7IeWkxpD7/t/kR6Y3KhqxRkwiyRfRcdyHpL
        nIYXugQYWXUTR7Z9t4JEAsf0A93dzZyKCthPsGAgWwLFL5Vv2HLdXCxoyEt6dStn/Fthxk
        iRnFGwkK8C5CsrgX7Bhacx66UqIPIGsaeQtk7tZdTUgQ9WTbmPU2qncG3X9ykzMe/DdahG
        R0WqHchZunDbDnjT5Y9ffdvAdCpyEHNrCK7eK4bTCwkWoyDREIs/6UI3oXmz7m26mgyDrL
        aBSvMa/qZHN89aqQY5kr3JRuwvy1Oo7QuolMTuzRyNr6IQM8fXVgJOzGqZDY+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjRFEWz5jlKzHFAwL9EZIVomiKiocU9NSXbM4K7hlx4=;
        b=rCeheSiSNBPpEpOitW/pZejRj2O/xFvCJbMy9L+8JIWGSHFwuEw+uG4+1gaeabM2k+bO4P
        bPwJAUDKxa9uPoBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Add insn_decode_kernel()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.379242587@infradead.org>
References: <20210326151259.379242587@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973932.29796.17464770652549935291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     52fa82c21f64e900a72437269a5cc9e0034b424e
Gitweb:        https://git.kernel.org/tip/52fa82c21f64e900a72437269a5cc9e0034b424e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:00 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 31 Mar 2021 16:20:22 +02:00

x86: Add insn_decode_kernel()

Add a helper to decode kernel instructions; there's no point in
endlessly repeating those last two arguments.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210326151259.379242587@infradead.org
---
 arch/x86/include/asm/insn.h        | 2 ++
 arch/x86/kernel/alternative.c      | 2 +-
 arch/x86/kernel/cpu/mce/severity.c | 2 +-
 arch/x86/kernel/kprobes/core.c     | 4 ++--
 arch/x86/kernel/kprobes/opt.c      | 2 +-
 arch/x86/kernel/traps.c            | 2 +-
 tools/arch/x86/include/asm/insn.h  | 2 ++
 7 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index f03b6ca..05a6ab9 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -150,6 +150,8 @@ enum insn_mode {
 
 extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
+#define insn_decode_kernel(_insn, _ptr) insn_decode((_insn), (_ptr), MAX_INSN_SIZE, INSN_MODE_KERN)
+
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ce28c5c..ff359b3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1280,7 +1280,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	if (!emulate)
 		emulate = opcode;
 
-	ret = insn_decode(&insn, emulate, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, emulate);
 
 	BUG_ON(ret < 0);
 	BUG_ON(len != insn.length);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index a2136ce..abdd2e4 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -225,7 +225,7 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
 		return false;
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index dd09021..1319ff4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -285,7 +285,7 @@ static int can_probe(unsigned long paddr)
 		if (!__addr)
 			return 0;
 
-		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
+		ret = insn_decode_kernel(&insn, (void *)__addr);
 		if (ret < 0)
 			return 0;
 
@@ -322,7 +322,7 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 			MAX_INSN_SIZE))
 		return 0;
 
-	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(insn, dest);
 	if (ret < 0)
 		return 0;
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 4299fc8..71425eb 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -324,7 +324,7 @@ static int can_optimize(unsigned long paddr)
 		if (!recovered_insn)
 			return 0;
 
-		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
+		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
 		if (ret < 0)
 			return 0;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a5d2540..034f27f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -504,7 +504,7 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
 		return GP_NO_HINT;
 
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index c9f3eee..dc632b4 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -150,6 +150,8 @@ enum insn_mode {
 
 extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
+#define insn_decode_kernel(_insn, _ptr) insn_decode((_insn), (_ptr), MAX_INSN_SIZE, INSN_MODE_KERN)
+
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
 {
