Return-Path: <linux-tip-commits+bounces-6844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A2BE26F0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34D8500AC4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A43218A6;
	Thu, 16 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrLp+VZA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0pEXOjtA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E893320CC2;
	Thu, 16 Oct 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607227; cv=none; b=CG32HOB5Dkubp3fzCzP72sgONdYVAeGAgiQsAnRWpMdaRKeKNYgzKyxPD1/ZiJ25WEzKj3JzuEWvIDv10WJ/bNnlsw8BoNGpNNAPfQyWN//msU3/SPA9+/6VuPiAk+C/+JxkaJMF5vl45C4bIfkzQyK3AJtQre4dCIyNJ72/X1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607227; c=relaxed/simple;
	bh=H3hAEskZFZwo8tIYqYLqGRYCviXQ5PGx/cwtQHER7NE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O7+NI/eesIo3XpftWWACgkZOQuZUIqPDgldf8mE6insWVW4GIxwAirl5KcjKiRz3D/g4P2NM0iDoLOvZTamhtwlZ9Ly2gt/UqQbDrY0tvoTn7PEcZ5MXvEiJGwg9PQ3axkQqRYGz72eJ9hZi/RWAjjjIzMnBee/kT59J8AIZyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrLp+VZA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0pEXOjtA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlVxRPVUSvlKC12+0DdL7mfyIXi3uJeWpWxUevNQOS8=;
	b=TrLp+VZA/MEOVeg64u725NvSgngYrVQBL7dcHrSfbp67fxgXS7kzBlr2hgijQJT62LoViH
	/oOgU5BOD3JyMw/0bLzTNUzR8Foq135HnKp2luVMprC21XU+yyVx+UpxojpWxSDKBuIgHn
	CF6cXf3u1Lr+KHxY/mBuzFOEOQs3R53pRKtrsL/CYbe5qFZUBk0tSiuqIqrHhfeZbJbkQs
	1xYL5E88HFQYb2nwE2P3BOTzbyO5RKfza16/Qny8PJSHXWCKUXmKNRBuFjHUYTHfZKDZ/S
	5+ZHmBwg4dpiKBkJE5hKhGEP0Pf5Rz0DX+tcGBQIyyT4/i0Z1mycoAMZ8l2AKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlVxRPVUSvlKC12+0DdL7mfyIXi3uJeWpWxUevNQOS8=;
	b=0pEXOjtAVQH0pwMIl7PY2gVIW+PlOBSXz4irJjdgoxob0Y1K/hcPJh/pEqpnh8H8TgJlGN
	dfWqclAi1THpTGDA==
From: "tip-bot2 for Adam Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Only update stats for allowed CPUs when
 looking for dst group
Cc: Adam Li <adamli@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251011064322.8500-1-adamli@os.amperecomputing.com>
References: <20251011064322.8500-1-adamli@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060722202.709179.10324554366547920524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82d6e01a0699800efd8b048eb584c907ccb47b7a
Gitweb:        https://git.kernel.org/tip/82d6e01a0699800efd8b048eb584c907ccb=
47b7a
Author:        Adam Li <adamli@os.amperecomputing.com>
AuthorDate:    Sat, 11 Oct 2025 06:43:22=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:50 +02:00

sched/fair: Only update stats for allowed CPUs when looking for dst group

Load imbalance is observed when the workload frequently forks new threads.
Due to CPU affinity, the workload can run on CPU 0-7 in the first
group, and only on CPU 8-11 in the second group. CPU 12-15 are always idle.

{ 0 1 2 3 4 5 6 7 } {8 9 10 11 12 13 14 15}
  * * * * * * * *    * * *  *

When looking for dst group for newly forked threads, in many times
update_sg_wakeup_stats() reports the second group has more idle CPUs
than the first group. The scheduler thinks the second group is less
busy. Then it selects least busy CPUs among CPU 8-11. Therefore CPU 8-11
can be crowded with newly forked threads, at the same time CPU 0-7
can be idle.

A task may not use all the CPUs in a schedule group due to CPU affinity.
Only update schedule group statistics for allowed CPUs.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00f9d6c..ac881df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10683,7 +10683,7 @@ static inline void update_sg_wakeup_stats(struct sche=
d_domain *sd,
 	if (sd->flags & SD_ASYM_CPUCAPACITY)
 		sgs->group_misfit_task_load =3D 1;
=20
-	for_each_cpu(i, sched_group_span(group)) {
+	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
 		struct rq *rq =3D cpu_rq(i);
 		unsigned int local;
=20

