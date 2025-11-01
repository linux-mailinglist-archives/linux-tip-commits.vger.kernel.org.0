Return-Path: <linux-tip-commits+bounces-7166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3AC287C8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E067F3B4A3E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB021E0DFE;
	Sat,  1 Nov 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1QP2RUnf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVWp3bak"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4713AA2F;
	Sat,  1 Nov 2025 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762029324; cv=none; b=EELefcGQ1ZSTj3g0PBicmPIpz3nEemzN9vsJwZ4jxzl/iYqhy6LPT5MShBb4S5PWzeQkhpWJCAt+vsXyr4XFz6LrOB0LnV7PXfwzuXqeHRlMVhwMglcAeCrTCulabbyb+Drji7SegOaczE147qYESr6wc8WHOP4qBH06xa70T0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762029324; c=relaxed/simple;
	bh=qBR311xG9hbJUXi3wAxdnPHJhe/GnqTLDgghqVJMpuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oxZ9URtS+V9HY5nkkHecRYULatJGNvzcAGdjCPJZ9dlqWpngVt8fLuAHwRUIGLEnK8cugJWlelYXBW21Ov3gZ1w2mqtxjYrX6yC4nzjreSTWEYirgR/a6FJlXFjESfOaWouChZ28sgBm+i+wyt4Vq9TTnYqJIEIhaVqQOKWP4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1QP2RUnf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVWp3bak; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 20:35:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762029319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEmCYxBYXKX76ATC702JHVn+ME1yei50fmsUp5Bh1hk=;
	b=1QP2RUnfJpI7RWbpT5+px0+SaIPsAwBu53Rh3BHBxXq3hTk7+1Od11RZqcbhHeXobGFiCS
	h5dYFNonEazQfvbW5fAkIf352HAkrgTcBD3ZmHNVKcVE3qpFkvjgsaKEtFs46OUtcI5UM/
	wd5rBI1jBLjw+8CSQkAYLe0jWDZh8EDLl29yuV+CvsHTlrRBbnEONz1T/sNkjWFJR5gHrj
	LCCK6dEh2tAjtWklDvTv4+v1FmdwIXvmLFFrcoVS9FY79uUVSUI7osKRrxSIpf8fezDY6U
	yDIMlZOaeNCZ6jWxb1ZcH+WZohytVhoR+9yIkBBSWJywicZqkOSqjKV+bQ8U4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762029319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEmCYxBYXKX76ATC702JHVn+ME1yei50fmsUp5Bh1hk=;
	b=LVWp3bakQD1gpWxahae0zjBEbtud44qyqKifQpUMPwa9Eb+6J6loGeVF7LjOtiFnKSKgmw
	ZBfntG9u73u8MmAg==
From: "tip-bot2 for Lukas Wunner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Reduce priority of forced secondary
 interrupt handler
Cc: Crystal Wood <crwood@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To:
 <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>
References:
 <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202931818.2601451.1497935414944669151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     51d0656959bcdb743232f9b530b4cca569e74e7f
Gitweb:        https://git.kernel.org/tip/51d0656959bcdb743232f9b530b4cca569e=
74e7f
Author:        Lukas Wunner <lukas@wunner.de>
AuthorDate:    Mon, 27 Oct 2025 13:59:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 21:30:02 +01:00

genirq/manage: Reduce priority of forced secondary interrupt handler

Crystal reports that the PCIe Advanced Error Reporting driver gets stuck
in an infinite loop on PREEMPT_RT:

Both the primary interrupt handler aer_irq() as well as the secondary
handler aer_isr() are forced into threads with identical priority.
Crystal writes that on the ARM system in question, the primary handler
has to clear an error in the Root Error Status register...

   "before the next error happens, or else the hardware will set the
    Multiple ERR_COR Received bit.  If that bit is set, then aer_isr()
    can't rely on the Error Source Identification register, so it scans
    through all devices looking for errors -- and for some reason, on
    this system, accessing the AER registers (or any Config Space above
    0x400, even though there are capabilities located there) generates
    an Unsupported Request Error (but returns valid data).  Since this
    happens more than once, without aer_irq() preempting, it causes
    another multi error and we get stuck in a loop."

The issue does not show on non-PREEMPT_RT because the primary handler
runs in hardirq context and thus can preempt the threaded secondary
handler, clear the Root Error Status register and prevent the secondary
handler from getting stuck.

Emulate the same behavior on PREEMPT_RT by assigning a lower default
priority to the secondary handler if the primary handler is forced into
a thread.

Reported-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Crystal Wood <crwood@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.17615=
69303.git.lukas@wunner.de
Closes: https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
---
 include/linux/sched.h   |  1 +
 kernel/irq/manage.c     |  5 ++++-
 kernel/sched/syscalls.c | 13 +++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340..cd6be74 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1901,6 +1901,7 @@ extern int sched_setscheduler(struct task_struct *, int=
, const struct sched_para
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struc=
t sched_param *);
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
+extern void sched_set_fifo_secondary(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_at=
tr *);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7a09d96..c812b6f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1239,7 +1239,10 @@ static int irq_thread(void *data)
=20
 	irq_thread_set_ready(desc, action);
=20
-	sched_set_fifo(current);
+	if (action->handler =3D=3D irq_forced_secondary_handler)
+		sched_set_fifo_secondary(current);
+	else
+		sched_set_fifo(current);
=20
 	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
 					   &action->thread_flags))
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f..4834795 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -856,6 +856,19 @@ void sched_set_fifo_low(struct task_struct *p)
 }
 EXPORT_SYMBOL_GPL(sched_set_fifo_low);
=20
+/*
+ * Used when the primary interrupt handler is forced into a thread, in addit=
ion
+ * to the (always threaded) secondary handler.  The secondary handler gets a
+ * slightly lower priority so that the primary handler can preempt it, there=
by
+ * emulating the behavior of a non-PREEMPT_RT system where the primary handl=
er
+ * runs in hard interrupt context.
+ */
+void sched_set_fifo_secondary(struct task_struct *p)
+{
+	struct sched_param sp =3D { .sched_priority =3D MAX_RT_PRIO / 2 - 1 };
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) !=3D 0);
+}
+
 void sched_set_normal(struct task_struct *p, int nice)
 {
 	struct sched_attr attr =3D {

