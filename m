Return-Path: <linux-tip-commits+bounces-6650-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D5B5957D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5387A371E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC1308F37;
	Tue, 16 Sep 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iWBEjkrK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xyXFw0Rh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACD3081C6;
	Tue, 16 Sep 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023018; cv=none; b=AE1nxQzINmbIOWB5Bz2V2jPu1w+CdVk/m5KyYeCCu2yhNJaG/aRMS83FHYXrVxlkCqg7xz9pWyQM6yWQVh2J4dn2xsWPM1xlw1mS0vvn5uJihbHw4YIrb4bi9r8Ivd+/RyBpA9GFpxpPhhiPxYqbwcM50JdHUbGep8pu5PxgtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023018; c=relaxed/simple;
	bh=y7wR+bA/adymunU0vUcEYopnCgPkn9+PWTJtJLmZGXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o5SK49H1Yw9OefnvWW00QoQA9RMpUVmUwvIYkDOLcqsfOWTHCCRX0g8csghXbmZj+5bhFarToCUwV/LGT8Q6pDcHnjF6IcQYvX9EbX7M4Hvi1LiygnClTf7U1nnIA46J0oyOI4qu2XqlAfQMHl+wqEnTAdxgRO+mjzuPn7ggyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iWBEjkrK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xyXFw0Rh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 11:43:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758023015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Itj3SBnxJhHFfSutMr68uiPRfYoaqS4UScE8xQGAZPg=;
	b=iWBEjkrKfNJ+GRHYH/eJx1m6i9W2nrqXugowyT2Efor2dxju38OW71lPvmRFmLIWdbNjqm
	lki9rgp1pHvNOG4TG39R6GvSDuROiuaOinpWhUHlNljM3OokKkrzGjFb6P1Kt2T+NiVzxv
	hgMzAMltHjuFo2du0srLAcT6TkSeZyv3dHtkyPROWKitlrqbY/vlZEvcxqqNQyf3D/D05X
	8UM5SeumCRAIZMW86bc97aB/ej/LkZBb/kDl6vRLjYDRsLsG64iINFQ4vNPxdumfZ5SGfh
	WpXIsMA7jnetMNYAuP5cLMekfIF20WtsAdEE31IV+Q3SARWfzFkRsYrlaOX61w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758023015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Itj3SBnxJhHFfSutMr68uiPRfYoaqS4UScE8xQGAZPg=;
	b=xyXFw0RhgDmXXVSFhEt8DsyeNOA9K1kHaDqvRdDKOQw1QM+Hc9kOd28L+olU8x4y2ygM9a
	R7UpFHEjtWEmkXCg==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Propagate load for throttled cfs_rq
Cc: Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250910095044.278-2-ziqianlu@bytedance.com>
References: <20250910095044.278-2-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802301366.709179.16577647971292327930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fe8d238e646e16cc431b7a5899f8dda690258ee9
Gitweb:        https://git.kernel.org/tip/fe8d238e646e16cc431b7a5899f8dda6902=
58ee9
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Wed, 10 Sep 2025 17:50:41 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:37 +02:00

sched/fair: Propagate load for throttled cfs_rq

Before task based throttle model, propagating load will stop at a
throttled cfs_rq and that propagate will happen on unthrottle time by
update_load_avg().

Now that there is no update_load_avg() on unthrottle for throttled
cfs_rq and all load tracking is done by task related operations, let the
propagate happen immediately.

While at it, add a comment to explain why cfs_rqs that are not affected
by throttle have to be added to leaf cfs_rq list in
propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
("sched/fair: Fix unfairness caused by missing load decay").

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 kernel/sched/fair.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc38..f993de3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5729,6 +5729,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_=
rq)
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
=20
+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6721,6 +6726,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_=
rq)
 	return 0;
 }
=20
+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return false;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_en=
tity *se)
 {
 	struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
=20
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
-	if (!throttled_hierarchy(cfs_rq))
+	/*
+	 * If a task gets attached to this cfs_rq and before being queued,
+	 * it gets migrated to another CPU due to reasons like affinity
+	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
+	 * that removed load decayed or it can cause faireness problem.
+	 */
+	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
=20
 	/* Start to propagate at parent */
@@ -13165,10 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_ent=
ity *se)
=20
 		update_load_avg(cfs_rq, se, UPDATE_TG);
=20
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		if (!throttled_hierarchy(cfs_rq))
+		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }

