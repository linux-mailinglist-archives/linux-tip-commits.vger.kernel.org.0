Return-Path: <linux-tip-commits+bounces-6059-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D50B00253
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AC33ADF25
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15427268FED;
	Thu, 10 Jul 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XL04xnKC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uCCbL96S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DD259C9A;
	Thu, 10 Jul 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151598; cv=none; b=CDeV2deuKWTWlaspICq/BN9cm+k8JDJZTMMcb6ZhWo4ol8kSI3xVlvcPfnAjSAAGEq1HEhJ66e+3Yh/SU2e+EXxQvEqOSvQxVVjYivwMB8sq6x5xYiWM2SHsytzQ4jbIHaa67KyCXXU+t7MC2Bj8VQ5EBUr8Jji6510ku7vSUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151598; c=relaxed/simple;
	bh=ZvQnHAQv3rNqDuPUpw+Yvb/N8IYBELNPHoDRW+PuOQc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dJGumsVed1001RXCnaeqryiWc07ZPnGdgxVFNaQZk2JQimRy+58j1ENcvHMillC87QvojrUHjPgkE9qTM1pjsY9PATBNukwWIfTen/PslOeKNUOtIXM7YDeu14FelD9WE+vlRcHzQtp1jeoMLCrgjSQKqIvYOHsYPseJvIGhPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XL04xnKC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uCCbL96S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4yBb1XLSRLapWhpMqlD3j1Eic3406DltzYpBsj0zUA=;
	b=XL04xnKCAkh1lY7TWxjisxvqlHJVa5Xj/Io+1y66TQErN/vj3oUAoXmazZ6ncoY20yzyY3
	qJtGtgZUc0/NnaiHhVMdD/QVzZeoSGZLNpEKmsw+4Td9njaRrDd5M2bzWF6STbpUW1rMcz
	83seZl94VqMEnQCWrhNEXby1kqyM0KrrO0YV+2B3sD+cGgKjkqZ11pAN2jQYjJXm5x2WMU
	DB0k0az5MrHihYzV3nJbE6zKmuPQrDCcnUVPU2QOalTvK/hrY1ZtNGR0Yrb8akFbMQftHj
	Yv3CvPnCGAHgVxXEIPAoXG9lBtBLTEIc4UGHYP3e1CTBiaYgUp8Y3Sx1ESICjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4yBb1XLSRLapWhpMqlD3j1Eic3406DltzYpBsj0zUA=;
	b=uCCbL96SMfkuJYxkpDiKEbKRHLWrOi4LHrsIgFRM80RIpRtJOf2fGpTbKJ6eb4J7MQm75Y
	8LqxziaXkwhjDBBg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Limit run to parity to the min slice of
 enqueued entities
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708165630.1948751-5-vincent.guittot@linaro.org>
References: <20250708165630.1948751-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159265.406.8983815628970626115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     052c3d87c82ea4ee83232b747512847b4e8c9976
Gitweb:        https://git.kernel.org/tip/052c3d87c82ea4ee83232b747512847b4e8c9976
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 08 Jul 2025 18:56:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:23 +02:00

sched/fair: Limit run to parity to the min slice of enqueued entities

Run to parity ensures that current will get a chance to run its full
slice in one go but this can create large latency and/or lag for
entities with shorter slice that have exhausted their previous slice
and wait to run their next slice.

Clamp the run to parity to the shortest slice of all enqueued entities.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250708165630.1948751-5-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96718b3..45e057f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -884,18 +884,20 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 /*
  * Set the vruntime up to which an entity can run before looking
  * for another entity to pick.
- * In case of run to parity, we protect the entity up to its deadline.
+ * In case of run to parity, we use the shortest slice of the enqueued
+ * entities to set the protected period.
  * When run to parity is disabled, we give a minimum quantum to the running
  * entity to ensure progress.
  */
 static inline void set_protect_slice(struct sched_entity *se)
 {
-	u64 slice = se->slice;
+	u64 slice = normalized_sysctl_sched_base_slice;
 	u64 vprot = se->deadline;
 
-	if (!sched_feat(RUN_TO_PARITY))
-		slice = min(slice, normalized_sysctl_sched_base_slice);
+	if (sched_feat(RUN_TO_PARITY))
+		slice = cfs_rq_min_slice(cfs_rq_of(se));
 
+	slice = min(slice, se->slice);
 	if (slice != se->slice)
 		vprot = min_vruntime(vprot, se->vruntime + calc_delta_fair(slice, se));
 

