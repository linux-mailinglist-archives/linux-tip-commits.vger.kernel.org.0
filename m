Return-Path: <linux-tip-commits+bounces-2359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED29941E7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B844428BEAA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3320C466;
	Tue,  8 Oct 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ye/m7ev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odRrVpgu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A81E47CD;
	Tue,  8 Oct 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374185; cv=none; b=oaNw1PPAoAsNtlEJQiveB6PxDQsNGnAKQFIPGqrNQzzGExpNwtnCSS4mQOhSw0XrLl5EucZQJEX+h8M6RSpWpc9emQC3kFJrfcWr1flTj45NftycDRMt/3K2KsAFRbPU1abYnijt105yqhVDLgnsEwFQUlKskfontYIyW9nL2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374185; c=relaxed/simple;
	bh=gVgDuVu6h/+4tN4+L5h+kOuMYr1cPtzw3BC/Gk8lfIU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LiKniei666CG0eHm2ZunnX5++AZeiyfn/ULU4h1WaD9FqmRHJozuRjiw/SsQ9zpbvGPmezpfBtfXCrskGW7Pp3Y2TIMLUXEmJbUU/sm1LbgdVIBWP+0CkzYNqEPwIME7bpRUKHFWg9hMbGmXD4LaxuRsa6ZCkvfO6MEqAG8HBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ye/m7ev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odRrVpgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zanghilEgP6Bg/N/KxMqzLgx6PNzk/oKxjWNLv2b/qM=;
	b=2ye/m7evRiLN6qcwOIDXmlG6BJ2KP3rzwjQFKDaqSaXJQgx7sBuHO+srQU0OaCW58fdMkC
	rR28pvl/QGdlwbMkH1cujx65TliXmIvh2rsG1XtMmJQ0QL5EyQLDWzQnHqdFatB8IicOPx
	8yLAwPcAF6r4u8BJRcV2BCIIrsZqyYrTte6p2mwz3JviUJ5VK0+a/x1BHmmgYmfYa1kdzY
	5TfP1FemhRtx89uL7Vvr3l0OFSbxc/o1cmJN5DBZ+1FsbsvrxtVAvf7hmvx9TPkCLFfEVp
	+fGPh3jUpHpV/NZYenHSsO2h9LpJJc1OTpO0BrwuWq0q4wCgw4EsuMkZ/IFXNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zanghilEgP6Bg/N/KxMqzLgx6PNzk/oKxjWNLv2b/qM=;
	b=odRrVpgugasjEVfiqHPbhhyMoXxoXP/NRaTZXZqPT1QMHTw6lN5rFyuOdN6pLEmVMLFrsz
	34O6/FTG1UuhNgCA==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] softirq: use bit waits instead of var waits.
Cc: NeilBrown <neilb@suse.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-8-neilb@suse.de>
References: <20240925053405.3960701-8-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418103.1442.7837579642724319886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     49994911b401c5f6b979060ffbc834949a024d8a
Gitweb:        https://git.kernel.org/tip/49994911b401c5f6b979060ffbc834949a024d8a
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:44 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:39 +02:00

softirq: use bit waits instead of var waits.

The waiting in softirq.c is always waiting for a bit to be cleared.
This makes the bit wait functions seem more suitable.
By switching over we can rid of all explicit barriers.  We also use
wait_on_bit_lock() to avoid an explicit loop.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-8-neilb@suse.de
---
 kernel/softirq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e78..b756d6b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -748,10 +748,8 @@ EXPORT_SYMBOL(__tasklet_hi_schedule);
 
 static bool tasklet_clear_sched(struct tasklet_struct *t)
 {
-	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
-		wake_up_var(&t->state);
+	if (test_and_clear_wake_up_bit(TASKLET_STATE_SCHED, &t->state))
 		return true;
-	}
 
 	WARN_ONCE(1, "tasklet SCHED state not set: %s %pS\n",
 		  t->use_callback ? "callback" : "func",
@@ -871,8 +869,7 @@ void tasklet_kill(struct tasklet_struct *t)
 	if (in_interrupt())
 		pr_notice("Attempt to kill tasklet from interrupt\n");
 
-	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
-		wait_var_event(&t->state, !test_bit(TASKLET_STATE_SCHED, &t->state));
+	wait_on_bit_lock(&t->state, TASKLET_STATE_SCHED, TASK_UNINTERRUPTIBLE);
 
 	tasklet_unlock_wait(t);
 	tasklet_clear_sched(t);
@@ -882,16 +879,13 @@ EXPORT_SYMBOL(tasklet_kill);
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 void tasklet_unlock(struct tasklet_struct *t)
 {
-	smp_mb__before_atomic();
-	clear_bit(TASKLET_STATE_RUN, &t->state);
-	smp_mb__after_atomic();
-	wake_up_var(&t->state);
+	clear_and_wake_up_bit(TASKLET_STATE_RUN, &t->state);
 }
 EXPORT_SYMBOL_GPL(tasklet_unlock);
 
 void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	wait_var_event(&t->state, !test_bit(TASKLET_STATE_RUN, &t->state));
+	wait_on_bit(&t->state, TASKLET_STATE_RUN, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(tasklet_unlock_wait);
 #endif

