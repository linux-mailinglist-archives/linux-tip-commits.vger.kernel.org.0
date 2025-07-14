Return-Path: <linux-tip-commits+bounces-6109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1EB03A73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BCA3B0271
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88742242D97;
	Mon, 14 Jul 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AuV1sIi6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GgpAxQDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DE242905;
	Mon, 14 Jul 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484245; cv=none; b=GRfHO+ObGc/L+PlwmdsH+vob/6/akQSgJ8qx0X0WpauBEYebnRVJSO9RHxfDKYRcNvIpRrcBHLm+hM9WMstnZbdqnlmO4gPCnD7xZL+5X4agi6XpSAms8beH3/M7VuxJMWNdJDTxJvYSCink91U8oUyqazhHszC9UA24HdPDS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484245; c=relaxed/simple;
	bh=qnAEu5j3CQ1xKcQWe+Ki3PKz+ffYOttyfadIfWTtIto=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SU5JYMZ39gmieg0b3tEKDs/VaW6zdRSiEpR1EAFdVXDINEfuZhqjTGHNcovebZge4KSumSBdkPlM11MYH7NeRKlJ0726gzM/oQjfeKlS/Fq6maG3px2cikNIzrRd6s79Ts6v2Vg5HxPBNV9lG/rW4GbaeU9OfadqZ3X1pmGcPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AuV1sIi6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GgpAxQDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFqasCAWOIMVY8xRWGwGfawyoa3gka7tW0N77MJafEI=;
	b=AuV1sIi614mc3sDrLHDhtFNNxMmkxyq8xmXjAirdiNetbhHyhVk3vICExzGP1ZTJkPQhRb
	dzQkTLN47puQ6Ayx+gVauUemh5TcZ/ldEY7xZxLKqTTxTb26ZoX8ruAtOYTT60dkja02Ur
	BEiWKM1pqaKrMaFCWhC5kHqYOvlWo8Gb6IYibaLoke235GCsWYtmsMA4R+Xe0BjQzW/Bni
	AQc+TZnsKzCtY+gBQlgrunL6ajEkD4vdQHyiEs0h1vlA+xAogpNUvVuWQL2RbZKqHiMzhi
	a7Idymqrtol32BIw8lba2UfeiXmCyMWXPmho/RteMHN4tya79h5oDmw4x7gQHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFqasCAWOIMVY8xRWGwGfawyoa3gka7tW0N77MJafEI=;
	b=GgpAxQDZO+VQz/gzlRPdmibDSg7qMVlOqyHgeO/AGFm7VEBQF2zCL0ZRxpWHdS+hwARw/G
	AOwZZryNbzAITfDQ==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: Fix accounting after global limits change
Cc: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
 Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627115118.438797-4-juri.lelli@redhat.com>
References: <20250627115118.438797-4-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248424109.406.14874147084639274833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     440989c10f4e32620e9e2717ca52c3ed7ae11048
Gitweb:        https://git.kernel.org/tip/440989c10f4e32620e9e2717ca52c3ed7ae11048
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Fri, 27 Jun 2025 13:51:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:33 +02:00

sched/deadline: Fix accounting after global limits change

A global limits change (sched_rt_handler() logic) currently leaves stale
and/or incorrect values in variables related to accounting (e.g.
extra_bw).

Properly clean up per runqueue variables before implementing the change
and rebuild scheduling domains (so that accounting is also properly
restored) after such a change is complete.

Reported-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # nuc & rock5b
Link: https://lore.kernel.org/r/20250627115118.438797-4-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 4 +++-
 kernel/sched/rt.c       | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0abffe3..9c7d952 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3183,6 +3183,9 @@ void sched_dl_do_global(void)
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
+	for_each_possible_cpu(cpu)
+		init_dl_rq_bw_ratio(&cpu_rq(cpu)->dl);
+
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
 
@@ -3198,7 +3201,6 @@ void sched_dl_do_global(void)
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
 		rcu_read_unlock_sched();
-		init_dl_rq_bw_ratio(&cpu_rq(cpu)->dl);
 	}
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 15d5855..be6e9bc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2886,6 +2886,12 @@ undo:
 	sched_domains_mutex_unlock();
 	mutex_unlock(&mutex);
 
+	/*
+	 * After changing maximum available bandwidth for DEADLINE, we need to
+	 * recompute per root domain and per cpus variables accordingly.
+	 */
+	rebuild_sched_domains();
+
 	return ret;
 }
 

