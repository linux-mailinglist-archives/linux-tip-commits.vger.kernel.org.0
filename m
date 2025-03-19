Return-Path: <linux-tip-commits+bounces-4383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941AA68B1C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EF13AE798
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554926159C;
	Wed, 19 Mar 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4xm8ueP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7aFycZDL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0625F7AB;
	Wed, 19 Mar 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382246; cv=none; b=ieQuk0jQU7+GMvoP532ySlw695tLNm1uWwxnZE/dLX32kbWm4pBil+N4bHWroVNMvJu2S5cKVn2oCeJi/W+TIQG/j5WpSsUfty/awH6TmOmNLIP55QuiG4e9CF7UtTPV08vHrRRjs34trboaQsxgK8zJ9VSUe/gN9yPL8Z4gGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382246; c=relaxed/simple;
	bh=TjYb1xns1YoTcLvv5NV1LtXhsttZd2IIocP6j9lefUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dry1L9f0viyIX8MwcuQCCH/WZtuGo068ga6a6yAmgZoykkL+lPs4bx0tnTmsGnzbDz03OPWxCNYT/5cIC9TC9i6InSwXVD6SRKEv/EONMTmlIQb+ip/XD3siAVVbm9u6JrKdxeIoEBB2ohDKQSyO57PbnfddMhCYYAUxjlHxz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4xm8ueP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7aFycZDL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nusJn7bR/ybrYlbqjUGGgI6BMSwF3FeCl9L3pYgrUmA=;
	b=q4xm8uePv2+j02L4BnDnm1bV/4ZcZnk1BQOAWuzTRwxYdoJxADE4nnxT2KfaYwRJaSfuvo
	dBJ/9HhFd1G/6iaWzSJXoilkqhiQHHMZlt97GFMtiQ6Uc9hhLRPCHGlmLh9geU5ehUAO7T
	yb8GwN8Fq8oO+9c/P4SOImeobIIuwoKtPNZcx1j/bV9b0epcTDsOsFyepcZtMj515yQfJ9
	4GelrZ5EVqB9nAMoNdo/8T2mMPbPkrV5UuE8DeX7WO4xXZx/ay/Z1C9hpZKlA3ChtkDqOB
	Y6THfKa6Otq4ZWeZ9DAamXbFMNs3XH5ZvGxUuNKIQ1vOG9OxRR17CVmPTcGE/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nusJn7bR/ybrYlbqjUGGgI6BMSwF3FeCl9L3pYgrUmA=;
	b=7aFycZDLVfDjZILVWvWAtTnscH2jm1srBZsQ+4K8Ivn67cRM+CZljrkGoUyCNY4SqHfOvW
	1BTZaffbxhiRIyAA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Always set the ASID valid bit for the INVLPGB
 instruction
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
References: <20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224228.14745.17859813215811435467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     634ab76159a842f890743fb435f74c228e06bb04
Gitweb:        https://git.kernel.org/tip/634ab76159a842f890743fb435f74c228e06bb04
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Tue, 04 Mar 2025 12:59:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

