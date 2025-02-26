Return-Path: <linux-tip-commits+bounces-3681-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1FA45FD1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB44166C4F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E292218AB7;
	Wed, 26 Feb 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xVKm85Kb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbEXdykV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3951DF990;
	Wed, 26 Feb 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574480; cv=none; b=fuTAIboiLtuWIi46aAgyWsTNaF+qvg8pmb/VcWLl8zdA7HJzT+UhslG/LvXLOfCr8vs+MkYMX3BYQOX3aDkrz3i7nO9ppTqA5TavrL0q6YYcXczDC2kt8gCs7rdbl/bvOxQDnPpVig7FJGZXe9hUCveL/Lnn8ydRULP4dBwXKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574480; c=relaxed/simple;
	bh=8pv4RUUkDhbNy+4qHg7mdpoS8yc2m0b9M/Z43gQlaMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=soRwTDwRU6nwxBcVmebafHr+jYTagnprJNo4q8HzpBrx2ODFxyuk2hjiWbq4n1uyFgneEpwJSVH28BAiYAQADSx2Qco8p2Pzup1Vny9Kr4pXujRy4H6IbnW8ydkU2VUtOisd0n/3kMBRHwtw75wbHYqQAC0IvAQXV763MCqWsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xVKm85Kb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbEXdykV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740574476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIUXEkY0A0t1HoVPQbmbgORGiJM7SDaggTzdqyU81/A=;
	b=xVKm85KbG/JwwUJdk9r+MBKwM/HrsI8Gv03r6/WTxwjQJRrhxY9/Xi6x/ix4J2VIzmdzJx
	vaY90R4sE8g4fLMd1sk1UlDD0uJH1auInQ+rtA0ofh+3t5pSvD0ZB3SQRMo638qlOX/J4V
	UOLEglgPBJb5j6feAqkTrUWcpzXf+njoHBN8WVH2UPL0uGjqOqjUED1XzwyTBXZc90Xhmn
	6GLvLsRdY+FpWRXt5k1he1Xa/sJgaHa/ASvmCha7sq7lDQK59Z744/UN7CQPh5GJ00jipz
	4VI/Sa51KboRMseNg0dtCsyB0+44sfazAhodS0UnmFZ20/Zig+QSMl3on5xJzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740574476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIUXEkY0A0t1HoVPQbmbgORGiJM7SDaggTzdqyU81/A=;
	b=ZbEXdykVlEVCHmg8SuyQ2QKtttF7tA9D4F40hk5pJvzqmYuCd9QxfVnON1pMQLfmHvpR2S
	8oA80HyXibVX+WDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bhi: Add BHI stubs
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.717378681@infradead.org>
References: <20250224124200.717378681@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057447611.10177.16167426753225126743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b815f6877d8063482fe745f098eeef632679aa8a
Gitweb:        https://git.kernel.org/tip/b815f6877d8063482fe745f098eeef632679aa8a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:48:52 +01:00

x86/bhi: Add BHI stubs

Add an array of code thunks, to be called from the FineIBT preamble,
clobbering the first 'n' argument registers for speculative execution.

Notably the 0th entry will clobber no argument registers and will never
be used, it exists so the array can be naturally indexed, while the 7th
entry will clobber all the 6 argument registers and also RSP in order to
mess up stack based arguments.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.717378681@infradead.org
---
 arch/x86/include/asm/cfi.h |   4 +-
 arch/x86/lib/Makefile      |   3 +-
 arch/x86/lib/bhi.S         | 147 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/lib/bhi.S

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 7dd5ab2..7c15c4b 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -101,6 +101,10 @@ enum cfi_mode {
 
 extern enum cfi_mode cfi_mode;
 
+typedef u8 bhi_thunk[32];
+extern bhi_thunk __bhi_args[];
+extern bhi_thunk __bhi_args_end[];
+
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8a59c61..f453507 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -66,5 +66,6 @@ endif
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o copy_user_uncached_64.o
-	lib-y += cmpxchg16b_emu.o
+        lib-y += cmpxchg16b_emu.o
+        lib-y += bhi.o
 endif
diff --git a/arch/x86/lib/bhi.S b/arch/x86/lib/bhi.S
new file mode 100644
index 0000000..5889168
--- /dev/null
+++ b/arch/x86/lib/bhi.S
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/unwind_hints.h>
+#include <asm/nospec-branch.h>
+
+/*
+ * Notably, the FineIBT preamble calling these will have ZF set and r10 zero.
+ *
+ * The very last element is in fact larger than 32 bytes, but since its the
+ * last element, this does not matter,
+ *
+ * There are 2 #UD sites, located between 0,1-2,3 and 4,5-6,7 such that they
+ * can be reached using Jcc.d8, these elements (1 and 5) have sufficiently
+ * big alignment holes for this to not stagger the array.
+ */
+
+.pushsection .noinstr.text, "ax"
+
+	.align 32
+SYM_CODE_START(__bhi_args)
+
+#ifdef CONFIG_FINEIBT_BHI
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_1, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	cmovne %r10, %rdi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+	ANNOTATE_REACHABLE
+.Lud_1:	ud2
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_2, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_3, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_1
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_4, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_5, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 8
+	ANNOTATE_REACHABLE
+.Lud_2:	ud2
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_6, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_7, SYM_L_LOCAL)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	jne .Lud_2
+	cmovne %r10, %rdi
+	cmovne %r10, %rsi
+	cmovne %r10, %rdx
+	cmovne %r10, %rcx
+	cmovne %r10, %r8
+	cmovne %r10, %r9
+	cmovne %r10, %rsp
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+#endif /* CONFIG_FINEIBT_BHI */
+
+	.align 32
+SYM_INNER_LABEL(__bhi_args_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	nop /* Work around toolchain+objtool quirk */
+SYM_CODE_END(__bhi_args)
+
+.popsection

