Return-Path: <linux-tip-commits+bounces-7612-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B7CAA33C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 06 Dec 2025 10:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66EB531071DB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Dec 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCC2E0B58;
	Sat,  6 Dec 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vSqUZAfw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byMNF0/3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E72DECB0;
	Sat,  6 Dec 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765012250; cv=none; b=kjb6Mppw/aWEfTByXQGizfDjuyZ1C/u0+q3Tk0hB0ZZ6o3q+Rn1fWG94vs5XEQ81nv6Y18Oa+y94XF1Zvvg9MKoRYCMxHrlZUZH9S7iDU6KCdkpPAcp+X6XSt20jV9dG+zOS5+Q469iVHkbw1msjmZjuyto7lHH+Td30AMeZsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765012250; c=relaxed/simple;
	bh=ZtZtF1+Zo9BvwcDTErMXsOxN3RqbxtS85gChGu7WEfQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=as4bX407XnjFHdwJVE1npCmXhM45JTT5kYZE7purz/zcWYs4HjmrEl9nANVVHM5B1gJsTD2Gl4rWFSFO7aB4Pro7BA5T36r5GRvIKe2mMjMv2ei89a8KEyX938NlAWHv3i2LRZJih4JaPPLawlDKXxOitpglX2x0huN9LRjJ5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vSqUZAfw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byMNF0/3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Dec 2025 09:10:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765012245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnnNzpJh3eFdT9OPWkABrUUtRXpys/BLTZTU4Za1bbg=;
	b=vSqUZAfwA6aS8wzuYN3WMZx5N7c1KuojWFG3QSRTu0KZauBMODzpUEWmIlefhNSshUJt8q
	KirSjDRLEVgEtR8LZDFToAPCjWu05jXTulH8ikjQq6IZtw/mRe1QEN6ZqKpevnCJVbVebK
	S9BpO9hNP0eC0lleWTyr3YvVSXqkUpcIAabHyhDZXHQIXpX6IP2PbpxbS50+HAYViGq+TL
	RU0uzPW52tL+/0Ren0oCd2tgjMcSfaWeSCWVIutcn5dr9nUlshHPSLu4SKZWz2gCydRyWm
	jas0Qk26N4CXJCFKDyGCcNm58RoI3VCUtj2Ghi8q+CyaMEY8QYInLnMcQEPufA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765012245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnnNzpJh3eFdT9OPWkABrUUtRXpys/BLTZTU4Za1bbg=;
	b=byMNF0/3gpdbfx7rak8VPxnM1Mh0vSHrMVdqRE2R9Xohsq4N1a51jqw3Zgb4RF1CLmrqFo
	PJ/6/kLDq5jplSDQ==
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
Message-ID: <176501224391.498.13728118947588320732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     22abd832776b1317ae4c3f8a097c8b71bf83fb38
Gitweb:        https://git.kernel.org/tip/22abd832776b1317ae4c3f8a097c8b71bf8=
3fb38
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 16:55:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Dec 2025 10:03:13 +01:00

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
index 1711e9e..ee7dfbf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7352,15 +7352,12 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
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

