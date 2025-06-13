Return-Path: <linux-tip-commits+bounces-5822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2FAD84BC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2713A48E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150726B772;
	Fri, 13 Jun 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEmmK6j3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3l5Bk2BD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCECB2D028F;
	Fri, 13 Jun 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800267; cv=none; b=it4WD4U+dvuehzCPelt1qjJA2VMZTdPegZyJllf+04OCAhtZyQ3tAqciSD23NEDlEgRiA/jYOAhNHh/yN7uquA/bpJtEcxZEgN/S8L0F37UyYA9jaFRrh/NAiMcfDgA9riWOTjbBlZyJHOmRH5H+UmzhjzHUXyZ9pyVZA4LE2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800267; c=relaxed/simple;
	bh=v9rob0QCWMXlFdhQcMhQ9t8v+6VxI0FsfhsK62XvMkA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pOGeGvdC4UCW2JvHr+0WjjvrqPXn/3Y0OZsHIrNsCPTREnL5xJEKdM3IX5/FsanMnsdyRewCLwPHp755UoVx/sfJL7BypSTz3XIjwFBG5mob+55HM+RBXC/H1adz3TmGTb1XNDSWq1CJZTjwJlSyVUsa5Lyq6rcWCSBKq4yioVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oEmmK6j3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3l5Bk2BD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2F3OrqNAXjfotJAJHs5KrImyG/CWvcwwRsCb/x6iUU=;
	b=oEmmK6j3DndpMqAFZb0/PHQXJ0KIqZGIQ9RG5zAK+0Nu7fsaUDvNwHNXmxZp+CGw+7xpMy
	m8gKZQjtxqrQgPQxBXt9ZRAEqrwatHVVdsGvIIK0QoXmfFMVB24FeeQYEKmzmrWRRoKBBN
	T84aPLLM4lFgXWEeMzq13x1lBQvpwLWykrApU6kt4yZyGxnpVxxoF2QhI6AviAlNGxrfPq
	cbGMx5uGXZn+WNIWJyUOj3u+tsUIoZMZhbHQBNquRqxPt6cJWGheMN1xQVTNo0qHys6UBI
	XqkEQO7zv16P7IrcGxcRhjJVPjOA8ztOY9gXImcB1Wf0Uc61EHG/X/OUdz+kVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2F3OrqNAXjfotJAJHs5KrImyG/CWvcwwRsCb/x6iUU=;
	b=3l5Bk2BDshGEy0GYnTLrhk0+emqGMG9s+t/x8mQ3qUjYcD3C9XdEZqxDLybD3w0qcxkQ/X
	v5bAV04gl/k+ZzCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/autogroup.[ch]
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-2-mingo@kernel.org>
References: <20250528080924.2273858-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980026185.406.15155965834038852325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     69ab14ee525649a875ca187cad2f05a2bec1ac3c
Gitweb:        https://git.kernel.org/tip/69ab14ee525649a875ca187cad2f05a2bec1ac3c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:14 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/autogroup.[ch]

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-2-mingo@kernel.org
---
 kernel/sched/autogroup.c | 6 +++---
 kernel/sched/autogroup.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index e96a167..cdea931 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -28,9 +28,9 @@ static void __init sched_autogroup_sysctl_init(void)
 {
 	register_sysctl_init("kernel", sched_autogroup_sysctls);
 }
-#else
+#else /* !CONFIG_SYSCTL: */
 #define sched_autogroup_sysctl_init() do { } while (0)
-#endif
+#endif /* !CONFIG_SYSCTL */
 
 void __init autogroup_init(struct task_struct *init_task)
 {
@@ -111,7 +111,7 @@ static inline struct autogroup *autogroup_create(void)
 	free_rt_sched_group(tg);
 	tg->rt_se = root_task_group.rt_se;
 	tg->rt_rq = root_task_group.rt_rq;
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 	tg->autogroup = ag;
 
 	sched_online_group(tg, &root_task_group);
diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index 5c1796a..06c82b2 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -43,7 +43,7 @@ autogroup_task_group(struct task_struct *p, struct task_group *tg)
 
 extern int autogroup_path(struct task_group *tg, char *buf, int buflen);
 
-#else /* !CONFIG_SCHED_AUTOGROUP */
+#else /* !CONFIG_SCHED_AUTOGROUP: */
 
 static inline void autogroup_init(struct task_struct *init_task) {  }
 static inline void autogroup_free(struct task_group *tg) { }
@@ -63,6 +63,6 @@ static inline int autogroup_path(struct task_group *tg, char *buf, int buflen)
 	return 0;
 }
 
-#endif /* CONFIG_SCHED_AUTOGROUP */
+#endif /* !CONFIG_SCHED_AUTOGROUP */
 
 #endif /* _KERNEL_SCHED_AUTOGROUP_H */

