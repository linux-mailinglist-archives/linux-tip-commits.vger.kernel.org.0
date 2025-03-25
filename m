Return-Path: <linux-tip-commits+bounces-4478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D4A6EC2E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9963616DEE4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F4F255E37;
	Tue, 25 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvTPQ9aN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ob0GxHtG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0E254855;
	Tue, 25 Mar 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893545; cv=none; b=jeJ8Y2t+TBQw/50pdGlS0BT5+EBttP7gOnfZs4kYsyQWdCalL4LkLPDCt+fKx6vI+m1zS18MNlJbxFJogKs+99pMe6CRcMApMciCy+qWESuhs1P+9ppo3K+wD8VzeNuiVvJ6pSIGjrH1hSOlAoj+xDOtrluKoH81D11xosq+tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893545; c=relaxed/simple;
	bh=8SdgqS2OJ0kJCpS6nooj1TfF1TC/hKE8z6IxPjb4AlM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xrm0pfTW3gk3+8tAD2pqHUDzaorIWwSFk0ogA7nCEF1bdP4xrf1ChVPp22mI/46kqoh7/U2S+vmAsW6NiS2XXVg3rGvHUGGeA92UjgTVAiSHoVFm6Q9hLX77K230NVMyUS1xqXizbu9iOhqAW7jCHxbJg3HZmqylaJ97jHC8FNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvTPQ9aN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ob0GxHtG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jro00RVfsAhFvFlnIFBg0oAlQ/Io//cNNs06m/AjVPI=;
	b=gvTPQ9aNEE4ho/wZvuYqZlDGPh6e2S7GfuWGpdJAmUZxGMX/a/CMXxaHNJjg2HPuylG49m
	phhEM2OSBerWY3B3BXEoDLb8scR6dxQWBkkTxpUqzV6Lj2yoPn7iQ/tqh+Hnrv2/YIn9f3
	XQ/cf5XubAhMHLS++ZHlh2mD0g5rb7IZH/Jv0m8zdNA8ZfDaBqcdkqNR26YPdJzCzBNoDu
	YzDFQo/kovkaSxMxICZlM6gKG/i4T8mXCPTQDHzJZ9OOMIxCQeuoPErqDOfysckTeRFolW
	iN3bTwHoflBYWrhLXDRjp3B/OZP+qpZ0f5MrzgRsK+cJrC/0+JThcX73Z4HO0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jro00RVfsAhFvFlnIFBg0oAlQ/Io//cNNs06m/AjVPI=;
	b=ob0GxHtGS96u9DMAUXIPPi/4HND/p2dqdaPMdT3lT5r6hgGxCRi/+LK2zqFCbLVGyRfPDk
	prDZVZPzgSfVVoBQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Filter valid CPUID ranges
Cc: Dave Hansen <dave.hansen@intel.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-15-darwi@linutronix.de>
References: <20250324142042.29010-15-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353961.14745.4205007280744154485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     72383c8274edf0a1736973462603dcfd0a088bb9
Gitweb:        https://git.kernel.org/tip/72383c8274edf0a1736973462603dcfd0a088bb9
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:46 +01:00

tools/x86/kcpuid: Filter valid CPUID ranges

Next commits will introduce vendor-specific CPUID ranges like Transmeta's
0x8086000 range and Centaur's 0xc0000000.

Initially explicit vendor detection was implemented, but it turned out to
be not strictly necessary.  As Dave Hansen noted, even established tools
like cpuid(1) just tries all ranges indices, and see if the CPU responds
back with something sensible.

Do something similar at setup_cpuid_range().  Query the range's index,
and check the maximum range function value returned.  If it's within an
expected interval of [range_index, range_index + MAX_RANGE_INDEX_OFFSET],
accept the range as valid and further query its leaves.

Set MAX_RANGE_INDEX_OFFSET to a heuristic of 0xff.  That should be
sensible enough since all the ranges covered by x86-cpuid-db XML database
are:

	0x00000000	0x00000023
	0x40000000	0x40000000
	0x80000000	0x80000026
	0x80860000	0x80860007
	0xc0000000	0xc0000001

At setup_cpuid_range(), if the range's returned maximum function was not
sane, mark it as invalid by setting its number of leaves, range->nr, to
zero.

Introduce the for_each_valid_cpuid_range() iterator instead of sprinkling
"range->nr != 0" checks throughout the code.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-15-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 ++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index ac3d36b..fe3d058 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -96,8 +96,13 @@ static char *range_to_str(struct cpuid_range *range)
 	}
 }
 
-#define for_each_cpuid_range(range)		\
-	for (unsigned int i = 0; i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]); i++)
+#define __for_each_cpuid_range(range, __condition)				\
+	for (unsigned int i = 0;						\
+	     i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]) && (__condition);	\
+	     i++)
+
+#define for_each_valid_cpuid_range(range)	__for_each_cpuid_range(range, (range)->nr != 0)
+#define for_each_cpuid_range(range)		__for_each_cpuid_range(range, true)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
 {
@@ -105,7 +110,7 @@ struct cpuid_range *index_to_cpuid_range(u32 index)
 	u32 range_idx = index & CPUID_INDEX_MASK;
 	struct cpuid_range *range;
 
-	for_each_cpuid_range(range) {
+	for_each_valid_cpuid_range(range) {
 		if (range->index == range_idx && (u32)range->nr > func_idx)
 			return range;
 	}
@@ -223,20 +228,32 @@ static void raw_dump_range(struct cpuid_range *range)
 }
 
 #define MAX_SUBLEAF_NUM		64
+#define MAX_RANGE_INDEX_OFFSET	0xff
 void setup_cpuid_range(struct cpuid_range *range)
 {
-	u32 max_func, idx_func;
+	u32 max_func, range_funcs_sz;
 	u32 eax, ebx, ecx, edx;
 
 	cpuid(range->index, max_func, ebx, ecx, edx);
 
-	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
-	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
+	/*
+	 * If the CPUID range's maximum function value is garbage, then it
+	 * is not recognized by this CPU.  Set the range's number of valid
+	 * leaves to zero so that for_each_valid_cpu_range() can ignore it.
+	 */
+	if (max_func < range->index || max_func > (range->index + MAX_RANGE_INDEX_OFFSET)) {
+		range->nr = 0;
+		return;
+	}
+
+	range->nr = (max_func & CPUID_FUNCTION_MASK) + 1;
+	range_funcs_sz = range->nr * sizeof(struct cpuid_func);
+
+	range->funcs = malloc(range_funcs_sz);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
 
-	range->nr = idx_func;
-	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
+	memset(range->funcs, 0, range_funcs_sz);
 
 	for (u32 f = range->index; f <= max_func; f++) {
 		u32 max_subleaf = MAX_SUBLEAF_NUM;
@@ -523,7 +540,7 @@ static void show_info(void)
 
 	if (show_raw) {
 		/* Show all of the raw output of 'cpuid' instr */
-		for_each_cpuid_range(range)
+		for_each_valid_cpuid_range(range)
 			raw_dump_range(range);
 		return;
 	}
@@ -552,7 +569,7 @@ static void show_info(void)
 	}
 
 	printf("CPU features:\n=============\n\n");
-	for_each_cpuid_range(range)
+	for_each_valid_cpuid_range(range)
 		show_range(range);
 }
 

