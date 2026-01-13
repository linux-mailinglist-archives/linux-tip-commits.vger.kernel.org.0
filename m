Return-Path: <linux-tip-commits+bounces-7904-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F46D181F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E08303B46E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D8349B02;
	Tue, 13 Jan 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMDFbx60";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXNb654Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557734164B;
	Tue, 13 Jan 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301015; cv=none; b=A6t7wiXErBZX+GJRU1IEAGAMTmtbV7VWOm2C9LlfwYO14hzZbe558GBZhNCiUcZAgyrILbxOPXxq3vC19HLXcj26T/JzinURdlFLX2pHdvZCYJ3kP9rF3bSZGXnGDKbmzdsqmFA5tPAtB5r5ofR8o55spkTD4rw1soUigrF47XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301015; c=relaxed/simple;
	bh=5EEZw/Dr+puPrQQjnHNMZU531i6g/bTlXXI85DAFlOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oDwAnhZCltTTND7e4uJPCE1+oYi/WNKEgjS5xyLqxrb7NKqUI49d/IAPK+6tk/AAM7GXOQk/uVUCiYN4o0CHnMjpzXrb9saTvTYXay6lfibt3g/SjCcJBRTDJ3t+2gGAAur60DzGTRVeAaGO8HdjaeS0UWlOYWQ3GNdmH/FlLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMDFbx60; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXNb654Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvNb64560Xhg8vqP0FJehwnIUbZxAOJSgADogC3pVR8=;
	b=eMDFbx60N982GQbttbjWYLc1Ci9yqokijBhVlP5dGD0i0kTtIfNWqZcwbtnmc6wQ6GWxaB
	rd3UHPIvoV4V4VF55WewYcxFXNH/8CLVJ/Wm+5CE8COKR+x2/gUZe9W1K+t5urjKvqCp+y
	KG90qClDnAvX2ByzOui9xJg8aMFcmTwhycwgsnK41WXG0P28naFKdbf8E5iyt23D18IcCI
	Xl3wwI6ciux52/WiXl5Rxfuuz2QRVj4DtcB3JaMTQSaKEaCFsUhDRGQjIkdKakYmWgEKyt
	1E7iPTgPQ5ALvVKCs2HCtucodBCCPnGKel/OcHQGXcxUjA+0kdKz9CCdJ3GY0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvNb64560Xhg8vqP0FJehwnIUbZxAOJSgADogC3pVR8=;
	b=ZXNb654ZY6dpPAX8QcUmYpzRhJJlOfu1mDT66gIEK3OIrqjMMeWc2QIfoX17IZAV6073vC
	bUO/UA0T4tv1iBCA==
From: "tip-bot2 for Pingfan Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix potential race in
 dl_add_task_root_domain()
Cc: Juri Lelli <juri.lelli@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251125032630.8746-3-piliu@redhat.com>
References: <20251125032630.8746-3-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830100616.510.8848475494579626153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     64e6fa76610ec970cfa8296ed057907a4b384ca5
Gitweb:        https://git.kernel.org/tip/64e6fa76610ec970cfa8296ed057907a4b3=
84ca5
Author:        Pingfan Liu <piliu@redhat.com>
AuthorDate:    Tue, 25 Nov 2025 11:26:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:51 +01:00

sched/deadline: Fix potential race in dl_add_task_root_domain()

The access rule for local_cpu_mask_dl requires it to be called on the
local CPU with preemption disabled. However, dl_add_task_root_domain()
currently violates this rule.

Without preemption disabled, the following race can occur:

1. ThreadA calls dl_add_task_root_domain() on CPU 0
2. Gets pointer to CPU 0's local_cpu_mask_dl
3. ThreadA is preempted and migrated to CPU 1
4. ThreadA continues using CPU 0's local_cpu_mask_dl
5. Meanwhile, the scheduler on CPU 0 calls find_later_rq() which also
   uses local_cpu_mask_dl (with preemption properly disabled)
6. Both contexts now corrupt the same per-CPU buffer concurrently

Fix this by moving the local_cpu_mask_dl access to the preemption
disabled section.

Closes: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.=
remote.csb
Fixes: 318e18ed22e8 ("sched/deadline: Walk up cpuset hierarchy to decide root=
 domain when hot-unplug")
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251125032630.8746-3-piliu@redhat.com
---
 kernel/sched/deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 463ba50..e3efc40 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3154,7 +3154,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq *rq;
 	struct dl_bw *dl_b;
 	unsigned int cpu;
-	struct cpumask *msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
+	struct cpumask *msk;
=20
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -3162,6 +3162,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
=20
+	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
 	dl_get_task_effective_cpus(p, msk);
 	cpu =3D cpumask_first_and(cpu_active_mask, msk);
 	BUG_ON(cpu >=3D nr_cpu_ids);

