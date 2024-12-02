Return-Path: <linux-tip-commits+bounces-2926-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3AE9E0017
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2179C1637B4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8C209671;
	Mon,  2 Dec 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Db8HLFPT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmYeXEvA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977C20896E;
	Mon,  2 Dec 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138091; cv=none; b=FuPXmcJAH7uf76ER+3AiBQm0txYyykfrTPNh2N3Ic3Hxyp+GIc8io4nk/5XbWlAahmZP7w4ws58oMj+Gu3mPTyAjqgE2uVBJZ8ewyF9OlaRTWse9Yy61PvGK+sVhVAaBtFWjEM8nlHa4SPk0eq5QNN7uVL6tthgmhp4AKpOIHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138091; c=relaxed/simple;
	bh=9wQFVNnUzvYzXx7R+xKmCHh0Wuxv/vlgn9WB8MBJmFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IxiiXGwDpGyyryWZTq3tFzAeBVaeWQeXM958oprjwcmZXxckJzlegjOIb0xbUcnui7S5kUXLmo68IygCySZpn301QvLHz1/bc79S5L0ySALJkOD68zizNMc3NRRkGEvWOS8e3dBlqlLLjXCcGon7Dfb5vGLgpjPLceb35ydhmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Db8HLFPT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmYeXEvA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ndvZkRNQlty5Qzoydy89oXFFo1NcEEu6qhi0vblCnM=;
	b=Db8HLFPT2wlEwOSF/+GcH661KqCsup+6nxk2CxWUwIAnfeXcTJgz9fXb9gcEdgRhNI78I3
	8XQPioBqNdJzKNEZ9a48MCXP4LzTHpgYuJqFh/g0JIVIlpwiiKtJRJVanXCD8/OW62Axa5
	nKJi6PiLJOaReKbJtpBn5Xlj0MJUEgu4GtflzVcjUdZmVljtbVHPL769FE4VpqxnBz0kKc
	x3fip4/tb2P6G7xHNpfFtO6Jhg099z92edgSNT60878olMv0bgajIrMRDOK3rtqI1CgsMB
	OJba038ds2BQKleNP4kS3Hgcdvk1vtVm/+g42YT9f1lpC/6EOqvVVqTqedR1sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ndvZkRNQlty5Qzoydy89oXFFo1NcEEu6qhi0vblCnM=;
	b=MmYeXEvADdVyl8LEOhwdNotbqqvgIiePcU2DnuhEz5RbwT3/7mZOUrYJ99C4zLbmb4gbGu
	qFxbxTGk1n95I0Aw==
From: "tip-bot2 for Wander Lairson Costa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix warning in migrate_enable for
 boosted tasks
Cc: Wander Lairson Costa <wander@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240724142253.27145-2-wander@redhat.com>
References: <20240724142253.27145-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808681.412.15028154941187407428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0664e2c311b9fa43b33e3e81429cd0c2d7f9c638
Gitweb:        https://git.kernel.org/tip/0664e2c311b9fa43b33e3e81429cd0c2d7f9c638
Author:        Wander Lairson Costa <wander@redhat.com>
AuthorDate:    Wed, 24 Jul 2024 11:22:47 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:29 +01:00

sched/deadline: Fix warning in migrate_enable for boosted tasks

When running the following command:

while true; do
    stress-ng --cyclic 30 --timeout 30s --minimize --quiet
done

a warning is eventually triggered:

WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
setup_new_dl_entity+0x13e/0x180
...
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1c4/0x2df
 ? enqueue_dl_entity+0x631/0x6e0
 ? setup_new_dl_entity+0x13e/0x180
 ? __warn+0x7e/0xd0
 ? report_bug+0x11a/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 enqueue_dl_entity+0x631/0x6e0
 enqueue_task_dl+0x7d/0x120
 __do_set_cpus_allowed+0xe3/0x280
 __set_cpus_allowed_ptr_locked+0x140/0x1d0
 __set_cpus_allowed_ptr+0x54/0xa0
 migrate_enable+0x7e/0x150
 rt_spin_unlock+0x1c/0x90
 group_send_sig_info+0xf7/0x1a0
 ? kill_pid_info+0x1f/0x1d0
 kill_pid_info+0x78/0x1d0
 kill_proc_info+0x5b/0x110
 __x64_sys_kill+0x93/0xc0
 do_syscall_64+0x5c/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
 RIP: 0033:0x7f0dab31f92b

This warning occurs because set_cpus_allowed dequeues and enqueues tasks
with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
is triggered. A boosted task already had its parameters set by
rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
hence the WARN_ON call.

Check if we are requeueing a boosted task and avoid calling
setup_new_dl_entity if that's the case.

Fixes: 295d6d5e3736 ("sched/deadline: Fix switching to -deadline")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240724142253.27145-2-wander@redhat.com
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 206691d..db47f33 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2042,6 +2042,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
+		   !is_dl_boosted(dl_se) &&
 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}

