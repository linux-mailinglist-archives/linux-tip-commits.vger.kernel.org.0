Return-Path: <linux-tip-commits+bounces-4519-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA01A6ECD3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A041898156
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782B025A2C5;
	Tue, 25 Mar 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0v1JDQwK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9u9eql9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C5257424;
	Tue, 25 Mar 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895401; cv=none; b=aU2VMgkLXvYnDBnMDvx8tnCqulYDQo9hld8bcZj1JqrlEI/g+PL2q29YwifEqUKe4ddl07hd2ZPUFKWfFDHxhOCBIWTNy3bgwX+ZlJzuICQkKzv0wThmlOvoQLWFUNQiSc5F9zU8V3UxKc9hodKXl4LLvU14ONAFznJG3iTCF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895401; c=relaxed/simple;
	bh=gx0E7SvZACwkTYOKTPEVLfHvhBvzOEIREELdCsVnEu0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ue6xc9CyH5+uoBYOeU3S6sUvQHsMEk0g/M/L+41SpNOW4FpQQXFrySZTVfvCSJeAknCzr/tgvh4heHNibxdd3E+S9NghMjSw80pBDoyO1xEww56tFl77hWI9BTb1IsNp3Xy9JD9MsZ2KS+CMs8Mk3KpYQFlRAMgxOn2LgblmvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0v1JDQwK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9u9eql9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tOP1pbNv91SLmvdIbyi7zE49x2ceHapYb23ebordhA=;
	b=0v1JDQwKVbhr6x3LNK+pTSOkpQZZ65dXXN7NwFxB64BrdeYaVD1mBPN2ArEfgmYFkpvArf
	VKBw1xZx17VSJAPKjoyw2+hnZ3IIPHFvbE9OKiurYmoldQwn3UN/GUff3+fYtNxelL07Gn
	a+Jyzwl3tu0AY69HY9VDKAG0METj4PqfiOMwkfw8AubbackOFV67DBk79ndGGH+7axicwN
	A6Tt0a7LqFcOZYuubpVzPLeDDqIQnVWzaLdtrp/Lt9uflOKmQ1GqyoXFZ7OozBfGlM5kC7
	Y2+Z9hij3kEslOFhxdI8/AYQgVP1g4DXCh5Vmlx0AwznfIBsCTZ9AAtcVjZM5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tOP1pbNv91SLmvdIbyi7zE49x2ceHapYb23ebordhA=;
	b=V9u9eql9QTURhTna1OmiVlUhyYFk6l0aE1KqeaUirnUdDZmVtekYgcmW7vc1xYjTwsgtVw
	pnrSlDhvYyuSgjDw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove CPUID leaf 0x2 parsing loop
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-2-darwi@linutronix.de>
References: <20250324133324.23458-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539700.14745.1737394657121748708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b5969494c8d8a2384c0636707a538efad15d8660
Gitweb:        https://git.kernel.org/tip/b5969494c8d8a2384c0636707a538efad15d8660
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:32:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:21:46 +01:00

x86/cpu: Remove CPUID leaf 0x2 parsing loop

Leaf 0x2 output includes a "query count" byte where it was supposed to
specify the number of repeated CPUID leaf 0x2 subleaf 0 queries needed to
extract all of the CPU's cache and TLB descriptors.

Per current Intel manuals, all CPUs supporting this leaf "will always"
return an iteration count of 1.

Remove the leaf 0x2 query loop and just query the hardware once.

Note, as previously done in:

  aec28d852ed2 ("x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>")

standardize on using 'u32' and 'u8' types.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-2-darwi@linutronix.de
---
 arch/x86/kernel/cpu/intel.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4cbb2e6..0570d4d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -6,6 +6,7 @@
 #include <linux/minmax.h>
 #include <linux/smp.h>
 #include <linux/string.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -777,28 +778,27 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	int i, j, n;
-	unsigned int regs[4];
-	unsigned char *desc = (unsigned char *)regs;
+	u32 regs[4];
+	u8 *desc = (u8 *)regs;
 
 	if (c->cpuid_level < 2)
 		return;
 
-	/* Number of times to iterate */
-	n = cpuid_eax(2) & 0xFF;
+	cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
-	for (i = 0 ; i < n ; i++) {
-		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 4 ; j++)
-			if (regs[j] & (1 << 31))
-				regs[j] = 0;
+	/* Intel CPUs must report an iteration count of 1 */
+	if (desc[0] != 0x01)
+		return;
 
-		/* Byte 0 is level count, not a descriptor */
-		for (j = 1 ; j < 16 ; j++)
-			intel_tlb_lookup(desc[j]);
+	/* If a register's bit 31 is set, it is an unknown format */
+	for (int i = 0; i < 4; i++) {
+		if (regs[i] & (1 << 31))
+			regs[i] = 0;
 	}
+
+	/* Skip the first byte as it is not a descriptor */
+	for (int i = 1; i < 16; i++)
+		intel_tlb_lookup(desc[i]);
 }
 
 static const struct cpu_dev intel_cpu_dev = {

