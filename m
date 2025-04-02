Return-Path: <linux-tip-commits+bounces-4623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29CA795F3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 21:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C623B1A24
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24B7DA6A;
	Wed,  2 Apr 2025 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R7e21bGM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5pZoS6Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E8537FF;
	Wed,  2 Apr 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622570; cv=none; b=UrzU0Sqjw9g7K04LiRdghejMRx6YtO6A6M/mjyUxVDXb5Aln2mu88QDXTmPCOk41HVNtefalQ8VFxmc/H5vB45hDKdyje+PaGpo3ukoBamhkUpCNnhA/mkVNjl1beBRTKdmeuA2wtdxZXDKGWzJJVBRhpR8rkR3a/wIE69TQBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622570; c=relaxed/simple;
	bh=QYxUp1y3lHcSXqBzuM7abL8xgi2CljGY8fj8TZh/lOg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NT++CAmRXoRA682pteae2H5pPsR3VkuGLGNh89LixgkTbNA3hX0zbKgidO/hyaxsnRcbaVdIWtZYfHQ7j6Q9GcO9ykOgGg6bOCCG/+nSezGyR4zY2e4V3IOnkI9UGg9uKdgRGJVWY3J5EZ9+UPbkki2CKKKcYWtIPlX1IbyTje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R7e21bGM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5pZoS6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Apr 2025 19:35:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743622564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bR2qg4JPikLG9Ta9Cmh0yEx+tdJ0hQfvjEOwlIlvRTA=;
	b=R7e21bGM3PZDw9MDHrm2CKlNFjGUPSKJXkJoTfVPNzYHk7W+ynzq4BCcJtxlYmttM9xlyZ
	S62TxL9I/75EBfxqxJF5kGdNIP2ZkxMT80tKsQDBy5CD2q59HG3MWQczOoCDcriRVwbVE1
	P/aSIINWvXMeIqjRcT/+rO0ASdGe72U2dNOofloVy+miBkl2hq2kt9qmTHAorQAgsw8RQi
	ptFxm4/nF+gtvRtTDO752fp8oU/pQhRyPuJrehzAEGz2bI0Ras8/vE+7bNiQAvQv1PtLAj
	GYnaI05snL4l6PaUGt3R7yaQlKahdC20DgX8mDRf/ER27rwVEYd1oFx69sKFEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743622564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bR2qg4JPikLG9Ta9Cmh0yEx+tdJ0hQfvjEOwlIlvRTA=;
	b=q5pZoS6QDMia24uKO3se9oNLAWxyynk+gOFxVEPf14FfdWlCRqfX0SJDpvRz/wxOI9SQ3A
	cMHJwmixneyXfQCQ==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/idle: Remove MFENCEs for X86_BUG_CLFLUSH_MONITOR in
 mwait_idle_with_hints() and prefer_mwait_c1_over_halt()
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402172458.1378112-1-andrew.cooper3@citrix.com>
References: <20250402172458.1378112-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174362255303.14745.1652478957395983511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     fda2d1d86abc2d83ce6163536cc75c1f9fec1d72
Gitweb:        https://git.kernel.org/tip/fda2d1d86abc2d83ce6163536cc75c1f9fec1d72
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 02 Apr 2025 18:24:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 02 Apr 2025 21:27:49 +02:00

x86/idle: Remove MFENCEs for X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints() and prefer_mwait_c1_over_halt()

The following commit, 12 years ago:

  7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")

added barriers around the CLFLUSH in mwait_idle_with_hints(), justified with:

  ... and add memory barriers around it since the documentation is explicit
  that CLFLUSH is only ordered with respect to MFENCE.

This also triggered, 11 years ago, the same adjustment in:

  f8e617f45829 ("sched/idle/x86: Optimize unnecessary mwait_idle() resched IPIs")

during development, although it failed to get the static_cpu_has_bug() treatment.

X86_BUG_CLFLUSH_MONITOR (a.k.a the AAI65 errata) is specific to Intel CPUs,
and the SDM currently states:

  Executions of the CLFLUSH instruction are ordered with respect to each
  other and with respect to writes, locked read-modify-write instructions,
  and fence instructions[1].

With footnote 1 reading:

  Earlier versions of this manual specified that executions of the CLFLUSH
  instruction were ordered only by the MFENCE instruction.  All processors
  implementing the CLFLUSH instruction also order it relative to the other
  operations enumerated above.

i.e. The SDM was incorrect at the time, and barriers should not have been
inserted.  Double checking the original AAI65 errata (not available from
intel.com any more) shows no mention of barriers either.

Note: If this were a general codepath, the MFENCEs would be needed, because
      AMD CPUs of the same vintage do sport otherwise-unordered CLFLUSHs.

Furthermore, use a plain alternative(), rather than static_cpu_has_bug() and/or
no optimisation.  The workaround is a single instruction.

Use an explicit %rax pointer rather than a general memory operand, because
MONITOR takes the pointer implicitly in the same way.

[ mingo: Cleaned up the commit a bit. ]

Fixes: 7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20250402172458.1378112-1-andrew.cooper3@citrix.com
---
 arch/x86/include/asm/mwait.h |  9 +++------
 arch/x86/kernel/process.c    |  9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index ce857ef..54dc313 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -116,13 +116,10 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
-		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
-			mb();
-			clflush((void *)&current_thread_info()->flags);
-			mb();
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 
 		if (!need_resched()) {
 			if (ecx & 1) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 91f6ff6..bda47d9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -907,13 +907,10 @@ static __init bool prefer_mwait_c1_over_halt(void)
 static __cpuidle void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
-		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
-			mb(); /* quirk */
-			clflush((void *)&current_thread_info()->flags);
-			mb(); /* quirk */
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 		if (!need_resched()) {
 			__sti_mwait(0, 0);
 			raw_local_irq_disable();

