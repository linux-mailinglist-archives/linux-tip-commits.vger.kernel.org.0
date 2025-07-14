Return-Path: <linux-tip-commits+bounces-6112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A58B03A79
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBA017A9CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3023D2AC;
	Mon, 14 Jul 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MScR/NCL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpDOtgtj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3223D2A3;
	Mon, 14 Jul 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484260; cv=none; b=dnINBMCRND5Bp0pVQO0GQthZFxCBzI2n46NbuQsEV2Bx1US0DcnHo9ekp/uaYP/3to8vvJUgVGF+ddn6dXa5U7FKgGv7CMEUwmYiPiYzzmdTSOc9QSFlSOB7goKY8mGqtMEnmDDy+AKi1bDk9AvAn+ZX8Tyukd/M0SWnsqxfabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484260; c=relaxed/simple;
	bh=D3BLNavxz/BjoDrrh6uaq6rooy4kefdmCNX9wLeVaVM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uFJnfFkEvf9ZY/EKKe3lTfXgYwt0uqpJQA/RkV+YXBHYCYUuwSfO3eSWrZITFc+G+e+yVLL1dmP3tnalambXTc+ysDHehvCUQyyf5sEFgzRHe5CAGNV9Yd5vyh+jWkJaBhObKjt/jtWM2v0b4w29LLOPzPeT9jspzFpPXVZSL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MScR/NCL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpDOtgtj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i594CxCYoxCvrP1SwDX6ZjRkM3/gFuUSpuPs5/Mb8AU=;
	b=MScR/NCL7mrs92WPkSHsG+rAr0C5g+bOrrntYJWb9kgzGSW7KiC/nwgOeLxt9BATStE9kO
	87+Ofy2zjJ9UWLG2/XuVdBWQpKZVNMeoq6RKKXQ0aoWSX8ZlIJkUel2zi6pP/xOgF8mK1e
	EQmtc8D1HaOvP1pndU8LhOESYiyBnLDfh4SnMNR8PGXdmekrRQNRa/qQHdm7aTiCUFw2AF
	WbMTW892/jrgAv6kdFOMJz9ZROVXe36EEfJfHGuqydfhL21F38OWX7J5tuBNxqvwbfdx8D
	wf0k1KdfQ+41Iq+hIAT7c8EMZeAGStGmA3Wm//rZEnApjEcQ9yPIPuFSOz+M4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i594CxCYoxCvrP1SwDX6ZjRkM3/gFuUSpuPs5/Mb8AU=;
	b=EpDOtgtjkai+0WoOlPGgpq/Hcad0DuJkrAL+vTjQzvYL7eNjHok1nnM2ptOr+UKhLsgqMu
	0VDFJMH4VX0E7qBA==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Change nr_uninterruptible type to unsigned long
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250709173328.606794-1-aruna.ramakrishna@oracle.com>
References: <20250709173328.606794-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248425580.406.13717847490476677522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     36569780b0d64de283f9d6c2195fd1a43e221ee8
Gitweb:        https://git.kernel.org/tip/36569780b0d64de283f9d6c2195fd1a43e221ee8
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Wed, 09 Jul 2025 17:33:28 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:31 +02:00

sched: Change nr_uninterruptible type to unsigned long

The commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
32-bit") changed nr_uninterruptible to an unsigned int. But the
nr_uninterruptible values for each of the CPU runqueues can grow to
large numbers, sometimes exceeding INT_MAX. This is valid, if, over
time, a large number of tasks are migrated off of one CPU after going
into an uninterruptible state. Only the sum of all nr_interruptible
values across all CPUs yields the correct result, as explained in a
comment in kernel/sched/loadavg.c.

Change the type of nr_uninterruptible back to unsigned long to prevent
overflows, and thus the miscalculation of load average.

Fixes: e6fe3f422be1 ("sched: Make multiple runqueue task counters 32-bit")

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250709173328.606794-1-aruna.ramakrishna@oracle.com
---
 kernel/sched/loadavg.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index c48900b..52ca8e2 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (int)this_rq->nr_uninterruptible;
+	nr_active += (long)this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb59..83e3aa9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1149,7 +1149,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned int		nr_uninterruptible;
+	unsigned long 		nr_uninterruptible;
 
 	union {
 		struct task_struct __rcu *donor; /* Scheduler context */

