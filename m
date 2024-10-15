Return-Path: <linux-tip-commits+bounces-2464-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E799FB92
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1783F1F22D1F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6331FDFA9;
	Tue, 15 Oct 2024 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsWCMI4q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NghYn1aU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7391F819F;
	Tue, 15 Oct 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032090; cv=none; b=JXkp4tfSTrmiuA8J8UX0sb9toABU0A95oIK7a4HeBXWjR9ArOP/d2d6wFlEj/ZSgxVauPk8xMmyTK7wzsoVoTwk6jJF7YZjrTW2MHOTl3uKuJ9zFV0qF11Eq4N8G+a4VGYZy5VHmLf49IKaM9Jy4X0qgVOylteoqbcIPb4B2yyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032090; c=relaxed/simple;
	bh=g32OrPD2VU+27bpfF8pjzUKe4kQkmKaG1NpNbex3d74=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=puQ0yrlb44b5Xki68SoI9Xr4KySRWPon2k6V9AaWjB/B1A+0gnd1dez4S/heXrSF3R1Be65SESjbEZ8+Jlixtm+S0j+dmS3fMB92c1fCQCcvNKTr501dkXq5Fv3PHfpD/81vJeWHHE93IGXwpnuKhFPLBkuqULFMUrfOWW2Cr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsWCMI4q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NghYn1aU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaSUyG/K9DWZAsi2ANaBECZE7m4qQ6W16Avie0GEEkM=;
	b=LsWCMI4qEjhr0f4hBAyFdkgd/P5taQwzik3ioc3TQThppOffeDDnfauh3lXWQX1rvhLr0o
	VYVmTRBmT13lruAG2jDr5LU8xWSvjNwUJHUH77UDCsrPffVZ7V8D+W92zwsHowTuLO6+6P
	lGLbuRzjd+GvhwkphfSGew+8YkIVRdOMoZ1wv3KSM3/glLlroKzyV9gtEIdlxQO+jvHckm
	6q1pwBWdDxlMhxlbKoXzdi3NDAqELPZjhrklHeY7R2XakGiaAo0JsIoN2TFWaqQ8ruJb9h
	w8I/ep2BxB8glVBQpLKO350nCkoO7LpFgg1r3nR12werSZkbywH8xwW968tNlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaSUyG/K9DWZAsi2ANaBECZE7m4qQ6W16Avie0GEEkM=;
	b=NghYn1aU65WeXv2vRRrlqDlvSo//uCdoTYK4kSa78iEfJPXZI66G0OEsWTMW1M1Mp8WtRL
	gGjqr4BHSdpzVvCA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Update schedule_[hr]timeout*() related
 function descriptions
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-3-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-3-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208623.1442.4584671542746896952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cf5b6ef0c36be3489972966b8a18aa5c48559661
Gitweb:        https://git.kernel.org/tip/cf5b6ef0c36be3489972966b8a18aa5c48559661
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:46 +02:00

timers: Update schedule_[hr]timeout*() related function descriptions

schedule_timeout*() functions do not have proper kernel-doc formatted
function descriptions. schedule_hrtimeout() and schedule_hrtimeout_range()
have a almost identical description.

Add missing function descriptions. Remove copy of function description and
add a pointer to the existing description instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-3-dc8b907cb62f@linutronix.de

---
 kernel/time/sleep_timeout.c | 66 ++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 78b2e7e..560d17c 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -110,8 +110,17 @@ signed long __sched schedule_timeout(signed long timeout)
 EXPORT_SYMBOL(schedule_timeout);
 
 /*
- * We can use __set_current_state() here because schedule_timeout() calls
- * schedule() unconditionally.
+ * __set_current_state() can be used in schedule_timeout_*() functions, because
+ * schedule_timeout() calls schedule() unconditionally.
+ */
+
+/**
+ * schedule_timeout_interruptible - sleep until timeout (interruptible)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_INTERRUPTIBLE before starting the timeout.
  */
 signed long __sched schedule_timeout_interruptible(signed long timeout)
 {
@@ -120,6 +129,14 @@ signed long __sched schedule_timeout_interruptible(signed long timeout)
 }
 EXPORT_SYMBOL(schedule_timeout_interruptible);
 
+/**
+ * schedule_timeout_killable - sleep until timeout (killable)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_KILLABLE before starting the timeout.
+ */
 signed long __sched schedule_timeout_killable(signed long timeout)
 {
 	__set_current_state(TASK_KILLABLE);
@@ -127,6 +144,14 @@ signed long __sched schedule_timeout_killable(signed long timeout)
 }
 EXPORT_SYMBOL(schedule_timeout_killable);
 
+/**
+ * schedule_timeout_uninterruptible - sleep until timeout (uninterruptible)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_UNINTERRUPTIBLE before starting the timeout.
+ */
 signed long __sched schedule_timeout_uninterruptible(signed long timeout)
 {
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -134,9 +159,15 @@ signed long __sched schedule_timeout_uninterruptible(signed long timeout)
 }
 EXPORT_SYMBOL(schedule_timeout_uninterruptible);
 
-/*
- * Like schedule_timeout_uninterruptible(), except this task will not contribute
- * to load average.
+/**
+ * schedule_timeout_idle - sleep until timeout (idle)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_IDLE before starting the timeout. It is similar to
+ * schedule_timeout_uninterruptible(), except this task will not contribute to
+ * load average.
  */
 signed long __sched schedule_timeout_idle(signed long timeout)
 {
@@ -151,6 +182,9 @@ EXPORT_SYMBOL(schedule_timeout_idle);
  * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
+ *
+ * Details are explained in schedule_hrtimeout_range() function description as
+ * this function is commonly used.
  */
 int __sched schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 					   const enum hrtimer_mode mode, clockid_t clock_id)
@@ -236,26 +270,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range);
  * @expires:	timeout value (ktime_t)
  * @mode:	timer mode
  *
- * Make the current task sleep until the given expiry time has
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Returns: 0 when the timer has expired. If the task was woken before the
- * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
- * by an explicit wakeup, it returns -EINTR.
+ * See schedule_hrtimeout_range() for details. @delta argument of
+ * schedule_hrtimeout_range() is set to 0 and has therefore no impact.
  */
 int __sched schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode)
 {

