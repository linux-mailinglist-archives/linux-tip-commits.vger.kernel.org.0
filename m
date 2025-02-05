Return-Path: <linux-tip-commits+bounces-3336-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00342A286C0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483667A37D3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB322ACE4;
	Wed,  5 Feb 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUZ7pdcX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mO3xqhS2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF422A7E9;
	Wed,  5 Feb 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748334; cv=none; b=DrZh5gyko+dKOUCvFl1TSYaYtoPqoL8F+yJ4QijZc5f39SF//JrwIPIjcUem8HYG60JSedH3RFY5avFZH6BVQVHtRvzrVzi7WiQp94EtsvTxaqFxVeevEV4k2Nwse2BqSCKFY6VDm/0PWZ4y0ysdes/vIkidf02TCJbcMwto36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748334; c=relaxed/simple;
	bh=1l0DeAsP+g4HIVuqBl31FGYYcVndgE2UlsjgdEVlqPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RMxK6DYZ34Zayg08C/OoLS2Eqc9ipdrPnKf2wt1XUakQtVaexQln+AtXcl+f1fF/w+fHIi+uAv3soby+Dbjyv8OtqwAq19qJKKU+nZ9XIugx4r0qM/hUSwo4Gp9hk4RhoPogX/58CgYtyJzmNxZg2mDl8drwbhfgf4A4xkvUs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUZ7pdcX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mO3xqhS2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 09:38:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738748331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxngsQEd08oovkhcqj9ZdEHlvGqbdOSipz5vVNlj6RY=;
	b=SUZ7pdcX6+1Yv7qjuS7PoON2HENYHtXA9qJcNJgjwRAcFUniwvHQX5kRCPrY5Kh2BNbWlc
	qYqpKy8ZdFuTzz5a0HRwOA8xHVleVHCxLvfb5c3dlf6A2g4zqJk+59f1bcjz9p5iEpM4uC
	s/GZa2hykNVcS03K2PnUEQp+T8O4rRnAXezcCNEZ2A6oSxP0yMTCPLlZahN4xz486TY5U1
	YRgLDYiEjL2aHUT+U6XNnvRnIXUpqpuNyBMU5XksuOVHFbGe/tGRb+pPRRvDeU4jje19gf
	neX1uF4ZWrZmsIiveD2o9t/ntXrPi+Wn3wpfVv3IBi43Zjal1gO5a92kMY2uvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738748331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxngsQEd08oovkhcqj9ZdEHlvGqbdOSipz5vVNlj6RY=;
	b=mO3xqhS2VW1orIlo/921u4tofm8PJeMR0DqlkyJC2Xt1nmqwZ+wy7iY/tEoli9hsrUT2UJ
	GduYsGXdtjcD3bBw==
From: "tip-bot2 for Liao Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Remove the spinlock within handle_singlestep()
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Liao Chang <liaochang1@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250124093826.2123675-3-liaochang1@huawei.com>
References: <20250124093826.2123675-3-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173874833040.10177.2192997781487750006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     83179cd67846fae0e6aea5848c07faaa5d89a1de
Gitweb:        https://git.kernel.org/tip/83179cd67846fae0e6aea5848c07faaa5d8=
9a1de
Author:        Liao Chang <liaochang1@huawei.com>
AuthorDate:    Fri, 24 Jan 2025 09:38:26=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Feb 2025 10:29:12 +01:00

uprobes: Remove the spinlock within handle_singlestep()

This patch introduces a flag to track TIF_SIGPENDING is suppress
temporarily during the uprobe single-step. Upon uprobe singlestep is
handled and the flag is confirmed, it could resume the TIF_SIGPENDING
directly without acquiring the siglock in most case, then reducing
contention and improving overall performance.

I've use the script developed by Andrii in [1] to run benchmark. The CPU
used was Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@2.4GHz running the
kernel on next tree + the optimization for get_xol_insn_slot() [2].

before-opt
----------
uprobe-nop      ( 1 cpus):    0.907 =C2=B1 0.003M/s  (  0.907M/s/cpu)
uprobe-nop      ( 2 cpus):    1.676 =C2=B1 0.008M/s  (  0.838M/s/cpu)
uprobe-nop      ( 4 cpus):    3.210 =C2=B1 0.003M/s  (  0.802M/s/cpu)
uprobe-nop      ( 8 cpus):    4.457 =C2=B1 0.003M/s  (  0.557M/s/cpu)
uprobe-nop      (16 cpus):    3.724 =C2=B1 0.011M/s  (  0.233M/s/cpu)
uprobe-nop      (32 cpus):    2.761 =C2=B1 0.003M/s  (  0.086M/s/cpu)
uprobe-nop      (64 cpus):    1.293 =C2=B1 0.015M/s  (  0.020M/s/cpu)

uprobe-push     ( 1 cpus):    0.883 =C2=B1 0.001M/s  (  0.883M/s/cpu)
uprobe-push     ( 2 cpus):    1.642 =C2=B1 0.005M/s  (  0.821M/s/cpu)
uprobe-push     ( 4 cpus):    3.086 =C2=B1 0.002M/s  (  0.771M/s/cpu)
uprobe-push     ( 8 cpus):    3.390 =C2=B1 0.003M/s  (  0.424M/s/cpu)
uprobe-push     (16 cpus):    2.652 =C2=B1 0.005M/s  (  0.166M/s/cpu)
uprobe-push     (32 cpus):    2.713 =C2=B1 0.005M/s  (  0.085M/s/cpu)
uprobe-push     (64 cpus):    1.313 =C2=B1 0.009M/s  (  0.021M/s/cpu)

uprobe-ret      ( 1 cpus):    1.774 =C2=B1 0.000M/s  (  1.774M/s/cpu)
uprobe-ret      ( 2 cpus):    3.350 =C2=B1 0.001M/s  (  1.675M/s/cpu)
uprobe-ret      ( 4 cpus):    6.604 =C2=B1 0.000M/s  (  1.651M/s/cpu)
uprobe-ret      ( 8 cpus):    6.706 =C2=B1 0.005M/s  (  0.838M/s/cpu)
uprobe-ret      (16 cpus):    5.231 =C2=B1 0.001M/s  (  0.327M/s/cpu)
uprobe-ret      (32 cpus):    5.743 =C2=B1 0.003M/s  (  0.179M/s/cpu)
uprobe-ret      (64 cpus):    4.726 =C2=B1 0.016M/s  (  0.074M/s/cpu)

after-opt
---------
uprobe-nop      ( 1 cpus):    0.985 =C2=B1 0.002M/s  (  0.985M/s/cpu)
uprobe-nop      ( 2 cpus):    1.773 =C2=B1 0.005M/s  (  0.887M/s/cpu)
uprobe-nop      ( 4 cpus):    3.304 =C2=B1 0.001M/s  (  0.826M/s/cpu)
uprobe-nop      ( 8 cpus):    5.328 =C2=B1 0.002M/s  (  0.666M/s/cpu)
uprobe-nop      (16 cpus):    6.475 =C2=B1 0.002M/s  (  0.405M/s/cpu)
uprobe-nop      (32 cpus):    4.831 =C2=B1 0.082M/s  (  0.151M/s/cpu)
uprobe-nop      (64 cpus):    2.564 =C2=B1 0.053M/s  (  0.040M/s/cpu)

uprobe-push     ( 1 cpus):    0.964 =C2=B1 0.001M/s  (  0.964M/s/cpu)
uprobe-push     ( 2 cpus):    1.766 =C2=B1 0.002M/s  (  0.883M/s/cpu)
uprobe-push     ( 4 cpus):    3.290 =C2=B1 0.009M/s  (  0.823M/s/cpu)
uprobe-push     ( 8 cpus):    4.670 =C2=B1 0.002M/s  (  0.584M/s/cpu)
uprobe-push     (16 cpus):    5.197 =C2=B1 0.004M/s  (  0.325M/s/cpu)
uprobe-push     (32 cpus):    5.068 =C2=B1 0.161M/s  (  0.158M/s/cpu)
uprobe-push     (64 cpus):    2.605 =C2=B1 0.026M/s  (  0.041M/s/cpu)

uprobe-ret      ( 1 cpus):    1.833 =C2=B1 0.001M/s  (  1.833M/s/cpu)
uprobe-ret      ( 2 cpus):    3.384 =C2=B1 0.003M/s  (  1.692M/s/cpu)
uprobe-ret      ( 4 cpus):    6.677 =C2=B1 0.004M/s  (  1.669M/s/cpu)
uprobe-ret      ( 8 cpus):    6.854 =C2=B1 0.005M/s  (  0.857M/s/cpu)
uprobe-ret      (16 cpus):    6.508 =C2=B1 0.006M/s  (  0.407M/s/cpu)
uprobe-ret      (32 cpus):    5.793 =C2=B1 0.009M/s  (  0.181M/s/cpu)
uprobe-ret      (64 cpus):    4.743 =C2=B1 0.016M/s  (  0.074M/s/cpu)

Above benchmark results demonstrates a obivious improvement in the
scalability of trig-uprobe-nop and trig-uprobe-push, the peak throughput
of which are from 4.5M/s to 6.4M/s and 3.3M/s to 5.1M/s individually.

[1] https://lore.kernel.org/all/20240731214256.3588718-1-andrii@kernel.org
[2] https://lore.kernel.org/all/20240727094405.1362496-1-liaochang1@huawei.com

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250124093826.2123675-3-liaochang1@huawei.com
---
 include/linux/uprobes.h | 1 +
 kernel/events/uprobes.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b1df7d7..a40efdd 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -143,6 +143,7 @@ struct uprobe_task {
=20
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
+	bool				signal_denied;
=20
 	struct arch_uprobe              *auprobe;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 33bd608..870f697 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2302,6 +2302,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state !=3D UTASK_SSTEP);
=20
 	if (task_sigpending(t)) {
+		utask->signal_denied =3D true;
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
=20
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
@@ -2735,9 +2736,10 @@ static void handle_singlestep(struct uprobe_task *utas=
k, struct pt_regs *regs)
 	utask->state =3D UTASK_RUNNING;
 	xol_free_insn_slot(utask);
=20
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* see uprobe_deny_signal() */
-	spin_unlock_irq(&current->sighand->siglock);
+	if (utask->signal_denied) {
+		set_thread_flag(TIF_SIGPENDING);
+		utask->signal_denied =3D false;
+	}
=20
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");

