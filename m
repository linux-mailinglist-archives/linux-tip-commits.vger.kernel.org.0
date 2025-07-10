Return-Path: <linux-tip-commits+bounces-6057-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04DB0024C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9D916412B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B01684B0;
	Thu, 10 Jul 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeHqyMdh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFtl/Rie"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1629239E9B;
	Thu, 10 Jul 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151595; cv=none; b=nTc2+qnQX1RNLd3aX2H2hx5xyKllcM6b15giTG5yexwh4aP1b495AbmW7eiwa9Q0/XxvoKwbMWWevbDK1wgoyW0AxbickPsBvEhU1hTZcpPa3gtjbHXHYsuSCGDye+duUIRYBlnJeRL88BEWuK+fJCiyf7tGsufp427OpByI0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151595; c=relaxed/simple;
	bh=Z9KH7u4TAQ4NcC0M8FsuW0LCLT31ApZ4+JcRHIOeUTU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MG2SGXDeDxqf2LF1TUoFkN0qCVonUUlV02Zi5aYbNxVGEhG8w/pS75IjFN0jEAQtxR+KV4b8dEHf2LSu3RcF/m/a0ogn6u5dwr68/LHwouc0kxRu3f7yhYsfPUl+RVDPJlWQnGoPKLQEgEkbSNQn+Zseehe6KF4DH9g1kMf+FAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UeHqyMdh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFtl/Rie; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNCgkguc4K17ftjsbExUmDwTu5KoCk7+tDdsgBUdwtQ=;
	b=UeHqyMdhuerWaCk0chtpgj/kxbxTbplhIxKzIF2065LpTEE8ypBdJw8z80tYmK7AFsWS/3
	G4EA1gTt+YEEzOOwm5ZF46yp0FN4mWYi+n7ktbBZOdxjf0tj49D8tUxCL79CGdX/BydGUQ
	LTXOnutq2qzTuILU4bT2tOCL6V1VTIXBTRZ/5casU3NcHoHFk7wiHUyc06/P+KYcBbvaz6
	30IuvzYpKOsn/xRWmHZkGdoIpUc5Mw3damxLD0LRy3w3StjQzhTE541HHvGvSGKDyH/OeV
	lRhz1nlRtuQQmsoGTeFIXgJMBbejkwyIkVRcveAZPMbnyn8N8LmAyX7wd5mjog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNCgkguc4K17ftjsbExUmDwTu5KoCk7+tDdsgBUdwtQ=;
	b=TFtl/RiefvIbnNlVDKAp3SQYUBoTFvl2lcvy1FyPvMKFEHqlgJKtlE8yFFAG7MoWGp1z2C
	pOp2VXlWkq9cvaBw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Always trigger resched at the end of a
 protected period
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708165630.1948751-7-vincent.guittot@linaro.org>
References: <20250708165630.1948751-7-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159074.406.16844859757255541211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0b9ca2dcabc3c8816a6ee75599cab7bef3330609
Gitweb:        https://git.kernel.org/tip/0b9ca2dcabc3c8816a6ee75599cab7bef3330609
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 08 Jul 2025 18:56:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:23 +02:00

sched/fair: Always trigger resched at the end of a protected period

Always trigger a resched after a protected period even if the entity is
still eligible. It can happen that an entity remains eligible at the end
of the protected period but must let an entity with a shorter slice to run
in order to keep its lag shorter than slice. This is particulalry true
with run to parity which tries to maximize the lag.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250708165630.1948751-7-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1660960..20a8456 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1182,14 +1182,6 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	cgroup_account_cputime(p, delta_exec);
 }
 
-static inline bool resched_next_slice(struct cfs_rq *cfs_rq, struct sched_entity *curr)
-{
-	if (protect_slice(curr))
-		return false;
-
-	return !entity_eligible(cfs_rq, curr);
-}
-
 /*
  * Used by other classes to account runtime.
  */
@@ -1250,7 +1242,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (cfs_rq->nr_queued == 1)
 		return;
 
-	if (resched || resched_next_slice(cfs_rq, curr)) {
+	if (resched || !protect_slice(curr)) {
 		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}

