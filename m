Return-Path: <linux-tip-commits+bounces-3894-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7AA4DA60
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51107188476C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5A200BA1;
	Tue,  4 Mar 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0+8m2YM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nDc7/X4b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85211200112;
	Tue,  4 Mar 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083980; cv=none; b=owk/VWu5/nloTLErVbyy3grPrFdYoP5AZitJ6CAUFOf2Dt1r45B9TZIphhYH2YxRSaNwKpVcJSGCxnyMQ2zS/M/p7RiY6vvsjW87a3TKpuU5a8fzCVNubE72zz88lPKkNG0xJVplxuQBjrXmsw3Gjagy+6q/sfv1yE+TwE36z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083980; c=relaxed/simple;
	bh=+ql9Qy6m2ET00JYvIIy0CZP8OzeVkKbq0YRc2+8Lu0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVO3Dl2w3f+thpuDBmAelqihOPyHBUQCEyhXTpixLtc9ACuDQynisOXuRTd0Wzst8AbgP/AGsYQwB3RD1Jvh1USM34grpf7HqX/bgh3hnuw+lPxjaKNTtJg0mDpVlwF1yE7OMnPNjwfd/v8+6+J3YIpt5ZDspOF0FCpFBkqp0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0+8m2YM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nDc7/X4b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ByYFXB4RKi2nmSos/8Xt7jDDzhDC6FoNaBcaH0JnE0=;
	b=X0+8m2YMq4+NfE65yrdowB3bV/mpN6+wWiK4KbUCkHaJiFyo2wvkYMUtfZFaOxcYLj3HWO
	BN8FKH+ZhnNHZhCsLY9accY+V5kl/esYFx3ngekTyAJ1/86tfXAS1r0JOiCemOD5qId9s+
	rbWdicxYJ9xM70qvndmb1G3+7esYhZsANv8IvtJp5tmQvJACWVU7puCc718ErZj4dIk8rM
	18dwm/VW2fCfqplWTmVatnTg3aFkyjsAlN9CAcbgZiqR54pqm4mhiYIaaeuFM46noF9O4f
	o6HqIwMavAI5pfpAK8W/ffe4d05ld3i5D8vTk8fQq1/YJ+GdM0a6bZp/fcBAdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ByYFXB4RKi2nmSos/8Xt7jDDzhDC6FoNaBcaH0JnE0=;
	b=nDc7/X4bBC1MZT7KRVh0pl8cTtBTx618GqUhrKO/AQPOsHPe+wRxKwcJW1TsSeaANApoTM
	yb/9Udm4niP+KpCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Remove the P4 trace leftovers for real
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-12-darwi@linutronix.de>
References: <20250304085152.51092-12-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108397607.14745.9578987198404480882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b3a756bd72ec8d1ba43334b17115e0ece1144a88
Gitweb:        https://git.kernel.org/tip/b3a756bd72ec8d1ba43334b17115e0ece1144a88
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:17:33 +01:00

x86/cacheinfo: Remove the P4 trace leftovers for real

Commit 851026a2bf54 ("x86/cacheinfo: Remove unused trace variable") removed
the switch case for LVL_TRACE but did not get rid of the surrounding gunk.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-12-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index a6c6bcc..eccffe2 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -31,7 +31,6 @@
 #define LVL_1_DATA	2
 #define LVL_2		3
 #define LVL_3		4
-#define LVL_TRACE	5
 
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
@@ -96,10 +95,6 @@ static const struct _cache_table cache_table[] =
 	{ 0x66, LVL_1_DATA, 8 },	/* 4-way set assoc, sectored cache, 64 byte line size */
 	{ 0x67, LVL_1_DATA, 16 },	/* 4-way set assoc, sectored cache, 64 byte line size */
 	{ 0x68, LVL_1_DATA, 32 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x70, LVL_TRACE,  12 },	/* 8-way set assoc */
-	{ 0x71, LVL_TRACE,  16 },	/* 8-way set assoc */
-	{ 0x72, LVL_TRACE,  32 },	/* 8-way set assoc */
-	{ 0x73, LVL_TRACE,  64 },	/* 8-way set assoc */
 	{ 0x78, LVL_2,      MB(1) },	/* 4-way set assoc, 64 byte line size */
 	{ 0x79, LVL_2,      128 },	/* 8-way set assoc, sectored cache, 64 byte line size */
 	{ 0x7a, LVL_2,      256 },	/* 8-way set assoc, sectored cache, 64 byte line size */
@@ -787,19 +782,13 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			}
 		}
 	}
-	/*
-	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
-	 * trace cache
-	 */
-	if ((!ci->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
+
+	/* Don't use CPUID(2) if CPUID(4) is supported. */
+	if (!ci->num_leaves && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
-		int only_trace = 0;
-
-		if (ci->num_leaves && c->x86 == 15)
-			only_trace = 1;
 
 		/* Number of times to iterate */
 		n = cpuid_eax(2) & 0xFF;
@@ -820,8 +809,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 				/* look up this descriptor in the table */
 				while (cache_table[k].descriptor != 0) {
 					if (cache_table[k].descriptor == des) {
-						if (only_trace && cache_table[k].cache_type != LVL_TRACE)
-							break;
 						switch (cache_table[k].cache_type) {
 						case LVL_1_INST:
 							l1i += cache_table[k].size;

