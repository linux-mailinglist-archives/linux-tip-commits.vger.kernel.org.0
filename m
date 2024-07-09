Return-Path: <linux-tip-commits+bounces-1645-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91C92B89B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E501F2275F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539415ECCC;
	Tue,  9 Jul 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XC3/uLPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kljxqvz5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F049158DD9;
	Tue,  9 Jul 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525323; cv=none; b=WeKMICdoI3KRc3jGQc7Rr2PxxWEtSJXoafKcEiAY7Eb7XtP9XCVzEcq29BKBurstX4XlFjWB9+r3Kd9ORwNq2kVZGWa7UBe43IgOQel6oJTX8IbCsiYcZI283jXn2Rqer1SMlVkKIlKC2yMXXThSZb/j0GtgTbnVPOr7Pds4rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525323; c=relaxed/simple;
	bh=/fAT3MGOTSy0nq4WLdKJEl2sqdwHOsx2BdkaTu49WLA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j6oNLSXgoJzr6lOaTyBTin0ra9mhyoKQhzWKUhgzv/m7M+aaFvbw78L1qLaIs42tN04BYV+4tSrTp4TQyWJZL/rpi4I3zkzqGOKrTgNf05749H1v5z1fbu0PwST6UX1ul+j6qvH+DFZXqaPMOUZC4pTjmQ86NzpACCYAaOrhNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XC3/uLPn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kljxqvz5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g4MHJODxuiymtPq3xlHv+SjAEhWu2ul+C8d0CXIy14=;
	b=XC3/uLPnaWYQyffAQex14jD4Zc+TlVrno8HQafiYktqysHbjb4AxOm1uDCqCZYRinIwhh6
	sfCi0RFSnBaZTTYxTWcu6YyJtc6rHrEX7Qcf7QEwcjQQCi5z51PevAE3g7swwTAgaWHUuo
	WAbgFMM+ZoXA6TxtYnyrjtr/klFXa8d0bCyaBxwJGuuaStzSHpYLAqoABRJKZW7dgI6ojY
	2Mc8KULx2HWOicyexcu4TptGhZ9Zt8BJA3rOAekaPErbg59CO2ZO7EYsw4yC28AQCMw5aL
	0DLwGKhVzHXKdDkBejc+RCqgQgkV3GnRo5T4UFXEKLNs+ajXaynXASdvfDYKSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9g4MHJODxuiymtPq3xlHv+SjAEhWu2ul+C8d0CXIy14=;
	b=Kljxqvz5mKPuVVuG1KKG1J1DBGmUewrFtTkMFTfmvPN5LWvsJsICHlFaL83B0utr0vOLSv
	aSD+pxJFbWfeU1Aw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] task_work: Add TWA_NMI_CURRENT as an additional notify mode.
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-3-bigeasy@linutronix.de>
References: <20240704170424.1466941-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531910.2215.8236126764601999778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     466e4d801cd438a1ab2c8a2cce1bef6b65c31bbb
Gitweb:        https://git.kernel.org/tip/466e4d801cd438a1ab2c8a2cce1bef6b65c31bbb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:34 +02:00

task_work: Add TWA_NMI_CURRENT as an additional notify mode.

Adding task_work from NMI context requires the following:
- The kasan_record_aux_stack() is not NMU safe and must be avoided.
- Using TWA_RESUME is NMI safe. If the NMI occurs while the CPU is in
  userland then it will continue in userland and not invoke the `work'
  callback.

Add TWA_NMI_CURRENT as an additional notify mode. In this mode skip
kasan and use irq_work in hardirq-mode to for needed interrupt. Set
TIF_NOTIFY_RESUME within the irq_work callback due to k[ac]san
instrumentation in test_and_set_bit() which does not look NMI safe in
case of a report.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240704170424.1466941-3-bigeasy@linutronix.de
---
 include/linux/task_work.h |  1 +
 kernel/task_work.c        | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 26b8a47..cf5e7e8 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -18,6 +18,7 @@ enum task_work_notify_mode {
 	TWA_RESUME,
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
+	TWA_NMI_CURRENT,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 2134ac8..5c2daa7 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -1,10 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/irq_work.h>
 #include <linux/spinlock.h>
 #include <linux/task_work.h>
 #include <linux/resume_user_mode.h>
 
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
+static void task_work_set_notify_irq(struct irq_work *entry)
+{
+	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
+	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
+
 /**
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
@@ -12,7 +20,7 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * @notify: how to notify the targeted task
  *
  * Queue @work for task_work_run() below and notify the @task if @notify
- * is @TWA_RESUME, @TWA_SIGNAL, or @TWA_SIGNAL_NO_IPI.
+ * is @TWA_RESUME, @TWA_SIGNAL, @TWA_SIGNAL_NO_IPI or @TWA_NMI_CURRENT.
  *
  * @TWA_SIGNAL works like signals, in that the it will interrupt the targeted
  * task and run the task_work, regardless of whether the task is currently
@@ -24,6 +32,8 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * kernel anyway.
  * @TWA_RESUME work is run only when the task exits the kernel and returns to
  * user mode, or before entering guest mode.
+ * @TWA_NMI_CURRENT works like @TWA_RESUME, except it can only be used for the
+ * current @task and if the current context is NMI.
  *
  * Fails if the @task is exiting/exited and thus it can't process this @work.
  * Otherwise @work->func() will be called when the @task goes through one of
@@ -44,8 +54,13 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 {
 	struct callback_head *head;
 
-	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack(work);
+	if (notify == TWA_NMI_CURRENT) {
+		if (WARN_ON_ONCE(task != current))
+			return -EINVAL;
+	} else {
+		/* record the work call stack in order to print it in KASAN reports */
+		kasan_record_aux_stack(work);
+	}
 
 	head = READ_ONCE(task->task_works);
 	do {
@@ -66,6 +81,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	case TWA_SIGNAL_NO_IPI:
 		__set_notify_signal(task);
 		break;
+	case TWA_NMI_CURRENT:
+		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;

