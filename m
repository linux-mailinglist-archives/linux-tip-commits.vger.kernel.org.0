Return-Path: <linux-tip-commits+bounces-4355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D19A68AC9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A813A75D6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FC25A625;
	Wed, 19 Mar 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0/QiTc1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQ3BIIMg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E90259CBF;
	Wed, 19 Mar 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382230; cv=none; b=B5EJMtk6D0jgG4fYZg+EEYLfRiDwW+ZgI5SZ0WfuondrSTndN2DOtD3Iqy9jJX5Zr73HI0awNZmRCak9YRtTSOIkQ4v9zbGmYBERuW3r5g7+/Ys8yBw+1HAE9nZR1WgIn6gflB7dLXjGUMgTs3jCpJHzJXwXHOlRpVL1SBEiUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382230; c=relaxed/simple;
	bh=W5AxF6ogtm2tqkPxFiB4zFiM1jaQcD0LXgmETBReXX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CtN54ne/lB0fwunZDhQFTtpTtAAoEKgsITTn+LEBZgjnLwWWwZx4IvHDbRPRTqLF/4PDcrXUP1wtH6snuH9fNsimyAtUGu+q49E73aCrRs6Q7MyV033aZJDSqgtt7crrVM2b1IMQ3K15gPp+cNAE/sY9nrdZBwtU/BeKNWuX5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0/QiTc1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQ3BIIMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiIigZ4KtN2ZDvJS9mwTAtyyFqgfSX0+n0o/eDbicN8=;
	b=a0/QiTc150+Ya3Jyd4TSe2XCMG+P0kdxgasgq0afqDB91ZsJL6UX3bLF2xbLk+QIxMiqPd
	oNEDp5063HAyISbfKlwz+Dj4qQVdY5rG4dCW7qKGdJeoz6sy7m+2BWNoyDpvRpMlXsNAZ8
	rJsCAHfkkeL6KxoEHGm/UNz0HH3T9FmvWCyoZwVaaCtY88JNG/5KrE8Vo0SyfQ4rHN5jBX
	+p9tmXt3zDSUHt6jsbnj7UZoRUdjN30DYngK0cSEz7A7OO41P/NsfEGC5HP/K4t+psVRu3
	if0Rm+42dqvGVqsdPtkarVkuOZf9UQM1V0HV7qX5NPOFcnUCMtdgolJb5pby1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiIigZ4KtN2ZDvJS9mwTAtyyFqgfSX0+n0o/eDbicN8=;
	b=yQ3BIIMgdpe6POMwYl7ddyVmnqYQD494MQV6A2AaMFHBkVF+KVbRjLmLZ1bvJUBeO2NAsm
	G7VA8rTlYnBQubCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317221824.3738853-5-mingo@kernel.org>
References: <20250317221824.3738853-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222532.14745.3385180566461540741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     cfb4fc5f089a90b44832656ebe4504fcc41058ea
Gitweb:        https://git.kernel.org/tip/cfb4fc5f089a90b44832656ebe4504fcc41058ea
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:26 +01:00

x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>

Convert all uses of 'unsigned int' to 'u32' in <asm/cpuid/api.h>.

This is how a lot of the call sites are doing it, and the two
types are equivalent in the C sense - but 'u32' better expresses
that these are expressions of an immutable hardware ABI.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Xin Li (Intel) <xin@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317221824.3738853-5-mingo@kernel.org
---
 arch/x86/include/asm/cpuid/api.h | 40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index f26926b..356db18 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -22,8 +22,8 @@ static inline bool have_cpuid_p(void)
 }
 #endif
 
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
+static inline void native_cpuid(u32 *eax, u32 *ebx,
+				u32 *ecx, u32 *edx)
 {
 	/* ecx is often an input as well as an output. */
 	asm volatile("cpuid"
@@ -36,9 +36,9 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 }
 
 #define NATIVE_CPUID_REG(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+static inline u32 native_cpuid_##reg(u32 op)	\
 {								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
+	u32 eax = op, ebx, ecx = 0, edx;		\
 								\
 	native_cpuid(&eax, &ebx, &ecx, &edx);			\
 								\
@@ -65,9 +65,9 @@ NATIVE_CPUID_REG(edx)
  * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
  * resulting in stale register contents being returned.
  */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
+static inline void cpuid(u32 op,
+			 u32 *eax, u32 *ebx,
+			 u32 *ecx, u32 *edx)
 {
 	*eax = op;
 	*ecx = 0;
@@ -75,9 +75,9 @@ static inline void cpuid(unsigned int op,
 }
 
 /* Some CPUID calls want 'count' to be placed in ECX */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
+static inline void cpuid_count(u32 op, int count,
+			       u32 *eax, u32 *ebx,
+			       u32 *ecx, u32 *edx)
 {
 	*eax = op;
 	*ecx = count;
@@ -88,43 +88,43 @@ static inline void cpuid_count(unsigned int op, int count,
  * CPUID functions returning a single datum:
  */
 
-static inline unsigned int cpuid_eax(unsigned int op)
+static inline u32 cpuid_eax(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return eax;
 }
 
-static inline unsigned int cpuid_ebx(unsigned int op)
+static inline u32 cpuid_ebx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return ebx;
 }
 
-static inline unsigned int cpuid_ecx(unsigned int op)
+static inline u32 cpuid_ecx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return ecx;
 }
 
-static inline unsigned int cpuid_edx(unsigned int op)
+static inline u32 cpuid_edx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return edx;
 }
 
-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
 {
 	regs[CPUID_EAX] = leaf;
 	regs[CPUID_ECX] = subleaf;
@@ -141,7 +141,7 @@ static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *re
 	__cpuid_read(leaf, 0, (u32 *)(regs));		\
 }
 
-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+static inline void __cpuid_read_reg(u32 leaf, u32 subleaf,
 				    enum cpuid_regs_idx regidx, u32 *reg)
 {
 	u32 regs[4];

