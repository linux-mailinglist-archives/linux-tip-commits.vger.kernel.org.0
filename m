Return-Path: <linux-tip-commits+bounces-5794-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDECAD8476
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2F3BA689
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9322E888F;
	Fri, 13 Jun 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPm5oXZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWbSDc3S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4A2E7F1A;
	Fri, 13 Jun 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800241; cv=none; b=eP8v2M8zWBfokFQlIFVqQBE707ikeE8hmbe+06FmBQz2YffgIclnm5SokUrv9kKThX3sZ4BALc5h5vQCg9PN3n3XExITbSmba28fVC1CRZ9J3uzXHM3Ex6Mh0c/YfqKGMmzliAwpWMBgSjSIqhyBMIudMNm8hcw2zZqDP7W8Jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800241; c=relaxed/simple;
	bh=Kdw3hBFMipUon2tOuLWtpNPqlMzaZz4xthoOeJG1pUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JIICsEfCYTt1ZZUhlV3NqwSmIAn+duMR6tfnXJEgU7L2Y4Ial0NyV4zX7BqYPZ2+iu7qNdwEOYqT2cDCfvYuxFgdbeulArQ9DwB2B+t1Z/umHWFoXY+HQRJxnK4WDsQbxCHiTJm46wcStxpCPDEbhLTQ7vJyIknC3T3iTkNRoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPm5oXZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EWbSDc3S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5h3DREMX1wbuYj6Hcak1PF49V59tWUCHLbGhzQArmo=;
	b=lPm5oXZil6dGy58FCygPoGjHJYb1BzAnCTa8co6icCgDZff5ccnYQJ86zMHICwKlTAhtPC
	AvH5WdsIVe4zu0cr4ffZ2TubXpvJ4Oblby1gcucgiEEsCczwhO9m9TbFhf1CknmS3GrhVy
	O7VEoVcsVMZDzBoLfyh0Ai5qLTgrOyYZQeZ+Fvqkh4GAgLhXW1EcT8DUA1iDaC9nTTSZKU
	37v442AugTIjxi4mKOOrJkAAXu89TtRCIiHpzxHKueFuvbfIadCHy1jKV2UVtKyBvAR6V6
	1ERMamqAZhEiog+GWmNyLgyE8MX6G0lVeZ/pht4HLso3WkSwEVDKQTNJNnRDyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5h3DREMX1wbuYj6Hcak1PF49V59tWUCHLbGhzQArmo=;
	b=EWbSDc3ShfurPTJSsLsNoG0ADXyQCis7OuE2VnshsVL+qe4qzv1CDN+LlD+1T7a6Ob7DeY
	oE/we4WBPUIhpXBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of the deadline
 scheduling class
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-30-mingo@kernel.org>
References: <20250528080924.2273858-30-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023775.406.17404450194416335798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6324dce8f6262ec2049494af311e5418bc733341
Gitweb:        https://git.kernel.org/tip/6324dce8f6262ec2049494af311e5418bc733341
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:20 +02:00

sched/smp: Use the SMP version of the deadline scheduling class

Simplify the scheduler by making CONFIG_SMP=y code
in prio_changed_dl() unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-30-mingo@kernel.org
---
 kernel/sched/deadline.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index bf9b70a..0f30697 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3005,7 +3005,6 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!task_on_rq_queued(p))
 		return;
 
-#ifdef CONFIG_SMP
 	/*
 	 * This might be too much, but unfortunately
 	 * we don't have the old deadline value, and
@@ -3034,13 +3033,6 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		    dl_time_before(p->dl.deadline, rq->curr->dl.deadline))
 			resched_curr(rq);
 	}
-#else /* !CONFIG_SMP: */
-	/*
-	 * We don't know if p has a earlier or later deadline, so let's blindly
-	 * set a (maybe not needed) rescheduling point.
-	 */
-	resched_curr(rq);
-#endif /* !CONFIG_SMP */
 }
 
 #ifdef CONFIG_SCHED_CORE

