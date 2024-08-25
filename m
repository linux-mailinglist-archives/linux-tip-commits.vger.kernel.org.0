Return-Path: <linux-tip-commits+bounces-2118-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D8095E494
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528EBB21061
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1F16F826;
	Sun, 25 Aug 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQH9gsK1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0n3bUVhw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA5210FB;
	Sun, 25 Aug 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724606927; cv=none; b=JgTb9MxRzTmeBM8yfEmJ3ra3ERe+4oSjT0pNs4hfe8swruhizUeoI2/CgUJ1z7Bf+xzM0xZnya/mpsi0PjjVHUNAN/i+zIKP3NMWwfrbGa0Xp5MdsHSUTrK4n6lXXtsbZ61ZU+uzSx2/1pHchsYtAIra8dYJaWsx32QOzjQp/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724606927; c=relaxed/simple;
	bh=FsgwyLrgAo9CFwXDvDhoJnNRgV+FIe0rtgQ2utURzGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G4J/R16kPq6OCE/CHq5vS0geUzIhuVOnSsg68KsVh9YbcFnkTZBpKxwor3F8CQHYWtvF+3XxuRJjQW7iMdT8nShguDOCpqzeTHuTb4B7CmeN/DLuIVi4FEa0EeGanOiiaerYSxI39Vl0lW7UktdLEcCrTTBi2lwRqAWKRYCVjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQH9gsK1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0n3bUVhw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 17:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724606923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35VSso7nNeiPqH4Xj+YlAt3VqzcZGMTOm8d2fczYNGM=;
	b=LQH9gsK1UZ1alL6qrstC/7eZnjGct00ynbSIcdXdQF28Ii2M8/xgE4J7pRsMUtcjK774DE
	p3+lskSH8cUJB9OeNAiWXqQw2axTUGPZmy0NtdcQX+xgMuV2fJVlm7av8iCPcCxcDansWl
	qcICHUsaEpAGNngxkzembn1jym6/DnodL71kRAt5bJThh4mi7DvwvRkBn+TTIiOG44JJY3
	1e3sWkjwh/yp+0OVLFCrQXvbsK3TtuG5zmWRgsCzLknmMGnALTMxYGW0yxZ/M5dKSBcv78
	0cuDqoV0u2gLD2Ynswo/wbPIKzKPgXMJ+odGdnLD0UK5dLNC4/9oKqYb4MrKNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724606923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35VSso7nNeiPqH4Xj+YlAt3VqzcZGMTOm8d2fczYNGM=;
	b=0n3bUVhw3rCLVYYMtITLvLIiynMmSN0R5ONSQjSazOUVBDYNbXTyLnSbOau164WwL8kU1R
	bPKGn83S56xJJUBQ==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240822073906.2176342-3-xin@zytor.com>
References: <20240822073906.2176342-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172460692260.2215.4975871459534263871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     efe508816d2caf83536ff2f308e09043380fb2b7
Gitweb:        https://git.kernel.org/tip/efe508816d2caf83536ff2f308e09043380fb2b7
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Thu, 22 Aug 2024 00:39:05 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 19:23:00 +02:00

x86/msr: Switch between WRMSRNS and WRMSR with the alternatives mechanism

Per the discussion about FRED MSR writes with WRMSRNS instruction [1],
use the alternatives mechanism to choose WRMSRNS when it's available,
otherwise fallback to WRMSR.

Remove the dependency on X86_FEATURE_WRMSRNS as WRMSRNS is no longer
dependent on FRED.

[1] https://lore.kernel.org/lkml/15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com/

Use DS prefix to pad WRMSR instead of a NOP. The prefix is ignored. At
least that's the current information from the hardware folks.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240822073906.2176342-3-xin@zytor.com

---
 arch/x86/include/asm/msr.h       | 25 +++++++++++--------------
 arch/x86/include/asm/switch_to.h |  1 -
 arch/x86/kernel/cpu/cpuid-deps.c |  1 -
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d642037..0018535 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -99,19 +99,6 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
-/*
- * WRMSRNS behaves exactly like WRMSR with the only difference being
- * that it is not a serializing instruction by default.
- */
-static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
-{
-	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
-	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
-		     "2:\n"
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a"(low), "d" (high));
-}
-
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
 	u64 __val = __rdmsr((msr));			\
@@ -312,9 +299,19 @@ do {							\
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
+/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
+#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
+
+/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
 static __always_inline void wrmsrns(u32 msr, u64 val)
 {
-	__wrmsrns(msr, val, val >> 32);
+	/*
+	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
+	 * DS prefix to avoid a trailing NOP.
+	 */
+	asm volatile("1: " ALTERNATIVE("ds wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS)
+		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
 }
 
 /*
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c3bd0c0..e9ded14 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,7 +71,6 @@ static inline void update_task_stack(struct task_struct *task)
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		/* WRMSRNS is a baseline feature for FRED. */
 		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
 	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		/* Xen PV enters the kernel on the thread stack. */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f53..8bd8411 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -83,7 +83,6 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
-	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
 

