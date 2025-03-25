Return-Path: <linux-tip-commits+bounces-4502-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6FAA6ECA3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23087A4BD9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236A256C70;
	Tue, 25 Mar 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACmVU89P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXahLQkb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66302566CB;
	Tue, 25 Mar 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895387; cv=none; b=Nw4XyeE6eoWZKnxzrlu8okIm8LqkW+QMQ0/ROA0oVChzsKbyUr3MDwZe8J3CDiuYOKvQspED9m5ON/N1PsEx6BpaM6439VEBG5q2DBBWNLUMPk4sFrEKxMlmCBUfsZli86Gx03LfPqs/VE97TNxEnrAi2NBCCmRGHKDHhwoGHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895387; c=relaxed/simple;
	bh=JT9BoZzOmRmJLwwxC2h6d3dWWqyEU5iSS4cTyYsv3VA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HL9PHy7Qbn7IwA++wbgsy85S8aMkMwePSUw/Ws4q/yEu/zPRikwxbSw4FRyivlMDKG63IruDqWDTWZ5KckHVlf77XN8OsdJSGJz8KA2Cibm3edM0LCEtlEtJFuZQrqHcNQtzibcL9Tkk9AmR9ftpzOO/0x6oEqPbY+GtQzRrjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACmVU89P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXahLQkb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0EGLzFyetPcexQNHA8AI36eENtUXVRTiQWjP33AxUs=;
	b=ACmVU89PNAUG0+HL5z2BY/Y2l8yTpBMd8PNln4s9J0GyJORm7tRczjzKobOAhuAmzEYmkW
	mA2W9XNLMP1SqP3v/noYTtZaKkERyL7/fMqCyD9iefatjFc/vYZZqkN3rjDkn6lazH3U9x
	Go3Y4d25gFCnYWmtD96r8vKI7+P41atPvnBT/CUbQG/nU2OsIsqCF2sta636X1zYiG7mSs
	rRCf15za8ND55mVqYE6VlLZYsp79yrE0jTTvPgtKgjgsE0pH9C+Pk5Wt4B49oHt2UHeDpv
	R1snSXEt3K0lHlja4bLP8W5oxUhHEQPU57CvFzoWEMB0YgeEfsVbzfm824R+/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0EGLzFyetPcexQNHA8AI36eENtUXVRTiQWjP33AxUs=;
	b=iXahLQkbyWTaSWbVCs0lq50UqnTvG2wM0Nh1j/ImjXgLKBYGYObQUx9lvCteZp2KAhPDWH
	s+e22oSKjAeUp9Aw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Use enums for cache descriptor types
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-19-darwi@linutronix.de>
References: <20250324133324.23458-19-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538350.14745.16612112876776060350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e1e6b57146554a321d0ed1e76d2839ac24117f26
Gitweb:        https://git.kernel.org/tip/e1e6b57146554a321d0ed1e76d2839ac24117f26
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:56 +01:00

x86/cacheinfo: Use enums for cache descriptor types

The leaf 0x2 one-byte cache descriptor types:

	CACHE_L1_INST
	CACHE_L1_DATA
	CACHE_L2
	CACHE_L3

are just discriminators to be used within the cache_table[] mapping.
Their specific values are irrelevant.

Use enums for such types.

Make the enum packed and static assert that its values remain within a
single byte so that the cache_table[] array size do not go out of hand.

Use a __CHECKER__ guard for the static_assert(sizeof(enum) == 1) line as
sparse ignores the __packed annotation on enums.

This is similar to:

  fe3944fb245a ("fs: Move enum rw_hint into a new header file")

for the core SCSI code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/Z9rsTirs9lLfEPD9@lx-t490
Link: https://lore.kernel.org/r/20250324133324.23458-19-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/types.h | 15 +++++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c    |  9 ++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 753f6c4..39c3c79 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_CPUID_TYPES_H
 #define _ASM_X86_CPUID_TYPES_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 /*
@@ -45,4 +46,18 @@ union leaf_0x2_regs {
 	u8			desc[16];
 };
 
+/*
+ * Leaf 0x2 1-byte descriptors' cache types
+ * To be used for their mappings at cache_table[]
+ */
+enum _cache_table_type {
+	CACHE_L1_INST,
+	CACHE_L1_DATA,
+	CACHE_L2,
+	CACHE_L3,
+} __packed;
+#ifndef __CHECKER__
+static_assert(sizeof(enum _cache_table_type) == 1);
+#endif
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 626f55f..09c5aa9 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -23,11 +23,6 @@
 
 #include "cpu.h"
 
-#define CACHE_L1_INST	1
-#define CACHE_L1_DATA	2
-#define CACHE_L2	3
-#define CACHE_L3	4
-
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
@@ -41,7 +36,7 @@ unsigned int memory_caching_control __ro_after_init;
 
 struct _cache_table {
 	u8 descriptor;
-	char cache_type;
+	enum _cache_table_type type;
 	short size;
 };
 
@@ -520,7 +515,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			if (!entry)
 				continue;
 
-			switch (entry->cache_type) {
+			switch (entry->type) {
 			case CACHE_L1_INST:	l1i += entry->size; break;
 			case CACHE_L1_DATA:	l1d += entry->size; break;
 			case CACHE_L2:		l2  += entry->size; break;

