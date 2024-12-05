Return-Path: <linux-tip-commits+bounces-2982-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542349E58B1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D7916C3BB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BD21A420;
	Thu,  5 Dec 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYtoJWLb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Il4NKSTc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E0217725;
	Thu,  5 Dec 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409759; cv=none; b=BwCvn3APTB4Yv3TEAqhClH/0DZluK6BjsK4N6mRSe34JQgU02CXH/w3pMT8v8Ic53aIN+vsmkGNtjagfexWrDN2ZGRlAkMjFD8kV3tpDsHhrd8/XHUhxCAU3ZIqYNtS8zL0za9RYyCFuMqCPIKNQTPZHUF8t3vFqqhHA/lm813Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409759; c=relaxed/simple;
	bh=JbXfuVd+fgDIx1VcgZ0yI4CxBVFSrRBnZXM4EOLbq9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C/ROl/2rhdL8oOvVWKht8FNP7wpgNEUwmN1J/WNm9csgLQTyg8t+f73vSS93MBNe3FjYlzI0e+GGaJ4yjTLux4ClURGVRs+So79OZ8U27451GW/0K+5dsJWn4+1BjsCrGBofB+yYzNl5xZwMjaNlGNgYOZTfoEr8hv9/kjlxHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYtoJWLb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Il4NKSTc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 14:42:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733409751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oglFsZpt4nXaTaf2fMRwK/fuQATAzkdtHz/yhIZldYs=;
	b=NYtoJWLbkYXxJ6Axo2j4MiztR5IoickPC7LDGT2n9SMlIKOZru3BZsFd3+Ax+4fZnpM08w
	LljO8uZDzfHwmpRNZPgUvV38V604PgeKl801p13fDMQ4MdoAdTMSHhAyLiEegZDZmHw3n/
	wCFHUs0rf6IzM66OfhEH38+ptzCZhVjRFDpdiaBZSzAEOdarYQ2fhHRpLk7DufagClPNf1
	DWkTdPk1EJHPdKpXxuH1pth6qdasHsG0IURubRLLjPsX/0yK2TeGNB0TJbOkbtg2xYtAwR
	kAl6fk7YhPkEIrfXedYFiMJeZORP0spHozjtAsKrWx/Hd58P2Aq6L5KXKLaScQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733409751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oglFsZpt4nXaTaf2fMRwK/fuQATAzkdtHz/yhIZldYs=;
	b=Il4NKSTcOMJpRqNj844baTYen6JOM6+RCGIpV/mPGU19qkRMQ15SJVEg4L8o7OCIZ8AkqM
	3RzhueGHrAwcQ4DQ==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] smp/scf: Evaluate local cond_func() before IPI
 side-effects
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241203163558.3455535-1-mathieu.desnoyers@efficios.com>
References: <20241203163558.3455535-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340975062.412.259675542832546880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     63a48181fbcddefe5fb4c6618938bb64c543945b
Gitweb:        https://git.kernel.org/tip/63a48181fbcddefe5fb4c6618938bb64c543945b
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 03 Dec 2024 11:35:58 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 14:25:28 +01:00

smp/scf: Evaluate local cond_func() before IPI side-effects

In smp_call_function_many_cond(), the local cond_func() is evaluated
after triggering the remote CPU IPIs.

If cond_func() depends on loading shared state updated by other CPU's
IPI handlers func(), then triggering execution of remote CPUs IPI before
evaluating cond_func() may have unexpected consequences.

One example scenario is evaluating a jiffies delay in cond_func(), which
is updated by func() in the IPI handlers. This situation can prevent
execution of periodic cleanup code on the local CPU.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20241203163558.3455535-1-mathieu.desnoyers@efficios.com
---
 kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 27dc31a..f104c8e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -815,7 +815,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	WARN_ON_ONCE(!in_task());
 
 	/* Check if we need local execution. */
-	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
+	    (!cond_func || cond_func(this_cpu, info)))
 		run_local = true;
 
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
@@ -868,7 +869,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
-	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
+	if (run_local) {
 		unsigned long flags;
 
 		local_irq_save(flags);

