Return-Path: <linux-tip-commits+bounces-8225-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMb0EHwrnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8225-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:27:08 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F8174D9C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 192DE3026A89
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0335C190;
	Mon, 23 Feb 2026 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fh/hyEpK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUNgJiIh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1E34C140;
	Mon, 23 Feb 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842325; cv=none; b=DSGa3wzplxTuw6d8pzSPmeXsY8zbZJnoOimhPg4mtOCMhvcQlcHchWN1GpOeh/ey6xikFIAyMERHcu29tww7Y6FM3srr4U4qJT25lZo0uL7EmIQDA6W53spQo73caKR5NEVw8ZM3Ra40SGNmLO7O7KQIr9g2IC4Yrdcw/dqGyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842325; c=relaxed/simple;
	bh=rIe95oqjLBKi+FOq8vH/0BWX1T/nNzXcEEelfwTJ+BA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SBWHobDj5Tn4i1FPxKldy03mEKY63NxZ9qOlKuhjMZUbVAduyLNKfpiACnx68LlfDdHzj465KqVHxmiyCyU+gY9eK22kYUryNOMX4DTU/NWPNVc2Rg8HbEWcRf4lfLSlCCViT2nyZEraNxUHSF5uVdugViQnmGyA2FVvLbAwX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fh/hyEpK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUNgJiIh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uUOGFFoSm9dG4trKCcNs8CGFurhBu0n2n3zPyJlD9w=;
	b=fh/hyEpKmxWR1Abl+ZUt1WLpNO/2l2vBLLL/uqUeLJe8SY/+IeKek5U4HKH8o1H3S3R5eH
	fp1e8pjBz4vKUeBteU3d4GoTuONrxrQfDgQ13uQ+20U6sYvlFLhGCrJqhbaC2AUlwXLJp1
	JN6VKv+8OJ9+eJeoiNKc+UvVqUbOFYOVMgu31H74djPuO5Rn0gb58gLByJ0jJgmI8nuP9t
	wDOSTbh/JhYhzaHBtqALd0V4F6nrSPSBdiOxRKZCVwawRkGVDJfrTZciTIBMoTZxdaVt1v
	qJtZckgk+31KttRj3usfnsBkorCht74ySrTA2Y1sP1hLyqjxq1BwmTdol7dVPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uUOGFFoSm9dG4trKCcNs8CGFurhBu0n2n3zPyJlD9w=;
	b=OUNgJiIhPzyCubu6ykK24x7AtYQYLA2hdDn7kZpEU9bOozBE5T7lXRZsk/89Nm2P1Wlcad
	yzPYwDnl62wfm6DQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix lag clamp
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250422101628.GA33555@noisy.programming.kicks-ass.net>
References: <20250422101628.GA33555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232145.1647592.17943422719917702258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8225-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim,linaro.org:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amperecomputing.com:email]
X-Rspamd-Queue-Id: E95F8174D9C
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6e3c0a4e1ad1e0455b7880fad02b3ee179f56c09
Gitweb:        https://git.kernel.org/tip/6e3c0a4e1ad1e0455b7880fad02b3ee179f=
56c09
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 22 Apr 2025 12:16:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:18 +01:00

sched/fair: Fix lag clamp

Vincent reported that he was seeing undue lag clamping in a mixed
slice workload. Implement the max_slice tracking as per the todo
comment.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Reported-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20250422101628.GA33555@noisy.programming.kicks=
-ass.net
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 074ad4e..a7b4a98 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -579,6 +579,7 @@ struct sched_entity {
 	u64				deadline;
 	u64				min_vruntime;
 	u64				min_slice;
+	u64				max_slice;
=20
 	struct list_head		group_node;
 	unsigned char			on_rq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93fa5b8..f4446cb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -748,6 +748,8 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	return cfs_rq->zero_vruntime;
 }
=20
+static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs_rq);
+
 /*
  * lag_i =3D S - s_i =3D w_i * (V - v_i)
  *
@@ -761,17 +763,16 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  * EEVDF gives the following limit for a steady state system:
  *
  *   -r_max < lag < max(r_max, q)
- *
- * XXX could add max_slice to the augmented data to track this.
  */
 static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	u64 max_slice =3D cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
 	s64 vlag, limit;
=20
 	WARN_ON_ONCE(!se->on_rq);
=20
 	vlag =3D avg_vruntime(cfs_rq) - se->vruntime;
-	limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	limit =3D calc_delta_fair(max_slice, se);
=20
 	se->vlag =3D clamp(vlag, -limit, limit);
 }
@@ -829,6 +830,21 @@ static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
 	return min_slice;
 }
=20
+static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *root =3D __pick_root_entity(cfs_rq);
+	struct sched_entity *curr =3D cfs_rq->curr;
+	u64 max_slice =3D 0ULL;
+
+	if (curr && curr->on_rq)
+		max_slice =3D curr->slice;
+
+	if (root)
+		max_slice =3D max(max_slice, root->max_slice);
+
+	return max_slice;
+}
+
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 {
 	return entity_before(__node_2_se(a), __node_2_se(b));
@@ -853,6 +869,15 @@ static inline void __min_slice_update(struct sched_entit=
y *se, struct rb_node *n
 	}
 }
=20
+static inline void __max_slice_update(struct sched_entity *se, struct rb_nod=
e *node)
+{
+	if (node) {
+		struct sched_entity *rse =3D __node_2_se(node);
+		if (rse->max_slice > se->max_slice)
+			se->max_slice =3D rse->max_slice;
+	}
+}
+
 /*
  * se->min_vruntime =3D min(se->vruntime, {left,right}->min_vruntime)
  */
@@ -860,6 +885,7 @@ static inline bool min_vruntime_update(struct sched_entit=
y *se, bool exit)
 {
 	u64 old_min_vruntime =3D se->min_vruntime;
 	u64 old_min_slice =3D se->min_slice;
+	u64 old_max_slice =3D se->max_slice;
 	struct rb_node *node =3D &se->run_node;
=20
 	se->min_vruntime =3D se->vruntime;
@@ -870,8 +896,13 @@ static inline bool min_vruntime_update(struct sched_enti=
ty *se, bool exit)
 	__min_slice_update(se, node->rb_right);
 	__min_slice_update(se, node->rb_left);
=20
+	se->max_slice =3D se->slice;
+	__max_slice_update(se, node->rb_right);
+	__max_slice_update(se, node->rb_left);
+
 	return se->min_vruntime =3D=3D old_min_vruntime &&
-	       se->min_slice =3D=3D old_min_slice;
+	       se->min_slice =3D=3D old_min_slice &&
+	       se->max_slice =3D=3D old_max_slice;
 }
=20
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,

