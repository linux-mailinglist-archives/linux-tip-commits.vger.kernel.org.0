Return-Path: <linux-tip-commits+bounces-4019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D8A50DC1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7641890BEB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A847D25D54E;
	Wed,  5 Mar 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fibIcKCH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PWNqHncF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60A2586E2;
	Wed,  5 Mar 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210591; cv=none; b=clkxsjwDI3ttHZsGjI3IC++4YX3I17kL6lrls84OF4jG//p+qkr7giYBXwCvopUvJshU4v+BQWQJHhBRli2VjVtRxjsfHH3b4LNsgks7i8Wc2JuIgbfheiAHLWXdTVoMjwaR8JqNVS9fWzXHtfVeg1yvkb9nHpkKXE/aUUqyfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210591; c=relaxed/simple;
	bh=RYlXY0lPYwilWdvY+eWSzidM+hqOLgRp1+tQmfF3E2M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j+6J3s+UujM8vg+61W6zO/ixHQ7gDq0mid9CllDrW6WlIjuIbeNpfxSb5k3qaoNxyrU17+Aey6TICmaa04rg+2ukD71W2yEjbIRtHGzSJnIUz0b8w50acCPedVitN1kDK/nYWHMv72mKp846WycSjIu7CSMAbyzckDMNNxPTR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fibIcKCH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PWNqHncF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffNaKrZnyHtrVDIxZ/vFrDVcxZyB65Nq/YOZCrf5UoE=;
	b=fibIcKCHamW1Jwkz6DLVpYFklascH5KRZQKdmcn4OA0uq0P0+IEIxiCrh848tU90749dUD
	UXRBCciSQFtX9mfEFtLHqV2k/xMlMYJZyGPbzLhqM/r8FzHpRjjQ6NmbXwa+8vpG3nHLKf
	6AKbXYwMDvZH9lAwe6mrrAhpSSd3wLf+ri4afMoLO/2Bo7rOSvkgXgITD3QD2wm72sl7g/
	Kr7jqxz0KOe9Sp4nolxq3p2e8VLy6F46/i3aGWYUlrRG/6cx9FjBkqbpzruIb/U3Nw2o1t
	gwcH5XhH/6nMm/xnnjB6WvaC0DAudQgXhreCPqaowMyGfoM+xdvRPjACuyER8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffNaKrZnyHtrVDIxZ/vFrDVcxZyB65Nq/YOZCrf5UoE=;
	b=PWNqHncFfReDBVnSBoIGY09XDySvO0bKd/uzYgVP8dAVn/pFUz8likoAkyYJHo/YpuomC1
	fdUedW3nU79KWcBQ==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add INVLPGB support code
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-4-riel@surriel.com>
References: <20250226030129.530345-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058698.14745.180244251450866359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6272c3a217e5837c72c6714d1e7eddd34254fac3
Gitweb:        https://git.kernel.org/tip/6272c3a217e5837c72c6714d1e7eddd34254fac3
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 28 Feb 2025 20:32:30 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 17:19:46 +01:00

 x86/mm: Add INVLPGB support code

Add helper functions and definitions needed to use broadcast TLB
invalidation on AMD CPUs.

  [ bp:
      - Cleanup commit message
      - Improve and expand comments
      - push the preemption guards inside the invlpgb* helpers
      - merge improvements from dhansen
      - add !CONFIG_BROADCAST_TLB_FLUSH function stubs because Clang
	can't do DCE properly yet and looks at the inline asm and
	complains about it getting a u64 argument on 32-bit code ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-4-riel@surriel.com
---
 arch/x86/include/asm/tlb.h | 132 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 77f52bc..31f6db4 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -6,6 +6,9 @@
 static inline void tlb_flush(struct mmu_gather *tlb);
 
 #include <asm-generic/tlb.h>
+#include <linux/kernel.h>
+#include <vdso/bits.h>
+#include <vdso/page.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
@@ -25,4 +28,133 @@ static inline void invlpg(unsigned long addr)
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 }
 
+enum addr_stride {
+	PTE_STRIDE = 0,
+	PMD_STRIDE = 1
+};
+
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+/*
+ * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.
+ *
+ * The INVLPGB instruction is weakly ordered, and a batch of invalidations can
+ * be done in a parallel fashion.
+ *
+ * The instruction takes the number of extra pages to invalidate, beyond
+ * the first page, while __invlpgb gets the more human readable number of
+ * pages to invalidate.
+ *
+ * The bits in rax[0:2] determine respectively which components of the address
+ * (VA, PCID, ASID) get compared when flushing. If neither bits are set, *any*
+ * address in the specified range matches.
+ *
+ * TLBSYNC is used to ensure that pending INVLPGB invalidations initiated from
+ * this CPU have completed.
+ */
+static inline void __invlpgb(unsigned long asid, unsigned long pcid,
+			     unsigned long addr, u16 nr_pages,
+			     enum addr_stride stride, u8 flags)
+{
+	u32 edx = (pcid << 16) | asid;
+	u32 ecx = (stride << 31) | (nr_pages - 1);
+	u64 rax = addr | flags;
+
+	/* The low bits in rax are for flags. Verify addr is clean. */
+	VM_WARN_ON_ONCE(addr & ~PAGE_MASK);
+
+	/* INVLPGB; supported in binutils >= 2.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xfe" :: "a" (rax), "c" (ecx), "d" (edx));
+}
+
+static inline void __invlpgb_all(unsigned long asid, unsigned long pcid, u8 flags)
+{
+	__invlpgb(asid, pcid, 0, 1, 0, flags);
+}
+
+static inline void __tlbsync(void)
+{
+	/*
+	 * TLBSYNC waits for INVLPGB instructions originating on the same CPU
+	 * to have completed. Print a warning if the task has been migrated,
+	 * and might not be waiting on all the INVLPGBs issued during this TLB
+	 * invalidation sequence.
+	 */
+	cant_migrate();
+
+	/* TLBSYNC: supported in binutils >= 0.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
+}
+#else
+/* Some compilers (I'm looking at you clang!) simply can't do DCE */
+static inline void __invlpgb(unsigned long asid, unsigned long pcid,
+			     unsigned long addr, u16 nr_pages,
+			     enum addr_stride s, u8 flags) { }
+static inline void __invlpgb_all(unsigned long asid, unsigned long pcid, u8 flags) { }
+static inline void __tlbsync(void) { }
+#endif
+
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
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr, bool stride)
+{
+	enum addr_stride str = stride ? PMD_STRIDE : PTE_STRIDE;
+	u8 flags = INVLPGB_FLAG_PCID | INVLPGB_FLAG_VA;
+
+	__invlpgb(0, pcid, addr, nr, str, flags);
+}
+
+/* Flush all mappings for a given PCID, not including globals. */
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb_all(0, pcid, INVLPGB_FLAG_PCID);
+}
+
+/* Flush all mappings, including globals, for all PCIDs. */
+static inline void invlpgb_flush_all(void)
+{
+	/*
+	 * TLBSYNC at the end needs to make sure all flushes done on the
+	 * current CPU have been executed system-wide. Therefore, make
+	 * sure nothing gets migrated in-between but disable preemption
+	 * as it is cheaper.
+	 */
+	guard(preempt)();
+	__invlpgb_all(0, 0, INVLPGB_FLAG_INCLUDE_GLOBAL);
+	__tlbsync();
+}
+
+/* Flush addr, including globals, for all PCIDs. */
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb(0, 0, addr, nr, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
+}
+
+/* Flush all mappings for all PCIDs except globals. */
+static inline void invlpgb_flush_all_nonglobals(void)
+{
+	guard(preempt)();
+	__invlpgb_all(0, 0, INVLPGB_MODE_ALL_NONGLOBALS);
+	__tlbsync();
+}
 #endif /* _ASM_X86_TLB_H */

