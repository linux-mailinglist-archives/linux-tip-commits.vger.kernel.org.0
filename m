Return-Path: <linux-tip-commits+bounces-7011-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27AC0F560
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF8188041E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE529316918;
	Mon, 27 Oct 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulxN0Lfr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5l/3FC8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C23168F6;
	Mon, 27 Oct 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582668; cv=none; b=TPKQiMOsUbjDFxDdgygMvpB42SjaYMRo2BVkkDivij/CBjkB5j9Oxhi4oV1ZwOVi04rn+vS/9vYIWJmndQytKTuI+lFoixfPipL9F+eFjrGqnnrMjlz7/96wi1inUw4CggcjynLV1mzgWm7xqaU0LKcWtmruIal1WQs4b4oR4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582668; c=relaxed/simple;
	bh=UJB+8FGsqG07Xj4G7fHvGd8fcvqvPucHfZxxcSoHpL4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kTap1iKWMv2z0ScffuHA55Tk4CuHnFwQHbp7ES80GxD0ec/AoQ7KWGfx2Ym+oEqqX9OT2Rs2mbRe4qNey6N/1u0fROnS5hQvpOOcYTYhfxC5tdzAXKjR9zKGSA8/BY27+Stl2VQDd+i5FVBVfAE/snj1qNxgD61/evnuSuym3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ulxN0Lfr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5l/3FC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrig1olNU4tUMiB3sylgA/0uL8MoyROkjRbq0I/alpo=;
	b=ulxN0Lfrjal5k1ZYc9pld5xbGbMIt8Si+rBzbCyHJR62GuSiAZEvbcjSyfvrQYa+6K3g3t
	cfya04h/yANcuoYX3FUj3O96dtGk4rxgWcPMBxWqFfwW+sd+g7nqqmxy5whXgZAvJ5yts/
	+c+E+b3TIkEJZSTAraS4LUSp5CUbHptG8r7cwDPfWZP/OIU79n4oNHHtmS55sSBmh5X4hV
	JW0LIDoPiQbjBSy5KTqmTLEPaaO41yVthPWJzfOCwKRo43RD/POluqIooTXA9wGCqrBZVv
	/74LSPg5oLHbb5o98nwStZ9R8R65AnbDerUdRxXz+DCdXuHUXIDYolGNak+Q5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrig1olNU4tUMiB3sylgA/0uL8MoyROkjRbq0I/alpo=;
	b=o5l/3FC8nNfjqbiiLgIkRvvqBSSNE7fY1EMgcM3hvNNwuw49ezUslU8MTu2m7aqODfRZoC
	Q0J75jvq0X3OnnCg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Allow per-cpu interrupt sharing for
 non-overlapping affinities
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-17-maz@kernel.org>
References: <20251020122944.3074811-17-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266387.2601451.7661119278420316726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bdf4e2ac295fe77c94b570a1ad12c0882bc89b53
Gitweb:        https://git.kernel.org/tip/bdf4e2ac295fe77c94b570a1ad12c0882bc=
89b53
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:35 +01:00

genirq: Allow per-cpu interrupt sharing for non-overlapping affinities

Interrupt sharing for percpu-devid interrupts is forbidden, and for good
reasons. These are interrupts generated *from* a CPU and handled by itself
(timer, for example). Nobody in their right mind would put two devices on
the same pin (and if they have, they get to keep the pieces...).

But this also prevents more benign cases, where devices are connected
to groups of CPUs, and for which the affinities are not overlapping.
Effectively, the only thing they share is the interrupt number, and
nothing else.

Tweak the definition of IRQF_SHARED applied to percpu_devid interrupts to
allow this particular use case. This results in extra validation at the
point of the interrupt being setup and freed, as well as a tiny bit of
extra complexity for interrupts at handling time (to pick the correct
irqaction).

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-17-maz@kernel.org
---
 kernel/irq/chip.c   |  8 +++--
 kernel/irq/manage.c | 67 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 633e1f6..19e0a87 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -897,8 +897,9 @@ void handle_percpu_irq(struct irq_desc *desc)
 void handle_percpu_devid_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	struct irqaction *action =3D desc->action;
 	unsigned int irq =3D irq_desc_get_irq(desc);
+	unsigned int cpu =3D smp_processor_id();
+	struct irqaction *action;
 	irqreturn_t res;
=20
 	/*
@@ -910,12 +911,15 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
=20
+	for (action =3D desc->action; action; action =3D action->next)
+		if (cpumask_test_cpu(cpu, action->affinity))
+			break;
+
 	if (likely(action)) {
 		trace_irq_handler_entry(irq, action);
 		res =3D action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 		trace_irq_handler_exit(irq, action, res);
 	} else {
-		unsigned int cpu =3D smp_processor_id();
 		bool enabled =3D cpumask_test_cpu(cpu, desc->percpu_enabled);
=20
 		if (enabled)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b1a3140..7a09d96 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1418,6 +1418,19 @@ setup_irq_thread(struct irqaction *new, unsigned int i=
rq, bool secondary)
 	return 0;
 }
=20
+static bool valid_percpu_irqaction(struct irqaction *old, struct irqaction *=
new)
+{
+	do {
+		if (cpumask_intersects(old->affinity, new->affinity) ||
+		    old->percpu_dev_id =3D=3D new->percpu_dev_id)
+			return false;
+
+		old =3D old->next;
+	} while (old);
+
+	return true;
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1438,6 +1451,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, st=
ruct irqaction *new)
 	struct irqaction *old, **old_ptr;
 	unsigned long flags, thread_mask =3D 0;
 	int ret, nested, shared =3D 0;
+	bool per_cpu_devid;
=20
 	if (!desc)
 		return -EINVAL;
@@ -1447,6 +1461,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, st=
ruct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
=20
+	per_cpu_devid =3D irq_settings_is_per_cpu_devid(desc);
+
 	new->irq =3D irq;
=20
 	/*
@@ -1554,13 +1570,20 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, =
struct irqaction *new)
 		 */
 		unsigned int oldtype;
=20
-		if (irq_is_nmi(desc)) {
+		if (irq_is_nmi(desc) && !per_cpu_devid) {
 			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
 				new->name, irq, desc->irq_data.chip->name);
 			ret =3D -EINVAL;
 			goto out_unlock;
 		}
=20
+		if (per_cpu_devid && !valid_percpu_irqaction(old, new)) {
+			pr_err("Overlapping affinities for %s (irq %d) on irqchip %s.\n",
+				new->name, irq, desc->irq_data.chip->name);
+			ret =3D -EINVAL;
+			goto out_unlock;
+		}
+
 		/*
 		 * If nobody did set the configuration before, inherit
 		 * the one provided by the requester.
@@ -1711,7 +1734,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, st=
ruct irqaction *new)
 		if (!(new->flags & IRQF_NO_AUTOEN) &&
 		    irq_settings_can_autoenable(desc)) {
 			irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
-		} else {
+		} else if (!per_cpu_devid) {
 			/*
 			 * Shared interrupts do not go well with disabling
 			 * auto enable. The sharing interrupt might request
@@ -2346,7 +2369,7 @@ void disable_percpu_nmi(unsigned int irq)
 static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *=
dev_id)
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
-	struct irqaction *action;
+	struct irqaction *action, **action_ptr;
=20
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
=20
@@ -2354,21 +2377,33 @@ static struct irqaction *__free_percpu_irq(unsigned i=
nt irq, void __percpu *dev_
 		return NULL;
=20
 	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
-		action =3D desc->action;
-		if (!action || action->percpu_dev_id !=3D dev_id) {
-			WARN(1, "Trying to free already-free IRQ %d\n", irq);
-			return NULL;
+		action_ptr =3D &desc->action;
+		for (;;) {
+			action =3D *action_ptr;
+
+			if (!action) {
+				WARN(1, "Trying to free already-free IRQ %d\n", irq);
+				return NULL;
+			}
+
+			if (action->percpu_dev_id =3D=3D dev_id)
+				break;
+
+			action_ptr =3D &action->next;
 		}
=20
-		if (!cpumask_empty(desc->percpu_enabled)) {
-			WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
-			     irq, cpumask_first(desc->percpu_enabled));
+		if (cpumask_intersects(desc->percpu_enabled, action->affinity)) {
+			WARN(1, "percpu IRQ %d still enabled on CPU%d!\n", irq,
+			     cpumask_first_and(desc->percpu_enabled, action->affinity));
 			return NULL;
 		}
=20
 		/* Found it - now remove it from the list of entries: */
-		desc->action =3D NULL;
-		desc->istate &=3D ~IRQS_NMI;
+		*action_ptr =3D action->next;
+
+		/* Demote from NMI if we killed the last action */
+		if (!desc->action)
+			desc->istate &=3D ~IRQS_NMI;
 	}
=20
 	unregister_handler_proc(irq, action);
@@ -2462,6 +2497,14 @@ struct irqaction *create_percpu_irqaction(irq_handler_=
t handler, unsigned long f
 	action->percpu_dev_id =3D dev_id;
 	action->affinity =3D affinity;
=20
+	/*
+	 * We allow some form of sharing for non-overlapping affinity
+	 * masks. Obviously, covering all CPUs prevents any sharing in
+	 * the first place.
+	 */
+	if (!cpumask_equal(affinity, cpu_possible_mask))
+		action->flags |=3D IRQF_SHARED;
+
 	return action;
 }
=20

