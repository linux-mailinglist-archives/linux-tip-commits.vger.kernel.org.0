Return-Path: <linux-tip-commits+bounces-5254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE745AABCDB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC54E0476
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E40241663;
	Tue,  6 May 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T9Vb/ulC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1pApqld"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203823F42D;
	Tue,  6 May 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519348; cv=none; b=VMt+K30C82p/BSKxx6lGMXLvu/rG7S9F/6VYF3tiZguCTcmnR36CptaUmInKWnXhP8TCXWqbvphQGPXrf4z6Xu868sEOxgOUrqbf00yYJbHzzXIk1Cyp6vOk4ymu5enAWF9KKh2I5YyUY9pGOoBbvPUQCKkBS+49U/uT3rG2rTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519348; c=relaxed/simple;
	bh=YKjqfQvee2j2+nsXOxD9gXSQQ3Wln6g5vc+oPD25nOk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VD4Pne6ftfza9n5fUUFxwuMROBNYWKzC28ePzdSnePGNQB8eV5gbU0tBw3pTNEpUq0Q18gAu2z+7PaYrb1SnjmD+dbhCcxWyl5orMdwyrqvlmxjJdegh/uKVfc3GdqVjKWcMqwYDRv3raqAnAS86VkAw6tp31l3SQ+di/y90dSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T9Vb/ulC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1pApqld; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 08:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746519345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJuVUAXSSyw+InaimbZuOQtnqmauSCl3M20V+lzwRjs=;
	b=T9Vb/ulCVdiVOHujUqhFIzIAxNp6HuteNimLNUHbQ6Rh+i2u90lCADoK8FNtju1sSEaBp/
	oaV9+LGncp8483FSQWDp3TEHa00XRMW3rfzyHrWtEuP2gJJGg9gLjn0ETkyLGR/GlP/Cqz
	io7FDdi6wqtjvVuc3Byi3LLZ9eXRm+eEziYjFt1BTbqOKSq453T2S0IGWVJk5bN5Xv1z7T
	xEw74tONqOfEMPoCf3A/ZYRVc0iJsqTPJJj6ouBOIh0g/XyrnOgZNaHXwvijvAnUBFzHJG
	ZveiLXXc6w5zVbWDye73oxPPxvGRHqtUwfxnJszWI6NtuDWj6fPZm7nWjW/uQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746519345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJuVUAXSSyw+InaimbZuOQtnqmauSCl3M20V+lzwRjs=;
	b=t1pApqldFMDgAZEhV8n9biEeapPJNvE7zjWkJZC5u5uBTiOkyGmCsgkD9f9VmrSP72FzoR
	H5byt/NQF46TksBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Sanitize CPUID(0x80000000) output
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506050437.10264-3-darwi@linutronix.de>
References: <20250506050437.10264-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174651934390.406.14677915128369507134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     cc663ba3fe383a628a812f893cc98aafff39ab04
Gitweb:        https://git.kernel.org/tip/cc663ba3fe383a628a812f893cc98aafff39ab04
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 06 May 2025 07:04:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 10:04:57 +02:00

x86/cpu: Sanitize CPUID(0x80000000) output

CPUID(0x80000000).EAX returns the max extended CPUID leaf available.  On
x86-32 machines without an extended CPUID range, a CPUID(0x80000000)
query will just repeat the output of the last valid standard CPUID leaf
on the CPU; i.e., a garbage values.  Current tip:x86/cpu code protects against
this by doing:

	eax = cpuid_eax(0x80000000);
	c->extended_cpuid_level = eax;

	if ((eax & 0xffff0000) == 0x80000000) {
		// CPU has an extended CPUID range. Check for 0x80000001
		if (eax >= 0x80000001) {
			cpuid(0x80000001, ...);
		}
	}

This is correct so far.  Afterwards though, the same possibly broken EAX
value is used to check the availability of other extended CPUID leaves:

	if (c->extended_cpuid_level >= 0x80000007)
		...
	if (c->extended_cpuid_level >= 0x80000008)
		...
	if (c->extended_cpuid_level >= 0x8000000a)
		...
	if (c->extended_cpuid_level >= 0x8000001f)
		...

which is invalid.  Fix this by immediately setting the CPU's max extended
CPUID leaf to zero if CPUID(0x80000000).EAX doesn't indicate a valid
CPUID extended range.

While at it, add a comment, similar to kernel/head_32.S, clarifying the
CPUID(0x80000000) sanity check.

References: 8a50e5135af0 ("x86-32: Use symbolic constants, safer CPUID when enabling EFER.NX")
Fixes: 3da99c977637 ("x86: make (early)_identify_cpu more the same between 32bit and 64 bit")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250506050437.10264-3-darwi@linutronix.de
---
 arch/x86/kernel/cpu/common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4ada55f..e5734df 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1005,17 +1005,18 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
-	/* AMD-defined flags: level 0x80000001 */
+	/*
+	 * Check if extended CPUID leaves are implemented: Max extended
+	 * CPUID leaf must be in the 0x80000001-0x8000ffff range.
+	 */
 	eax = cpuid_eax(0x80000000);
-	c->extended_cpuid_level = eax;
+	c->extended_cpuid_level = ((eax & 0xffff0000) == 0x80000000) ? eax : 0;
 
-	if ((eax & 0xffff0000) == 0x80000000) {
-		if (eax >= 0x80000001) {
-			cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
+	if (c->extended_cpuid_level >= 0x80000001) {
+		cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
 
-			c->x86_capability[CPUID_8000_0001_ECX] = ecx;
-			c->x86_capability[CPUID_8000_0001_EDX] = edx;
-		}
+		c->x86_capability[CPUID_8000_0001_ECX] = ecx;
+		c->x86_capability[CPUID_8000_0001_EDX] = edx;
 	}
 
 	if (c->extended_cpuid_level >= 0x80000007) {

