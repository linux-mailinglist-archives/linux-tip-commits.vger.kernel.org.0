Return-Path: <linux-tip-commits+bounces-3028-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76149E9124
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C741640BD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E73217F49;
	Mon,  9 Dec 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+SuT/Fz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dl7gkO49"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A121767A;
	Mon,  9 Dec 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742007; cv=none; b=UQFFqTX3jAP+IuNWDQbEdT9G8u+JVGbgJYjvAQu8optN4hUGD8bJ1AbJkxePkmPO6Xh9oZk+1slSxlTQkvY9RR5hPAdnKXPLorrFklnRAxp3fzmNlyIMvewtqu/m9F1MhvGD8XDn7wGy4it5fwW3Jr49GX2HvaMMivcrJCFdg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742007; c=relaxed/simple;
	bh=19ZnVTJPrhOdjo24cW2yLuVpRx6wqwC5L4q7IbWZIjI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NXw9QZna7qNbPQQ/Ib3YjUNLRHBb3c1Rz279PU8apuAwW/5IEA9H2io+3a9Tr9xu4cyzsM3A213+Bmx3tS8Iuw0XLJxTvBQckbZ4mVh9F2T8FdHmK8t/oZUu/WzebgHN3a3lmcQY1wraZGokE5+8ONmDDbrHhW+7/OdWx/aQ8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+SuT/Fz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dl7gkO49; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZxyBjrcaamSk41t/BbQKQyspeHKrPd78WNOrRjPMJQ=;
	b=s+SuT/FzGokfJ/HxwH0FuB5PY1ymBKFI63oU9xXSGEk1/wQzZv2oy49IcXcXo9nxFTIbcR
	1MESSrBF1sWGcf13fv/bdbQwZAzc2vNw+Gce9QDe93FF0FZpmII0RwOSHhQOrqD3qLMIY7
	m2clMRLnvsAAUGliZLhAFiqlEGlxuj5c9zR0qVpq9EhdaOfmf5NvJax4dSJeM+UhZMtiaN
	eYTSzQG9lZy/6XM2ZltlofhR7Ft86CWac7HtsWcY1+EywUYPWtJ9zV9JJXeXkN9/VjFV+y
	kRbJrs6L5itJqCun1LoMZ2iV4qv85m+DhozXjzg5kVbcmBMhxGXVV+JuzEOulg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZxyBjrcaamSk41t/BbQKQyspeHKrPd78WNOrRjPMJQ=;
	b=Dl7gkO49qatutOBxjrUj3+QzBAPNa+KKpv7vKbALt5rzV8W1j2NRBDiJHZudVtDn2h4yxg
	yc0+iviegBmGD2CA==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix variable declaration position
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-12-vincent.guittot@linaro.org>
References: <20241202174606.4074512-12-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200278.412.14459413242760786276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0429489e092851f066b08deed9ce0f3910515383
Gitweb:        https://git.kernel.org/tip/0429489e092851f066b08deed9ce0f3910515383
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:13 +01:00

sched/fair: Fix variable declaration position

Move variable declaration at the beginning of the function

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-12-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2aa1d0c..04db7e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5494,6 +5494,7 @@ static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool sleep = flags & DEQUEUE_SLEEP;
+	int action = UPDATE_TG;
 
 	update_curr(cfs_rq);
 	clear_buddies(cfs_rq, se);
@@ -5519,7 +5520,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		}
 	}
 
-	int action = UPDATE_TG;
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
 		action |= DO_DETACH;
 
@@ -5627,6 +5627,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se;
+
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
@@ -5637,7 +5639,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 		return cfs_rq->next;
 	}
 
-	struct sched_entity *se = pick_eevdf(cfs_rq);
+	se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*

