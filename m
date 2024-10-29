Return-Path: <linux-tip-commits+bounces-2631-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B859B44A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 09:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE57283C95
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D72040B5;
	Tue, 29 Oct 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqPL5AMn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8U3hU9t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672320401E;
	Tue, 29 Oct 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191528; cv=none; b=WWAx1InoRWn9St62BYoHHhtufgc0kMwQAcL7jeEiaDYvbZ6PoxE7rJf1Rvb+lKygFHU3Wq16oZ50iyPd0DBkFrToafMZ+6mbdg0dzDUO3AyFLr0mWOpivPiB/I8hzj+FoUnyjzXgFB4H0lZy2W7oPcEq5CLqimashHMAwB2kSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191528; c=relaxed/simple;
	bh=vsNwpXI0KRMsutJXBqEotp/ieDY2D1Xq0zrnsKMjvGE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fkXpmZSM3++yNuZ3OvpCFOB9UwDT/KvZGBszszhpa4twx4nw6fca2Pf9BJRswWEuboh6Nc3w0/6SzP0VTvgtX2mTS3NbuyftYYPymD49yBfPyDObx5nnvvXMc7aD1equUc9u/CDJXKOR/7IRpjzmPxPp0lwtX25QA5/H2nahU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqPL5AMn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8U3hU9t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 08:45:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730191524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nIyj7r4lYRQ3tuchXInzFIagz/qiHafZhnOb9dkeAnQ=;
	b=DqPL5AMnTP76Pq8dUnxlPiQYibA+0b8cc/kxl3konPtqHnkChD/HwF4ZXzkr8offmWifdD
	EUfS0l2Ml2TzRYAfxkmBCVAfUnCiy4yMoV06Cx0225lDce2V25j7M5UegThCErgI2ceBzq
	v+Wf12vR4/Bcd5ah0GHSOJzjnZbb8sDXLVkkG5FXp3LnRlSutj5K2ISIp8S5euCV5whmrd
	Po0ICjmtCzmSpdiUWe7MHRYEL/MKIzQsm+G72mO9GCAAe/yrlqf8i8k9TBH6AH96JUkCUt
	bzEYvQ2NrkY8hi0ox8GUpEEU605TPbud+K6Lnl7X5KYX/tSG9wpghSFSRKgK0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730191524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nIyj7r4lYRQ3tuchXInzFIagz/qiHafZhnOb9dkeAnQ=;
	b=g8U3hU9th9GCZrHGf9Cb5sApWaHTrf4fjONzPLKwVqKffofh9s23PKTDY6CrjdsIonDPWl
	fKG33OmAKB5NX4Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Cleanup flush_sigqueue_mask()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173019152387.1442.13483128683837906223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e19b317fbac41c8901f0d3e71fc90bfebbe47880
Gitweb:        https://git.kernel.org/tip/e19b317fbac41c8901f0d3e71fc90bfebbe47880
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 09:39:05 +01:00

signal: Cleanup flush_sigqueue_mask()

Mop up the stale return value comment and add a lockdep check instead of
commenting on the locking requirement.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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
 

