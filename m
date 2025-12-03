Return-Path: <linux-tip-commits+bounces-7580-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36167CA041C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1020306AECE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECA33A6EB;
	Wed,  3 Dec 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMl5SuNn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJGMfisQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B181365A19;
	Wed,  3 Dec 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780740; cv=none; b=OBg5PSYsan+u11uokz3SVFLzJjQ5aGwNeQCBFEYDjvPs4cNxRnDwh6yd6np3aSHAh3XLQoBsJCkSSCNlyM8L/y8CK+w7lFuXVF5s5duwegkUlJzSHhJx1lX2NcAuXNQl8SeIb1PuQFWiLbXj2wCJngZI8VLWIUTdB/B2eNCQtKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780740; c=relaxed/simple;
	bh=pB5WUZuk1u9FJsGEx2SWz6wyArkae620aEbaIjgYO5A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mVJnDiBSq4/SpbOiNkTWUcidt9wuSbg+HseWUrQsPnHxI7Po0SnOX8jWHBtdQjIEqOjUXtoEUpBT0pwMhhQ1suUqrUIpxYS2jaRSk49R8g9z/KOId5xZfu95Fb74HxCVz1bPxPz61G0JuPbKknu+up4QV7gr+efli0G33+eTVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMl5SuNn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJGMfisQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 16:52:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764780736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwhKJD0y63IVTEXN5uGng1P82Zy0oXe8jLIn2d/ZDNU=;
	b=KMl5SuNnpX9ZItGXbTtJ2jgolWvD9rtPueJmrFOTK/l4ur7oseVVQJ0N6pHf9AxZytHB9v
	jh7qAZvJ13FtgIbu3lALzFeuL9mdeGFWHs+cxf1vdvnwpxqe9Hp+KJvAQIhzY1rBtiRxlG
	QfmkIDg7bUuR8kMSqyJBMTaEuoyOViu4b5bN4ZRO5cT2P7qjvyASFb+Gx/YTQQWsmxqWv0
	j3eRW0oZ5WHI9zu5ELDNq7pNq4Qqf8T1U6hX1j24S4c2pIvb7yA0qV5nWYoDd0lSKgkbXQ
	kY+aglVD0KR3J2GLhWbdjnH21UyA0y35ZHzXgLjnej4TeWINx557khH0Y1ykvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764780736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwhKJD0y63IVTEXN5uGng1P82Zy0oXe8jLIn2d/ZDNU=;
	b=LJGMfisQ6gBEhRakHOAGUZL7hmEtf3D8YdSsD2JXtRyVfXd/3STQlB5mh2QmiNXWWLnHww
	jZtPVzvnIf1Yl3CA==
From: "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Clear ->h_load_next when
 unregistering a cgroup
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Cruz Zhao <CruzZhao@linux.alibaba.com>,
 Peng Wang <peng_wang@linux.alibaba.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbf93d41ff9f2da19ef2c1cfb505362e0b48c39de=2E1761290?=
 =?utf-8?q?330=2Egit=2Epeng=5Fwang=40linux=2Ealibaba=2Ecom=3E?=
References: =?utf-8?q?=3Cbf93d41ff9f2da19ef2c1cfb505362e0b48c39de=2E17612903?=
 =?utf-8?q?30=2Egit=2Epeng=5Fwang=40linux=2Ealibaba=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f85fd15b0da76f08e2d5bb4179c54993f7e07853
Gitweb:        https://git.kernel.org/tip/f85fd15b0da76f08e2d5bb4179c54993f7e=
07853
Author:        Peng Wang <peng_wang@linux.alibaba.com>
AuthorDate:    Fri, 24 Oct 2025 15:23:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 17:44:01 +01:00

sched/fair: Clear ->h_load_next when unregistering a cgroup

An invalid pointer dereference bug was reported on ARM64 CPUs, and has
not yet been seen on x86. A partial oops looks like:

 Call trace:
  update_cfs_rq_h_load+0x80/0xb0
  wake_affine+0x158/0x168
  select_task_rq_fair+0x364/0x3a8
  try_to_wake_up+0x154/0x648
  wake_up_q+0x68/0xd0
  futex_wake_op+0x280/0x4c8
  do_futex+0x198/0x1c0
  __arm64_sys_futex+0x11c/0x198

See: https://lore.kernel.org/all/20251013071820.1531295-1-CruzZhao@linux.alib=
aba.com/

We found that the task_group corresponding to the problematic se
is not in the parent task_group=E2=80=99s children list, indicating that
h_load_next points to an invalid address. Consider the following
cgroup and task hierarchy:

         A
        / \
       /   \
      B     E
     / \    |
    /   \   t2
   C     D
   |     |
   t0    t1

Here follows a timing sequence that may be responsible for triggering
the problem:

  CPU X                   CPU Y                   CPU Z
  wakeup t0
  set list A->B->C
  traverse A->B->C
  t0 exits
  destroy C
                          wakeup t2
                          set list A->E           wakeup t1
                                                  set list A->B->D
                          traverse A->B->C
                          panic

CPU Z sets ->h_load_next list to A->B->D, but due to weaker memory
ordering on ARM64, Y may observe A->B before it sees B->D, then in this
time window, it can traverse A->B->C and reach an invalid se.

We can avoid stale pointer accesses by clearing ->h_load_next when
unregistering a cgroup.

Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/bf93d41ff9f2da19ef2c1cfb505362e0b48c39de.17612=
90330.git.peng_wang@linux.alibaba.com
---
 kernel/sched/fair.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 769d7b7..00a32c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13687,6 +13687,8 @@ void unregister_fair_sched_group(struct task_group *t=
g)
 		struct rq *rq =3D cpu_rq(cpu);
=20
 		if (se) {
+			struct cfs_rq *parent_cfs_rq =3D cfs_rq_of(se);
+
 			if (se->sched_delayed) {
 				guard(rq_lock_irqsave)(rq);
 				if (se->sched_delayed) {
@@ -13696,6 +13698,13 @@ void unregister_fair_sched_group(struct task_group *=
tg)
 				list_del_leaf_cfs_rq(cfs_rq);
 			}
 			remove_entity_load_avg(se);
+
+			/*
+			 * Clear parent's h_load_next if it points to the
+			 * sched_entity being freed, to avoid stale pointer.
+			 */
+			if (READ_ONCE(parent_cfs_rq->h_load_next) =3D=3D se)
+				WRITE_ONCE(parent_cfs_rq->h_load_next, NULL);
 		}
=20
 		/*

