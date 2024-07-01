Return-Path: <linux-tip-commits+bounces-1552-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE491D88A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E651C20D37
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63059160;
	Mon,  1 Jul 2024 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oc4Hx/W4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CisqMcp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992305474A;
	Mon,  1 Jul 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817611; cv=none; b=qq00IG1ApP9L2q/V/1nxhUCgDnkLaxgGAb4sBDAeCXZji/DvcXekFqTNK5UsyW2TfyxJ5DFaFrMWYNUtxPgj+IzqOEtGRyC5L7HzIBP2iIsllgFOMuk4BJsCnLjBN66r25ew17ykxPMDWLbT42mk/5KGXJ3+5rvrp2yLrFNa8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817611; c=relaxed/simple;
	bh=jhF0lJfvNpLOlEaZeurBYmYplAtz6JVvOZiwjNVbUn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uxr/THH/ZHywcv1C/W+YVfbyq1iX2k7jmi04sU8PNq92Ff5+gJNaRTqaUbiC/f388cKk+JySNEd3fAuvmw+2L8TnFNBlfsFI/sg37bfWyFTPUaM58Xb6upPfnLgMW2fuMuqk21xnpLw+b4Riykxysp4r/UC/jv2DmLYA2jG4r6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oc4Hx/W4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3CisqMcp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 07:06:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719817607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxEnAqFCiSo+sqOvLdgvU6ZOnixf+RYcVgubN6qo+4c=;
	b=oc4Hx/W4lrzVvS+muJKooURyud3KlxPCuMTdmevhB035X6x+ldGEpv19AUZjddvmn5wrbZ
	2X+BkYqPBTDb+fvOBokuSp96+2AlxIACYR4LgWek7VsfqNgKcXZGlkpdKp5+k/DNmrHh8U
	WrkltQZah26BHuDavlKWerCr/vvUiJ35icjkeBeUKRHc35DtQ4ZGS3efQEJD5lPCUKIPbq
	LmbATR3x0gA/ypMB0zRJmc0dPcyftBfRXc8RHQXLhFg1tJp1YD7m0Z518OmrEpWYMvZSlf
	len19MzFODYlUTd8SlGWF8IdYzyvSuqMBLxvP7hd9Gj+dncB5CXekU1E+/534Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719817607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxEnAqFCiSo+sqOvLdgvU6ZOnixf+RYcVgubN6qo+4c=;
	b=3CisqMcpuN2HXSjjbi6d9KwsEHstfPY+YFoa1wMTxO9AorVFZokCa3Wm0tethWwV5HGYZ6
	ETJGFHmJcFuPHmCA==
From: "tip-bot2 for Wander Lairson Costa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: fix task_struct reference leak
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240620125618.11419-1-wander@redhat.com>
References: <20240620125618.11419-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171981760737.2215.2716487204272407636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a7accf658efa4fa5b04a74f21863833fd737f469
Gitweb:        https://git.kernel.org/tip/a7accf658efa4fa5b04a74f21863833fd737f469
Author:        Wander Lairson Costa <wander@redhat.com>
AuthorDate:    Thu, 20 Jun 2024 09:56:17 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jun 2024 10:43:41 +02:00

sched/deadline: fix task_struct reference leak

During the execution of the following stress test with linux-rt:

stress-ng --cyclic 30 --timeout 30 --minimize --quiet

kmemleak frequently reported a memory leak concerning the task_struct:

unreferenced object 0xffff8881305b8000 (size 16136):
  comm "stress-ng", pid 614, jiffies 4294883961 (age 286.412s)
  object hex dump (first 32 bytes):
    02 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  debug hex dump (first 16 bytes):
    53 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00  S...............
  backtrace:
    [<00000000046b6790>] dup_task_struct+0x30/0x540
    [<00000000c5ca0f0b>] copy_process+0x3d9/0x50e0
    [<00000000ced59777>] kernel_clone+0xb0/0x770
    [<00000000a50befdc>] __do_sys_clone+0xb6/0xf0
    [<000000001dbf2008>] do_syscall_64+0x5d/0xf0
    [<00000000552900ff>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

The issue occurs in start_dl_timer(), which increments the task_struct
reference count and sets a timer. The timer callback, dl_task_timer,
is supposed to decrement the reference count upon expiration. However,
if enqueue_task_dl() is called before the timer expires and cancels it,
the reference count is not decremented, leading to the leak.

This patch fixes the reference leak by ensuring the task_struct
reference count is properly decremented when the timer is canceled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240620125618.11419-1-wander@redhat.com
---
 kernel/sched/deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c75d130..9bedd14 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1804,8 +1804,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * The replenish timer needs to be canceled. No
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
+			 *
+			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
+			 * it will eventually call put_task_struct().
 			 */
-			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
+			    !dl_server(&p->dl))
+				put_task_struct(p);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {

