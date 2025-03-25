Return-Path: <linux-tip-commits+bounces-4477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE13A6EC2B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7171316D926
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10E255E20;
	Tue, 25 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mbDBZK+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3bRSVmV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3A253B5D;
	Tue, 25 Mar 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893544; cv=none; b=GPClvkENJunyQdgAOEtrD6nDr2mCSlJWXCfHyDWsBaEGPgP6OD2rgtjMHbfOCDsKT7diVI1p1IGJ34Zr0a8p5+BRUaLDQG9uXZdIs2wGJ7mUyRH3Fo5rV9S8U33kd2eJZqmF5BAKZfgIwG3U7rZW/55znYbTQ+qjbWFt2fPo9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893544; c=relaxed/simple;
	bh=smosKVLW17hav+zflykb4DVHkzqka9EBFlespDlaJTg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R2ldvlhxfgJ60PRePWprEn6rWPBsNvQSx1OCO0/RFEJqPqB3aqP3aCPqgf00Og1QWfp3zYW4FdpCMn0r+0oGx+2Hder6/teGE/0e10bjOejsZORIVNMNvHyQySPr0IlaV/hdIbvdQwM8yO7xvmlnxuRoCY4qq4xR3N1uVbdx1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mbDBZK+n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3bRSVmV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDGHARfYl55ZorSq9D/ojeVsejSs6F6rl6gsllnaFkI=;
	b=mbDBZK+n0w7ffmIXM2U1AxE8K7hH2ATtS1yCVmsEvF7N84ZAcXnCzRJXneujMzVw4GVSuz
	v6bjczLm3dOIPhMxa7jpZzpCcrCjCQTgFQt91bGMCnt97+RTnB3PPLS6SyiYQAVQ0npOMh
	IcOt5fht4Hf7UBTKARmYvtRE6IKBRQUJN46PVq4jNLxsRig7kLsHn5ewVHeo2IaouC55U2
	6aEjrpppVAMSPgCKDvTeZTO3O3jgf7AtIBwvo83JWO/7KOZQkrb0EjtVaff2D6r+czdJB/
	VsokXMDpdSJv9cP0x5EcpYPlcxpsrGjeN/McSZvN8Qxj4NlgyEoCwpw9Tg3ZxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDGHARfYl55ZorSq9D/ojeVsejSs6F6rl6gsllnaFkI=;
	b=G3bRSVmVsrUINDab9mHvB97gCkUOaut+wUxeo/It4VMvLKYVhnY6rjk/nhSsUOcY1vdC6B
	3ylQH8ztrIJhDKAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Extend CPUID index mask macro
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-13-darwi@linutronix.de>
References: <20250324142042.29010-13-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354073.14745.6316487857745557641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f2e2efe9489d883fdaac8b7b46bd669b6214b1cb
Gitweb:        https://git.kernel.org/tip/f2e2efe9489d883fdaac8b7b46bd669b6214b1cb
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:46 +01:00

tools/x86/kcpuid: Extend CPUID index mask macro

Extend the CPUID index mask macro from 0x80000000 to 0xffff0000.  This
accommodates the Transmeta (0x80860000) and Centaur (0xc0000000) index
ranges which will be later added.

This also automatically sets CPUID_FUNCTION_MASK to 0x0000ffff, which is
the actual correct value.  Use that macro, instead of the 0xffff literal
where appropriate.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-13-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 7790136..1f48de3 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -71,7 +71,7 @@ enum range_index {
 	RANGE_EXT = 0x80000000,		/* Extended */
 };
 
-#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_INDEX_MASK		0xffff0000
 #define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
 
 struct cpuid_range {
@@ -173,7 +173,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	 * Cut off vendor-prefix from CPUID function as we're using it as an
 	 * index into ->funcs.
 	 */
-	func = &range->funcs[f & 0xffff];
+	func = &range->funcs[f & CPUID_FUNCTION_MASK];
 
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
@@ -228,7 +228,7 @@ void setup_cpuid_range(struct cpuid_range *range)
 
 	cpuid(range->index, max_func, ebx, ecx, edx);
 
-	idx_func = (max_func & 0xffff) + 1;
+	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
@@ -512,7 +512,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	if (!range)
 		return NULL;
 
-	func_idx = index & 0xffff;
+	func_idx = index & CPUID_FUNCTION_MASK;
 	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
 

