Return-Path: <linux-tip-commits+bounces-5171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E6AA6D9F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540514C0A45
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA27267713;
	Fri,  2 May 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7kZ1eSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rnx9YwdZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987F246792;
	Fri,  2 May 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176672; cv=none; b=srK8j+UlVSXtFD8pI4i7IVayy9DDhiXmHA3Z1xYoB2rrp7pfmY8EwM+FtLPSN3a3rjEVvS/jYOlZUew2TfBTaWqCkRsWGZJjAB0c1PeF5YSf+JabWXpDZAJ5sqc0G8v6YeY2byVVlFLagp3N2KhGc338Tn/B/VYpj/pRiSzUx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176672; c=relaxed/simple;
	bh=RWzZYwzlUx7IrMbP4+6VrYVj/En9mmm7JCswSe/X8xY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hUmlf3U5FSuxk9Rh1fcWif4rFU9F5MuN49yKCUWkQQA/T2mjryc/juyf+CrZPHQSpOZs50dctBqFZfiTVxoFPiVY8QBWZeGKdkg1yqxaOIXeG0EUYZU/6dGrR8HW/PtQsOGVPBXIgeiYtkwC8/2Ghu++GyDXs3w5Rsc5hPtXpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q7kZ1eSe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rnx9YwdZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JQfFU1+hKfdp/gBbMgUd6tqjRUDw3+YagjRlpm0wME=;
	b=q7kZ1eSeMy6Ugbqm3RmCRsVi4X0w8pxHbeunwc5ozWYTCRAnocr0K78SfDZyL/PkaYp8fQ
	WXBXF721mu9mc/w1f9nhfGq2IV5VsvWN15LjGkoiBGHYW2tyY3d1y4oRKKXM3uuyEM6h3n
	4oTdFxPL2w9XqWpMFw1wut43wzlyZXUEYsxThb1Q+JCoRMMEAYVuigqSHQEgf4lXVWVxLw
	NbNcioePwRe4kJayOjcB/iMLz8OUFbPE8NW+5H0PurfVRrha0v+exJcrBDawUtEfTArcMa
	l5h1NWPXO82DLsAZnApGK/sn5aa6Uje4MyhNtuskR503WplXb7AyNzDN9R7X4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JQfFU1+hKfdp/gBbMgUd6tqjRUDw3+YagjRlpm0wME=;
	b=Rnx9YwdZ+5T0wyhA1ByH6d16mIU6i8n3EMIvuoNDbbyZ0gMpJg3T5NFbC6jxFBx9tNtUrl
	s1xUtLlL2SH/TQBw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Move rdtsc{,_ordered}() to <asm/tsc.h>
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-3-xin@zytor.com>
References: <20250427092027.1598740-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666745.22196.15200555517786851071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     288a4ff0ad29d1a9391b8a111a4b6da51da3aa85
Gitweb:        https://git.kernel.org/tip/288a4ff0ad29d1a9391b8a111a4b6da51da3aa85
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 02 May 2025 10:20:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:24:39 +02:00

x86/msr: Move rdtsc{,_ordered}() to <asm/tsc.h>

Relocate rdtsc{,_ordered}() from <asm/msr.h> to <asm/tsc.h>.

[ mingo: Do not remove the <asm/tsc.h> inclusion from <asm/msr.h>
         just yet, to reduce -next breakages. We can do this later
	 on, separately, shortly before the next -rc1. ]

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-3-xin@zytor.com
---
 arch/x86/include/asm/msr.h | 54 +------------------------------------
 arch/x86/include/asm/tsc.h | 55 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 35a78d2..f5c0969 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -153,60 +153,6 @@ native_write_msr_safe(u32 msr, u32 low, u32 high)
 extern int rdmsr_safe_regs(u32 regs[8]);
 extern int wrmsr_safe_regs(u32 regs[8]);
 
-/**
- * rdtsc() - returns the current TSC without ordering constraints
- *
- * rdtsc() returns the result of RDTSC as a 64-bit integer.  The
- * only ordering constraint it supplies is the ordering implied by
- * "asm volatile": it will put the RDTSC in the place you expect.  The
- * CPU can and will speculatively execute that RDTSC, though, so the
- * results can be non-monotonic if compared on different CPUs.
- */
-static __always_inline u64 rdtsc(void)
-{
-	EAX_EDX_DECLARE_ARGS(val, low, high);
-
-	asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
-
-	return EAX_EDX_VAL(val, low, high);
-}
-
-/**
- * rdtsc_ordered() - read the current TSC in program order
- *
- * rdtsc_ordered() returns the result of RDTSC as a 64-bit integer.
- * It is ordered like a load to a global in-memory counter.  It should
- * be impossible to observe non-monotonic rdtsc_unordered() behavior
- * across multiple CPUs as long as the TSC is synced.
- */
-static __always_inline u64 rdtsc_ordered(void)
-{
-	EAX_EDX_DECLARE_ARGS(val, low, high);
-
-	/*
-	 * The RDTSC instruction is not ordered relative to memory
-	 * access.  The Intel SDM and the AMD APM are both vague on this
-	 * point, but empirically an RDTSC instruction can be
-	 * speculatively executed before prior loads.  An RDTSC
-	 * immediately after an appropriate barrier appears to be
-	 * ordered as a normal load, that is, it provides the same
-	 * ordering guarantees as reading from a global memory location
-	 * that some other imaginary CPU is updating continuously with a
-	 * time stamp.
-	 *
-	 * Thus, use the preferred barrier on the respective CPU, aiming for
-	 * RDTSCP as the default.
-	 */
-	asm volatile(ALTERNATIVE_2("rdtsc",
-				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
-				   "rdtscp", X86_FEATURE_RDTSCP)
-			: EAX_EDX_RET(val, low, high)
-			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
-			:: "ecx");
-
-	return EAX_EDX_VAL(val, low, high);
-}
-
 static inline u64 native_read_pmc(int counter)
 {
 	EAX_EDX_DECLARE_ARGS(val, low, high);
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 94408a7..4f7f09f 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -5,10 +5,65 @@
 #ifndef _ASM_X86_TSC_H
 #define _ASM_X86_TSC_H
 
+#include <asm/asm.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
 
+/**
+ * rdtsc() - returns the current TSC without ordering constraints
+ *
+ * rdtsc() returns the result of RDTSC as a 64-bit integer.  The
+ * only ordering constraint it supplies is the ordering implied by
+ * "asm volatile": it will put the RDTSC in the place you expect.  The
+ * CPU can and will speculatively execute that RDTSC, though, so the
+ * results can be non-monotonic if compared on different CPUs.
+ */
+static __always_inline u64 rdtsc(void)
+{
+	EAX_EDX_DECLARE_ARGS(val, low, high);
+
+	asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
+
+	return EAX_EDX_VAL(val, low, high);
+}
+
+/**
+ * rdtsc_ordered() - read the current TSC in program order
+ *
+ * rdtsc_ordered() returns the result of RDTSC as a 64-bit integer.
+ * It is ordered like a load to a global in-memory counter.  It should
+ * be impossible to observe non-monotonic rdtsc_unordered() behavior
+ * across multiple CPUs as long as the TSC is synced.
+ */
+static __always_inline u64 rdtsc_ordered(void)
+{
+	EAX_EDX_DECLARE_ARGS(val, low, high);
+
+	/*
+	 * The RDTSC instruction is not ordered relative to memory
+	 * access.  The Intel SDM and the AMD APM are both vague on this
+	 * point, but empirically an RDTSC instruction can be
+	 * speculatively executed before prior loads.  An RDTSC
+	 * immediately after an appropriate barrier appears to be
+	 * ordered as a normal load, that is, it provides the same
+	 * ordering guarantees as reading from a global memory location
+	 * that some other imaginary CPU is updating continuously with a
+	 * time stamp.
+	 *
+	 * Thus, use the preferred barrier on the respective CPU, aiming for
+	 * RDTSCP as the default.
+	 */
+	asm volatile(ALTERNATIVE_2("rdtsc",
+				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
+				   "rdtscp", X86_FEATURE_RDTSCP)
+			: EAX_EDX_RET(val, low, high)
+			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
+			:: "ecx");
+
+	return EAX_EDX_VAL(val, low, high);
+}
+
 /*
  * Standard way to access the cycle counter.
  */

