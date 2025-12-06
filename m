Return-Path: <linux-tip-commits+bounces-7614-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F344CAA355
	for <lists+linux-tip-commits@lfdr.de>; Sat, 06 Dec 2025 10:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2804030119F6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Dec 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB261F3FED;
	Sat,  6 Dec 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuGTujax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wzhsyY7X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D58003D;
	Sat,  6 Dec 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765012976; cv=none; b=PPcNunBQ3gWpC9ngengzc6j/VWPCijuPq4BnLh1kqc0ciWuPEIBqDM9yL0WOKhH/Cz0MpKESurc8YYRKPkGNAvMNGUELHhWpjR3s87QU08A/FZIwNR/XuJ5l1l9eVDHNKW46tHI1T6+tlpxnCLMWd+YdzBzK1gZ6bBMiUw4hKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765012976; c=relaxed/simple;
	bh=3Eas2oOoAxpyalsdkWwqNoosQU5ZeL9RlMTlf+LePno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fhgsw89sxASU9lkG+t+Sg3bu+nSX2cfB25MXLFJFUMnIy2BUfaBQv8WX9U4i7uo2r3YbvTYF7O7pGpsPELaTv4dWzVCNhGWxENYL4vLUJS0G8JpDZbCHXyMpqfcfIryW6SfgzW94FqI/FE4AXmj48o5nlVCYqtDn+q7v1XIOfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuGTujax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wzhsyY7X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Dec 2025 09:22:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765012973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePixMQzUcedGMd5TPY+bdzIB6wcssC/H3mlVPbuDaGI=;
	b=XuGTujaxL4tmoQ3nyGe4nP6y8GJu++wrwZQVVQTXzbqYTChuVclCtBqHNVKMNRBZIAJe9x
	57n2YjZyNStvrrHE05pS9o7yk3jdrNBFR6niiqvSWO8TOFsehtUdOyxNelgsatmcH3+pSm
	BnnV3nAedLEOxnAXMD4oGELt0uTYvvycsLMqMb0KxkmMuzu/E12DMc8fTdEnQiqbYnGYgm
	lH00j2rH54rHjODY5iz6TaPbGViYmIFBO+TfX4mcQB7Lq9WEWHHpnLWZoCSJSleU6Ycsxv
	6/sCWSLIHVHRnLiTHhfdQXp6qav0hrEiuh0copS3BHPf1uZiO9J2aBmvq3zbQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765012973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePixMQzUcedGMd5TPY+bdzIB6wcssC/H3mlVPbuDaGI=;
	b=wzhsyY7XGubgEGt2Yjiy+RuDv02vLI3cfcy9IMaJzRzIv4uNnFqXAlsmURB4IRrkEY3J41
	YvVRF7hZXD5+1oAQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix psi_dequeue() for Proxy Execution
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>,
 Ingo Molnar <mingo@kernel.org>, Haiyue Wang <haiyuewa@163.com>,
 Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205012721.756394-1-jstultz@google.com>
References: <20251205012721.756394-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176501297111.498.5857163083971363652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c2ae8b0df2d1bb7a063f9e356e4e9a06cd4afe11
Gitweb:        https://git.kernel.org/tip/c2ae8b0df2d1bb7a063f9e356e4e9a06cd4=
afe11
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 05 Dec 2025 01:27:09=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Dec 2025 10:13:16 +01:00

sched/core: Fix psi_dequeue() for Proxy Execution

Currently, if the sleep flag is set, psi_dequeue() doesn't
change any of the psi_flags.

This is because psi_task_switch() will clear TSK_ONCPU as well
as other potential flags (TSK_RUNNING), and the assumption is
that a voluntary sleep always consists of a task being dequeued
followed shortly there after with a psi_sched_switch() call.

Proxy Execution changes this expectation, as mutex-blocked tasks
that would normally sleep stay on the runqueue. But in the case
where the mutex-owning task goes to sleep, or the owner is on a
remote cpu, we will then deactivate the blocked task shortly
after.

In that situation, the mutex-blocked task will have had its
TSK_ONCPU cleared when it was switched off the cpu, but it will
stay TSK_RUNNING. Then if we later dequeue it (as currently done
if we hit a case find_proxy_task() can't yet handle, such as the
case of the owner being on another rq or a sleeping owner)
psi_dequeue() won't change any state (leaving it TSK_RUNNING),
as it incorrectly expects a psi_task_switch() call to
immediately follow.

Later on when the task get woken/re-enqueued, and psi_flags are
set for TSK_RUNNING, we hit an error as the task is already
TSK_RUNNING:

  psi: inconsistent task state! task=3D188:kworker/28:0 cpu=3D28 psi_flags=3D=
4 clear=3D0 set=3D4

To resolve this, extend the logic in psi_dequeue() so that
if the sleep flag is set, we also check if psi_flags have
TSK_ONCPU set (meaning the psi_task_switch is imminent) before
we do the shortcut return.

If TSK_ONCPU is not set, that means we've already switched away,
and this psi_dequeue call needs to clear the flags.

Fixes: be41bde4c3a8 ("sched: Add an initial sketch of the find_proxy_task() f=
unction")
Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Haiyue Wang <haiyuewa@163.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://patch.msgid.link/20251205012721.756394-1-jstultz@google.com
Closes: https://lore.kernel.org/lkml/20251117185550.365156-1-kprateek.nayak@a=
md.com/
---
 kernel/sched/stats.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index cbf7206..c903f1a 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -180,8 +180,13 @@ static inline void psi_dequeue(struct task_struct *p, in=
t flags)
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
+	 *
+	 * In the SCHED_PROXY_EXECUTION case we may do sleeping
+	 * dequeues that are not followed by a task switch, so check
+	 * TSK_ONCPU is set to ensure the task switch is imminent.
+	 * Otherwise clear the flags as usual.
 	 */
-	if (flags & DEQUEUE_SLEEP)
+	if ((flags & DEQUEUE_SLEEP) && (p->psi_flags & TSK_ONCPU))
 		return;
=20
 	/*

