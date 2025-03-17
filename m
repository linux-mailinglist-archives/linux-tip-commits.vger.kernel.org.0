Return-Path: <linux-tip-commits+bounces-4260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF64A64A75
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CAB3BB089
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A023E336;
	Mon, 17 Mar 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YILW1/7Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PpCfhSir"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5323C8D4;
	Mon, 17 Mar 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207687; cv=none; b=ZUP0tJ/RC6H2RMhUIAMciJcg1J+c5RlwDznT9AxaLJ4gcX8GQgAERzDoMq17a9yDWRumgZI3cMkNJUEQMROLZhAe7ntloOTaG8H8lZZay8Yk9Xwq2hyzeed4d3vJvbIMOdjiQ2WxmwvmB098o1s08bLgS0gWznEHQoDWAv49RD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207687; c=relaxed/simple;
	bh=XOwHEu3aZH+jWa2ukkLM+I+tM4BH3KKySj4wwJtwe4Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZxQxfDKwtbewgsqw3LePVQfMKfoTOqUPso+5254cxoL9N+Zkl+ILkWfhVidTNyCJpYfZrpyka4Hd9Hb2DB+d+10ydSCxXtrh8k0ry741UAovQHKU8QKS4iOMR6fflF9X3IH83rww+zb6JLgtQSBECRW/uSv6eS4pSXhL6oQLDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YILW1/7Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PpCfhSir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKiXn6hLuo5Od801UGkrpQPy/cH4FzwRlASDQJHTFrQ=;
	b=YILW1/7QS/hMY8UFZZ6EZKlOEWbxPjbMdD5Y9TiHS02KBDigfiEdCxBt8Yl9sGHHAXdLjl
	dX88Wz8ILhnDADKNiSIUIpxfEkAvHnFoKzVVm0PmnHn+V6EJqUo4ya1tNqzYAEf+se1P5J
	t57bHRRxmcqoGyJFfthZC+TgNA6RLMiBFqqKOiaq2Mj+ye5JMCTcAzz5btm4+MS/YKwCml
	ZzqZHtHmJLZVXqEgVM8866WfWA8eQhCIZd2d13Ysq2S0+7en+gTkiMt3tOP6Rwl8kABHwJ
	CYVRflTTCPbj96VK9zGNgSeRqD33O8PGUd9I45wCG5mjcg8GPPdUpXKtjeZpzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKiXn6hLuo5Od801UGkrpQPy/cH4FzwRlASDQJHTFrQ=;
	b=PpCfhSirgvTDy36aFiobP/iJJ1gRBfm8EHH1kZh9906VmKrWaZJFZ8tcUWhUGmVZnwNbpW
	vR074Ro3UibDSyBA==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Ignore special tasks when
 rebuilding domains
Cc: Jon Hunter <jonathanh@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250313170011.357208-2-juri.lelli@redhat.com>
References: <20250313170011.357208-2-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768337.14745.8898635689115136336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f6147af176eaa4027b692fdbb1a0a60dfaa1e9b6
Gitweb:        https://git.kernel.org/tip/f6147af176eaa4027b692fdbb1a0a60dfaa1e9b6
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:00:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:41 +01:00

sched/deadline: Ignore special tasks when rebuilding domains

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20250313170011.357208-2-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff4df16..1a041c1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}

