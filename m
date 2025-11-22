Return-Path: <linux-tip-commits+bounces-7461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5BEC7CAC4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3FF3A666A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE6283FFC;
	Sat, 22 Nov 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bA2hdPhT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+pft9WoB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E248CFC;
	Sat, 22 Nov 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763800250; cv=none; b=B900Npx13RUv9QrT867LPAgH9guiUOhlNESflTx8eZ+XmrUrl1cmFqGzVBDBKCYR0AXV716afVNI/lsQ+WDvSUenGEVhh9xhXPFuVlctQubhxfMKtZvSnXAd8/+0wLPt2PFFMGR68tAkZWmJQpwHtAFRrWhyxd/NC11XgWmWvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763800250; c=relaxed/simple;
	bh=6jkAQD1HiaeCRdpzVQyLsPhGMOKCfzG9FBeRi4x+uyk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KBSRWz9xApBT8bi4mzDF1ocgaitoeG5Kk1bklmP3FVIQtoDSNJqbJzbmUenmbzAt045EoQkH+D7oNoDavzj7TDp7HK1RpxHCv0gT5FjxQPOinboP2O+9AoYCWM3CGEcSNdIeg5G/55de259LXNHo/6y+ih+nsFGcCYDbGIO+SZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bA2hdPhT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+pft9WoB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 08:30:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763800246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8XPN0t1iztzSiAso3MkQ8PTSz6YhEPs9R1XXO2nvB4=;
	b=bA2hdPhTRRCraaLDB6f6E4B7WoYAZLhO0VSiyjDdy/YyDsn174kgwuaudc2gN+j8WWwL2D
	b6nM3qvMvQnjI8Yt+fN53PLrpI4jlfc3HrTTX5pR/JqK71yHRHjPtrwtQ6gvQUHt/MJlu7
	uFmDJ2DDc/ViEaeePvQAz3YyaTLC/S0A/QLl44R2gBccdwYqiSxXJKRHBHxIgkbzsGxzlw
	G8aXDGszxUnxFZR521diZ1JSjyUUXx570E1xDuIDvUXUn4cURgEtjnUS1WP7cy7uBfVyah
	RiOVs4FNCHkIVrdRXcw8+4kx6ChyejEoSJBFcURL5R57221w3N8GgfqBi2e/Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763800246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8XPN0t1iztzSiAso3MkQ8PTSz6YhEPs9R1XXO2nvB4=;
	b=+pft9WoBrTlhpksx5yzIpVCHm2OvrFK3Hmzs+aksExhHJTFQtE2FprKRVMVZAoWFFFsc5j
	kA2t2OuFcdzSSICA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Prevent early spurious wake-ups of interrupt threads
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251121143500.42111-2-frederic@kernel.org>
References: <20251121143500.42111-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176380024558.498.17587575376332801987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     68775ca79af3b8d4c147598983ece012d7007bac
Gitweb:        https://git.kernel.org/tip/68775ca79af3b8d4c147598983ece012d70=
07bac
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Nov 2025 15:34:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Nov 2025 09:26:18 +01:00

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

[ tglx: Simplified the changes and extended the changelog. ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

