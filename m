Return-Path: <linux-tip-commits+bounces-4644-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A044FA7A3CA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A502418967DD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275B42505BD;
	Thu,  3 Apr 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUBZVq/w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qv3ZMXyR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7724EA99;
	Thu,  3 Apr 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687226; cv=none; b=SXbq+OMxhyYOwe3aUePJ6cKM7pYFdRAsSwd//FTSzPDPMwklwPyrX+DUGPTqee1M7X3zAK0oLVs9K3SmNs/uDFSQ4JP58U/aR+QXYKsVpFGG59GWqVRQt+kxeTr6DI8UeBF1GSMrXJvl8+mxEHLA3/YXyYbleDb6tzBn5xiPZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687226; c=relaxed/simple;
	bh=Shb0iUGYo+PQuq5icSnRBhSoiaS34oA7cwPptXDQr+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SBYpuCjtCvFgYCx2qlJ/ZKVDoODvUc7hNxeJ/z84e8BchIgFYX0aGcqHI7rMcip8te8ZsXDzo6cz7ZGF/EnDJcUHiZLXW8yLM16tEnYSPyDP/jpVbl0opKaZHQGUdPmX4XqEYJCZxiwr3F8EM6hmN8fCwRGtcqPBw/ND1uYCB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUBZVq/w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qv3ZMXyR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpKcaxvmHwTgVORBijsdONeNBE/852PlzD5wFDCTTbY=;
	b=EUBZVq/wgb04gMiwGwcSwWw0kqO4xaWc+H7meY9UEp6n0p+BSI4IEJeedj0dR2aAMWR+wL
	c2z2/uMmkN4DvxBiM92O0fzB7DcJ+KMiFWJooC4Sb37MLc5pLtxfjl/eAim+NAVR+nfGFB
	poQNu/NECviwoyr8rGx8TpiAAt3r4Rh3WfgmPh8dWybHUIKRdbLNmr953GZoj6ZQfoypcm
	+P66M8d6KZbzC1hWUk/NaLH8bT4TPD6COqnspaCok5viBQU8nnLdS9QJ8hLdsJBFYrww7Q
	aCfv4FY2d7N8laveQf3hooNLEMrnKHsQANHn1Bet0ZVH+XWyUr4vBDl94zriUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpKcaxvmHwTgVORBijsdONeNBE/852PlzD5wFDCTTbY=;
	b=Qv3ZMXyRl46k2URBAI0wId8PLMxYYSTg9Up6e7XOKyEGQxXxu6HXPeg8RR1ysVO1EBVXPW
	e9NgLFY9Gl8iiSAA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Improve and relocate NMI handler comments
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-7-sohil.mehta@intel.com>
References: <20250327234629.3953536-7-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722072.30396.2890770040949864219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     59cddd397accfa92fc36c223e3d532b47fdab841
Gitweb:        https://git.kernel.org/tip/59cddd397accfa92fc36c223e3d532b47fdab841
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:26 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:16 +02:00

x86/nmi: Improve and relocate NMI handler comments

Some of the comments in the default NMI handling code are out of place
or inadequate. Move them to the appropriate locations and update them as
needed.

Move the comment related to CPU-specific NMIs closer to the actual code.
Also, add more details about how back-to-back NMIs are detected since
that isn't immediately obvious.

Opportunistically, replace an #ifdef section in the vicinity with an
IS_ENABLED() check to make the code easier to read.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-7-sohil.mehta@intel.com
---
 arch/x86/kernel/nmi.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 2a07c9a..59ed74e 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -359,17 +359,18 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	bool b2b = false;
 
 	/*
-	 * CPU-specific NMI must be processed before non-CPU-specific
-	 * NMI, otherwise we may lose it, because the CPU-specific
-	 * NMI can not be detected/processed on other CPUs.
-	 */
-
-	/*
-	 * Back-to-back NMIs are interesting because they can either
-	 * be two NMI or more than two NMIs (any thing over two is dropped
-	 * due to NMI being edge-triggered).  If this is the second half
-	 * of the back-to-back NMI, assume we dropped things and process
-	 * more handlers.  Otherwise reset the 'swallow' NMI behaviour
+	 * Back-to-back NMIs are detected by comparing the RIP of the
+	 * current NMI with that of the previous NMI. If it is the same,
+	 * it is assumed that the CPU did not have a chance to jump back
+	 * into a non-NMI context and execute code in between the two
+	 * NMIs.
+	 *
+	 * They are interesting because even if there are more than two,
+	 * only a maximum of two can be detected (anything over two is
+	 * dropped due to NMI being edge-triggered). If this is the
+	 * second half of the back-to-back NMI, assume we dropped things
+	 * and process more handlers. Otherwise, reset the 'swallow' NMI
+	 * behavior.
 	 */
 	if (regs->ip == __this_cpu_read(last_nmi_rip))
 		b2b = true;
@@ -383,6 +384,11 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	if (microcode_nmi_handler_enabled() && microcode_nmi_handler())
 		goto out;
 
+	/*
+	 * CPU-specific NMI must be processed before non-CPU-specific
+	 * NMI, otherwise we may lose it, because the CPU-specific
+	 * NMI can not be detected/processed on other CPUs.
+	 */
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
 	if (handled) {
@@ -419,13 +425,14 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 			pci_serr_error(reason, regs);
 		else if (reason & NMI_REASON_IOCHK)
 			io_check_error(reason, regs);
-#ifdef CONFIG_X86_32
+
 		/*
 		 * Reassert NMI in case it became active
 		 * meanwhile as it's edge-triggered:
 		 */
-		reassert_nmi();
-#endif
+		if (IS_ENABLED(CONFIG_X86_32))
+			reassert_nmi();
+
 		__this_cpu_add(nmi_stats.external, 1);
 		raw_spin_unlock(&nmi_reason_lock);
 		goto out;

