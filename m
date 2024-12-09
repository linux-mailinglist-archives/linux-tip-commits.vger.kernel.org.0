Return-Path: <linux-tip-commits+bounces-3029-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B769E9126
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F17281D9B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C422185AF;
	Mon,  9 Dec 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bm8teiP6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCS5nKP/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CC217656;
	Mon,  9 Dec 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742008; cv=none; b=TUUXYD22LixBeahJRevG82f8K0uuMbjCiwTnutQKX6YmiQv/pVLD5zIZxborOCi6uhhTJOxAD4TKe7NdjRlVYYJlAVGDt/kErlsJEVCxzZuoiaiLRQaJcF4ZCRcuxkzA5rOsCH1Jpz388yDNhNUn4zPQZerOiCeu3W+3YczkHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742008; c=relaxed/simple;
	bh=Jq2WmuoEZMY0f2iqU5zdZLDOY1MfN2EZsMzOfRJ4Z44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ujhz4o5Oz5eiXrzXeKlIm88+V+Sn36c3fG0d32xKYqDvLdYE9d1HW6tVYCGXwaGm7UvizNrvUSCS0eJNekhHR90DVwi9R7hSFw00a9kiUOve3Ql0++q68yc3iO33hDtahzB02pl1lhBZSt4QKxsALzyhyWoNtWe0x8psNcMJQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bm8teiP6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCS5nKP/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oed0ZC2d2/Xtw3TbhCBRtsAMntr7ON+nO1ZvmOs4Dls=;
	b=Bm8teiP6AF6D57wxSYVF/vqYJWd8JQGVhJ+Yv3vsd03jGttzy91OwhWZV965fLXP592X8J
	ZsWzJwMPI6LlhI0tyjcuRd5K+RD80lACQC0MzAOdxFJkKj1EKXe9PEY5N3GmNuQxy8Unww
	xUs2HYaPJobcFJSlwOiSmZjtK/wpvPqJKNHJV2iR2W/pheabNImkIeceGe2JSX7dSKXiiF
	crUnF3T6Tic4FP1ESRmuutlD/pxWeBEV89LtvmFG1bZVxt5fYd1Zj5sWAOrr7EWCMaGvGW
	Z6FCJ61Hn2usGGNdxUrJuUx1L244AskGHj3SsLv44F+eJqHfKd+DPPLYNHu1dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oed0ZC2d2/Xtw3TbhCBRtsAMntr7ON+nO1ZvmOs4Dls=;
	b=dCS5nKP/4wmmFSH4LvxF02X96Vzrod1wf5rSKIDtuk/HbRqHNDKXVfZA0u3ahfJZz7/po8
	yfL/kcZqNaayCmCw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Do not try to migrate delayed dequeue task
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-11-vincent.guittot@linaro.org>
References: <20241202174606.4074512-11-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200362.412.2553443361090747763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     61b82dfb6b7e1f951fd1e95198a2aee2ccf6a167
Gitweb:        https://git.kernel.org/tip/61b82dfb6b7e1f951fd1e95198a2aee2ccf6a167
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:13 +01:00

sched/fair: Do not try to migrate delayed dequeue task

Migrating a delayed dequeued task doesn't help in balancing the number
of runnable tasks in the system.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-11-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84c0191..2aa1d0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9391,11 +9391,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * We do not migrate tasks that are:
-	 * 1) throttled_lb_pair, or
-	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 1) delayed dequeued unless we migrate load, or
+	 * 2) throttled_lb_pair, or
+	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
+	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
+		return 0;
+
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 

