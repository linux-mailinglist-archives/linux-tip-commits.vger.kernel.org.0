Return-Path: <linux-tip-commits+bounces-4303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C0A6734F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E82F179A2D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97D20C482;
	Tue, 18 Mar 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fINxbNwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bk2heMIR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095520C030;
	Tue, 18 Mar 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299211; cv=none; b=qQlMuTeY8BhSavjXt5104rIrxvrs7jeWkaXZE/Q8veAi5bQa5u6hvAoBTpOUIb+i2Ssz1c5cDPHCasijx0IY14KwWzSgzUxNk23JOymOzuQf0PtQZVlcSphjmm0KQ35BKSexSOUITC89UN2X3Zb3ixLeSHfsMREObpqvuBdfuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299211; c=relaxed/simple;
	bh=FWYUvk12fvLqIPz6dvORhypagT5IqWR+7PU/jjnT2Yo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eVJs/QIw73BC8MRUFqDkbgH6BHcDiQM+fB4YaIBeiQhfSnxfc9+AyZi8kgJ7Hy2nlxcEgClP2a+lXEKnB9ZGEgFkwCrFYKlKZUKf9U+NnyN01BBfyRY2kiRruQiRLB87CvHY4Kaj5npsZR3zs+qUH9+m7yKYKQpL+7JX/ZP5GbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fINxbNwJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bk2heMIR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742299207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30HNR5hSIqhpu/jOe4cBPKVzXFEtfCsdahE/IwjHmuQ=;
	b=fINxbNwJ7eKl+aXBXlQc4qx6GccfwLOv38EbZdNW7BfW0dHtlKCkoGhWy7R15vHwfK6tHL
	ydWLPuYC6xQ9ftTJMDXsIsOM8sZ9lC8wYEPeBuiaw5SmFdwoQj1IfdVULuDCYAEqsADhRE
	tUj5YUcyyqK5AN20OxS0ImelmkBmaTfLLphf5hQmYhM3n1Ml/lbczXdihalT6l0EYuwylN
	a8NF43DmbXJY6HrNbvR+4UFIpWU66zbt4/fVabJ1mbEEFGmCNm3nEsu3SZIayVxD0zJ8cC
	aYwXgznj4cY1AQL4rdkbIBObHnQznBNO4ozSneG9zEc+yNkVusZkCsV0UhmBTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742299207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30HNR5hSIqhpu/jOe4cBPKVzXFEtfCsdahE/IwjHmuQ=;
	b=Bk2heMIRamzQ7/MSxtSRkRc0coehy46RsF8d/hsmdefJQIlBUS/t95KrMPupDKPj3rpgcj
	Fu/jWOn23Z130fAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
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
Message-ID: <174229920666.14745.17383545792766480875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     aec28d852ed27499a944e37801ed815ab9af3a0e
Gitweb:        https://git.kernel.org/tip/aec28d852ed27499a944e37801ed815ab9af3a0e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 09:35:58 +01:00

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

