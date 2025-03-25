Return-Path: <linux-tip-commits+bounces-4518-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEAA6ECCE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B534189B0E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419A258CF3;
	Tue, 25 Mar 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BgUVaNnR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zs3gZLWm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A1258CF5;
	Tue, 25 Mar 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895401; cv=none; b=IKOk2MwKDBWCtIbhS0sGuhwkqr+Y4ESUMkBVAiTqqQnOfRFYEQripWfl+pdhUKXeoxu0prptoEKXuQbqyYT/+NidEY3NvIoi9RfjwSmTpB5wT4EaU9K9Ro4GZ2jQM2LB0EA0DzmLScSFioCfSJ7nggXjjgImnzzO444l+y56tWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895401; c=relaxed/simple;
	bh=nKA3QQr1uDm8X9Zdv0FGKkw8GjMEC+M64nd1CalKu/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rlt4kD0u5sAEOz+KRRrJvHMwwc4W4Jje94mAzgqw66HCPH07uMt0GhHPRHWMTaaURSgq3oaKk9AT1znEUVz5c5LbX4TZlOJ6ioYOVaU19avUuV1lbdV15B5IJULHk9Jv3Xflh5NmQoRtdaxMWHkOwkOBBmvLJ/hjt3Ars0T4reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BgUVaNnR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zs3gZLWm; arc=none smtp.client-ip=193.142.43.55
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
	bh=JTWiXNSdXWQgxKuMxjSfRQvW3WX4K14zMzEdP5Ood6Q=;
	b=BgUVaNnRXHn8jpPvRTAY+mQYSW2cJqjZu/QnpE+1SKe/7wuQaQe9bXOq2AHxURtQ7f/4sL
	z9BX/dVPIFLWbY1ZzYeEjrbecI1NVt7GMW5r2M18QpeBVYwBe6aa9UdbPbrJHSU/lINj+n
	q5LKfnKoCgMvBfLY8tlG7n9cgHJheYomEhf4VVFdoNHaOjhBt0Y5vbfbrqH4t0iU87BLo0
	YuEvqe3bhbx5/ob0OOQ+4g+xiMo7eR2G8Gcx9Vdw91vSYjFvSnFrw9yVAjI88uMlA+DlNl
	ObjettSksLuBRv24StcyQeiszbbJAsqDlFgNSHY81uhEc4IoOoPu8J0787/QCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTWiXNSdXWQgxKuMxjSfRQvW3WX4K14zMzEdP5Ood6Q=;
	b=Zs3gZLWmuPZmmUMy8SFYgDDJ1hOEROXFjESppVXd6Dd9C4MhbOhPyuX2TbnYLu2qGQky5m
	xfsFb3u5rBoVteBg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Remove CPUID leaf 0x2 parsing loop
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-3-darwi@linutronix.de>
References: <20250324133324.23458-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539647.14745.12398405425285372043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     09a1da4beb310420b720994f7b6599e8d0bce3e1
Gitweb:        https://git.kernel.org/tip/09a1da4beb310420b720994f7b6599e8d0bce3e1
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:32:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:02 +01:00

x86/cacheinfo: Remove CPUID leaf 0x2 parsing loop

Leaf 0x2 output includes a "query count" byte where it was supposed to
specify the number of repeated CPUID leaf 0x2 subleaf 0 queries needed to
extract all of the CPU's cache and TLB descriptors.

Per current Intel manuals, all CPUs supporting this leaf "will always"
return an iteration count of 1.

Remove the leaf 0x2 query loop and just query the hardware once.

Note, as previously done at commit aec28d852ed2 ("x86/cpuid: Standardize
on u32 in <asm/cpuid/api.h>"), standardize on using 'u32' and 'u8' types.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-3-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 77 +++++++++++++++-----------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b3a5209..36782fd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -42,7 +42,7 @@ static cpumask_var_t cpu_cacheinfo_mask;
 unsigned int memory_caching_control __ro_after_init;
 
 struct _cache_table {
-	unsigned char descriptor;
+	u8 descriptor;
 	char cache_type;
 	short size;
 };
@@ -783,50 +783,47 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		/* supports eax=2  call */
-		int j, n;
-		unsigned int regs[4];
-		unsigned char *dp = (unsigned char *)regs;
-
-		/* Number of times to iterate */
-		n = cpuid_eax(2) & 0xFF;
-
-		for (i = 0 ; i < n ; i++) {
-			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 4 ; j++)
-				if (regs[j] & (1 << 31))
-					regs[j] = 0;
-
-			/* Byte 0 is level count, not a descriptor */
-			for (j = 1 ; j < 16 ; j++) {
-				unsigned char des = dp[j];
-				unsigned char k = 0;
-
-				/* look up this descriptor in the table */
-				while (cache_table[k].descriptor != 0) {
-					if (cache_table[k].descriptor == des) {
-						switch (cache_table[k].cache_type) {
-						case LVL_1_INST:
-							l1i += cache_table[k].size;
-							break;
-						case LVL_1_DATA:
-							l1d += cache_table[k].size;
-							break;
-						case LVL_2:
-							l2 += cache_table[k].size;
-							break;
-						case LVL_3:
-							l3 += cache_table[k].size;
-							break;
-						}
+		u32 regs[4];
+		u8 *desc = (u8 *)regs;
 
+		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
+
+		/* Intel CPUs must report an iteration count of 1 */
+		if (desc[0] != 0x01)
+			return;
+
+		/* If a register's bit 31 is set, it is an unknown format */
+		for (int i = 0; i < 4; i++) {
+			if (regs[i] & (1 << 31))
+				regs[i] = 0;
+		}
+
+		/* Skip the first byte as it is not a descriptor */
+		for (int i = 1; i < 16; i++) {
+			u8 des = desc[i];
+			u8 k = 0;
+
+			/* look up this descriptor in the table */
+			while (cache_table[k].descriptor != 0) {
+				if (cache_table[k].descriptor == des) {
+					switch (cache_table[k].cache_type) {
+					case LVL_1_INST:
+						l1i += cache_table[k].size;
+						break;
+					case LVL_1_DATA:
+						l1d += cache_table[k].size;
+						break;
+					case LVL_2:
+						l2 += cache_table[k].size;
+						break;
+					case LVL_3:
+						l3 += cache_table[k].size;
 						break;
 					}
 
-					k++;
+					break;
 				}
+				k++;
 			}
 		}
 	}

