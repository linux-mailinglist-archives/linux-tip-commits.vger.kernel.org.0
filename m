Return-Path: <linux-tip-commits+bounces-7307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F983C4F0CA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 911BF4EF04F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7B2857FC;
	Tue, 11 Nov 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RFNxbG9L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2p9y1nQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9030313E3B;
	Tue, 11 Nov 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878785; cv=none; b=epKFSv8eGHM2O1uKHMmAXJf4Lkf6ce3ndSdau8tovKWcGhTxGyuHT/Vgul+D2z4howIEeOAiXggws7UiQn9lXt1WAAWw0iKFL+awJVCWI3K+M33AfX1fH71C6jb9XqtxkG3OWFZoCKYek8k6BqjFwC+a9tgAN+xcZEyYZ6a3tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878785; c=relaxed/simple;
	bh=fTvGHLO06b/2k2Z1He/lu5DXGIi+UJ03yE7Z7ekJgzE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cOknIJFwKDPacAZIXwAToGKitFExlJYG5AGmpt67wSh64BnoMzxoXprWV1H77JIvDh+7Up//DDRkApsSImtdc1BGW07MR5y3ez3dNSO84z4i2svnDQfAk5NNmhOQPN8aNev7P/srFlbzzip5nh3mU5oUpB10dLL4CG0kuS8FjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RFNxbG9L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2p9y1nQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 16:33:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762878782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cJqp/N7W9vGEtBqjDPdSUiU245IhjW+KdPa9/WlK9o=;
	b=RFNxbG9LJDLc/S0EAHIMOzEbqIiCFu8hSGKrPkRhcO7CeKZ0C9MzT62gbnapUINAK2y3jF
	UibNrm+S9R5Av9c3Crr5JxrK35K/5CW0NkZwNqLPQg30QiXFUQRtTsWBHyQrJPA5Oyo0rC
	u5pq2IayZ2qur0a3jASjpFE1kH/jFi3PWHIGAB2QTZTL0+lEIet4MEyRHvOqPmP1KWNqEg
	m/c5NDlpRmFuOaiYVkXzP6Hs5h2BZl6X+07NWbQS1a9GnMB/cdErToegAB3VaYLQWGU7oH
	UQi13sziOIm67x6xt8sL5vjJQvsDakDLwkNrtc6EGwys+fRyMiIrGAl9XZiEiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762878782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cJqp/N7W9vGEtBqjDPdSUiU245IhjW+KdPa9/WlK9o=;
	b=v2p9y1nQxg6oPQ2cV+MO33T5106PmS17iFT+uipDoh98dzgfU5O/iNzSNG3sANrdGNKs78
	2Ix+1QdQvwqk8eDA==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: Use cpumask_weight_and() in dl_bw_cpus
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014100342.978936-3-sshegde@linux.ibm.com>
References: <20251014100342.978936-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176287878111.498.732354130967280139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b4bfacd39216755c058f6d13c71c86a9bf5a1631
Gitweb:        https://git.kernel.org/tip/b4bfacd39216755c058f6d13c71c86a9bf5=
a1631
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Tue, 14 Oct 2025 15:33:42 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 17:27:55 +01:00

sched/deadline: Use cpumask_weight_and() in dl_bw_cpus

cpumask_subset(a,b) -> cpumask_weight(a) should be same as cpumask_weight_and=
(a,b)
for_each_cpu_and(a,b) to count cpus could be replaced by cpumask_weight_and(a=
,b)

No Functional Change. It could save a few cycles since cpumask_weight_and
would be more efficient. Plus one less stack variable.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20251014100342.978936-3-sshegde@linux.ibm.com
---
 kernel/sched/deadline.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e958cf9..4dd4b2f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -125,20 +125,11 @@ static inline struct dl_bw *dl_bw_of(int i)
 static inline int dl_bw_cpus(int i)
 {
 	struct root_domain *rd =3D cpu_rq(i)->rd;
-	int cpus;
=20
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
=20
-	if (cpumask_subset(rd->span, cpu_active_mask))
-		return cpumask_weight(rd->span);
-
-	cpus =3D 0;
-
-	for_each_cpu_and(i, rd->span, cpu_active_mask)
-		cpus++;
-
-	return cpus;
+	return cpumask_weight_and(rd->span, cpu_active_mask);
 }
=20
 static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)

