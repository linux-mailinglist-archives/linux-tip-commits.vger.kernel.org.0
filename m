Return-Path: <linux-tip-commits+bounces-7696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84167CBCC51
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 08:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7503002692
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A55313532;
	Mon, 15 Dec 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuXwSMi/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rou69YT9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C1313522;
	Mon, 15 Dec 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783780; cv=none; b=DgtC+hh4g2iA94fIVAyUDm84AKByjtqJABgaNJutdtzVQPal63RrFN8x4wnssrDqnDju/ai8j2eWoEjck+7+TYZDuedBALDwAS3PAq3I1Cu6lVhMjb7+/6fV6tqdYm9HEoWe/RigMdckXvZh1/xsqbcOceq1bpMK+KPTqyOr2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783780; c=relaxed/simple;
	bh=6Yumyo20oySMajWv2fAqDmrh6e9D7bbShn1JJ7FlNpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CS5F1AUtTpWr07MHqLHwLyd0nDa3pSgd7twviawYmFSbMNXrDD6MNfBtNJ/VQD/j+f1jLg+cHMkJrma2TwGz+Zju0G7Y3JJA9n8FWfqEIWQ4GRTJBC9qg+xhb0zOniJwTRJi5XFHYuVp0PNR+ncptPgSm5sO8O1dgjev5215VJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuXwSMi/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rou69YT9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:18:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765783117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55OqeXvegQjYguOhoqwSL48wzxa/fxMqaq8Gb5eBZSI=;
	b=kuXwSMi/4BCH70vYOuvlduL+wAJIXvrFSz52iLLAEZyCsakE8T9xhanVk4ICpMO8YoNRDc
	9zoh2/J/u3nvxeHPbRTyicjLKnL/0/GzHfEYXzVG4CyY8o2glr8/XWt+mDf+JwgPB6RI4n
	JlMbFp0Xa6FaSHzPjbKrWA56COmdU6y5iocDpgqc2ACczdmt0md+eZFhi3TkA5PukMmrc5
	gFJnUxIhOZ1G2wLVWSmYH5YgDGywtzA5AXcnE0vFtTVPD0J08DOx+qNpSELiIb7Yumc0ka
	8tDBTWvT0uarebSpqe1f+Equ3GYrFh8n86vxYPQwH8u7ovoO+rvjTqOoj3sFRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765783117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55OqeXvegQjYguOhoqwSL48wzxa/fxMqaq8Gb5eBZSI=;
	b=Rou69YT9I726ODFA9dpaDAPI7zKalRjMo7scRd4UFv3Fdxe0q7OpwaAdeDlbCgbl9oYltZ
	SJNDyE4swKepLHDQ==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Drop vestigial PBE logic in AMD/Hygon/Centaur/Cyrix
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Pu Wen <puwen@hygon.cn>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251126125147.880275-1-andrew.cooper3@citrix.com>
References: <20251126125147.880275-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578311272.498.3625790823072042019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0bc03750deefc5fdab77b01c459bb1691c64c3c5
Gitweb:        https://git.kernel.org/tip/0bc03750deefc5fdab77b01c459bb1691c6=
4c3c5
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 26 Nov 2025 12:51:47=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:57:13 +01:00

x86/cpu: Drop vestigial PBE logic in AMD/Hygon/Centaur/Cyrix

Besides formatting changes, this logic dates back to Linux 2.4.0-test11 in
November 2000.

Prior to "Massive cleanup of CPU detection and bug handling",
c->x86_capability was a single u32 containing cpuid(1).edx,
cpuid(0x80000001).edx, or a synthesis thereof.  X86_FEATURE_AMD3D was
defined as the top bit this single u32.

After "Massive cleanup of CPU detection and bug handling",
c->x86_capability became an array with AMD's extended feature leaf split
away from Intel's basic feature leaf.

AMD doc #20734-G states that 3DNow is only enumerated in the extended
feature leaf, and that other vendors where using this bit too.  i.e. AMD
never produced a CPU which set bit 31 in the basic leaf, meaning that
there's nothing to clear out in the first place.

This logic looks like it was relevant in the pre-"Massive cleanup" world
but ought to have been dropped when c->x86_capability was properly split.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pu Wen <puwen@hygon.cn>
Link: https://patch.msgid.link/20251126125147.880275-1-andrew.cooper3@citrix.=
com
---
 arch/x86/kernel/cpu/amd.c     | 6 ------
 arch/x86/kernel/cpu/centaur.c | 6 ------
 arch/x86/kernel/cpu/cyrix.c   | 6 ------
 arch/x86/kernel/cpu/hygon.c   | 6 ------
 4 files changed, 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c04f53f..c792c2a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1051,12 +1051,6 @@ static void init_amd(struct cpuinfo_x86 *c)
=20
 	early_init_amd(c);
=20
-	/*
-	 * Bit 31 in normal CPUID used for nonstandard 3DNow ID;
-	 * 3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway
-	 */
-	clear_cpu_cap(c, 0*32+31);
-
 	if (c->x86 >=3D 0x10)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
=20
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index a3b55db..c839894 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -119,12 +119,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	u32  fcr_clr =3D 0;
 	u32  lo, hi, newlo;
 	u32  aa, bb, cc, dd;
-
-	/*
-	 * Bit 31 in normal CPUID used for nonstandard 3DNow ID;
-	 * 3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway
-	 */
-	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
 	init_intel_cacheinfo(c);
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index dfec2c6..8f22085 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -195,12 +195,6 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 	char *buf =3D c->x86_model_id;
 	const char *p =3D NULL;
=20
-	/*
-	 * Bit 31 in normal CPUID used for nonstandard 3DNow ID;
-	 * 3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway
-	 */
-	clear_cpu_cap(c, 0*32+31);
-
 	/* Cyrix used bit 24 in extended (AMD) CPUID for Cyrix MMX extensions */
 	if (test_cpu_cap(c, 1*32+24)) {
 		clear_cpu_cap(c, 1*32+24);
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 1fda6c3..7f95a74 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -174,12 +174,6 @@ static void init_hygon(struct cpuinfo_x86 *c)
=20
 	early_init_hygon(c);
=20
-	/*
-	 * Bit 31 in normal CPUID used for nonstandard 3DNow ID;
-	 * 3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway
-	 */
-	clear_cpu_cap(c, 0*32+31);
-
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
=20
 	/*

