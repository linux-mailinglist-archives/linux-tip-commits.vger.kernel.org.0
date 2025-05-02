Return-Path: <linux-tip-commits+bounces-5176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6BAA6DAD
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721644C07F8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222D26AA8F;
	Fri,  2 May 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jiu2uwuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzgG5GFX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845B2690CC;
	Fri,  2 May 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176675; cv=none; b=FRMm8d2V+tz76Yeys7EyPZJ+vAVozJePafyEzxY9N6T2UBT7tHf5smFcse/7EuWRbWZ4P5J3c90sP0nv2MUtD1lJEpANZTQTrOmBisivw/8bT20SDTA75PqWSzb2yjcV41duS2H48xV2xrY7erKKwl5YfOzY5nHysmVRPCrAXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176675; c=relaxed/simple;
	bh=qsjLoGLKx7/EfAt7Fpy5n52uXeF+kK36JqvZEcFOno0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uYO/Nw/3AsgrPqbOFGvX5umoa5hVtzeWxYbiIrBnsTKLYNjuMAuA75PhMpWZFA0wTZl+QSpTWo6ThlZaYWdpcCPWNVQpGhzUSvytwUtyhdb1mRv15GE5k4MOy2rTqVWISO5cLaBj5Kkooh7xgEMcWFtgxqcinMigwMP2dOpkrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jiu2uwuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzgG5GFX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Je0gKWWrsM6qLzgZTu2Y5+U0+Nna6+DXrgiHboyP0dM=;
	b=jiu2uwuj3SbM68g4ON8PKi01OcupxEepdQegBFXuW0zWjMQcMlv0wVnUXUw84i69iCnipn
	ueghAHk5yWf6c8HRYa1jfY1Un/4MYbyursCsjuDsIpfcgabilIVDMOlkQWQS4TIvvZ0+sL
	6Z9dPTIp7Y/s0u8hc4Xb844WDiMbt7uwslspiQtvNizTyM1Ta8hUwiOZKoY/qjttBTypo5
	gY0c+RcSGDI+LiuRug3GmhaEexXD8HkGCnY+8B5HgXHfViniRWSWA7AfsZr52asljcd4bA
	SVmiIw08YgCkub6yAgOXzSmZE55yud3p9eCkaRaCqxcE4TFmZLEAn4SftCexPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Je0gKWWrsM6qLzgZTu2Y5+U0+Nna6+DXrgiHboyP0dM=;
	b=vzgG5GFX/DBKybMQqIvjNqitLE/7Q6eaYW0pGOi87kI7G4o45HYDKCg9mzv3sKP+UQtO6u
	/JnuR1zoNhRbADBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/merge] x86/msr: Rename DECLARE_ARGS() to EAX_EDX_DECLARE_ARGS
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666993.22196.2729172970704358674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     c9d8ea9d53d4ddb80f2ad2bca5b9e9e40fcb9b16
Gitweb:        https://git.kernel.org/tip/c9d8ea9d53d4ddb80f2ad2bca5b9e9e40fcb9b16
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 02 May 2025 10:08:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:11:17 +02:00

x86/msr: Rename DECLARE_ARGS() to EAX_EDX_DECLARE_ARGS

DECLARE_ARGS() is way too generic of a name that says very little about
why these args are declared in that fashion - use the EAX_EDX_ prefix
to create a common prefix between the three helper methods:

	EAX_EDX_DECLARE_ARGS()
	EAX_EDX_VAL()
	EAX_EDX_RET()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/msr.h     | 14 +++++++-------
 arch/x86/kernel/cpu/mce/core.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 27bc0b5..d57a94c 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -46,11 +46,11 @@ struct saved_msrs {
  * clearing the high half of 'low':
  */
 #ifdef CONFIG_X86_64
-# define DECLARE_ARGS(val, low, high)	unsigned long low, high
+# define EAX_EDX_DECLARE_ARGS(val, low, high)	unsigned long low, high
 # define EAX_EDX_VAL(val, low, high)		((low) | (high) << 32)
 # define EAX_EDX_RET(val, low, high)		"=a" (low), "=d" (high)
 #else
-# define DECLARE_ARGS(val, low, high)	u64 val
+# define EAX_EDX_DECLARE_ARGS(val, low, high)	u64 val
 # define EAX_EDX_VAL(val, low, high)		(val)
 # define EAX_EDX_RET(val, low, high)		"=A" (val)
 #endif
@@ -83,7 +83,7 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
  */
 static __always_inline u64 __rdmsr(u32 msr)
 {
-	DECLARE_ARGS(val, low, high);
+	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
@@ -129,7 +129,7 @@ static inline u64 native_read_msr(u32 msr)
 
 static inline u64 native_read_msr_safe(u32 msr, int *err)
 {
-	DECLARE_ARGS(val, low, high);
+	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	asm volatile("1: rdmsr ; xor %[err],%[err]\n"
 		     "2:\n\t"
@@ -182,7 +182,7 @@ extern int wrmsr_safe_regs(u32 regs[8]);
  */
 static __always_inline u64 rdtsc(void)
 {
-	DECLARE_ARGS(val, low, high);
+	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
 
@@ -199,7 +199,7 @@ static __always_inline u64 rdtsc(void)
  */
 static __always_inline u64 rdtsc_ordered(void)
 {
-	DECLARE_ARGS(val, low, high);
+	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	/*
 	 * The RDTSC instruction is not ordered relative to memory
@@ -227,7 +227,7 @@ static __always_inline u64 rdtsc_ordered(void)
 
 static inline u64 native_read_pmc(int counter)
 {
-	DECLARE_ARGS(val, low, high);
+	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	asm volatile("rdpmc" : EAX_EDX_RET(val, low, high) : "c" (counter));
 	if (tracepoint_enabled(rdpmc))
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 255927f..7b9908c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -390,7 +390,7 @@ void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 /* MSR access wrappers used for error injection */
 noinstr u64 mce_rdmsrq(u32 msr)
 {
-	DECLARE_ARGS(val, low, high);
+	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	if (__this_cpu_read(injectm.finished)) {
 		int offset;

