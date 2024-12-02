Return-Path: <linux-tip-commits+bounces-2922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD59E0010
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F1A162F27
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC550207A1E;
	Mon,  2 Dec 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J2jNtxCu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hW0r0GlS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224491FE444;
	Mon,  2 Dec 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138087; cv=none; b=rLmW4eViaEojTo73W7iekZV68K1WL0JG9hHTKwNZsvOzJFak+/dZOqhUpg6Rcw7AJBXmun1M8qqeYyq2Njo+L8VTJlmQJqfKrH5KPrPUI0SMPEB8zC4cGgiEg7HPeWj94lw+sXymblTmYinv1E+d9O0HMLa5+bnfBawqzsX4G0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138087; c=relaxed/simple;
	bh=Q3oAqNt+8gB6E1+z2gsovOlWtwInQlN6LLSntwh1EI0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F/sOmKkRWXFnShSlGBW4fKiR0YnapUO1E19I+fqPKmSO3ACN1cQAuliIIg0F/7QEaKhXbf83zSq9LcMAqkEllhZ4xhErx2ru5HDGlcrBCMGj5HsfAo14nb64CBmviM0aW5EJyvL2r5vif6g25ZrdJQFb7GWjW7KXPSyuyIi6wsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2jNtxCu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hW0r0GlS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewCHsCptMUUfTsaesPLtBDpAbg5ztArziZYr9FDxxUE=;
	b=J2jNtxCu2WNbAPyO5neR3U/NBfJSTeqKQI/sczXOQz1v8cndG5KrQR4RBopNbImg9LIzmR
	kCGxpF9sehdVIAD73uSNewS58ixr4U+v8CVKTgxpa7qZ+Y13VO/KwsqrN+23OZN8BM47ej
	KVNb2E5TO13jtRQTxXzypm6oLIc7DtluJd64a/jnrpGOLL1O9mDfwVA/nGH9XXAzwkQhvk
	/TUXNjEWd9E/114r/hpHWnWow+8IEL0Yed2t1lq7gFjLaIhSdoP4JuwWdvLs/XZ/rwKb92
	DIEJmeDZLr82RHG+YM34uehMz1BtRsRn2oySz+Tb0hyZL08V/zQRV0f17lHRIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewCHsCptMUUfTsaesPLtBDpAbg5ztArziZYr9FDxxUE=;
	b=hW0r0GlSVnP7TpyiRCZSzZypmHgy2p4OTD3CkNGO3cMjUdTjdTrrgY1R8I81e69TomZxC2
	KCSsgnD+7Og9McAA==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241114142810.794657-2-juri.lelli@redhat.com>
References: <20241114142810.794657-2-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808391.412.7201088170374631569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     41d4200b7103152468552ee50998cda914102049
Gitweb:        https://git.kernel.org/tip/41d4200b7103152468552ee50998cda914102049
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 14 Nov 2024 14:28:09 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:30 +01:00

sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes

When root domain non-destructive changes (e.g., only modifying one of
the existing root domains while the rest is not touched) happen we still
need to clear DEADLINE bandwidth accounting so that it's then properly
restored, taking into account DEADLINE tasks associated to each cpuset
(associated to each root domain). After the introduction of dl_servers,
we fail to restore such servers contribution after non-destructive
changes (as they are only considered on destructive changes when
runqueues are attached to the new domains).

Fix this by making sure we iterate over the dl_servers attached to
domains that have not been destroyed and add their bandwidth
contribution back correctly.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20241114142810.794657-2-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 17 ++++++++++++++---
 kernel/sched/topology.c |  8 +++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index db47f33..ff68ce4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2960,11 +2960,22 @@ void dl_add_task_root_domain(struct task_struct *p)
 
 void dl_clear_root_domain(struct root_domain *rd)
 {
-	unsigned long flags;
+	int i;
 
-	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
 	rd->dl_bw.total_bw = 0;
-	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+
+	/*
+	 * dl_server bandwidth is only restored when CPUs are attached to root
+	 * domains (after domains are created or CPUs moved back to the
+	 * default root doamin).
+	 */
+	for_each_cpu(i, rd->span) {
+		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
+
+		if (dl_server(dl_se) && cpu_active(i))
+			rd->dl_bw.total_bw += dl_se->dl_bw;
+	}
 }
 
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c..9c405f0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2721,9 +2721,11 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 				/*
 				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.  It
-				 * will be recomputed in function
-				 * update_tasks_root_domain().
+				 * its dl_bw->total_bw needs to be cleared.
+				 * Tasks contribution will be then recomputed
+				 * in function dl_update_tasks_root_domain(),
+				 * dl_servers contribution in function
+				 * dl_restore_server_root_domain().
 				 */
 				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
 				dl_clear_root_domain(rd);

