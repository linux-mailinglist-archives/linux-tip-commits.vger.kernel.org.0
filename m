Return-Path: <linux-tip-commits+bounces-7596-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9427CA137E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8713266C10
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7131D38F;
	Wed,  3 Dec 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TwHSUjAb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uc7OFbDS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A133164B6;
	Wed,  3 Dec 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786319; cv=none; b=QJkpIt9Q/wQNs46o4jZALgTcBYfzFBDZupxLcrWUvUfdI/WhPtAL8omcamRHpyk66KbG0CS/ACOc/zRNo0/pc0UvKOeBkPHwjm0xgWZkDOW6tPogTIgtzT+jvUbwIXKb9q3DcxXG3oHHe08g0uUvTupL9GPKOIip3jRGThol8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786319; c=relaxed/simple;
	bh=fItXuMlDDnXbQpwFB3J1DyMFDcOzRjQo2TH6pe379lU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ba0JTMhvKbNxf2Uk15WMXIdZvUHIXm2YRc7NyVpZ8ssxFPcf1hR+YDCy9IIh2VE8/3LMSgOntcaH+90S2RKSkRjsQw352PNgTWken2tM0nvwtis7T7SCjUINjFnukwSrb+n6TOkgdnpcdHVGLArOQFMN+JAXTKlfZUzesLZw8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TwHSUjAb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uc7OFbDS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4XG5EKytgZj4FfO6V347gyis37ijyG19Tx9Lb5YWxw=;
	b=TwHSUjAbM6seBG+BFe28sQQTtGadGQfF/uZAobNJiXrvvix6Ynr1qjlKyeJge7GGTiaMiE
	g1B25tgMg2s8bzt+wYT2YFtBJk37ak4KfGOJ7CTEhj1jsblRnf2CisnOuHooyRZK/nk8J1
	FZwBSCXLL38wdDBHjOwcCbdiDNl4wd3mbmkE7LtgwVzKiIqNP4wIrhxvzAWV+0fNEnHjIp
	/Bzqy425Fk5S13Zg1N8AL3hnsLACz5zqHJfO2Vt0Ok5Gj+SV/05y3xUEiSy7mK3bEq1LoR
	BIqihp6YATF0J8WtBQAVu0Qf6lGDmdzLnMW7PCVACv7PlEzd2M4XMuoihUYXeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4XG5EKytgZj4FfO6V347gyis37ijyG19Tx9Lb5YWxw=;
	b=uc7OFbDST6NjpUPU6VJVDi1IKSi0lBChFl+dYAd3texqMMeesJ85xgn3R7OfusNC7TS5AI
	k3bc5ou7L33XwGAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt: Remove a preempt-disable section in
 rt_mutex_setprio()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251127155529.t_sTatE4@linutronix.de>
References: <20251127155529.t_sTatE4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478631197.498.9342089450906538199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     81a325c5b4ebc387181c5aca7586ccc049a2e96e
Gitweb:        https://git.kernel.org/tip/81a325c5b4ebc387181c5aca7586ccc049a=
2e96e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 16:55:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Dec 2025 15:27:16 +01:00

sched/rt: Remove a preempt-disable section in rt_mutex_setprio()

rt_mutex_setprio() has only one caller: rt_mutex_adjust_prio(). It
expects that task_struct::pi_lock and rt_mutex_base::wait_lock are held.
Both locks are raw_spinlock_t and are acquired with disabled interrupts.

Nevertheless rt_mutex_setprio() disables preemption while invoking
__balance_callbacks() and raw_spin_rq_unlock(). Even if one of the
balance callbacks unlocks the rq then it must not enable interrupts
because rt_mutex_base::wait_lock is still locked.
Therefore interrupts should remain disabled and disabling preemption is
not needed.

Commit 4c9a4bc89a9cc ("sched: Allow balance callbacks for check_class_changed=
()")
adds a preempt-disable section to rt_mutex_setprio() and
__sched_setscheduler(). In __sched_setscheduler() the preemption is
disabled before rq is unlocked and interrupts enabled but I don't see
why it makes a difference in rt_mutex_setprio().

Remove the preempt_disable() section from rt_mutex_setprio().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251127155529.t_sTatE4@linutronix.de
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c4ff93..7dfb6a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7358,15 +7358,12 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
ask_struct *pi_task)
 		p->prio =3D prio;
 	}
 out_unlock:
-	/* Avoid rq from going away on us: */
-	preempt_disable();
+	/* Caller holds task_struct::pi_lock, IRQs are still disabled */
=20
 	rq_unpin_lock(rq, &rf);
 	__balance_callbacks(rq);
 	rq_repin_lock(rq, &rf);
 	__task_rq_unlock(rq, p, &rf);
-
-	preempt_enable();
 }
 #endif /* CONFIG_RT_MUTEXES */
=20

