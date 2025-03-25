Return-Path: <linux-tip-commits+bounces-4524-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8E6A6ED6A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B168516FE78
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F9253355;
	Tue, 25 Mar 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAklUpZP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bys5YYKL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180821C245C;
	Tue, 25 Mar 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897896; cv=none; b=UToa8h1wd8kdR6OzUUcReFjGHvObB0LwHO9BH5uHuQylWy3QiTVRphMNXUY+t9d9HEYNmxG/BQWEbwOgqFTL/58tV977rXFVm2+QNOIejaYjEVhzlYLaYJeSN/atBsX0lUIsSet4/9Plr7Nc/Pj/3L7pBcq3EV/5agy+S0s5w5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897896; c=relaxed/simple;
	bh=dYVAY2/kyeREhcgazF1hxHneWSBzHYujyMH+AF+tTfc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JmCjbV/P2WotnsumI3VLjzoYiOeqOtQDpUJ1gXwHmY7vPlJBzWKWVSCHPKB9Nx8RquIFVD3XjBor6QLenrVbH2s7FwRE3wj04JbBSVsFcQ+LQ14CJwAAIj5xTqClzhCMk/jOVmLFVEeZZZM47AvAmG4D/HvizTvR57jN+xbHt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAklUpZP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bys5YYKL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 10:18:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742897893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLHQtMJI88ToMI4NPTnzOhVzgrVjKvozP9ss0hi/E+M=;
	b=CAklUpZPmZare0amv5dQVpbx9ah5Hux/QTPjuJaUEkAwIf0C/7A+mIWI41jw/U9NNqFvvA
	HDTXTdDP66zbc8e5u9TYS2NFI8xCEOnh12SjihqibCMQSsGR/Ol048O2xwbJCPE91hQhSc
	2WueKPw4gqcn//DQ5e10FUl/Y7LmEerdVcaulJ4/+Gn5VcKekZvQUCzzOz5Yp99xfmTIXF
	yb5qNoTApxGX7yNbfL/pc6Wt9VheGGyefAi0GJvHe3C3dJrnkk5xsgsDiTM7RsBuAEtY4j
	g1aGCgxD0S7r7HdcXPntTdviWzMdWOTGO6f2a8gJFiGFfb/9Xa6XhWAJgAsiVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742897893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLHQtMJI88ToMI4NPTnzOhVzgrVjKvozP9ss0hi/E+M=;
	b=bys5YYKLzW7mTDAzUrPL9mqAi0LF1lr/RTQsnkox1sB8VTUmszn0cs0S9uMZecLQON6NdU
	ZDAguKaI8Fu1O/AQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Remove xstate offset check
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320234301.8342-2-chang.seok.bae@intel.com>
References: <20250320234301.8342-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289789282.14745.8464947563647511728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     937a3c877f7c84103891a2319e24626bf3a4d8a5
Gitweb:        https://git.kernel.org/tip/937a3c877f7c84103891a2319e24626bf3a4d8a5
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 20 Mar 2025 16:42:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 11:02:20 +01:00

x86/fpu/xstate: Remove xstate offset check

Traditionally, new xstate components have been assigned sequentially,
aligning feature numbers with their offsets in the XSAVE buffer. However,
this ordering is not architecturally mandated in the non-compacted
format, where a component's offset may not correspond to its feature
number.

The kernel caches CPUID-reported xstate component details, including size
and offset in the non-compacted format. As part of this process, a sanity
check is also conducted to ensure alignment between feature numbers and
offsets.

This check was likely intended as a general guideline rather than a
strict requirement. Upcoming changes will support out-of-order offsets.
Remove the check as becoming obsolete.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250320234301.8342-2-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a41d16..542c698 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -216,9 +216,6 @@ static bool xfeature_enabled(enum xfeature xfeature)
 static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
-	/* start at the beginning of the "extended state" */
-	unsigned int last_good_offset = offsetof(struct xregs_state,
-						 extended_state_area);
 	/*
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
@@ -246,16 +243,6 @@ static void __init setup_xstate_cache(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
-
-		/*
-		 * In our xstate size checks, we assume that the highest-numbered
-		 * xstate feature has the highest offset in the buffer.  Ensure
-		 * it does.
-		 */
-		WARN_ONCE(last_good_offset > xstate_offsets[i],
-			  "x86/fpu: misordered xstate at %d\n", last_good_offset);
-
-		last_good_offset = xstate_offsets[i];
 	}
 }
 

