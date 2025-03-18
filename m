Return-Path: <linux-tip-commits+bounces-4304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C848A67355
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D1E3BC5A9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7420C49C;
	Tue, 18 Mar 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPi7iiPR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zy+UYUZl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78420C478;
	Tue, 18 Mar 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299212; cv=none; b=AcSoVncnCHKTRbZGBUnXgjBo3SD8mbOmf5q+05Zwz5bxyWg6ioRFU7fHSlIlFJyiu7sqSZxtTes+fRAx5fFTKi4lnNnhbpNyDAPqQ0m82PPUHeNXaPRqyxvTe5jrTamnCl5BrZqkf8LJQakhKtsX1fWvargTZEuTP8gyk1P7VIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299212; c=relaxed/simple;
	bh=PJcEYcg+/fI7SDW/ALy1xeOcVfC0mb8T8XPc5iCSgmM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dteVQ+wffJ0FbbAzsL0c6T7m7xpquIGAuo0drxuZD6Upo4wZQbtnX2OkB1mhhKFmkYpiXQ0dp3VQ+qVlUZ6X+ZzUiHxKIhjVrWCN73ECjBBox4blzYE3ti3PkcDWxFxgw4NMypD/GPbHorDxCyDgJV4Yoyrw4S3rlpffTHgMTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPi7iiPR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zy+UYUZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742299209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7R5n9S1D8x2ERjs1LUaKnpq50ZX+Yq7TxI5HtMMP1cc=;
	b=CPi7iiPRqjwP7R8kVsiX9+KMbY2aYKupxgcU7yK+fTAutJGff0RW1N9JcRwgI+00QDFF98
	oHyGySxMzM7t5G7bRhnp2lI+tMC1Yzcd0/P0vUfXCyWQdD+QtYXeI1AuUp6jkg6ynY7TZ+
	L2/iuKh1HRMRsGM6mD3++UUnEnXct3GgsaOlXDQ8xtMtqTWgs8fJpbbVxios3CML0o3ADr
	kQN8tgI9X2DPLnfy/Yqi2xstns8REn+MLzxpGfqMMBBAq7CU+a1hhgFYwHYXPhhKmKBci2
	ZvJSi3pj6lVlpIou2paKJCRH0X0mJvPTdOCbZ5f/riBNeyGzN+8ktRbgbqQpRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742299209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7R5n9S1D8x2ERjs1LUaKnpq50ZX+Yq7TxI5HtMMP1cc=;
	b=zy+UYUZlLEWNctwbzcmfK6VkCx8acYWDhKAetSek6/A583lBEfqXG4v5GdqVqapenhcdEg
	UqIkA1VUYnvqIMBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Clean up <asm/cpuid/api.h>
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317221824.3738853-4-mingo@kernel.org>
References: <20250317221824.3738853-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174229920796.14745.2870340797932662284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f2f828b547abb37fe60bc3419414c50327b7acff
Gitweb:        https://git.kernel.org/tip/f2f828b547abb37fe60bc3419414c50327b7acff
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 09:35:58 +01:00

x86/cpuid: Clean up <asm/cpuid/api.h>

 - Include <asm/cpuid/types.h> first, as is customary. This also has
   the side effect of build-testing the header dependency assumptions
   in the types header.

 - No newline necessary after the SPDX line

 - Newline necessary after inline function definitions

 - Rename native_cpuid_reg() to NATIVE_CPUID_REG(): it's a CPP macro,
   whose name we capitalize in such cases.

 - Prettify the CONFIG_PARAVIRT_XXL inclusion block a bit

 - Standardize register references in comments to EAX/EBX/ECX/etc.,
   from the hodgepodge of references.

 - s/cpus/CPUs because why add noise to common acronyms?

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317221824.3738853-4-mingo@kernel.org
---
 arch/x86/include/asm/cpuid/api.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 4d1da9c..f26926b 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef _ASM_X86_CPUID_API_H
 #define _ASM_X86_CPUID_API_H
 
+#include <asm/cpuid/types.h>
+
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-#include <asm/cpuid/types.h>
 #include <asm/string.h>
 
 /*
- * Raw CPUID accessors
+ * Raw CPUID accessors:
  */
 
 #ifdef CONFIG_X86_32
@@ -21,6 +21,7 @@ static inline bool have_cpuid_p(void)
 	return true;
 }
 #endif
+
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 				unsigned int *ecx, unsigned int *edx)
 {
@@ -34,7 +35,7 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 	    : "memory");
 }
 
-#define native_cpuid_reg(reg)					\
+#define NATIVE_CPUID_REG(reg)					\
 static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 {								\
 	unsigned int eax = op, ebx, ecx = 0, edx;		\
@@ -45,22 +46,23 @@ static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 }
 
 /*
- * Native CPUID functions returning a single datum.
+ * Native CPUID functions returning a single datum:
  */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
+NATIVE_CPUID_REG(eax)
+NATIVE_CPUID_REG(ebx)
+NATIVE_CPUID_REG(ecx)
+NATIVE_CPUID_REG(edx)
 
 #ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
+# include <asm/paravirt.h>
 #else
-#define __cpuid			native_cpuid
+# define __cpuid native_cpuid
 #endif
 
 /*
  * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ *
+ * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
  * resulting in stale register contents being returned.
  */
 static inline void cpuid(unsigned int op,
@@ -72,7 +74,7 @@ static inline void cpuid(unsigned int op,
 	__cpuid(eax, ebx, ecx, edx);
 }
 
-/* Some CPUID calls want 'count' to be placed in ecx */
+/* Some CPUID calls want 'count' to be placed in ECX */
 static inline void cpuid_count(unsigned int op, int count,
 			       unsigned int *eax, unsigned int *ebx,
 			       unsigned int *ecx, unsigned int *edx)
@@ -83,7 +85,7 @@ static inline void cpuid_count(unsigned int op, int count,
 }
 
 /*
- * CPUID functions returning a single datum
+ * CPUID functions returning a single datum:
  */
 
 static inline unsigned int cpuid_eax(unsigned int op)

