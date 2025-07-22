Return-Path: <linux-tip-commits+bounces-6158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCAB0D9FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438063A19ED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA4478F51;
	Tue, 22 Jul 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJDfEBgM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlq0P37N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC24B667;
	Tue, 22 Jul 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188356; cv=none; b=VafwUqKO9k3bI//MWVcVeePxNWWUlfYgI4mwwxnzYrRpSmFbEF78vX6t0AxoFH0pslb4dr691wBCWE+a7KVr5RSByDhZf/G4GVqysrhDtPjHv5ZSxzJDGfqUh5QBxCQ6aJlTYscY1YgR7+t215zu71eQgNrSk4ziJCNOARSrTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188356; c=relaxed/simple;
	bh=2Xjxe1zIPufemvLlYa3hD8t/GgDncpaI0curRvMBYY4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MvKXggm3GxIMyBe0O7DwXuTJwvAZDtXBa3qSQ7jcHAFokpP3duFnVfD80jBgI6/t56uFU5lXrYhL9dKL+DIU8ADwph4Jrd4NFIgtuL41kMUgplv6Yg4lpEJDipVlAtN5HHjTgr1b/w70mTVioyC09QD/o+BFZ+rjFoHJEplWmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IJDfEBgM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlq0P37N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 12:45:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753188353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSbcqZxT7QssuSX5+9dlqJEIUvJx72U8IAmIzP+mqiw=;
	b=IJDfEBgMYToN/7B+fjEZZrYrgxrr9163Pk2f5zGa0YrcU4P8Waaeqd2Qse8EkkLYDxefY1
	CuqPn//tR71bZhiJGg2P7ML/itqn+0YjgMekr9Y13y/6G1Ml9lxc8ZeYXuqU+vAcL4tn3U
	Cd6skQ+2LSXE/tlnl2rJOk1d7xGx+p8S+Vt3SYb/iXX8CmIA3FJwzonXDXjxX2q61cWHJj
	HhMSvRfA3rpa4zDF26Ay82gnKtbivkTMIsKFxQO0A6Zr5YTkWgk7uL0toaluOay6kvpLFK
	GEhVWSPOsAdB2cTDiwn4O/XUU9/wAetxh2ziSsevYI6ctFs4GliQlcAEP6u/nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753188353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSbcqZxT7QssuSX5+9dlqJEIUvJx72U8IAmIzP+mqiw=;
	b=rlq0P37NiADHXya6pdJDKo3pMzOB2iV8TnL4q5zVKH4YCj2mAr+TpOqwH3tOopNDPo+91N
	GwbGfJ5MSAGHooAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Prevent migration live lock in handle_edge_irq()
Cc: Yicong Shen <shenyicong.1023@bytedance.com>,
 Liangyan <liangyan.peng@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250718185312.076515034@linutronix.de>
References: <20250718185312.076515034@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175318835197.1420.18164666187894657180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8d39d6ec4db5da9899993092227584a97c203fd3
Gitweb:        https://git.kernel.org/tip/8d39d6ec4db5da9899993092227584a97c2=
03fd3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 18 Jul 2025 20:54:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 14:30:42 +02:00

genirq: Prevent migration live lock in handle_edge_irq()

Yicon reported and Liangyan debugged a live lock in handle_edge_irq()
related to interrupt migration.

If the interrupt affinity is moved to a new target CPU and the interrupt is
currently handled on the previous target CPU for edge type interrupts the
handler might get stuck on the previous target:

CPU 0 (previous target)		CPU 1 (new target)

  handle_edge_irq()
   repeat:
	handle_event()		handle_edge_irq()
			        if (INPROGESS) {
				  set(PENDING);
				  mask();
				  return;
				}
	if (PENDING) {
	  clear(PENDING);
	  unmask();
	  goto repeat;
	}

The migration in software never completes and CPU0 continues to handle the
pending events forever. This happens when the device raises interrupts with
a high rate and always before handle_event() completes and before the CPU0
handler can clear INPROGRESS so that CPU1 sets the PENDING flag over and
over. This has been observed in virtual machines.

Prevent this by checking whether the CPU which observes the INPROGRESS flag
is the new affinity target. If that's the case, do not set the PENDING flag
and wait for the INPROGRESS flag to be cleared instead, so that the new
interrupt is handled on the new target CPU and the previous CPU is released
from the action.

This is restricted to the edge type handler and only utilized on systems,
which use single CPU targets for interrupt affinity.

Reported-by: Yicong Shen <shenyicong.1023@bytedance.com>
Reported-by: Liangyan <liangyan.peng@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Liangyan <liangyan.peng@bytedance.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@byte=
dance.com
Link: https://lore.kernel.org/all/20250718185312.076515034@linutronix.de

---
 kernel/irq/chip.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 11ecf6c..624106e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -476,11 +476,14 @@ static bool irq_wait_on_inprogress(struct irq_desc *des=
c)
=20
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
+	struct irq_data *irqd =3D &desc->irq_data;
+	const struct cpumask *aff;
+
 	/*
 	 * If the interrupt is not in progress and is not an armed
 	 * wakeup interrupt, proceed.
 	 */
-	if (!irqd_has_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
+	if (!irqd_has_set(irqd, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
 		return true;
=20
 	/*
@@ -501,7 +504,41 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 			return false;
 		return irq_wait_on_inprogress(desc);
 	}
-	return false;
+
+	/* The below works only for single target interrupts */
+	if (!IS_ENABLED(CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK) ||
+	    !irqd_is_single_target(irqd) || desc->handle_irq !=3D handle_edge_irq)
+		return false;
+
+	/*
+	 * If the interrupt affinity was moved to this CPU and the
+	 * interrupt is currently handled on the previous target CPU, then
+	 * busy wait for INPROGRESS to be cleared. Otherwise for edge type
+	 * interrupts the handler might get stuck on the previous target:
+	 *
+	 * CPU 0			CPU 1 (new target)
+	 * handle_edge_irq()
+	 * repeat:
+	 *	handle_event()		handle_edge_irq()
+	 *			        if (INPROGESS) {
+	 *				  set(PENDING);
+	 *				  mask();
+	 *				  return;
+	 *				}
+	 *	if (PENDING) {
+	 *	  clear(PENDING);
+	 *	  unmask();
+	 *	  goto repeat;
+	 *	}
+	 *
+	 * This happens when the device raises interrupts with a high rate
+	 * and always before handle_event() completes and the CPU0 handler
+	 * can clear INPROGRESS. This has been observed in virtual machines.
+	 */
+	aff =3D irq_data_get_effective_affinity_mask(irqd);
+	if (cpumask_first(aff) !=3D smp_processor_id())
+		return false;
+	return irq_wait_on_inprogress(desc);
 }
=20
 static inline bool irq_can_handle_actions(struct irq_desc *desc)

