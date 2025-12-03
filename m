Return-Path: <linux-tip-commits+bounces-7598-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38ECA12E1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDFB301AD3C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428A347BA8;
	Wed,  3 Dec 2025 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wP2Bl/SS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N96aaU5O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F935346FBE;
	Wed,  3 Dec 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786673; cv=none; b=ArB6x2fosnr+tsOagoJrjIzZfEei9gv/p98OiBjWktgodHKfyCFMrBMeb5Y2lV5Q/N38D2lUTnFUdcwk2E1QCMR2pY2D0SgI/NQ8wX9Xb9h2Hqrvly2bRcWv/+kd/xrhgXM2vzqZjNOA6l8uHonTX+0A2A/93qb0mMV5YqGJQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786673; c=relaxed/simple;
	bh=3kTAjPgTPt87/wASN2BD49skqljbauBeESAwAbqddBg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ImhPLeq4Ui5kn6KQq7D5nejgNyVfrNJ0EGB/C72WG8nvFonhNhCvdzrZdKjpKV+fb8UCpmG9vIERYy88s74MTscz1D/nimyqXGZz/s4FY7PArcJ09TTx4DkgZvoOZ+qWbixJkkit3BH/kFxT0ZHUI6So1j6ZPFOOau297R4wD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wP2Bl/SS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N96aaU5O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:31:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUZO5NjxDRuegB2VnuT3hxp7p+KTTmF8SAXT9FgTB2M=;
	b=wP2Bl/SSuHGdr8BfV+bCWLjDafJwN4VJeNPihFM4auZ0r2A1aqcheXA+bm3dW6n2V49Vdc
	/GGC7ed1yviRif8VGMiB0SB+kaJNQb8Gfta+s8pyr08n4vUmgm/ULPqQEX9SM57Gd0HvlM
	N6XDc0DKzIwKHkxa3Z/Z6sq7sOBYgHhMdk5xfnbiAs6P1cwqo79gasyWyCByIiSTr97GhM
	DTcfEcGvze+GKcjvfVwR4taikhtq5+n8+k1tN7B6wtgbmIzemTDAoX5LaxoFFEoGbzcCDD
	l2KeZH8dxXhJKvU/fzljGqjB+jH58D79RAd8Y+oXrSE1O74kqKJCGSY+h/+g/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUZO5NjxDRuegB2VnuT3hxp7p+KTTmF8SAXT9FgTB2M=;
	b=N96aaU5Oekos4w6znDZ+pyrQsmvg25piZKlFShzJTjWP6evyWmILajmPwVrKzz4B7gjI0B
	e6dm2uqWgjgYidDw==
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
Message-ID: <176478666883.498.10093712208692414606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b53fb61525912e81519eedd4aefe5de8e6999b0c
Gitweb:        https://git.kernel.org/tip/b53fb61525912e81519eedd4aefe5de8e69=
99b0c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 16:55:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:26:13 +01:00

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

