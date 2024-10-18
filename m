Return-Path: <linux-tip-commits+bounces-2509-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21779A3699
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2881F22F48
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66417188719;
	Fri, 18 Oct 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DaXG1X28";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+K7Eo/d/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A341885B8;
	Fri, 18 Oct 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235271; cv=none; b=uTOVTReLQ3rIb3psSo1ZmWiFcf2RPGdGTN7VzzivnKiptEKRCmsYb/N0OQFZcETLvXzA0Mg70r7viC1sEqhNg33iDZs2AXvSgoFmZFMD+3+zj65qshe/3ayXKgQTTPr+NjiLXYARj1rNcJTmnkrFUdNSSowt0zdOocV+SLcmLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235271; c=relaxed/simple;
	bh=G+MS2Cm3gnAV32tHvPJ0mGoiY5o8Rirxx3SDmkzq3eg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HtNDBMHLApOr3EZCeDynSqq2+9ecN5fbCGluLOkiAol7BhdTOLi3xONcRK7hvvtb4tw9s0tnCZHQ0Knl+3jmjJMFNWgvyqTE3cmKkFQ6rcPTtJKcstHldC0HuLIHYGVvUdqeGf7Xq53VYxmT6stV5LhVEoVO1LF4oKiueqqPoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DaXG1X28; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+K7Eo/d/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4R4OQq6JSBa5DvrNQCYV1dLeFWL05F5wK9LdhQRJi0=;
	b=DaXG1X28nCKS7nK7BDcNxyrrQF3z+ewxKXPqaZZt6i9rZp8VcEzsFXKH6jaWvezX5lhhbo
	/uKMIAfe9jfM9N95ppBNAn5mBQaVFWylpuvSNE3hkZ5HgutjbXCWtC11u1sm1yljnXpA3R
	UmaLiMtpVgy1ND2KzaCM6UT/iwiR/hxZd0HoJMC0ooXY1dpxWMIrsKY885VqSkQNzlzTsu
	EWvLmn0LSlEFqjZ7Cysa6jfTaDeeWkhNiXh8apf2/zaicNjoApbo1ifMXqjK05mVvyIcEe
	sCQIgx/9S/Ut5DPyeobth2dYnEhF3pRRKOXHKeoZe3hu9QG+phaHxOuOHpkq4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4R4OQq6JSBa5DvrNQCYV1dLeFWL05F5wK9LdhQRJi0=;
	b=+K7Eo/d/uYPTDLFS51s9dFqCHnUQyh4EbW6cCNrQLP+Xg0GmNG03OQF5M1pKeM86XNMt3P
	cXJqlir5GR1o57CQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Split out __schedule() deactivate task logic
 into a helper
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Metin Kaya <metin.kaya@arm.com>, Qais Yousef <qyousef@layalina.io>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009235352.1614323-7-jstultz@google.com>
References: <20241009235352.1614323-7-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526117.1442.11641248208406837165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7b3d61f6578ab06f130ecc13cd2f3010a6c295bb
Gitweb:        https://git.kernel.org/tip/7b3d61f6578ab06f130ecc13cd2f3010a6c295bb
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Wed, 09 Oct 2024 16:53:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:41 +02:00

sched: Split out __schedule() deactivate task logic into a helper

As we're going to re-use the deactivation logic,
split it into a helper.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20241009235352.1614323-7-jstultz@google.com
---
 kernel/sched/core.c | 67 ++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab0b775..b534de6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6491,6 +6491,45 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #define SM_RTLOCK_WAIT		2
 
 /*
+ * Helper function for __schedule()
+ *
+ * If a task does not have signals pending, deactivate it
+ * Otherwise marks the task's __state as RUNNING
+ */
+static bool try_to_block_task(struct rq *rq, struct task_struct *p,
+			      unsigned long task_state)
+{
+	int flags = DEQUEUE_NOCLOCK;
+
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		return false;
+	}
+
+	p->sched_contributes_to_load =
+		(task_state & TASK_UNINTERRUPTIBLE) &&
+		!(task_state & TASK_NOLOAD) &&
+		!(task_state & TASK_FROZEN);
+
+	if (unlikely(is_special_task_state(task_state)))
+		flags |= DEQUEUE_SPECIAL;
+
+	/*
+	 * __schedule()			ttwu()
+	 *   prev_state = prev->state;    if (p->on_rq && ...)
+	 *   if (prev_state)		    goto out;
+	 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+	 *				  p->state = TASK_WAKING
+	 *
+	 * Where __schedule() and ttwu() have matching control dependencies.
+	 *
+	 * After this, schedule() must not care about p->state any more.
+	 */
+	block_task(rq, p, flags);
+	return true;
+}
+
+/*
  * __schedule() is the main scheduler function.
  *
  * The main means of driving the scheduler and thus entering this function are:
@@ -6598,33 +6637,7 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		if (signal_pending_state(prev_state, prev)) {
-			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
-			int flags = DEQUEUE_NOCLOCK;
-
-			prev->sched_contributes_to_load =
-				(prev_state & TASK_UNINTERRUPTIBLE) &&
-				!(prev_state & TASK_NOLOAD) &&
-				!(prev_state & TASK_FROZEN);
-
-			if (unlikely(is_special_task_state(prev_state)))
-				flags |= DEQUEUE_SPECIAL;
-
-			/*
-			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;    if (p->on_rq && ...)
-			 *   if (prev_state)		    goto out;
-			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
-			 *				  p->state = TASK_WAKING
-			 *
-			 * Where __schedule() and ttwu() have matching control dependencies.
-			 *
-			 * After this, schedule() must not care about p->state any more.
-			 */
-			block_task(rq, prev, flags);
-			block = true;
-		}
+		block = try_to_block_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 

