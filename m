Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9264F28635F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgJGQO4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgJGQOx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:14:53 -0400
Date:   Wed, 07 Oct 2020 16:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekQmDJ6SkMzxWz0mhUkFm+pIF6HNEMBNCXeIKiPmXLM=;
        b=H/2uzxegaWZfe4ZjGTSzU/Vodq8VxCjEe3OzxVbUKya/IBy+63Vzf+WHOXOcWVd9GmRXZL
        3XKQ188ZSfn85CRV3qaoRLtQWF/jOoiNtxKnl4/dkr1iCZtCKnyNDFoMhbsoNLhefw0m/y
        LPAhEJpaT0OyI+7UJFxf1EeaHz9M22RSbFNKukdh/GOZbfFXObth4MNuKWfsttfP/e0aO3
        9hLDWZEG/9WU+eet9gXe6u7WtdsgE13nCmys2Bv3Znumvn35eSg1ZdlQgBKFZXmBEA/4LE
        DLN/GXFcDnT+oGpIXHaoAQ/oug7NN0o47c1f5MBQN+xncEqIzFkWrI07xAsQCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekQmDJ6SkMzxWz0mhUkFm+pIF6HNEMBNCXeIKiPmXLM=;
        b=aJI1WZfsAHGjnCwYffS4evMM1mtlImkynG8in90p5pWwdcwYAEYyLuio7a/r8ephbO5ZmI
        cM6ngTIjnKl/leDQ==
From:   "tip-bot2 for Dave Jiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/asm: Carve out a generic movdir64b() helper for
 general usage
Cc:     Michael Matz <matz@suse.de>, Dave Jiang <dave.jiang@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005151126.657029-2-dave.jiang@intel.com>
References: <20201005151126.657029-2-dave.jiang@intel.com>
MIME-Version: 1.0
Message-ID: <160208728972.7002.18130814269550766361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     0888e1030d3e3e5ce9dfd8e030cf13a2e9a1519a
Gitweb:        https://git.kernel.org/tip/0888e1030d3e3e5ce9dfd8e030cf13a2e9a1519a
Author:        Dave Jiang <dave.jiang@intel.com>
AuthorDate:    Mon, 05 Oct 2020 08:11:22 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 17:49:25 +02:00

x86/asm: Carve out a generic movdir64b() helper for general usage

Carve out the MOVDIR64B inline asm primitive into a generic helper so
that it can be used by other functions. Move it to special_insns.h and
have iosubmit_cmds512() call it.

 [ bp: Massage commit message. ]

Suggested-by: Michael Matz <matz@suse.de>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201005151126.657029-2-dave.jiang@intel.com
---
 arch/x86/include/asm/io.h            | 17 +++--------------
 arch/x86/include/asm/special_insns.h | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e1aa17a..d726459 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -401,7 +401,7 @@ extern bool phys_mem_access_encrypted(unsigned long phys_addr,
 
 /**
  * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
- * @__dst: destination, in MMIO space (must be 512-bit aligned)
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
  * @src: source
  * @count: number of 512 bits quantities to submit
  *
@@ -412,25 +412,14 @@ extern bool phys_mem_access_encrypted(unsigned long phys_addr,
  * Warning: Do not use this helper unless your driver has checked that the CPU
  * instruction is supported on the platform.
  */
-static inline void iosubmit_cmds512(void __iomem *__dst, const void *src,
+static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
 				    size_t count)
 {
-	/*
-	 * Note that this isn't an "on-stack copy", just definition of "dst"
-	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
-	 * In the MOVDIR64B case that may be needed as you can use the
-	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
-	 * lets the compiler know how much gets clobbered.
-	 */
-	volatile struct { char _[64]; } *dst = __dst;
 	const u8 *from = src;
 	const u8 *end = from + count * 64;
 
 	while (from < end) {
-		/* MOVDIR64B [rdx], rax */
-		asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
-			     : "=m" (dst)
-			     : "d" (from), "a" (dst));
+		movdir64b(dst, from);
 		from += 64;
 	}
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13..d4baa0e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,28 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+/* The dst parameter must be 64-bytes aligned */
+static inline void movdir64b(void *dst, const void *src)
+{
+	const struct { char _[64]; } *__src = src;
+	struct { char _[64]; } *__dst = dst;
+
+	/*
+	 * MOVDIR64B %(rdx), rax.
+	 *
+	 * Both __src and __dst must be memory constraints in order to tell the
+	 * compiler that no other memory accesses should be reordered around
+	 * this one.
+	 *
+	 * Also, both must be supplied as lvalues because this tells
+	 * the compiler what the object is (its size) the instruction accesses.
+	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
+	 */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     : "+m" (*__dst)
+		     :  "m" (*__src), "a" (__dst), "d" (__src));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
