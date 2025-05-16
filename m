Return-Path: <linux-tip-commits+bounces-5565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3BAB983E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 11:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD24A4755
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3734922FE0E;
	Fri, 16 May 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ircdNigy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ws7Yfku7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19D20B7FE;
	Fri, 16 May 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386065; cv=none; b=AF9lqzsPVtgjsRVimjePTdX/EfLJ6CnWaZVECya6GkQmSEQe+8Er64AYN3Ja2BKVbvKGKWa3t7Hodj0mXvuhBV5LsjyeeS78OzyLqBtjp286zg5hvJHMHQWqjBlipkfCvs73CcQ9QcY9QwFoIUChl/GZU6OQXts4/mIZHXQuh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386065; c=relaxed/simple;
	bh=f/yda2gE3MEL/hTumrVExVXdBE/L3M+sjzGXRQ1G5SY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qu0cnFpFYe3MDezIaWzMzpMZinlen0209B0CzpQdZT4/DDGHINFfJcXFZRLIAY5DLgWan1b9MtQnbDT/Iaj3eJbrkWTmV8w5BZD/wosImvPKHrCLjV0jXuYs2/KZlBUtFg3UXLR0nRXgHNtfipd1ShBr8xweTSKNhVT1UZ55ZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ircdNigy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ws7Yfku7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 09:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747386061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S18cehFSUHefq6PTrUYNOrDbKRuIsk1buU25at9T5Ww=;
	b=ircdNigyt5dHgbl2Tn9YTpUCjt6ql/24KZH5moeJikIwz3OJQsiMxIg970nXqiRueIgnCG
	Y7sNMVjwN2yebq3VS0161A6uYmLCWM8rsGa7yh4OTqRezGtB6f0KToox7ivi9uqzEKzkpH
	wiYjl7P77kpw7CsAmmju8aCrCIQ6HRsqGLl/4I74mS/75JvRIh3/1LreWwlTPVAcz8o4FI
	44BpO2ZDDpgiFvrJ6UpjS4v/M9CSchg2+0GfeImVpv5f7rWXOpHvrcPIbQ2YMx7sbznrFo
	9y2FkCbD8BNEl2aqqiRj+o3IXUPGfBoNq+lfHujB1V6rk83e9PkJie39S61sfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747386061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S18cehFSUHefq6PTrUYNOrDbKRuIsk1buU25at9T5Ww=;
	b=ws7Yfku7V7LcxZFuGnj931PSGmHMZBoUhbG1QosqZ9dK1n0gOB2vYjThlxj8JKxg1ZIv8h
	Yz2B59T3U1wUuxCw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Rename cpuid_get_leaf_0x2_regs() to
 cpuid_leaf_0x2()
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-6-darwi@linutronix.de>
References: <20250508150240.172915-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738606068.406.9695253977424825815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e7df7289f1481993c9f326aea801323a1d3d0c5f
Gitweb:        https://git.kernel.org/tip/e7df7289f1481993c9f326aea801323a1d3d0c5f
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 10:49:48 +02:00

x86/cpuid: Rename cpuid_get_leaf_0x2_regs() to cpuid_leaf_0x2()

Rename the CPUID(0x2) register accessor function:

    cpuid_get_leaf_0x2_regs(regs)

to:

    cpuid_leaf_0x2(regs)

for consistency with other <cpuid/api.h> accessors that return full CPUID
registers outputs like:

    cpuid_leaf(regs)
    cpuid_subleaf(regs)

In the same vein, rename the CPUID(0x2) iteration macro:

    for_each_leaf_0x2_entry()

to:

    for_each_cpuid_0x2_desc()

to include "cpuid" in the macro name, and since what is iterated upon is
CPUID(0x2) cache and TLB "descriptos", not "entries".  Prefix an
underscore to that iterator macro parameters, so that the newly renamed
'desc' parameter do not get mixed with "union leaf_0x2_regs :: desc[]" in
the macro's implementation.

Adjust all the affected call-sites accordingly.

While at it, use "CPUID(0x2)" instead of "CPUID leaf 0x2" as this is the
recommended style.

No change in functionality intended.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-6-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 40 +++++++++++++++----------------
 arch/x86/kernel/cpu/cacheinfo.c  |  4 +--
 arch/x86/kernel/cpu/intel.c      |  4 +--
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index c0211fc..ccf20c6 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -216,17 +216,17 @@ static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
  */
 
 /**
- * cpuid_get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
+ * cpuid_leaf_0x2() - Return sanitized CPUID(0x2) register output
  * @regs:	Output parameter
  *
- * Query CPUID leaf 0x2 and store its output in @regs.	Force set any
+ * Query CPUID(0x2) and store its output in @regs.  Force set any
  * invalid 1-byte descriptor returned by the hardware to zero (the NULL
  * cache/TLB descriptor) before returning it to the caller.
  *
- * Use for_each_leaf_0x2_entry() to iterate over the register output in
+ * Use for_each_cpuid_0x2_desc() to iterate over the register output in
  * parsed form.
  */
-static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
+static inline void cpuid_leaf_0x2(union leaf_0x2_regs *regs)
 {
 	cpuid_leaf(0x2, regs);
 
@@ -251,34 +251,34 @@ static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 }
 
 /**
- * for_each_leaf_0x2_entry() - Iterator for parsed leaf 0x2 descriptors
- * @regs:   Leaf 0x2 register output, returned by cpuid_get_leaf_0x2_regs()
- * @__ptr:  u8 pointer, for macro internal use only
- * @entry:  Pointer to parsed descriptor information at each iteration
+ * for_each_cpuid_0x2_desc() - Iterator for parsed CPUID(0x2) descriptors
+ * @_regs:	CPUID(0x2) register output, as returned by cpuid_leaf_0x2()
+ * @_ptr:	u8 pointer, for macro internal use only
+ * @_desc:	Pointer to the parsed CPUID(0x2) descriptor at each iteration
  *
- * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
- * @regs.  Provide the parsed information for each descriptor through @entry.
+ * Loop over the 1-byte descriptors in the passed CPUID(0x2) output registers
+ * @_regs.  Provide the parsed information for each descriptor through @_desc.
  *
- * To handle cache-specific descriptors, switch on @entry->c_type.  For TLB
- * descriptors, switch on @entry->t_type.
+ * To handle cache-specific descriptors, switch on @_desc->c_type.  For TLB
+ * descriptors, switch on @_desc->t_type.
  *
  * Example usage for cache descriptors::
  *
- *	const struct leaf_0x2_table *entry;
+ *	const struct leaf_0x2_table *desc;
  *	union leaf_0x2_regs regs;
  *	u8 *ptr;
  *
- *	cpuid_get_leaf_0x2_regs(&regs);
- *	for_each_leaf_0x2_entry(regs, ptr, entry) {
- *		switch (entry->c_type) {
+ *	cpuid_leaf_0x2(&regs);
+ *	for_each_cpuid_0x2_desc(regs, ptr, desc) {
+ *		switch (desc->c_type) {
  *			...
  *		}
  *	}
  */
-#define for_each_leaf_0x2_entry(regs, __ptr, entry)				\
-	for (__ptr = &(regs).desc[1];						\
-	     __ptr < &(regs).desc[16] && (entry = &cpuid_0x2_table[*__ptr]);	\
-	     __ptr++)
+#define for_each_cpuid_0x2_desc(_regs, _ptr, _desc)				\
+	for (_ptr = &(_regs).desc[1];						\
+	     _ptr < &(_regs).desc[16] && (_desc = &cpuid_0x2_table[*_ptr]);	\
+	     _ptr++)
 
 /*
  * CPUID(0x80000006) parsing:
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 6d61f7d..b6349c1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -388,8 +388,8 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 	if (c->cpuid_level < 2)
 		return;
 
-	cpuid_get_leaf_0x2_regs(&regs);
-	for_each_leaf_0x2_entry(regs, ptr, entry) {
+	cpuid_leaf_0x2(&regs);
+	for_each_cpuid_0x2_desc(regs, ptr, entry) {
 		switch (entry->c_type) {
 		case CACHE_L1_INST:	l1i += entry->c_size; break;
 		case CACHE_L1_DATA:	l1d += entry->c_size; break;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 7f8ca29..f8141b5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -716,8 +716,8 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 	if (c->cpuid_level < 2)
 		return;
 
-	cpuid_get_leaf_0x2_regs(&regs);
-	for_each_leaf_0x2_entry(regs, ptr, entry)
+	cpuid_leaf_0x2(&regs);
+	for_each_cpuid_0x2_desc(regs, ptr, entry)
 		intel_tlb_lookup(entry);
 }
 

