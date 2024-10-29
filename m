Return-Path: <linux-tip-commits+bounces-2642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2CE9B4800
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281B11F2392C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446E207203;
	Tue, 29 Oct 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OybYpns/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ihe5V+QI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA1206075;
	Tue, 29 Oct 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200164; cv=none; b=Oz2cSkOcGgaTdVAXG044d4Af77IHO41yBkG9eYf1xZk4aLSYYhfYsGTVqYYQ9uyoJX9w55Sok6IsQweB68XDurXb+neI8Cm/icHpoCa79gRy8OD+QK7wbcjRYEOo0/s+nX8ddWv8R2/su3QO6KU1aEF7BWNCoG72co1GqWULFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200164; c=relaxed/simple;
	bh=txGftgOJAB81jIDn0ZXFEtrRIdnrY6k/gZxP6hs+DHA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nvJE2oNqupMOoJn2P2t0PMxKHwUQM3BehKtYN+9/6otriX+6p2SK4j8oqBIi+vfjTJAgc3bPNQxcnWrL7aOwBQdO+tU1zte4LQScZQUFHn4qJu2WU+Y74ycY85YpDX3L4RJvSPKpHn+yjNDuMFlw+pMLPUbTGePw991NN6c2b+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OybYpns/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ihe5V+QI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:09:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730200158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ulcwdJ0khfh2xhovSU9hFirxze+aCpgDaQmOW/kSPs=;
	b=OybYpns/GIq9+ruJeVCp1ZpazzpkN/rgEf1zfHIjFazl+2LoxfzwzEY16GiIVEjpc1YfcB
	J3yK9wd0QI5DeFqijqjRqlCKFta/xRtEgqsEKHBMicyW95gN6Z4RufAlUWzBcEq4sWEGu+
	38GKwLUBJXHdBez7gGkbQ5paDdOlVcuRRzud2o5Yx/+FsLLosCQgdjpoEORdGQ/NrC5u25
	5Y3GVYWFYOvb3CBJFJkmlBWsCfD7Ciu3tXeApwuuKSBjab2SQipX2qf8dSh/1R20r+ytZ0
	zjOLQDyXsiuVmo1GkGwPMeBY6POQmuMrsH8BbNWC4qjIqOO5s7smVK36XyzEmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730200158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ulcwdJ0khfh2xhovSU9hFirxze+aCpgDaQmOW/kSPs=;
	b=ihe5V+QI5CcDN0GO3uWVnAHis9ITb4EbijZqZkIs9Xv+zb+0IudUIr3Ga4dx3rG2ArtQqa
	bXFKeYkR5jjg96Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Cleanup flush_sigqueue_mask()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083835.374933959@linutronix.de>
References: <20241001083835.374933959@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020015810.1442.6206650339161280666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a76e1bbe879cf39952ec4b43ed653b0905635f24
Gitweb:        https://git.kernel.org/tip/a76e1bbe879cf39952ec4b43ed653b0905635f24
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 11:43:18 +01:00

signal: Cleanup flush_sigqueue_mask()

Mop up the stale return value comment and add a lockdep check instead of
commenting on the locking requirement.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241001083835.374933959@linutronix.de

---
 kernel/signal.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b65cc18..f420c43 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -704,17 +704,14 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
 		kick_process(t);
 }
 
-/*
- * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
- *
- * All callers must be holding the siglock.
- */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+/* Remove signals in mask from the pending set and queue. */
+static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
 
+	lockdep_assert_held(&p->sighand->siglock);
+
 	sigandsets(&m, mask, &s->signal);
 	if (sigisemptyset(&m))
 		return;
@@ -848,18 +845,18 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(p, &flush, &signal->shared_pending);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(p, &flush, &t->pending);
 	} else if (sig == SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(p, &flush, &signal->shared_pending);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(p, &flush, &t->pending);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &= ~JOBCTL_STOPPED;
@@ -4114,8 +4111,8 @@ void kernel_sigaction(int sig, __sighandler_t action)
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
 
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(current, &mask, &current->signal->shared_pending);
+		flush_sigqueue_mask(current, &mask, &current->pending);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4182,9 +4179,9 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(p, &mask, &p->signal->shared_pending);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(p, &mask, &t->pending);
 		}
 	}
 

