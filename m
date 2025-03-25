Return-Path: <linux-tip-commits+bounces-4516-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB675A6ECCD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9EE3B71F8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB1259C94;
	Tue, 25 Mar 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nX+mwkUx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MwcjjFoF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54B2580FA;
	Tue, 25 Mar 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895399; cv=none; b=Thdxw1SKKJlHOYX6rjzZcOWw6BFEslgY4v1Ok8n1uq0+750Gca4cKoiLFkqdNzgJW0s2PJKfoMVSXPdtNlK6Ly3ZJYq6CYoWKF7/D2L3NpfC6xtkDCPmOUOnneCz3R2a6hI0ZxN+naPPm51euCIeqTWinLRjiEkTf4Z21UVoh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895399; c=relaxed/simple;
	bh=29+7xJ4867AgjXhDDQYWgcquJTZiz47tN8aZLPNgPHA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bwlIHnpu5mfGArXSKPrpbyp0Sc5AOXq5EK+NuqLtZicK2blqGc5NnU9rhqiz9g7KgprR3aDkTksv4pAcvsQruv0H4f2IP4O9i9wXhI4NBJEOvLSpqI4K0tYYBZ8MDRLFNU7ET5YctU6r5P1OhjIlV0tov+L449uezdMhSQ0brGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nX+mwkUx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MwcjjFoF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0BEAdUSqmvO4ipM4lNsiUeqrbzhXsL0VOYIYWzdAHs=;
	b=nX+mwkUxxuL2BnRRGdfrT4MRbqkREKCDd2cz9sjvl3M/DLClHhJY1SEMpt47QMHFYKuxW+
	slCzYjbsuqNC29RyskikNqY6vQEXXuW5g/U1Ro7DVd1e/GwFQKeCempGhw+x3k7TjwQhsh
	c3QBNe8mlpiWjreO3eYMDt6KGhJdbuE9s1FyKBXM/EKANovRF4AIxXTHx+u4CIlPWXGlhH
	otDaBVsAZuRP0Io+tmy/Lb4bkn86u++N0sXqVltnUhy5mTv0aTVomqBPluvIYgZsriJtP5
	wJF++DPqYjg6PqzimHBwUbU15fWw/I9gxejATkfhDE0fl43HE+JTu283rnWXhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0BEAdUSqmvO4ipM4lNsiUeqrbzhXsL0VOYIYWzdAHs=;
	b=MwcjjFoFuQ6Yla4lBaH3sehmaQ76Cu7fWKcVJyP/xB/AB0Sg/bR4eie1oIQt/Rbwt/lB0R
	qa/tgyTHnt3+/zAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-7-darwi@linutronix.de>
References: <20250324133324.23458-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539420.14745.12025478199109562353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     21e2a452dca34538db0731b45c113cfd31aa45e6
Gitweb:        https://git.kernel.org/tip/21e2a452dca34538db0731b45c113cfd31aa45e6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:16 +01:00

x86/cacheinfo: Properly name amd_cpuid4()'s first parameter

amd_cpuid4()'s first parameter, "leaf", is not a CPUID leaf as the name
implies.  Rather, it's an index emulating CPUID(4)'s subleaf semantics;
i.e. an ID for the cache object currently enumerated.  Rename that
parameter to "index".

Apply minor coding style fixes to the rest of the function as well.

[ darwi: Move into a separate commit and write commit log.
	 Use "index" instead of "subleaf" for amd_cpuid4() first param,
	 as that's the name typically used at the whole of cacheinfo.c. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-7-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index d0bfdb8..0fd4e96 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -233,12 +233,10 @@ static const enum cache_type cache_type_map[] = {
 };
 
 static void
-amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
-		     union _cpuid4_leaf_ebx *ebx,
-		     union _cpuid4_leaf_ecx *ecx)
+amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
+	   union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
-	unsigned dummy;
-	unsigned line_size, lines_per_tag, assoc, size_in_kb;
+	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
 	union l1_cache l1i, l1d;
 	union l2_cache l2;
 	union l3_cache l3;
@@ -251,7 +249,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
 	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
 
-	switch (leaf) {
+	switch (index) {
 	case 1:
 		l1 = &l1i;
 		fallthrough;
@@ -289,12 +287,11 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	}
 
 	eax->split.is_self_initializing = 1;
-	eax->split.type = types[leaf];
-	eax->split.level = levels[leaf];
+	eax->split.type = types[index];
+	eax->split.level = levels[index];
 	eax->split.num_threads_sharing = 0;
 	eax->split.num_cores_on_die = topology_num_cores_per_package();
 
-
 	if (assoc == 0xffff)
 		eax->split.is_fully_associative = 1;
 	ebx->split.coherency_line_size = line_size - 1;

