Return-Path: <linux-tip-commits+bounces-3537-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CDA3DDE3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 16:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DFB1889DC5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A491D6DA1;
	Thu, 20 Feb 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="utzNEmdX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipjU+W9b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5671D61A3;
	Thu, 20 Feb 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064125; cv=none; b=ixLI/O5SJmDZWcKzVfSYhqXNweIAQupYyP9tq/Aj7uqLozxeuWTh86WtJQvX/YdP5KNDw53VEHYchlthNPhDToZ1qT+G8OkISCmpCtw5EQn0urHRLHQTjabIUFTGE60jIOpzTXO++AuwbJR7I+c8RL01zPPXSuLz8cajX0pbs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064125; c=relaxed/simple;
	bh=HZlSRWUR+ZrGx6F4ABt4czgvurk1gGPOfgxi2u5OdHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ANrW+gLssDaBTU0UXo9ZAu8csR31dida3ZUniXQ0cbwe2z1f7BVNEnPvKSsN3VDQmD7IwxZtGjCWRrKX6NiENkqx/oYrUsMYvNN5Rb3u/9ONEvIhZj1Gbpnj3rqPP2ByMIJ/aa61YyxoiNHzIMk2mn0jF8cERW2UTa5d9GkWdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=utzNEmdX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipjU+W9b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 15:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740064121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CANXD6Os141F4iw4c5MAzLrTB0R++Cu5K6sxq6JFs8=;
	b=utzNEmdXVlbpvvXYeGJGD299eNg7C0WUVKigFXSsLoxi0jOV5EJlyyYdJ7st6OOV0s2L7+
	QX2sPp0zZwX82IgcHru2FPXzhAIJnuzI1P8Bld2PN+UIyghUBeJ8m+oi0bgK3XakpMg2S1
	fK7lhqE8w1yCkelBx4tjBenAn6ppNcrEDSN1jCDDo5hFYp3f1LcOu1vFSVBGX91vYNcmzE
	c1vMtIN/rtA2LmzXzIG5y6EJetxIvKHp9q2LqJ8A0LjH4OkxmCHhjkI105wAYOHHsv8ZgU
	T/VR2UNT5790Gue/i6JXw6kAcSz5f0lquQ9CouwhWfpAkFUAZvzdH6ojJZWq+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740064121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CANXD6Os141F4iw4c5MAzLrTB0R++Cu5K6sxq6JFs8=;
	b=ipjU+W9bZW85pxHp2I0SXnsK11+h78+UDQIZhpl5lC1DZWXT8VkbUco5+p1H/S+AyCaDcs
	up8j896kp50IVqAw==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Compact RSEQ concurrency IDs with reduced
 threads and affinity
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250210153253.460471-2-gmonaco@redhat.com>
References: <20250210153253.460471-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174006412025.10177.7108180687069026332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     02d954c0fdf91845169cdacc7405b120f90afe01
Gitweb:        https://git.kernel.org/tip/02d954c0fdf91845169cdacc7405b120f90afe01
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 10 Feb 2025 16:32:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Feb 2025 08:50:36 +01:00

sched: Compact RSEQ concurrency IDs with reduced threads and affinity

When a process reduces its number of threads or clears bits in its CPU
affinity mask, the mm_cid allocation should eventually converge towards
smaller values.

However, the change introduced by:

commit 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency
IDs for intermittent workloads")

adds a per-mm/CPU recent_cid which is never unset unless a thread
migrates.

This is a tradeoff between:

A) Preserving cache locality after a transition from many threads to few
   threads, or after reducing the hamming weight of the allowed CPU mask.

B) Making the mm_cid upper bounds wrt nr threads and allowed CPU mask
   easy to document and understand.

C) Allowing applications to eventually react to mm_cid compaction after
   reduction of the nr threads or allowed CPU mask, making the tracking
   of mm_cid compaction easier by shrinking it back towards 0 or not.

D) Making sure applications that periodically reduce and then increase
   again the nr threads or allowed CPU mask still benefit from good
   cache locality with mm_cid.

Introduce the following changes:

* After shrinking the number of threads or reducing the number of
  allowed CPUs, reduce the value of max_nr_cid so expansion of CID
  allocation will preserve cache locality if the number of threads or
  allowed CPUs increase again.

* Only re-use a recent_cid if it is within the max_nr_cid upper bound,
  else find the first available CID.

Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lkml.kernel.org/r/20250210153253.460471-2-gmonaco@redhat.com
---
 include/linux/mm_types.h |  7 ++++---
 kernel/sched/sched.h     | 25 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b27db7..0234f14 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -875,10 +875,11 @@ struct mm_struct {
 		 */
 		unsigned int nr_cpus_allowed;
 		/**
-		 * @max_nr_cid: Maximum number of concurrency IDs allocated.
+		 * @max_nr_cid: Maximum number of allowed concurrency
+		 *              IDs allocated.
 		 *
-		 * Track the highest number of concurrency IDs allocated for the
-		 * mm.
+		 * Track the highest number of allowed concurrency IDs
+		 * allocated for the mm.
 		 */
 		atomic_t max_nr_cid;
 		/**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b93c8c3..c8512a9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3698,10 +3698,28 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
 {
 	struct cpumask *cidmask = mm_cidmask(mm);
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid = __this_cpu_read(pcpu_cid->recent_cid);
+	int cid, max_nr_cid, allowed_max_nr_cid;
 
+	/*
+	 * After shrinking the number of threads or reducing the number
+	 * of allowed cpus, reduce the value of max_nr_cid so expansion
+	 * of cid allocation will preserve cache locality if the number
+	 * of threads or allowed cpus increase again.
+	 */
+	max_nr_cid = atomic_read(&mm->max_nr_cid);
+	while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed),
+					   atomic_read(&mm->mm_users))),
+	       max_nr_cid > allowed_max_nr_cid) {
+		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into max_nr_cid. */
+		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid)) {
+			max_nr_cid = allowed_max_nr_cid;
+			break;
+		}
+	}
 	/* Try to re-use recent cid. This improves cache locality. */
-	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
+	cid = __this_cpu_read(pcpu_cid->recent_cid);
+	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
+	    !cpumask_test_and_set_cpu(cid, cidmask))
 		return cid;
 	/*
 	 * Expand cid allocation if the maximum number of concurrency
@@ -3709,8 +3727,9 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
 	 * and number of threads. Expanding cid allocation as much as
 	 * possible improves cache locality.
 	 */
-	cid = atomic_read(&mm->max_nr_cid);
+	cid = max_nr_cid;
 	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
+		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into cid. */
 		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
 			continue;
 		if (!cpumask_test_and_set_cpu(cid, cidmask))

