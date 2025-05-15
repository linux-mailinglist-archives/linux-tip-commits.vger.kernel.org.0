Return-Path: <linux-tip-commits+bounces-5557-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB9AB8D79
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA3176E0F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C025A34F;
	Thu, 15 May 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEaq9lpe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFnsHxki"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B02256C9E;
	Thu, 15 May 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329440; cv=none; b=nlmU0SRvCueBR+KvSgnoavLF0wwfurVa53Qy4CKDLZ5i22GcT9D0rqAz55UfHUPq/0F2+qpJczgst1l6C/dXBJpnUlzCzwNlTAU3qecRriaVxk96Q2mvtmc7lQwTQN0fgYS7XLk2gqZ/45OeAQfK08Mj2+qwsM6EcUCX3hrqBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329440; c=relaxed/simple;
	bh=tVWMekDkW9q0LUBiYNi1WrWKIkReHw2wUIeY4xwjPWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fM9pj2wTjgmzN1TzbKVvldGatp7df4akZ30PMXmD/2lbujJsFzd8RPJiHKKIw6A8+QO+sgVvjjM3BU4toqHR+B80yH9VcvsXxU3pkZnFskifAfwmLA2Z2wIXegjRKx8QpjjPN9Hh4icBqbiJsvurJkIgJzwZYNrgBYkfGm2slpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEaq9lpe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFnsHxki; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts5qO5wERAEeVRAGXMcVz8JaQ+lxfccpla54kuhx38E=;
	b=JEaq9lpebTn4/9DJ8MaujKnXo9XAWX9iw26Kb+RxTXGvx39NlEZK0ZGvkdF5kzOJfQWZ8m
	bqW50ewWbCHa1jzfiI1ptnZqf6dMJVlu/jmR0AgnthTkVGszWN8JWYm77SkLCkzIUYJ0jW
	MewJPY1KsK5N2vhV5DhINWfg1xdt3+lSneTCYPl/XAG+sdclVeJP3uBPqkz/sIW8b+KlZD
	/YZEsMu0zbCrEiYXCKftLxP+be9MAWC7lx8iTXbZszbIVCBdTEswaMJoZ+PRfKAi7xQMS7
	k1fD2nglcRnr/8Dmc3DEYTKqVei74vd2ptmz0ICUoKnYeP5lDqh0yZ/cAu7FgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts5qO5wERAEeVRAGXMcVz8JaQ+lxfccpla54kuhx38E=;
	b=CFnsHxkiIfzNcxrjUzWCul2ciiU8OA9Iz2eV5e92pM2SDO9MvKekPuzNvagjuGx5iYR3MB
	R/vZW+938qw5ZJDw==
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
Message-ID: <174732943606.406.3556994959930813413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c4c9ea879c3b22e812bf69cf94c5042f809a4ab0
Gitweb:        https://git.kernel.org/tip/c4c9ea879c3b22e812bf69cf94c5042f809a4ab0
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:42:49 +02:00

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
 arch/x86/include/asm/cpuid/api.h | 34 +++++++++++++++----------------
 arch/x86/kernel/cpu/cacheinfo.c  |  4 ++--
 arch/x86/kernel/cpu/intel.c      |  4 ++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index c0211fc..bf97f97 100644
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
+ * for_each_cpuid_0x2_desc() - Iterator for parsed CPUID(0x2) descriptors
+ * @regs:   CPUID(0x2) register output, as returned by cpuid_leaf_0x2()
  * @__ptr:  u8 pointer, for macro internal use only
- * @entry:  Pointer to parsed descriptor information at each iteration
+ * @desc:   Pointer to parsed CPUID(0x2) descriptor at each iteration
  *
- * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
- * @regs.  Provide the parsed information for each descriptor through @entry.
+ * Loop over the 1-byte descriptors in the passed CPUID(0x2) output registers
+ * @regs.  Provide the parsed information for each descriptor through @desc.
  *
  * To handle cache-specific descriptors, switch on @entry->c_type.  For TLB
  * descriptors, switch on @entry->t_type.
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
 

