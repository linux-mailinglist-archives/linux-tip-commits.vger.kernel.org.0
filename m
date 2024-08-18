Return-Path: <linux-tip-commits+bounces-2063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5E955B2F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F73028254E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022D18052;
	Sun, 18 Aug 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ni1JbG4O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChtoDEfs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC715E96;
	Sun, 18 Aug 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962193; cv=none; b=A4VU8P3gpDJT20CnYOtIFn8G7UIZsd7X8HwT0MlYuQqmx6+hnlWoHorVyIU7ldrpb9QcR7Nt391aQpbjaVs9srclJdookhU4MOpPOLl91SeKS/1PcF7D9HgdOnXkJpKYmImYI4TxRfFtW5YFwNlG0PBXnQRiWmndv4ZeYWYA8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962193; c=relaxed/simple;
	bh=lvRgzYCEnhZBCm9i7N4I4IXs4JCtsczkMXRSeucuMdk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u3p6yO4V1jUNqA7B3Jgt/wflFZZaEa36gVuSVWDpUMxhD29vV7IF4M46BhRbwq4v6V1UwyXJyRAvxa3/cbyRlglj7knHG9ztQ2xResTVz5niGH8KLplhfSju3chPqc1LSWE0ndYj0LCTQubA0TugMy2VAQMN3zV2SQDfNJp65qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ni1JbG4O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChtoDEfs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+w3UgpyFpI657egP/Z0l+yUbB0FR1/oKS5o3vowoh0g=;
	b=Ni1JbG4OO5zEfYHCuZr3pSRQhZ0FlpxXQSFA+wUDraXTNdtJncP3OIKdCJaJ+swfLT8FDf
	r2XXuAWLOSKWaF8wf98Ci6nJbM8lQMagN3MFjZnWRhaLiIuCi5Ken04gSNiwrjfYiP8Cve
	B8nbw2teM6leMkT0j2LXotAAhNoN4CL8uEqPfbYQ07tF13EVIW6xG5eCyVj/+hHj8yoGGk
	FVEGOcl3CvqrSIEiS47RQD88+7CA9EpK3gU83k5gpA91IDpCab/ybkDmOot360IDmznvin
	ygX/lHweZq2aqqpd2U3WvYZ/ZoNNUggS1V9z4HGRDKkl2xExpAZ10xM3AXfSRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+w3UgpyFpI657egP/Z0l+yUbB0FR1/oKS5o3vowoh0g=;
	b=ChtoDEfsqxNTFfJhmiHGCaXV6UQDl1XIsSJQQgol6CknK+1On1lvoq6wcZZMmCDAaFjS6g
	go+V/AMXlJEe6bBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Implement DELAY_ZERO
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.403750550@infradead.org>
References: <20240727105030.403750550@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218743.2215.1544441241531263872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     54a58a78779169f9c92a51facf6de7ce94962328
Gitweb:        https://git.kernel.org/tip/54a58a78779169f9c92a51facf6de7ce94962328
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 12:26:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:44 +02:00

sched/fair: Implement DELAY_ZERO

'Extend' DELAY_DEQUEUE by noting that since we wanted to dequeued them
at the 0-lag point, truncate lag (eg. don't let them earn positive
lag).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.403750550@infradead.org
---
 kernel/sched/fair.c     | 20 ++++++++++++++++++--
 kernel/sched/features.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da5065a..1a59339 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5447,8 +5447,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 
-	if (flags & DEQUEUE_DELAYED)
+	if (flags & DEQUEUE_DELAYED) {
 		se->sched_delayed = 0;
+		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
+			se->vlag = 0;
+	}
 
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
@@ -5527,7 +5530,6 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		SCHED_WARN_ON(se->sched_delayed);
 		SCHED_WARN_ON(se->on_rq);
-
 		return NULL;
 	}
 	return se;
@@ -6825,6 +6827,20 @@ requeue_delayed_entity(struct sched_entity *se)
 	SCHED_WARN_ON(!se->sched_delayed);
 	SCHED_WARN_ON(!se->on_rq);
 
+	if (sched_feat(DELAY_ZERO)) {
+		update_entity_lag(cfs_rq, se);
+		if (se->vlag > 0) {
+			cfs_rq->nr_running--;
+			if (se != cfs_rq->curr)
+				__dequeue_entity(cfs_rq, se);
+			se->vlag = 0;
+			place_entity(cfs_rq, se, 0);
+			if (se != cfs_rq->curr)
+				__enqueue_entity(cfs_rq, se);
+			cfs_rq->nr_running++;
+		}
+	}
+
 	se->sched_delayed = 0;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1feaa7b..7fdeb55 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -34,8 +34,11 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  * By delaying the dequeue for non-eligible tasks, they remain in the
  * competition and can burn off their negative lag. When they get selected
  * they'll have positive lag by definition.
+ *
+ * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
  */
 SCHED_FEAT(DELAY_DEQUEUE, true)
+SCHED_FEAT(DELAY_ZERO, true)
 
 /*
  * Allow wakeup-time preemption of the current task:

