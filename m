Return-Path: <linux-tip-commits+bounces-6798-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F611BD91A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 13:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723C34FFA39
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1453101CE;
	Tue, 14 Oct 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ni1SzCRW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTuWozEj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8772FD1A1;
	Tue, 14 Oct 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442475; cv=none; b=PkCUSNuLpajF10HMef534gRVmGgkHXoB9kRYPXRycYIuCPXPZMug2FQmIfrlDynB3SOh5eJ4gvmNdjla9a5rPjctsUB0OZsLj7baeGiqtTK/d0lyrihzlxULTy3bDiwVx83oxsj1dcGlE0lIUgO5FnK8X3LEKldkieJ5kzHbFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442475; c=relaxed/simple;
	bh=1XXrh4jBF9xct/oMS0Wb7fCyVpTxfXvTAbFelikYFqA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a28zw8el/bUH0R9J79JzbErJYkcUuDCqoZvjWeZuAF2eBwUdWnl+NT24cnkgKejXBnLZRmVz3YUbdd6U61I0MFmRvfgRIj45gQkYvdF9PnNkbU75/WzajCCRD3FPj4l9RB7bDQrPoEhBDdU0SmrNqIDnw8c20NEM6n76fwthMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ni1SzCRW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTuWozEj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 11:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760442471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fbil3FDzzeX1whWBixVlvZO7kQWcWnwgd4hV2AU+LeI=;
	b=Ni1SzCRWqZTavPoVXr+nSzzepPakuVWd9a0SHdZlcX1DrF3KudxK0KhSCow2nU6j6rO9bJ
	Tf7EvJDj8g5f7gQPSXcGVAiE8mWt6w2fnlTfjWpd5f+NTM1YXRmUa8PPNzhQCv3gHidDgE
	mHcS2dPK/U916Fz9vTsYPvrLwVdwqb3ivy4MjiEniBhCmVkETc5h2oG4Tx47ii4QHL/9d8
	zAhDTPj7BwXfJMTuLXgWDy3lsDUeLYEw+S7oXWQUH1/YAVBxhzmuSoVA/06Iu/tdkcNgdS
	e8AZwdGlTd/dxH6sqJczd890acI2cYDKjJtSiQ+7jCTful2MtMuqMzKLvW9z9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760442471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fbil3FDzzeX1whWBixVlvZO7kQWcWnwgd4hV2AU+LeI=;
	b=DTuWozEjw1iiO47lUuPuIM1djRJFl42pmkQt/VboLnTjtz/q+//Lvyp+hDwP9Cy3YWx5iG
	jJKYlhac2gGS4+Ag==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/deadline: Stop dl_server before CPU goes offline
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251009184727.673081-1-sshegde@linux.ibm.com>
References: <20251009184727.673081-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176044247061.709179.18187573865828537454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ee6e44dfe6e50b4a5df853d933a96bdff5309e6e
Gitweb:        https://git.kernel.org/tip/ee6e44dfe6e50b4a5df853d933a96bdff53=
09e6e
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Fri, 10 Oct 2025 00:17:27 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 13:43:08 +02:00

sched/deadline: Stop dl_server before CPU goes offline

IBM CI tool reported kernel warning[1] when running a CPU removal
operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"

WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
Call Trace:
[c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
[c0000000002b7cb8] dl_server_timer+0x168/0x2a0
[c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
[c00000000034f624] hrtimer_interrupt+0x124/0x300
[c00000000002a230] timer_interrupt+0x140/0x320

Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting s=
tuck")

This happens since:
- dl_server hrtimer gets enqueued close to cpu offline, when
  kthread_park enqueues a fair task.
- CPU goes offline and drmgr removes it from cpu_present_mask.
- hrtimer fires and warning is hit.

Fix it by stopping the dl_server before CPU is marked dead.

[1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.i=
bm.com/
[2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr

[sshegde: wrote the changelog and tested it]
Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linu=
x.ibm.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c     | 2 ++
 kernel/sched/deadline.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 198d2dd..f1ebf67 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8571,10 +8571,12 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
=20
 	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
 	if (rq->nr_running !=3D 1 || rq_has_pinned_tasks(rq)) {
 		WARN(true, "Dying CPU not properly vacated!");
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
+	dl_server_stop(&rq->fair_server);
 	rq_unlock_irqrestore(rq, &rf);
=20
 	calc_load_migrate(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 615411a..7b76710 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1582,6 +1582,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
=20
+	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
+		return;
+
 	dl_se->dl_server_active =3D 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))

