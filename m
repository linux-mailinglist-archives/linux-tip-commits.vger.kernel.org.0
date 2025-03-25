Return-Path: <linux-tip-commits+bounces-4474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF025A6EC24
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BCE3B1CDB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D8254B05;
	Tue, 25 Mar 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qd8lkMXh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocFJfjjS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E0253F11;
	Tue, 25 Mar 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893543; cv=none; b=QKFFBd25a4Ds3At3dgfr5u3go972TKwgwGUv9VffXRmlSIlh4jIoPaa/PiJaBtVmOpHEdwcPsqSQfFcjXvASPKlmTgQEw2ZgUENlV9B+oPF4tceDR6EnFQBHJP4tpHjqV2mJfkRUtcOaojtyduhBjuvamAp8IxTEP9u/U1yrcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893543; c=relaxed/simple;
	bh=Npohv4lWVN4XS7+H/tIssGVk9BLEGAvAQ6P6qo3zvDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MDodpvBtY8pC0w/QNwYsH+E5MbILcEx+osYh/Pwoj4/0DNfXE5fI+w971lCP8vrO4W0UkwBvxJL+gHNDj1Ft4yU7PLf1JV/D7uLns9YyMOjLvQrOxglEJ9gdbXDK3BJtIA0piOqnaKggmbvx2QWHkTW/nuNdkHzSaFAlw4zmjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qd8lkMXh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocFJfjjS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAV+yjx6WSRjnc/EGaLSG1W3c11O6uL8hSvKjuIh9Cw=;
	b=Qd8lkMXhdfptXeehsefnxkLNWg23U4HeFVOylRbcaC8AN8Wz76yvYdlMk69Pe0i+h7r8N7
	EoMgATCL4kzCI2mAgUQ16g8plBIg4Q0eGtBv9Nt6oTxeuvjN1eXHKdgAfMrxHgLd/l40cl
	Q6Z/07rd5DWj5HbXmERCgTrz0qeQkNzFE54lbLC4DrM/MRe2mZR/jolIj5Zehb9T0nk2Mb
	ydW8yaBjgMGBmEl4LKp2+hmrRAwQhPJ8GiRlXTccqzyItKX7P35iSK1I712maH8uZ9Cksl
	lfhBc+JaeaI+cHHp6r19IyYDKXMEgovJsFIidRS6Yu9RPtEQzzQuZm5iyvpGow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAV+yjx6WSRjnc/EGaLSG1W3c11O6uL8hSvKjuIh9Cw=;
	b=ocFJfjjS98X6vfUXA4DYn/K4AzfETxt7HxudM46MbhnyqWSnGOz3ENlgwNtZioEgGCS2nc
	x95vX12BZfGQH3BQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Consolidate index validity checks
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-14-darwi@linutronix.de>
References: <20250324142042.29010-14-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354021.14745.1064590595168669636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     74d29127f83042500c20c903dd67151dbdd86ec8
Gitweb:        https://git.kernel.org/tip/74d29127f83042500c20c903dd67151dbdd86ec8
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:46 +01:00

tools/x86/kcpuid: Consolidate index validity checks

Let index_to_cpuid_range() return a CPUID range only if the passed index
is within a CPUID range's maximum supported function on the CPU.
Returning a CPUID range that is invalid on the CPU for the passed index
does not make sense.

This also avoids repeating the "function index is within CPUID range"
checks, both at setup_cpuid_range() and index_to_func().

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-14-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1f48de3..ac3d36b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -101,10 +101,12 @@ static char *range_to_str(struct cpuid_range *range)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
 {
+	u32 func_idx = index & CPUID_FUNCTION_MASK;
+	u32 range_idx = index & CPUID_INDEX_MASK;
 	struct cpuid_range *range;
 
 	for_each_cpuid_range(range) {
-		if (range->index == (index & CPUID_INDEX_MASK))
+		if (range->index == range_idx && (u32)range->nr > func_idx)
 			return range;
 	}
 
@@ -331,17 +333,16 @@ static void parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	/* Skip line parsing if it's not covered by known ranges */
+	/*
+	 * Skip line parsing if the index is not covered by known-valid
+	 * CPUID ranges on this CPU.
+	 */
 	range = index_to_cpuid_range(index);
 	if (!range)
 		return;
 
-	/* Skip line parsing for non-existing indexes */
-	index &= CPUID_FUNCTION_MASK;
-	if ((int)index >= range->nr)
-		return;
-
 	/* Skip line parsing if the index CPUID output is all zero */
+	index &= CPUID_FUNCTION_MASK;
 	func = &range->funcs[index];
 	if (!func->nr)
 		return;
@@ -505,17 +506,13 @@ static void show_range(struct cpuid_range *range)
 
 static inline struct cpuid_func *index_to_func(u32 index)
 {
+	u32 func_idx = index & CPUID_FUNCTION_MASK;
 	struct cpuid_range *range;
-	u32 func_idx;
 
 	range = index_to_cpuid_range(index);
 	if (!range)
 		return NULL;
 
-	func_idx = index & CPUID_FUNCTION_MASK;
-	if ((func_idx + 1) > (u32)range->nr)
-		return NULL;
-
 	return &range->funcs[func_idx];
 }
 

