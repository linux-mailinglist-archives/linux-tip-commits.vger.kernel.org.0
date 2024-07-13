Return-Path: <linux-tip-commits+bounces-1692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7749304FE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A04282A2C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0713664A;
	Sat, 13 Jul 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uu3dk13K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFyrnj79"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7E757E7;
	Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865826; cv=none; b=o5GTauRd09KL9ZgdNXh4PYGuqK6TNJYOrIIfuUObJFnR2Upq33WFZFlLQy3tm9NxeqYHZgmNvMWdnLSx3thbRM65GV4rksJ9TAH8Bs2Sq7d7JFm5OS0gQY6eLwMjmHtKD2IQgVY0QcTfQ2iGGF2nlXcmUseIyk+CvZsN48/S02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865826; c=relaxed/simple;
	bh=Ua2pUXWELktfsUhZwP16jpTVOmgvp4VlsXnzYWvhoE8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CFgeECPWhDFveSJIfhsXI54GWHhxlXIVyOk7P/KY9bYV+6u7F1LO65KLYTI0DU9MHvCOCJhSsCzO1xgAJtGzE05zK3dYDvtEwgCsqa6ae2s0Tl/nOU/ZojDFGFNKkrX0ZVXeqeDg6ZBBpHfvIVszrXs+vfkBcb7nrQwSiD3xpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uu3dk13K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFyrnj79; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Liyz8sd4FHHJPWYuRGtiaS6Et2fr2lsgzj2sIdZeMa4=;
	b=uu3dk13KotVzs5XMQ1QhxSL41vfTgWSge0xUUtw/6bKDlsi+TKU7oQ/mSZFN1Sy0LWsRdj
	nj3F9eEVGiOm4n/cdJVqK5FhgE+0jjLqW6ZpQ1SgzferHUX0ihSYfA61PVwKo+7dK+PGnt
	AlC+AOa3HqFxfdI+zuH3o4gtjUM8Y+YvSgI/r9WqblcIVYXSIIzh+aYk5z0sfLI1pQrqGP
	K6ylt6C6IJ3obGJK0JAVRAJkt4A6CERcxAiEBUo95ozg1so/7c3aYjfjcvwKPnvlWaw46X
	5bdjDD4N20f/5eZ9E/h7M/iQd+THGvD03dvGaPNhlILbd+pHPAakscxjOf6VTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Liyz8sd4FHHJPWYuRGtiaS6Et2fr2lsgzj2sIdZeMa4=;
	b=AFyrnj79L/kUSYlX7cbokE11Ae2VVMvNUC+jj1WNKgcpJl0HgMw/N3Py9178TdzoLbJMEd
	4d8K28h0YqGn+nAw==
From:
 tip-bot2 for Niklas =?utf-8?q?S=C3=B6derlund?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Address race condition
 for clock events
Cc: niklas.soderlund+renesas@ragnatech.se,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240702190230.3825292-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240702190230.3825292-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581567.2215.5668683014863983086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     db19d3aa77612983a02bd223b3f273f896b243cf
Gitweb:        https://git.kernel.org/tip/db19d3aa77612983a02bd223b3f273f896b=
243cf
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Tue, 02 Jul 2024 21:02:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:05 +02:00

clocksource/drivers/sh_cmt: Address race condition for clock events

There is a race condition in the CMT interrupt handler. In the interrupt
handler the driver sets a driver private flag, FLAG_IRQCONTEXT. This
flag is used to indicate any call to set_next_event() should not be
directly propagated to the device, but instead cached. This is done as
the interrupt handler itself reprograms the device when needed before it
completes and this avoids this operation to take place twice.

It is unclear why this design was chosen, my suspicion is to allow the
struct clock_event_device.event_handler callback, which is called while
the FLAG_IRQCONTEXT is set, can update the next event without having to
write to the device twice.

Unfortunately there is a race between when the FLAG_IRQCONTEXT flag is
set and later cleared where the interrupt handler have already started to
write the next event to the device. If set_next_event() is called in
this window the value is only cached in the driver but not written. This
leads to the board to misbehave, or worse lockup and produce a splat.

   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
   rcu:     0-...!: (0 ticks this GP) idle=3Df5e0/0/0x0 softirq=3D519/519 fqs=
=3D0 (false positive?)
   rcu:     (detected by 1, t=3D6502 jiffies, g=3D-595, q=3D77 ncpus=3D2)
   Sending NMI from CPU 1 to CPUs 0:
   NMI backtrace for cpu 0
   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc5-arm64-renesas-00019-g=
74a6f86eaf1c-dirty #20
   Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
   pc : tick_check_broadcast_expired+0xc/0x40
   lr : cpu_idle_poll.isra.0+0x8c/0x168
   sp : ffff800081c63d70
   x29: ffff800081c63d70 x28: 00000000580000c8 x27: 00000000bfee5610
   x26: 0000000000000027 x25: 0000000000000000 x24: 0000000000000000
   x23: ffff00007fbb9100 x22: ffff8000818f1008 x21: ffff8000800ef07c
   x20: ffff800081c79ec0 x19: ffff800081c70c28 x18: 0000000000000000
   x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc2c717d8
   x14: 0000000000000000 x13: ffff000009c18080 x12: ffff8000825f7fc0
   x11: 0000000000000000 x10: ffff8000818f3cd4 x9 : 0000000000000028
   x8 : ffff800081c79ec0 x7 : ffff800081c73000 x6 : 0000000000000000
   x5 : 0000000000000000 x4 : ffff7ffffe286000 x3 : 0000000000000000
   x2 : ffff7ffffe286000 x1 : ffff800082972900 x0 : ffff8000818f1008
   Call trace:
    tick_check_broadcast_expired+0xc/0x40
    do_idle+0x9c/0x280
    cpu_startup_entry+0x34/0x40
    kernel_init+0x0/0x11c
    do_one_initcall+0x0/0x260
    __primary_switched+0x80/0x88
   rcu: rcu_preempt kthread timer wakeup didn't happen for 6501 jiffies! g-59=
5 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
   rcu:     Possible timer handling issue on cpu=3D0 timer-softirq=3D262
   rcu: rcu_preempt kthread starved for 6502 jiffies! g-595 f0x0 RCU_GP_WAIT_=
FQS(5) ->state=3D0x402 ->cpu=3D0
   rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now e=
xpected behavior.
   rcu: RCU grace-period kthread stack dump:
   task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2      =
flags:0x00000008
   Call trace:
    __switch_to+0xbc/0x100
    __schedule+0x358/0xbe0
    schedule+0x48/0x148
    schedule_timeout+0xc4/0x138
    rcu_gp_fqs_loop+0x12c/0x764
    rcu_gp_kthread+0x208/0x298
    kthread+0x10c/0x110
    ret_from_fork+0x10/0x20

The design have been part of the driver since it was first merged in
early 2009. It becomes increasingly harder to trigger the issue the
older kernel version one tries. It only takes a few boots on v6.10-rc5,
while hundreds of boots are needed to trigger it on v5.10.

Close the race condition by using the CMT channel lock for the two
competing sections. The channel lock was added to the driver after its
initial design.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20240702190230.3825292-1-niklas.soderlund+ren=
esas@ragnatech.se
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 2691955..b72b36e 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -528,6 +528,7 @@ static void sh_cmt_set_next(struct sh_cmt_channel *ch, un=
signed long delta)
 static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 {
 	struct sh_cmt_channel *ch =3D dev_id;
+	unsigned long flags;
=20
 	/* clear flags */
 	sh_cmt_write_cmcsr(ch, sh_cmt_read_cmcsr(ch) &
@@ -558,6 +559,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
=20
 	ch->flags &=3D ~FLAG_SKIPEVENT;
=20
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (ch->flags & FLAG_REPROGRAM) {
 		ch->flags &=3D ~FLAG_REPROGRAM;
 		sh_cmt_clock_event_program_verify(ch, 1);
@@ -570,6 +573,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
=20
 	ch->flags &=3D ~FLAG_IRQCONTEXT;
=20
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
 	return IRQ_HANDLED;
 }
=20
@@ -780,12 +785,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 				   struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch =3D ced_to_sh_cmt(ced);
+	unsigned long flags;
=20
 	BUG_ON(!clockevent_state_oneshot(ced));
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (likely(ch->flags & FLAG_IRQCONTEXT))
 		ch->next_match_value =3D delta - 1;
 	else
-		sh_cmt_set_next(ch, delta - 1);
+		__sh_cmt_set_next(ch, delta - 1);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
=20
 	return 0;
 }

