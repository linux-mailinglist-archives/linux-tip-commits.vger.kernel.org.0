Return-Path: <linux-tip-commits+bounces-4094-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A703BA57DDE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6416D702
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB917A5BD;
	Sat,  8 Mar 2025 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FuaDFJ3B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5amJJz8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2641392;
	Sat,  8 Mar 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741463475; cv=none; b=f1D5p8AksdK930ifUItDXrgze9T3ap4Spbb6Ke2ZkNwNgcn/+mwfxIkcub/Cu7UgvATJo6AImc9Y9pQQ6N5KiTk6vFtVURAbBoyDrRi3d0TqRdP1rX9JTQ0fyRVcvvXrrtkqruDOoyE/GRP2lMH/45aCoYN33CYBDnRjAQRoLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741463475; c=relaxed/simple;
	bh=Cv9w6j1wkUGMGsL8WPaA8N2nNTPKr3doitguBpOz9L4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z2yMlNEv77AeA1qCOHHCwtK5PQi0i8VN3oHcDXXjz3sR4WolhPuP0QPdFQFSInFrGxGF3DyS+nXkD637FtmBTynuqJ+latrvueAGdEONS7rJSEIwtfSEG+EmS2u5I789KP6a4uxE1VNnVKdsXdBr7SXbtpgc5n5/6ESh0V91PJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FuaDFJ3B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5amJJz8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 19:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741463471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6KyjsVOfXSso1sQaltrCCGA6dJuEPH4J7hFkk+58wU=;
	b=FuaDFJ3B8ZrX5QRKDiqwMnQkhE09ufiv9pD3JIhCwQHlvacQlwq5/DpiQwR5FQbqJn7psz
	WRcrDDKttfJ9IS6MChPL/4inIDEQiUJ8oYksxpJb5Vp4Q2+VfLsYu2vHO6sOzV33SUEY1/
	ip5nkpabzx28uD+eyM/pPaQAJuZ3ru2aXB003Z6MlKcMiq1yljG6BSMmL5rjrGv/siwFpv
	fpwyoQE2yyC1Zj9MZ8R9V6FSwgdD+lJWYVOPTKJU17R/lkcuiHUAgt+YBwLOPJLEmao15L
	417iib7eIOFwM9PffNUfxd/QB5hv10BKHRSj4sX+ZLlAhMtlQ7d4WqOrod2TlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741463471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6KyjsVOfXSso1sQaltrCCGA6dJuEPH4J7hFkk+58wU=;
	b=L5amJJz8MhWmL1VFRR+A6nid6SlJogfpCPJM79wEAXDyxeQmRG1m1MXMCVWVwpT4O/uywT
	KYXwJ2y01jsJ0MAg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Do not test if AC and ID eflags are
 changeable on x86_64
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Brian Gerst <brgerst@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307091022.181136-1-ubizjak@gmail.com>
References: <20250307091022.181136-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174146346999.14745.5356641328543778517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     558fc8e1869ca6e1eb99a1e2b52f6c35424d4adf
Gitweb:        https://git.kernel.org/tip/558fc8e1869ca6e1eb99a1e2b52f6c35424d4adf
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 07 Mar 2025 10:10:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 20:36:26 +01:00

x86/boot: Do not test if AC and ID eflags are changeable on x86_64

The test for the changeabitily of AC and ID EFLAGS is used to
distinguish between i386 and i486 processors (AC) and to test
for CPUID instruction support (ID).

Skip these tests on x86_64 processors as they always supports CPUID.

Also change the return type of has_eflag() to bool.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20250307091022.181136-1-ubizjak@gmail.com
---
 arch/x86/boot/cpuflags.c | 26 +++++++++-----------------
 arch/x86/boot/cpuflags.h |  6 +++++-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237b..2150a01 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -29,40 +29,32 @@ static int has_fpu(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
+#ifdef CONFIG_X86_32
 /*
  * For building the 16-bit code we want to explicitly specify 32-bit
  * push/pop operations, rather than just saying 'pushf' or 'popf' and
- * letting the compiler choose. But this is also included from the
- * compressed/ directory where it may be 64-bit code, and thus needs
- * to be 'pushfq' or 'popfq' in that case.
+ * letting the compiler choose.
  */
-#ifdef __x86_64__
-#define PUSHF "pushfq"
-#define POPF "popfq"
-#else
-#define PUSHF "pushfl"
-#define POPF "popfl"
-#endif
-
-int has_eflag(unsigned long mask)
+bool has_eflag(unsigned long mask)
 {
 	unsigned long f0, f1;
 
-	asm volatile(PUSHF "	\n\t"
-		     PUSHF "	\n\t"
+	asm volatile("pushfl	\n\t"
+		     "pushfl	\n\t"
 		     "pop %0	\n\t"
 		     "mov %0,%1	\n\t"
 		     "xor %2,%1	\n\t"
 		     "push %1	\n\t"
-		     POPF "	\n\t"
-		     PUSHF "	\n\t"
+		     "popfl	\n\t"
+		     "pushfl	\n\t"
 		     "pop %1	\n\t"
-		     POPF
+		     "popfl"
 		     : "=&r" (f0), "=&r" (f1)
 		     : "ri" (mask));
 
 	return !!((f0^f1) & mask);
 }
+#endif
 
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
 {
diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index fdcc2aa..a398d92 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -15,7 +15,11 @@ struct cpu_features {
 extern struct cpu_features cpu;
 extern u32 cpu_vendor[3];
 
-int has_eflag(unsigned long mask);
+#ifdef CONFIG_X86_32
+bool has_eflag(unsigned long mask);
+#else
+static inline bool has_eflag(unsigned long mask) { return true; }
+#endif
 void get_cpuflags(void);
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
 bool has_cpuflag(int flag);

