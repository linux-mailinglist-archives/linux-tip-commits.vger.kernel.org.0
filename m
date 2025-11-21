Return-Path: <linux-tip-commits+bounces-7456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89FC7B9B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 21:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22F794EB070
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D1305057;
	Fri, 21 Nov 2025 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ED5MrfU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xY+4NOkR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468313043C8;
	Fri, 21 Nov 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755295; cv=none; b=SI4/9JS4Ve31jEom8e5NTACIlawAzaJQAR74i2TqIFGslrnpPLEMmB587ixQuID1HjU3VKfT496oGlcuC6JdXG/x/4fJK+d4UHcGstf6/QhnKppklC09pXiZKG+dvyU9ZOu2De4HLscin8hb6QCgMwFVr3VSrJvSo7jQS8aFxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755295; c=relaxed/simple;
	bh=wCG4IVi/C2NerX0Z0NhFPtGBXqwuiQpJNX6PV7S+Slc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X+AfHvUghz084LKxpm4uwmKspnGaFBk3VBKsUrAco5avK8gBpEooVPYx5DBWADuh72hcpVB+/9FzOEkgJnHP4IY43wcE0zP487wJTf4kILhy803A/FnjhxllxO/llXKjAq5/zDBrDHzCOUUgvxFmzV/k/WhhzaMVnBGT/g891q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ED5MrfU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xY+4NOkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 20:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763755291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhgU0wsElUfBi18xQStQyCzzCKuKIzisHjE6zpHMqXk=;
	b=ED5MrfU/VgIqwWEPJnz/kPplLP+cL2xFPLR7pncwTV1NiFGoyITijyupp9pNylaNCKfTix
	USJehqmhx9oersxpehVjd9A21FtPzDSvkHHIhxrVncwebzFFIguGskcRm5FDo3jgBm4PgQ
	SdwD/qFR5K9W/hqp2WnKkHPn7ef7Wm2QRCDmgQIghgGqBDmHuH0o76XpF9AY9+altDxSQM
	hc6rYJYKYTH2YuRGulp/bMbx3fRO5+znjkr8Wff9aXsznKS6wOS1q/rYGDCQKt8cCefnw9
	sf30+9gQ24lL0NiFtLWNy5pOuWPXNEE31rblpplvgr3RxiZ3TP5naOYZgBY37w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763755291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhgU0wsElUfBi18xQStQyCzzCKuKIzisHjE6zpHMqXk=;
	b=xY+4NOkR2DfUj/Owqp5yxKogTP8RIeLGjc99J1IYBly5FOkINENcdixmMSrBOt+59OSpnD
	WvYGMy0kcACNLrDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Prevent early spurious wake-ups of interrupt threads
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251121143500.42111-2-frederic@kernel.org>
References: <20251121143500.42111-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176375529017.498.4701344518061876052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9d5ca2edd74e479ad09bc7d02820395a9d46e2bd
Gitweb:        https://git.kernel.org/tip/9d5ca2edd74e479ad09bc7d02820395a9d4=
6e2bd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 21 Nov 2025 15:34:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Nov 2025 20:50:30 +01:00

genirq: Prevent early spurious wake-ups of interrupt threads

During initialization, the interrupt thread is created before the interrupt
is enabled. The interrupt enablement happens before the actual kthread wake
up point. Once the interrupt is enabled the hardware can raise an interrupt
and once setup_irq() drops the descriptor lock a interrupt wake-up can
happen.

Even when such an interrupt can be considered premature, this is not a
problem in general because at the point where the descriptor lock is
dropped and the wakeup can happen, the data which is used by the thread is
fully initialized.

Though from the perspective of least surprise, the initial wakeup really
should be performed by the setup code and not randomly by a premature
interrupt.

Prevent this by performing a wake-up only if the target is in state
TASK_INTERRUPTIBLE, which the thread uses in wait_for_interrupt().

If the thread is still in state TASK_UNINTERRUPTIBLE, the wake-up is not
lost because after the setup code completed the initial wake-up the thread
will observe the IRQTF_RUNTHREAD and proceed with the handling.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251121143500.42111-2-frederic@kernel.org
---
 kernel/irq/handle.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e103451..786f557 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -133,7 +133,15 @@ void __irq_wake_thread(struct irq_desc *desc, struct irq=
action *action)
 	 */
 	atomic_inc(&desc->threads_active);
=20
-	wake_up_process(action->thread);
+	/*
+	 * This might be a premature wakeup before the thread reached the
+	 * thread function and set the IRQTF_READY bit. It's waiting in
+	 * kthread code with state UNINTERRUPTIBLE. Once it reaches the
+	 * thread function it waits with INTERRUPTIBLE. The wakeup is not
+	 * lost in that case because the thread is guaranteed to observe
+	 * the RUN flag before it goes to sleep in wait_for_interrupt().
+	 */
+	wake_up_state(action->thread, TASK_INTERRUPTIBLE);
 }
=20
 static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);

