Return-Path: <linux-tip-commits+bounces-2793-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5279BFB95
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5011C20B80
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60CF192D73;
	Thu,  7 Nov 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Me28Xocn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSsK2W3n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C419067A;
	Thu,  7 Nov 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943103; cv=none; b=J3Yf7E9CKMzSO/ldpD66csQuMu8kd9u5ClVCA3nNNCspQZE53hCqxRHp/TV0+A6X02GMeekVm0uWTWvP27PzfTddqzMaDoQV2zcMpyRhkWdYM0DWzeuOyHZWn7QSYvxrbF0lKqm3TvFv98/ikE59qm6d5RYSE5Me7gLe5xCU1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943103; c=relaxed/simple;
	bh=PJtCthtm4M0QrLviTwnmjFA5kdRQfJP8g3xyZ1EkDu4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gEEcHmWBySir9vuyKv14/RhbDBH8fOO5HAaUspkoYOhmK+xX2aJDxIsOT8xGYmRiKYgFrq2af0M2dfv9e1yOIDI0UloGXt8zF5Lueb8UL/wPu3qHESXQsqLyBNOEyIKoTBU72GSptnbbAwqyi0HGq7H+NSvctMH9Jvp2kBqoaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Me28Xocn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QSsK2W3n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTtOvon9IwJ729l+wIxqIR9Pk1g/4MQ0PATa+5s/4cI=;
	b=Me28Xocnz431XkjZ69SSKbuXUNOihI+BTmT5msERYiQnmFe0+hzILnErf7psAgvsF6AZ3x
	YTF4YvzCQoMLM0OvLtHkXajkjTbQzXJvd9uEWI0uvsriPaZocHXR+9V9XUA7Zwjt6Xbk94
	71LbuA7VXtgKQc+TIJNkRqkiQmPD35uAobvQta3tkaUiC8h8nvEWf4nvg1LnRHQt5PXD+M
	i4uduka7RrR8fMkxCAp2AC86UlINEV0yitlY8vf6mZ91F64s/Zsys6x+mkw/tml/NRo2bs
	PSDhKmJJWqaB6ZZtLluZoal3DCRmvAFg2Xt5TaCtSv+r9+mfqKGsimo+6+bG6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTtOvon9IwJ729l+wIxqIR9Pk1g/4MQ0PATa+5s/4cI=;
	b=QSsK2W3n8lz5f+8VH36RbaSiGuLVmCgnLErPeTXoNN/FdFU+KOmLLWGwjJK/Al2k4NrzF3
	+5e2Y8lztjyE1RAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Split up __sigqueue_alloc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.371410037@linutronix.de>
References: <20241105064213.371410037@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309953.32228.8770388453597481954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5cac427f7971b0619ebbfc131ef81fcf229c3c01
Gitweb:        https://git.kernel.org/tip/5cac427f7971b0619ebbfc131ef81fcf229c3c01
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:44 +01:00

signal: Split up __sigqueue_alloc()

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Reorganize __sigqueue_alloc() so the ucounts retrieval and the
initialization can be used independently.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.371410037@linutronix.de

---
 kernel/signal.c | 52 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ba7159b..dbd4247 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -396,16 +396,9 @@ void task_join_group_stop(struct task_struct *task)
 	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
-/*
- * allocate a new signal queue record
- * - this may be called without locks if and only if t == current, otherwise an
- *   appropriate lock must be held to stop the target task from exiting
- */
-static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-		 int override_rlimit, const unsigned int sigqueue_flags)
+static struct ucounts *sig_get_ucounts(struct task_struct *t, int sig,
+				       int override_rlimit)
 {
-	struct sigqueue *q = NULL;
 	struct ucounts *ucounts;
 	long sigpending;
 
@@ -424,19 +417,44 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	if (!sigpending)
 		return NULL;
 
-	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
-	} else {
+	if (unlikely(!override_rlimit && sigpending > task_rlimit(t, RLIMIT_SIGPENDING))) {
+		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		print_dropped_signal(sig);
+		return NULL;
 	}
 
-	if (unlikely(q == NULL)) {
+	return ucounts;
+}
+
+static void __sigqueue_init(struct sigqueue *q, struct ucounts *ucounts,
+			    const unsigned int sigqueue_flags)
+{
+	INIT_LIST_HEAD(&q->list);
+	q->flags = sigqueue_flags;
+	q->ucounts = ucounts;
+}
+
+/*
+ * allocate a new signal queue record
+ * - this may be called without locks if and only if t == current, otherwise an
+ *   appropriate lock must be held to stop the target task from exiting
+ */
+static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+					 int override_rlimit, const unsigned int sigqueue_flags)
+{
+	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
+	struct sigqueue *q;
+
+	if (!ucounts)
+		return NULL;
+
+	q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+	if (!q) {
 		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
-	} else {
-		INIT_LIST_HEAD(&q->list);
-		q->flags = sigqueue_flags;
-		q->ucounts = ucounts;
+		return NULL;
 	}
+
+	__sigqueue_init(q, ucounts, sigqueue_flags);
 	return q;
 }
 

