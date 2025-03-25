Return-Path: <linux-tip-commits+bounces-4521-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB175A6ED4E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870CD189483B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033EB1A23AA;
	Tue, 25 Mar 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjPWLmPp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9OBh6y+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97219B5B4;
	Tue, 25 Mar 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897190; cv=none; b=K2Kcw41oObEEKkzU80s3e4zit6wSxV0/B8cqCEpBoyz9goyEx15+peI5VTMY4jyNGHmGE5t8w52JtJeBgfJROy/0rTXZrPiBRvx1ygohtfxHHj5p7d7QngDkspIQZlGlmHDX3+JOpZSeYuu78zWU1jI6mLe3jvzW7e7MGay0ZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897190; c=relaxed/simple;
	bh=XyDE2CEqYlVLaXbgJvzKpOkd2bsD6p8WqOoHpe8jZVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZpAm57QUfiAI6gz0CQDO+tq2z/vRh5B+vqEhb1XT9j+o31FLyS37aUkyBkX25PEU8RF0/KvxzCSHVWnoyoYGar5wGfkKfjJw+6z33i21BNtgncnaebpkebAjY55j4z7g6XcSiy0L5+e/l8h2JlUNnPzoB+ph+oRDv19ZaAc0KqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjPWLmPp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9OBh6y+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 10:06:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742897187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uof9g/Cj1Qfuu/FmUE4qy0Z2nMrEENfbBIKHt0SFqtU=;
	b=LjPWLmPpv2JvPyXqZ4Yvqn8bv1Om8WDZkyBJFi9jqeJ+4+uz/KPW7DvksE4pbwiqRnX/3T
	J4JfX9zxR81LxddKF3T20Ju0nF0qsQIjooGOOLG6BOBRdgtVTdSp0r9l1i7d+L7jrohMyR
	+y9QT8gt6uLeo63NGllVXo6rJxWbFtD4UGe4WtoJBdUeB7FzhNOhiIo8Okm6qN3zV6eO7t
	oB4F+UFLxozFLsfPnfLo5gl5ZLH7InvR9LzcjN45k6bOQST0pNaNYMkNLAXP+r/JgUu4pH
	KWyTWOiNhGg7kptkgk34S3Y1Cqwameq4025S0NwRl1SCFALUWF5UtmEiRv44+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742897187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uof9g/Cj1Qfuu/FmUE4qy0Z2nMrEENfbBIKHt0SFqtU=;
	b=j9OBh6y+ANDVddMtkqhgE8kdFz58BfGG3FMJ5ei3KkltF/FZerkEsOT4xU7hPdPgp5cZ85
	nyoUCE7zHQqwbUDg==
From: "tip-bot2 for Ryo Takakura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Fix wait context check on softirq for
 PREEMPT_RT
Cc: Ryo Takakura <ryotkkr98@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250321143322.79651-1-boqun.feng@gmail.com>
References: <20250321143322.79651-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289718274.14745.16349720260441360293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     61c39d8c83e2077f33e0a2c8980a76a7f323f0ce
Gitweb:        https://git.kernel.org/tip/61c39d8c83e2077f33e0a2c8980a76a7f323f0ce
Author:        Ryo Takakura <ryotkkr98@gmail.com>
AuthorDate:    Fri, 21 Mar 2025 07:33:22 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:46:44 +01:00

lockdep: Fix wait context check on softirq for PREEMPT_RT

Since:

  0c1d7a2c2d32 ("lockdep: Remove softirq accounting on PREEMPT_RT.")

the wait context test for mutex usage within "in softirq context" fails
as it references @softirq_context:

    | wait context tests |
    --------------------------------------------------------------------------
                                   | rcu  | raw  | spin |mutex |
    --------------------------------------------------------------------------
                 in hardirq context:  ok  |  ok  |  ok  |  ok  |
  in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
                 in softirq context:  ok  |  ok  |  ok  |FAILED|

As a fix, add lockdep map for BH disabled section. This fixes the
issue by letting us catch cases when local_bh_disable() gets called
with preemption disabled where local_lock doesn't get acquired.
In the case of "in softirq context" selftest, local_bh_disable() was
being called with preemption disable as it's early in the boot.

[ boqun: Move the lockdep annotations into __local_bh_*() to avoid false
         positives because of unpaired local_bh_disable() reported by
	 Borislav Petkov and Peter Zijlstra, and make bh_lock_map
	 only exist for PREEMPT_RT. ]

[ mingo: Restored authorship and improved the bh_lock_map definition. ]

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250321143322.79651-1-boqun.feng@gmail.com
---
 kernel/softirq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4dae6ac..513b194 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -126,6 +126,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name			= "local_bh",
+	.key			= &bh_lock_key,
+	.wait_type_outer	= LD_WAIT_FREE,
+	.wait_type_inner	= LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type		= LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -148,6 +160,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	WARN_ON_ONCE(in_hardirq());
 
+	lock_map_acquire_read(&bh_lock_map);
+
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
@@ -211,6 +225,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
+	lock_map_release(&bh_lock_map);
+
 	local_irq_save(flags);
 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
@@ -261,6 +277,8 @@ static inline void ksoftirqd_run_begin(void)
 /* Counterpart to ksoftirqd_run_begin() */
 static inline void ksoftirqd_run_end(void)
 {
+	/* pairs with the lock_map_acquire_read() in ksoftirqd_run_begin() */
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable(SOFTIRQ_OFFSET, true);
 	WARN_ON_ONCE(in_interrupt());
 	local_irq_enable();

