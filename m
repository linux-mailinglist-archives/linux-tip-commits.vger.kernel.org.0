Return-Path: <linux-tip-commits+bounces-4012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED9A50DBF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707C2167178
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A469A2580D0;
	Wed,  5 Mar 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqnz1Hhn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMWeEH/p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73920296C;
	Wed,  5 Mar 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210587; cv=none; b=uuSAcdD38pUIrswA8oiBzLPCzHVj7YavQX1PyoUYyrYUnbJDAD/BihKzJSura0evCjxqMma6caTqRBlOw4xMNwGTyvlehdRC5ahiWQFFolB9ykS/bSxEkHB1nCoaxld6pv+9TR5izq7JtMkz6Q9tM1b7AWR7Bqfel6rAtlvzjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210587; c=relaxed/simple;
	bh=9MJvig3z4gqPzWjHl0HJF6yNm1y4bnQx+/ZCo/7scdQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L0U780YEqv/laLRiOhEL9qIUrJVbL21EbfFqX2tDY0wMJPZTdBmCY0Zky9Juj55y6fUKDqeLrJ7RK+Fxjixrd7YfiIwn0LrN85r/hSjl/PmEgaZcBE10gO8nQp7M02WQscztG2KVr46QbDmDsb6GtQGF6InSkIPhl9RtuKk+0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqnz1Hhn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMWeEH/p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpZJz5SRVfe31iWznXlCvnn+moEJqfPgw3aOjOgbFuU=;
	b=rqnz1HhnzeebZtfaCLrXA+UEC+OAiUJU/uAhGxPR4Vtv93FT7zdX/+TxXdomcxRAhxgxzB
	5PgW6UG+f76+0toMenlsMRToMyzrbW+Z6Q/xXUT6Otgl07nwwuvie9E7IXmJOi4xhezlRx
	HjWAk+cMIMLG+B/cI+k5oCwqBVHvfNr9B/S/MMwr16aw5c6IXlHOKObijFNKEli4s/y9n5
	OsPMhZSVuRVdB4SkyjxAIX3onmZwD9VhtFEo8AFViFerhHZXUOvMAIChZfGi2cKmA9jnDS
	kRsPkNstmlaD4zi1C7GR3aJBlh3n+A0cktl331foPec8xjqPV8vetCb7StQvrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpZJz5SRVfe31iWznXlCvnn+moEJqfPgw3aOjOgbFuU=;
	b=kMWeEH/pRd0NZ79TFZg0KRihIxK0rCVqaSPcD/Y4NT+izVpzKFe28seIGLLwP47m/6lVwg
	fRHYE1FWoWcgvFCA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Always set the ASID valid bit for the INVLPGB
 instruction
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
References: <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058012.14745.3311319586440639512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0896acd80782ec49c6d36e576fcd53786f0a2bfb
Gitweb:        https://git.kernel.org/tip/0896acd80782ec49c6d36e576fcd53786f0a2bfb
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Tue, 04 Mar 2025 12:59:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 22:18:16 +01:00

x86/mm: Always set the ASID valid bit for the INVLPGB instruction

When executing the INVLPGB instruction on a bare-metal host or hypervisor, if
the ASID valid bit is not set, the instruction will flush the TLB entries that
match the specified criteria for any ASID, not just the those of the host. If
virtual machines are running on the system, this may result in inadvertent
flushes of guest TLB entries.

When executing the INVLPGB instruction in a guest and the INVLPGB instruction is
not intercepted by the hypervisor, the hardware will replace the requested ASID
with the guest ASID and set the ASID valid bit before doing the broadcast
invalidation. Thus a guest is only able to flush its own TLB entries.

So to limit the host TLB flushing reach, always set the ASID valid bit using an
ASID value of 0 (which represents the host/hypervisor). This will will result in
the desired effect in both host and guest.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local
---
 arch/x86/include/asm/tlb.h | 58 ++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 31f6db4..866ea78 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -33,6 +33,27 @@ enum addr_stride {
 	PMD_STRIDE = 1
 };
 
+/*
+ * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
+ * of the three. For example:
+ * - FLAG_VA | FLAG_INCLUDE_GLOBAL: invalidate all TLB entries at the address
+ * - FLAG_PCID:			    invalidate all TLB entries matching the PCID
+ *
+ * The first is used to invalidate (kernel) mappings at a particular
+ * address across all processes.
+ *
+ * The latter invalidates all TLB entries matching a PCID.
+ */
+#define INVLPGB_FLAG_VA			BIT(0)
+#define INVLPGB_FLAG_PCID		BIT(1)
+#define INVLPGB_FLAG_ASID		BIT(2)
+#define INVLPGB_FLAG_INCLUDE_GLOBAL	BIT(3)
+#define INVLPGB_FLAG_FINAL_ONLY		BIT(4)
+#define INVLPGB_FLAG_INCLUDE_NESTED	BIT(5)
+
+/* The implied mode when all bits are clear: */
+#define INVLPGB_MODE_ALL_NONGLOBALS	0UL
+
 #ifdef CONFIG_BROADCAST_TLB_FLUSH
 /*
  * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.
@@ -40,14 +61,20 @@ enum addr_stride {
  * The INVLPGB instruction is weakly ordered, and a batch of invalidations can
  * be done in a parallel fashion.
  *
- * The instruction takes the number of extra pages to invalidate, beyond
- * the first page, while __invlpgb gets the more human readable number of
- * pages to invalidate.
+ * The instruction takes the number of extra pages to invalidate, beyond the
+ * first page, while __invlpgb gets the more human readable number of pages to
+ * invalidate.
  *
  * The bits in rax[0:2] determine respectively which components of the address
  * (VA, PCID, ASID) get compared when flushing. If neither bits are set, *any*
  * address in the specified range matches.
  *
+ * Since it is desired to only flush TLB entries for the ASID that is executing
+ * the instruction (a host/hypervisor or a guest), the ASID valid bit should
+ * always be set. On a host/hypervisor, the hardware will use the ASID value
+ * specified in EDX[15:0] (which should be 0). On a guest, the hardware will
+ * use the actual ASID value of the guest.
+ *
  * TLBSYNC is used to ensure that pending INVLPGB invalidations initiated from
  * this CPU have completed.
  */
@@ -55,9 +82,9 @@ static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 			     unsigned long addr, u16 nr_pages,
 			     enum addr_stride stride, u8 flags)
 {
-	u32 edx = (pcid << 16) | asid;
+	u64 rax = addr | flags | INVLPGB_FLAG_ASID;
 	u32 ecx = (stride << 31) | (nr_pages - 1);
-	u64 rax = addr | flags;
+	u32 edx = (pcid << 16) | asid;
 
 	/* The low bits in rax are for flags. Verify addr is clean. */
 	VM_WARN_ON_ONCE(addr & ~PAGE_MASK);
@@ -93,27 +120,6 @@ static inline void __invlpgb_all(unsigned long asid, unsigned long pcid, u8 flag
 static inline void __tlbsync(void) { }
 #endif
 
-/*
- * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
- * of the three. For example:
- * - FLAG_VA | FLAG_INCLUDE_GLOBAL: invalidate all TLB entries at the address
- * - FLAG_PCID:			    invalidate all TLB entries matching the PCID
- *
- * The first is used to invalidate (kernel) mappings at a particular
- * address across all processes.
- *
- * The latter invalidates all TLB entries matching a PCID.
- */
-#define INVLPGB_FLAG_VA			BIT(0)
-#define INVLPGB_FLAG_PCID		BIT(1)
-#define INVLPGB_FLAG_ASID		BIT(2)
-#define INVLPGB_FLAG_INCLUDE_GLOBAL	BIT(3)
-#define INVLPGB_FLAG_FINAL_ONLY		BIT(4)
-#define INVLPGB_FLAG_INCLUDE_NESTED	BIT(5)
-
-/* The implied mode when all bits are clear: */
-#define INVLPGB_MODE_ALL_NONGLOBALS	0UL
-
 static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
 						unsigned long addr,
 						u16 nr, bool stride)

