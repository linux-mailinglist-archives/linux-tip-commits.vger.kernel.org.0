Return-Path: <linux-tip-commits+bounces-7771-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52654CCEFBA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC3930A8B1F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AC306B02;
	Fri, 19 Dec 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtU6WKTV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvF1PyDl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF5305E28;
	Fri, 19 Dec 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132216; cv=none; b=GO6UNSjye6bZu0idcI6+SVIPkut5tSs4TSowIpegGSz5h7vXuVVhVN8q9kammAExxaMCcxXiE9IYUX66zC64aNtGuKef2LTD0ck1V2GEf1pO9zgBNGRErQ1/b0zzcWcqsrywS0tODQBIjaeVar0+eOFSdWYgLcAlp87bWhPJkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132216; c=relaxed/simple;
	bh=jy/Mh/GOyuzHoXMF4hVFP1aS9qIB/U94Qg7D19TNV2U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pcx0pHjUHnLFyFHA4W09rokIeLhx9Zc1i11tSDVibUlsTUYIDinkO6hFpCUO1xv/77AehSFIxoMjkm0ALal8w0pFVYEevaPkE86ny5//vuss0eU0TxvbSSHl22NJCxbqspHUgCA2SWQ5LVgFET+qUBTw4THYoQFHuHcav3DrmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtU6WKTV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvF1PyDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Dec 2025 08:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766132212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUSFlcFwnv42vT4o3X+vJlASJxjYyowAPnDgS7wIzso=;
	b=wtU6WKTVW2gEjJ6TykkK9jbYjx/RIcukJAnQMTinbETP26Q2IQWFdW4LV8aFQVmruJn6bG
	Lib/m/ogaxeipbNPKTd0CbXnxl3GBH6Djp/pB/+fFLK+tnxJm6EIDGT1NYg7MpO5/znutg
	Qmo69uiQH0/F5AHS9tCi3hmpxlwrPRUMAH8OrRUadiDKN+7CqQ6R4+ZHXqtBk7kK1P/5et
	JE4Fh31Sz8zbuTDi5eKlM07cUFDbuGTSsuyYbri1W+G3pG4jlK8I/QboOMTxpljpUyxeSK
	Lt+HkANyYtjIeo1ep4tlvV79OgrlN7stvmq+FR54FzQDWcLSGKpTDdhj6pJU7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766132212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUSFlcFwnv42vT4o3X+vJlASJxjYyowAPnDgS7wIzso=;
	b=yvF1PyDlgq8QPp2qSFEK4h+n+f27eOIPREjylH2MBTjyIx5NyyG0jDua2KvWXrN989BvYY
	UJMiH64YpKNsYXDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix sched_avg fold
Cc: kernel test robot <oliver.sang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251218102020.GO3707891@noisy.programming.kicks-ass.net>
References: <20251218102020.GO3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176613221140.510.276814644472640242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6ab7973f254071faf20fe5fcc502a3fe9ca14a47
Gitweb:        https://git.kernel.org/tip/6ab7973f254071faf20fe5fcc502a3fe9ca=
14a47
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 Dec 2025 09:04:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Dec 2025 09:09:38 +01:00

sched/fair: Fix sched_avg fold

After the robot reported a regression wrt commit: 089d84203ad4 ("sched/fair:
Fold the sched_avg update"), Shrikanth noted that two spots missed a factor
se_weight().

Fixes: 089d84203ad4 ("sched/fair: Fold the sched_avg update")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202512181208.753b9f6e-lkp@intel.com
Debugged-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251218102020.GO3707891@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 76f5e4b..7377f91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3775,13 +3775,15 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	__update_sa(&cfs_rq->avg, load, se->avg.load_avg, se->avg.load_sum);
+	__update_sa(&cfs_rq->avg, load, se->avg.load_avg,
+		    se_weight(se) * se->avg.load_sum);
 }
=20
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	__update_sa(&cfs_rq->avg, load, -se->avg.load_avg, -se->avg.load_sum);
+	__update_sa(&cfs_rq->avg, load, -se->avg.load_avg,
+		    se_weight(se) * -se->avg.load_sum);
 }
=20
 static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int=
 flags);

