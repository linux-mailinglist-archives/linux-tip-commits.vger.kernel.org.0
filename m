Return-Path: <linux-tip-commits+bounces-2783-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B09BFB7F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC681F229F8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85572940D;
	Thu,  7 Nov 2024 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hkOWYENf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tu8VgKs/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA312B63;
	Thu,  7 Nov 2024 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943096; cv=none; b=ND0ncZkOGPwDeVYmDzWnzoh7H1A+s+7fRYjJb7Vp0rMt99ScZ2UOjcPK/IsVp8NJRUBt6lnEKCkVonRbeie3O4bOpuNDTsirzuLjf6tc9DZb9jssNr4SpA0Y0ztxqpDPTYKORUmgIZg2z03AR4ig5HOIJm4ubeejSmyWVx9fpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943096; c=relaxed/simple;
	bh=vGzoATPQoiZQAZ498Xx+ENUMwUgbPMtmfcZgwAFEavg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I+bLA2lDy4QimXmc7Mn7TUtxShHARPhv1QXBJ5GHLUqZAQjqvL/fgpCpciNZjUc5nagksSnI90h+Fw+rvJEeYZUSH/5RyOLju/sAcaGPPk5FmpHEBOotPngX/XYacKyXf1/drDuu83yCGfTh+ftquT1x+JYCbeAasJ0us2hSLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hkOWYENf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tu8VgKs/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMuWTzzApAViGJIw+oeHPk29nS9dq0Ggfp2KIO9JGeI=;
	b=hkOWYENfiNpLAslP6cnzBncn9LO/xTPhbOLNWONR06LMhqgaNfKHPy1h6Vlap6UPKSN8eq
	aB9/SvdGKjZvH5KkAZtlE9QNtgAZN7OtuJSiigPy/dkLn2nLu0smHjXf5hESUBsvBvOxIX
	Pq9zbMsSvXBfk+6kfCiDHOdX8DmwEr07Wp76DCzQGGRPqq3uKOv7gmvdtgnv23dpL/uycB
	jvqOggyzpnNmtWMZSzHn4xP1tdcF5sCCIyaz8WGuvk9c+tRe4grBEheUjcra07M5pFON96
	IxIacpTEo/hnvp7pdJuIwMxDKwDCpVBMajWtloLlMlrBwo1z+S0TTA3M/cnU+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMuWTzzApAViGJIw+oeHPk29nS9dq0Ggfp2KIO9JGeI=;
	b=tu8VgKs/IzBZBrue9mAg482NWCoolnxs2ThpT1Qeww+/mSVUX4jnIrGSIxypBqrwip+/61
	UddTbpZ/marfoOBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064214.054091076@linutronix.de>
References: <20241105064214.054091076@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309217.32228.17189886987510380791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     caf77435dd8a52cb39c602bdf67d35d6f782f553
Gitweb:        https://git.kernel.org/tip/caf77435dd8a52cb39c602bdf67d35d6f782f553
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

signal: Handle ignored signals in do_sigaction(action != SIG_IGN)

When a real handler (including SIG_DFL) is installed for a signal, which
had previously SIG_IGN set, then the list of ignored posix timers has to be
checked for timers which are affected by this change.

Add a list walk function which checks for the matching signal number and if
found requeues the timers signal, so the timer is rearmed on signal
delivery.

Rearming the timer right away is not possible because that requires to drop
sighand lock.

No functional change as the counter part which queues the timers on the
ignored list is still missing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064214.054091076@linutronix.de

---
 kernel/signal.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d2734dc..908b49c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2002,7 +2002,54 @@ out:
 	unlock_task_sighand(t, &flags);
 	return ret;
 }
-#endif /* CONFIG_POSIX_TIMERS */
+
+static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
+{
+	struct hlist_head *head = &tsk->signal->ignored_posix_timers;
+	struct hlist_node *tmp;
+	struct k_itimer *tmr;
+
+	if (likely(hlist_empty(head)))
+		return;
+
+	/*
+	 * Rearming a timer with sighand lock held is not possible due to
+	 * lock ordering vs. tmr::it_lock. Just stick the sigqueue back and
+	 * let the signal delivery path deal with it whether it needs to be
+	 * rearmed or not. This cannot be decided here w/o dropping sighand
+	 * lock and creating a loop retry horror show.
+	 */
+	hlist_for_each_entry_safe(tmr, tmp , head, ignored_list) {
+		struct task_struct *target;
+
+		/*
+		 * tmr::sigq.info.si_signo is immutable, so accessing it
+		 * without holding tmr::it_lock is safe.
+		 */
+		if (tmr->sigq.info.si_signo != sig)
+			continue;
+
+		hlist_del_init(&tmr->ignored_list);
+
+		/* This should never happen and leaks a reference count */
+		if (WARN_ON_ONCE(!list_empty(&tmr->sigq.list)))
+			continue;
+
+		/*
+		 * Get the target for the signal. If target is a thread and
+		 * has exited by now, drop the reference count.
+		 */
+		guard(rcu)();
+		target = posixtimer_get_target(tmr);
+		if (target)
+			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
+		else
+			posixtimer_putref(tmr);
+	}
+}
+#else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
+#endif /* !CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
@@ -4180,6 +4227,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4200,6 +4249,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 			flush_sigqueue_mask(p, &mask, &p->signal->shared_pending);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(p, &mask, &t->pending);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 

