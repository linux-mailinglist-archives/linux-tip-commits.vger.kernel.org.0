Return-Path: <linux-tip-commits+bounces-4182-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CFA5F268
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9368917E55E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD09266EE9;
	Thu, 13 Mar 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/zFfidf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8L3I+08"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B6266B51;
	Thu, 13 Mar 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865488; cv=none; b=VUW1eICe0V2nhgtouJ60XKKqaQuf2JBoH5x93FpzsE6UU4k8PPbGdtjHS7cmP3KGur6rDxdseQXohgV12WvwJLeOCMuq/Ps4HnjeNsnWHanvJK8sknN1X2irF3a8I0++cw31s4bMqEy/RSEovpuK5626wCZsB6Xd8c2rDt8SPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865488; c=relaxed/simple;
	bh=ZTUGJiK6VjMMQG/tPjYCnMy9pF1g9Iex6olFX2KQFuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H173sae+76lC2uBQmbtCgUHm6krSmFx/8Zzjtk+J+zcYrNiVfP1MP+exsAD5YcotxJmbtXPJHLMnbCdXyogWHUikpcC+V6XTP6imJJSVYaGdeXuV0bWSNMogNUYuP/+IA61lNZ5OYZ1sKhymyGiyUjFWThO5ZoaDo6MRygYLHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/zFfidf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8L3I+08; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giDCpG5PuRd2bdBFfxKKDD0J/pdLOG+U62NXof20l+A=;
	b=V/zFfidfxQG4RNzA5jjQPS6cbquIywOYudQvTSFIvg6iBcbKMeRhQXSRZ8ho3cXrDmh+y1
	7XbG6PfakzXyFMP6lYykcdWjIDDejy8OkBdiOWxkpIbHGecG0uhIjXIQZIkh/xuvvzUYb3
	jUOaehUV+hgYtSCXodjk3jE74fkTmK2wDsn9nmZ3chPltRmWp6CrakoA4RV95EdSVVf337
	IxFHAftiaRVlZA1h+ZokgHiFghhNre+uWLt/0UFvL4fI40yLvb6TgwNCwhsCwRjA5LZrpt
	Jeiwi07+xS3Moma46pZVFjl4tMv1dTflz3LQ0/xRieE17Hokdro1vsOzKiBUPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giDCpG5PuRd2bdBFfxKKDD0J/pdLOG+U62NXof20l+A=;
	b=I8L3I+08K20EWp7ho7fmY86Tdsp3Oo0zblvs+jOWervCo0tzshYZOpEfS1hSrisOqMRQmB
	0ghf2gGckMhDYMAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Avoid false cacheline sharing
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.341108067@linutronix.de>
References: <20250308155624.341108067@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548465.14745.14172763285747190520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5fa75a432f1a6b1402edd8802ecc14f8bbb90e49
Gitweb:        https://git.kernel.org/tip/5fa75a432f1a6b1402edd8802ecc14f8bbb90e49
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:18 +01:00

posix-timers: Avoid false cacheline sharing

struct k_itimer has the hlist_node, which is used for lookup in the hash
bucket, and the timer lock in the same cache line.

That's obviously bad, if one CPU fiddles with a timer and the other is
walking the hash bucket on which that timer is queued.

Avoid this by restructuring struct k_itimer, so that the read mostly (only
modified during setup and teardown) fields are in the first cache line and
the lock and the rest of the fields which get written to are in cacheline
2-N.

Reduces cacheline contention in a test case of 64 processes creating and
accessing 20000 timers each by almost 30% according to perf.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155624.341108067@linutronix.de


---
 include/linux/posix-timers.h | 21 ++++++++++++---------
 kernel/time/posix-timers.c   |  4 ++--
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index e714a55..094ef57 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -177,23 +177,26 @@ static inline void posix_cputimers_init_work(void) { }
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct hlist_node	list;
-	struct hlist_node	ignored_list;
+	/* 1st cacheline contains read-mostly fields */
 	struct hlist_node	t_hash;
-	spinlock_t		it_lock;
-	const struct k_clock	*kclock;
-	clockid_t		it_clock;
+	struct hlist_node	list;
 	timer_t			it_id;
+	clockid_t		it_clock;
+	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
+	struct signal_struct	*it_signal;
+	const struct k_clock	*kclock;
+
+	/* 2nd cacheline and above contain fields which are modified regularly */
+	spinlock_t		it_lock;
 	int			it_status;
 	bool			it_sig_periodic;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	unsigned int		it_sigqueue_seq;
-	int			it_sigev_notify;
-	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
-	struct signal_struct	*it_signal;
+	struct hlist_node	ignored_list;
 	union {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
@@ -210,7 +213,7 @@ struct k_itimer {
 		} alarm;
 	} it;
 	struct rcu_head		rcu;
-};
+} ____cacheline_aligned_in_smp;
 
 void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0c4cee3..e4c92f4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -260,8 +260,8 @@ static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
-					       SLAB_ACCOUNT, NULL);
+	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer),
+					       __alignof__(struct k_itimer), SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);

