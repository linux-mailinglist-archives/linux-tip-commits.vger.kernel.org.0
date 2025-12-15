Return-Path: <linux-tip-commits+bounces-7712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81558CBFFB2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A850630ACCB1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21F3314BB;
	Mon, 15 Dec 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0eS4VOdD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zujeNGK9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474C32E739;
	Mon, 15 Dec 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834039; cv=none; b=bS2WEeNrwmd1KlIb0lphQeT/aIiZ3zr6f4w9mPaik83A+3QybdYZTj+N8/cpj0qRaz4JKpii+FA1sZd43qQEKmGQa5v9RglOoRuVXwa526BuJfugcPy2FMwBHuXCD5i2w2edC0Fd60Ta7uC3ct4S4VXlK2tEl8FbghnM7iWamQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834039; c=relaxed/simple;
	bh=ZG8Cpynlq5CTGg5xA8bDSYAh1Ecr8O4GU9ZHU2HKlXs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GodwKnow4oAdru96sMlRzDUrjeV6CQXr8jtJptCrLeVaZtqHoX6EInn/+c/6Bb1GU3p+U5AtAsKLu6b3rjC+GANQ8hoE0hc/NanxleCmA9b7LOfNVPDX+PQdDNJZprm979SFk9rOeL2sc6J1c0JRw0p73kpOp1rYdt03RlPVux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0eS4VOdD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zujeNGK9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:27:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwWynUPxnGOWwoJQBDovDglV+q1SD5nWbVxk87FROxc=;
	b=0eS4VOdDoZVhJAZxNKP44YkC2z2f6ETYrSK2pZIGB4oDJUKi7gEA9of3tw8+nd08geWW8E
	SMQPsKKKBUcukZ+XvOMZijcMAahB7T9NzHJSIHOs5tbnUOwINphFRBPSeU+zAE6qulcvMq
	7w4+ygxx0JyHyIloeGySvlAqmDMsaTPIZ9/cFwEQXXd+D8M4GqFMU1gtRObsnf/dJOFaI8
	h94maRDIcB0oXdYPL4kP1CeN9fqWmfo2RUOtJGHkOjpwWag2QwHLGGymkurg3aCt2DIDbr
	ofQq9s0/qBqU5+l7vD/LoTbKGgClqC4cUpt0byFNQkPisdVJRfTSMaIpGyaD/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwWynUPxnGOWwoJQBDovDglV+q1SD5nWbVxk87FROxc=;
	b=zujeNGK9R2OYHLzOggHQSjW2BClZCG2mZZJxK7TLg435Ppvl6y/sHJcrCBDkwj5KVH2dHu
	7UgUlJiqBHniGCBw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove IRQ timing tracking infrastructure
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jinjie Ruan <ruanjinjie@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-2-maz@kernel.org>
References: <20251210082242.360936-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583403381.510.9946219739605513173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c119e6685311cef0e4a4e0b7752293bea056bac7
Gitweb:        https://git.kernel.org/tip/c119e6685311cef0e4a4e0b7752293bea05=
6bac7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:37=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:20:50 +01:00

genirq: Remove IRQ timing tracking infrastructure

The IRQ timing tracking infrastructure was merged in 2019, but was never
plumbed in, is not selectable, and is therefore never used.

As Daniel agrees that there is little hope for this infrastructure to be
completed in the near term, drop it altogether.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/87zf7vex6h.wl-maz@kernel.org
Link: https://patch.msgid.link/20251210082242.360936-2-maz@kernel.org
---
 include/linux/interrupt.h |   6 +-
 kernel/irq/Kconfig        |   3 +-
 kernel/irq/Makefile       |   4 +-
 kernel/irq/handle.c       |   2 +-
 kernel/irq/internals.h    | 110 +----
 kernel/irq/manage.c       |   3 +-
 kernel/irq/timings.c      | 959 +-------------------------------------
 lib/Kconfig.debug         |   8 +-
 8 files changed, 1095 deletions(-)
 delete mode 100644 kernel/irq/timings.c

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 266f2b3..44e335b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -871,12 +871,6 @@ static inline void init_irq_proc(void)
 }
 #endif
=20
-#ifdef CONFIG_IRQ_TIMINGS
-void irq_timings_enable(void);
-void irq_timings_disable(void);
-u64 irq_timings_next_event(u64 now);
-#endif
-
 struct seq_file;
 int show_interrupts(struct seq_file *p, void *v);
 int arch_show_interrupts(struct seq_file *p, int prec);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1b4254d..05cba4e 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -92,9 +92,6 @@ config GENERIC_MSI_IRQ
 config IRQ_MSI_IOMMU
 	bool
=20
-config IRQ_TIMINGS
-	bool
-
 config GENERIC_IRQ_MATRIX_ALLOCATOR
 	bool
=20
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 6ab3a40..86a2e5a 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=20
 obj-y :=3D irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.=
o devres.o kexec.o
-obj-$(CONFIG_IRQ_TIMINGS) +=3D timings.o
-ifeq ($(CONFIG_TEST_IRQ_TIMINGS),y)
-	CFLAGS_timings.o +=3D -DDEBUG
-endif
 obj-$(CONFIG_GENERIC_IRQ_CHIP) +=3D generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) +=3D autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) +=3D irqdomain.o
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 786f557..b7d5282 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -188,8 +188,6 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *de=
sc)
 	unsigned int irq =3D desc->irq_data.irq;
 	struct irqaction *action;
=20
-	record_irq_time(desc);
-
 	for_each_action_of_desc(desc, action) {
 		irqreturn_t res;
=20
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0164ca4..202c50f 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -288,116 +288,6 @@ static inline void
 irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action) { }
 #endif
=20
-#ifdef CONFIG_IRQ_TIMINGS
-
-#define IRQ_TIMINGS_SHIFT	5
-#define IRQ_TIMINGS_SIZE	(1 << IRQ_TIMINGS_SHIFT)
-#define IRQ_TIMINGS_MASK	(IRQ_TIMINGS_SIZE - 1)
-
-/**
- * struct irq_timings - irq timings storing structure
- * @values: a circular buffer of u64 encoded <timestamp,irq> values
- * @count: the number of elements in the array
- */
-struct irq_timings {
-	u64	values[IRQ_TIMINGS_SIZE];
-	int	count;
-};
-
-DECLARE_PER_CPU(struct irq_timings, irq_timings);
-
-extern void irq_timings_free(int irq);
-extern int irq_timings_alloc(int irq);
-
-static inline void irq_remove_timings(struct irq_desc *desc)
-{
-	desc->istate &=3D ~IRQS_TIMINGS;
-
-	irq_timings_free(irq_desc_get_irq(desc));
-}
-
-static inline void irq_setup_timings(struct irq_desc *desc, struct irqaction=
 *act)
-{
-	int irq =3D irq_desc_get_irq(desc);
-	int ret;
-
-	/*
-	 * We don't need the measurement because the idle code already
-	 * knows the next expiry event.
-	 */
-	if (act->flags & __IRQF_TIMER)
-		return;
-
-	/*
-	 * In case the timing allocation fails, we just want to warn,
-	 * not fail, so letting the system boot anyway.
-	 */
-	ret =3D irq_timings_alloc(irq);
-	if (ret) {
-		pr_warn("Failed to allocate irq timing stats for irq%d (%d)",
-			irq, ret);
-		return;
-	}
-
-	desc->istate |=3D IRQS_TIMINGS;
-}
-
-extern void irq_timings_enable(void);
-extern void irq_timings_disable(void);
-
-DECLARE_STATIC_KEY_FALSE(irq_timing_enabled);
-
-/*
- * The interrupt number and the timestamp are encoded into a single
- * u64 variable to optimize the size.
- * 48 bit time stamp and 16 bit IRQ number is way sufficient.
- *  Who cares an IRQ after 78 hours of idle time?
- */
-static inline u64 irq_timing_encode(u64 timestamp, int irq)
-{
-	return (timestamp << 16) | irq;
-}
-
-static inline int irq_timing_decode(u64 value, u64 *timestamp)
-{
-	*timestamp =3D value >> 16;
-	return value & U16_MAX;
-}
-
-static __always_inline void irq_timings_push(u64 ts, int irq)
-{
-	struct irq_timings *timings =3D this_cpu_ptr(&irq_timings);
-
-	timings->values[timings->count & IRQ_TIMINGS_MASK] =3D
-		irq_timing_encode(ts, irq);
-
-	timings->count++;
-}
-
-/*
- * The function record_irq_time is only called in one place in the
- * interrupts handler. We want this function always inline so the code
- * inside is embedded in the function and the static key branching
- * code can act at the higher level. Without the explicit
- * __always_inline we can end up with a function call and a small
- * overhead in the hotpath for nothing.
- */
-static __always_inline void record_irq_time(struct irq_desc *desc)
-{
-	if (!static_branch_likely(&irq_timing_enabled))
-		return;
-
-	if (desc->istate & IRQS_TIMINGS)
-		irq_timings_push(local_clock(), irq_desc_get_irq(desc));
-}
-#else
-static inline void irq_remove_timings(struct irq_desc *desc) {}
-static inline void irq_setup_timings(struct irq_desc *desc,
-				     struct irqaction *act) {};
-static inline void record_irq_time(struct irq_desc *desc) {}
-#endif /* CONFIG_IRQ_TIMINGS */
-
-
 #ifdef CONFIG_GENERIC_IRQ_CHIP
 void irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 			   int num_ct, unsigned int irq_base,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8b1b4c8..7b25ffc 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1778,8 +1778,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, st=
ruct irqaction *new)
 	chip_bus_sync_unlock(desc);
 	mutex_unlock(&desc->request_mutex);
=20
-	irq_setup_timings(desc, new);
-
 	wake_up_and_wait_for_irq_thread_ready(desc, new);
 	wake_up_and_wait_for_irq_thread_ready(desc, new->secondary);
=20
@@ -1950,7 +1948,6 @@ static struct irqaction *__free_irq(struct irq_desc *de=
sc, void *dev_id)
=20
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
-		irq_remove_timings(desc);
 	}
=20
 	mutex_unlock(&desc->request_mutex);
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
deleted file mode 100644
index 4b7315e..0000000
--- a/kernel/irq/timings.c
+++ /dev/null
@@ -1,959 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.or=
g>
-#define pr_fmt(fmt) "irq_timings: " fmt
-
-#include <linux/kernel.h>
-#include <linux/percpu.h>
-#include <linux/slab.h>
-#include <linux/static_key.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/idr.h>
-#include <linux/irq.h>
-#include <linux/math64.h>
-#include <linux/log2.h>
-
-#include <trace/events/irq.h>
-
-#include "internals.h"
-
-DEFINE_STATIC_KEY_FALSE(irq_timing_enabled);
-
-DEFINE_PER_CPU(struct irq_timings, irq_timings);
-
-static DEFINE_IDR(irqt_stats);
-
-void irq_timings_enable(void)
-{
-	static_branch_enable(&irq_timing_enabled);
-}
-
-void irq_timings_disable(void)
-{
-	static_branch_disable(&irq_timing_enabled);
-}
-
-/*
- * The main goal of this algorithm is to predict the next interrupt
- * occurrence on the current CPU.
- *
- * Currently, the interrupt timings are stored in a circular array
- * buffer every time there is an interrupt, as a tuple: the interrupt
- * number and the associated timestamp when the event occurred <irq,
- * timestamp>.
- *
- * For every interrupt occurring in a short period of time, we can
- * measure the elapsed time between the occurrences for the same
- * interrupt and we end up with a suite of intervals. The experience
- * showed the interrupts are often coming following a periodic
- * pattern.
- *
- * The objective of the algorithm is to find out this periodic pattern
- * in a fastest way and use its period to predict the next irq event.
- *
- * When the next interrupt event is requested, we are in the situation
- * where the interrupts are disabled and the circular buffer
- * containing the timings is filled with the events which happened
- * after the previous next-interrupt-event request.
- *
- * At this point, we read the circular buffer and we fill the irq
- * related statistics structure. After this step, the circular array
- * containing the timings is empty because all the values are
- * dispatched in their corresponding buffers.
- *
- * Now for each interrupt, we can predict the next event by using the
- * suffix array, log interval and exponential moving average
- *
- * 1. Suffix array
- *
- * Suffix array is an array of all the suffixes of a string. It is
- * widely used as a data structure for compression, text search, ...
- * For instance for the word 'banana', the suffixes will be: 'banana'
- * 'anana' 'nana' 'ana' 'na' 'a'
- *
- * Usually, the suffix array is sorted but for our purpose it is
- * not necessary and won't provide any improvement in the context of
- * the solved problem where we clearly define the boundaries of the
- * search by a max period and min period.
- *
- * The suffix array will build a suite of intervals of different
- * length and will look for the repetition of each suite. If the suite
- * is repeating then we have the period because it is the length of
- * the suite whatever its position in the buffer.
- *
- * 2. Log interval
- *
- * We saw the irq timings allow to compute the interval of the
- * occurrences for a specific interrupt. We can reasonably assume the
- * longer is the interval, the higher is the error for the next event
- * and we can consider storing those interval values into an array
- * where each slot in the array correspond to an interval at the power
- * of 2 of the index. For example, index 12 will contain values
- * between 2^11 and 2^12.
- *
- * At the end we have an array of values where at each index defines a
- * [2^index - 1, 2 ^ index] interval values allowing to store a large
- * number of values inside a small array.
- *
- * For example, if we have the value 1123, then we store it at
- * ilog2(1123) =3D 10 index value.
- *
- * Storing those value at the specific index is done by computing an
- * exponential moving average for this specific slot. For instance,
- * for values 1800, 1123, 1453, ... fall under the same slot (10) and
- * the exponential moving average is computed every time a new value
- * is stored at this slot.
- *
- * 3. Exponential Moving Average
- *
- * The EMA is largely used to track a signal for stocks or as a low
- * pass filter. The magic of the formula, is it is very simple and the
- * reactivity of the average can be tuned with the factors called
- * alpha.
- *
- * The higher the alphas are, the faster the average respond to the
- * signal change. In our case, if a slot in the array is a big
- * interval, we can have numbers with a big difference between
- * them. The impact of those differences in the average computation
- * can be tuned by changing the alpha value.
- *
- *
- *  -- The algorithm --
- *
- * We saw the different processing above, now let's see how they are
- * used together.
- *
- * For each interrupt:
- *	For each interval:
- *		Compute the index =3D ilog2(interval)
- *		Compute a new_ema(buffer[index], interval)
- *		Store the index in a circular buffer
- *
- *	Compute the suffix array of the indexes
- *
- *	For each suffix:
- *		If the suffix is reverse-found 3 times
- *			Return suffix
- *
- *	Return Not found
- *
- * However we can not have endless suffix array to be build, it won't
- * make sense and it will add an extra overhead, so we can restrict
- * this to a maximum suffix length of 5 and a minimum suffix length of
- * 2. The experience showed 5 is the majority of the maximum pattern
- * period found for different devices.
- *
- * The result is a pattern finding less than 1us for an interrupt.
- *
- * Example based on real values:
- *
- * Example 1 : MMC write/read interrupt interval:
- *
- *	223947, 1240, 1384, 1386, 1386,
- *	217416, 1236, 1384, 1386, 1387,
- *	214719, 1241, 1386, 1387, 1384,
- *	213696, 1234, 1384, 1386, 1388,
- *	219904, 1240, 1385, 1389, 1385,
- *	212240, 1240, 1386, 1386, 1386,
- *	214415, 1236, 1384, 1386, 1387,
- *	214276, 1234, 1384, 1388, ?
- *
- * For each element, apply ilog2(value)
- *
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, ?
- *
- * Max period of 5, we take the last (max_period * 3) 15 elements as
- * we can be confident if the pattern repeats itself three times it is
- * a repeating pattern.
- *
- *	             8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, 8,
- *	15, 8, 8, 8, ?
- *
- * Suffixes are:
- *
- *  1) 8, 15, 8, 8, 8  <- max period
- *  2) 8, 15, 8, 8
- *  3) 8, 15, 8
- *  4) 8, 15           <- min period
- *
- * From there we search the repeating pattern for each suffix.
- *
- * buffer: 8, 15, 8, 8, 8, 8, 15, 8, 8, 8, 8, 15, 8, 8, 8
- *         |   |  |  |  |  |   |  |  |  |  |   |  |  |  |
- *         8, 15, 8, 8, 8  |   |  |  |  |  |   |  |  |  |
- *                         8, 15, 8, 8, 8  |   |  |  |  |
- *                                         8, 15, 8, 8, 8
- *
- * When moving the suffix, we found exactly 3 matches.
- *
- * The first suffix with period 5 is repeating.
- *
- * The next event is (3 * max_period) % suffix_period
- *
- * In this example, the result 0, so the next event is suffix[0] =3D> 8
- *
- * However, 8 is the index in the array of exponential moving average
- * which was calculated on the fly when storing the values, so the
- * interval is ema[8] =3D 1366
- *
- *
- * Example 2:
- *
- *	4, 3, 5, 100,
- *	3, 3, 5, 117,
- *	4, 4, 5, 112,
- *	4, 3, 4, 110,
- *	3, 5, 3, 117,
- *	4, 4, 5, 112,
- *	4, 3, 4, 110,
- *	3, 4, 5, 112,
- *	4, 3, 4, 110
- *
- * ilog2
- *
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4
- *
- * Max period 5:
- *	   0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4,
- *	0, 0, 0, 4
- *
- * Suffixes:
- *
- *  1) 0, 0, 4, 0, 0
- *  2) 0, 0, 4, 0
- *  3) 0, 0, 4
- *  4) 0, 0
- *
- * buffer: 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4
- *         |  |  |  |  |  |  X
- *         0, 0, 4, 0, 0, |  X
- *                        0, 0
- *
- * buffer: 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4
- *         |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
- *         0, 0, 4, 0, |  |  |  |  |  |  |  |  |  |  |
- *                     0, 0, 4, 0, |  |  |  |  |  |  |
- *                                 0, 0, 4, 0, |  |  |
- *                                             0  0  4
- *
- * Pattern is found 3 times, the remaining is 1 which results from
- * (max_period * 3) % suffix_period. This value is the index in the
- * suffix arrays. The suffix array for a period 4 has the value 4
- * at index 1.
- */
-#define EMA_ALPHA_VAL		64
-#define EMA_ALPHA_SHIFT		7
-
-#define PREDICTION_PERIOD_MIN	3
-#define PREDICTION_PERIOD_MAX	5
-#define PREDICTION_FACTOR	4
-#define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
-#define PREDICTION_BUFFER_SIZE	16 /* slots for EMAs, hardly more than 16 */
-
-/*
- * Number of elements in the circular buffer: If it happens it was
- * flushed before, then the number of elements could be smaller than
- * IRQ_TIMINGS_SIZE, so the count is used, otherwise the array size is
- * used as we wrapped. The index begins from zero when we did not
- * wrap. That could be done in a nicer way with the proper circular
- * array structure type but with the cost of extra computation in the
- * interrupt handler hot path. We choose efficiency.
- */
-#define for_each_irqts(i, irqts)					\
-	for (i =3D irqts->count < IRQ_TIMINGS_SIZE ?			\
-		     0 : irqts->count & IRQ_TIMINGS_MASK,		\
-		     irqts->count =3D min(IRQ_TIMINGS_SIZE,		\
-					irqts->count);			\
-	     irqts->count > 0; irqts->count--,				\
-		     i =3D (i + 1) & IRQ_TIMINGS_MASK)
-
-struct irqt_stat {
-	u64	last_ts;
-	u64	ema_time[PREDICTION_BUFFER_SIZE];
-	int	timings[IRQ_TIMINGS_SIZE];
-	int	circ_timings[IRQ_TIMINGS_SIZE];
-	int	count;
-};
-
-/*
- * Exponential moving average computation
- */
-static u64 irq_timings_ema_new(u64 value, u64 ema_old)
-{
-	s64 diff;
-
-	if (unlikely(!ema_old))
-		return value;
-
-	diff =3D (value - ema_old) * EMA_ALPHA_VAL;
-	/*
-	 * We can use a s64 type variable to be added with the u64
-	 * ema_old variable as this one will never have its topmost
-	 * bit set, it will be always smaller than 2^63 nanosec
-	 * interrupt interval (292 years).
-	 */
-	return ema_old + (diff >> EMA_ALPHA_SHIFT);
-}
-
-static int irq_timings_next_event_index(int *buffer, size_t len, int period_=
max)
-{
-	int period;
-
-	/*
-	 * Move the beginning pointer to the end minus the max period x 3.
-	 * We are at the point we can begin searching the pattern
-	 */
-	buffer =3D &buffer[len - (period_max * 3)];
-
-	/* Adjust the length to the maximum allowed period x 3 */
-	len =3D period_max * 3;
-
-	/*
-	 * The buffer contains the suite of intervals, in a ilog2
-	 * basis, we are looking for a repetition. We point the
-	 * beginning of the search three times the length of the
-	 * period beginning at the end of the buffer. We do that for
-	 * each suffix.
-	 */
-	for (period =3D period_max; period >=3D PREDICTION_PERIOD_MIN; period--) {
-
-		/*
-		 * The first comparison always succeed because the
-		 * suffix is deduced from the first n-period bytes of
-		 * the buffer and we compare the initial suffix with
-		 * itself, so we can skip the first iteration.
-		 */
-		int idx =3D period;
-		size_t size =3D period;
-
-		/*
-		 * We look if the suite with period 'i' repeat
-		 * itself. If it is truncated at the end, as it
-		 * repeats we can use the period to find out the next
-		 * element with the modulo.
-		 */
-		while (!memcmp(buffer, &buffer[idx], size * sizeof(int))) {
-
-			/*
-			 * Move the index in a period basis
-			 */
-			idx +=3D size;
-
-			/*
-			 * If this condition is reached, all previous
-			 * memcmp were successful, so the period is
-			 * found.
-			 */
-			if (idx =3D=3D len)
-				return buffer[len % period];
-
-			/*
-			 * If the remaining elements to compare are
-			 * smaller than the period, readjust the size
-			 * of the comparison for the last iteration.
-			 */
-			if (len - idx < period)
-				size =3D len - idx;
-		}
-	}
-
-	return -1;
-}
-
-static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
-{
-	int index, i, period_max, count, start, min =3D INT_MAX;
-
-	if ((now - irqs->last_ts) >=3D NSEC_PER_SEC) {
-		irqs->count =3D irqs->last_ts =3D 0;
-		return U64_MAX;
-	}
-
-	/*
-	 * As we want to find three times the repetition, we need a
-	 * number of intervals greater or equal to three times the
-	 * maximum period, otherwise we truncate the max period.
-	 */
-	period_max =3D irqs->count > (3 * PREDICTION_PERIOD_MAX) ?
-		PREDICTION_PERIOD_MAX : irqs->count / 3;
-
-	/*
-	 * If we don't have enough irq timings for this prediction,
-	 * just bail out.
-	 */
-	if (period_max <=3D PREDICTION_PERIOD_MIN)
-		return U64_MAX;
-
-	/*
-	 * 'count' will depends if the circular buffer wrapped or not
-	 */
-	count =3D irqs->count < IRQ_TIMINGS_SIZE ?
-		irqs->count : IRQ_TIMINGS_SIZE;
-
-	start =3D irqs->count < IRQ_TIMINGS_SIZE ?
-		0 : (irqs->count & IRQ_TIMINGS_MASK);
-
-	/*
-	 * Copy the content of the circular buffer into another buffer
-	 * in order to linearize the buffer instead of dealing with
-	 * wrapping indexes and shifted array which will be prone to
-	 * error and extremely difficult to debug.
-	 */
-	for (i =3D 0; i < count; i++) {
-		int index =3D (start + i) & IRQ_TIMINGS_MASK;
-
-		irqs->timings[i] =3D irqs->circ_timings[index];
-		min =3D min_t(int, irqs->timings[i], min);
-	}
-
-	index =3D irq_timings_next_event_index(irqs->timings, count, period_max);
-	if (index < 0)
-		return irqs->last_ts + irqs->ema_time[min];
-
-	return irqs->last_ts + irqs->ema_time[index];
-}
-
-static __always_inline int irq_timings_interval_index(u64 interval)
-{
-	/*
-	 * The PREDICTION_FACTOR increase the interval size for the
-	 * array of exponential average.
-	 */
-	u64 interval_us =3D (interval >> 10) / PREDICTION_FACTOR;
-
-	return likely(interval_us) ? ilog2(interval_us) : 0;
-}
-
-static __always_inline void __irq_timings_store(int irq, struct irqt_stat *i=
rqs,
-						u64 interval)
-{
-	int index;
-
-	/*
-	 * Get the index in the ema table for this interrupt.
-	 */
-	index =3D irq_timings_interval_index(interval);
-
-	if (index > PREDICTION_BUFFER_SIZE - 1) {
-		irqs->count =3D 0;
-		return;
-	}
-
-	/*
-	 * Store the index as an element of the pattern in another
-	 * circular array.
-	 */
-	irqs->circ_timings[irqs->count & IRQ_TIMINGS_MASK] =3D index;
-
-	irqs->ema_time[index] =3D irq_timings_ema_new(interval,
-						    irqs->ema_time[index]);
-
-	irqs->count++;
-}
-
-static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
-{
-	u64 old_ts =3D irqs->last_ts;
-	u64 interval;
-
-	/*
-	 * The timestamps are absolute time values, we need to compute
-	 * the timing interval between two interrupts.
-	 */
-	irqs->last_ts =3D ts;
-
-	/*
-	 * The interval type is u64 in order to deal with the same
-	 * type in our computation, that prevent mindfuck issues with
-	 * overflow, sign and division.
-	 */
-	interval =3D ts - old_ts;
-
-	/*
-	 * The interrupt triggered more than one second apart, that
-	 * ends the sequence as predictable for our purpose. In this
-	 * case, assume we have the beginning of a sequence and the
-	 * timestamp is the first value. As it is impossible to
-	 * predict anything at this point, return.
-	 *
-	 * Note the first timestamp of the sequence will always fall
-	 * in this test because the old_ts is zero. That is what we
-	 * want as we need another timestamp to compute an interval.
-	 */
-	if (interval >=3D NSEC_PER_SEC) {
-		irqs->count =3D 0;
-		return;
-	}
-
-	__irq_timings_store(irq, irqs, interval);
-}
-
-/**
- * irq_timings_next_event - Return when the next event is supposed to arrive
- * @now: current time
- *
- * During the last busy cycle, the number of interrupts is incremented
- * and stored in the irq_timings structure. This information is
- * necessary to:
- *
- * - know if the index in the table wrapped up:
- *
- *      If more than the array size interrupts happened during the
- *      last busy/idle cycle, the index wrapped up and we have to
- *      begin with the next element in the array which is the last one
- *      in the sequence, otherwise it is at the index 0.
- *
- * - have an indication of the interrupts activity on this CPU
- *   (eg. irq/sec)
- *
- * The values are 'consumed' after inserting in the statistical model,
- * thus the count is reinitialized.
- *
- * The array of values **must** be browsed in the time direction, the
- * timestamp must increase between an element and the next one.
- *
- * Returns a nanosec time based estimation of the earliest interrupt,
- * U64_MAX otherwise.
- */
-u64 irq_timings_next_event(u64 now)
-{
-	struct irq_timings *irqts =3D this_cpu_ptr(&irq_timings);
-	struct irqt_stat *irqs;
-	struct irqt_stat __percpu *s;
-	u64 ts, next_evt =3D U64_MAX;
-	int i, irq =3D 0;
-
-	/*
-	 * This function must be called with the local irq disabled in
-	 * order to prevent the timings circular buffer to be updated
-	 * while we are reading it.
-	 */
-	lockdep_assert_irqs_disabled();
-
-	if (!irqts->count)
-		return next_evt;
-
-	/*
-	 * Number of elements in the circular buffer: If it happens it
-	 * was flushed before, then the number of elements could be
-	 * smaller than IRQ_TIMINGS_SIZE, so the count is used,
-	 * otherwise the array size is used as we wrapped. The index
-	 * begins from zero when we did not wrap. That could be done
-	 * in a nicer way with the proper circular array structure
-	 * type but with the cost of extra computation in the
-	 * interrupt handler hot path. We choose efficiency.
-	 *
-	 * Inject measured irq/timestamp to the pattern prediction
-	 * model while decrementing the counter because we consume the
-	 * data from our circular buffer.
-	 */
-	for_each_irqts(i, irqts) {
-		irq =3D irq_timing_decode(irqts->values[i], &ts);
-		s =3D idr_find(&irqt_stats, irq);
-		if (s)
-			irq_timings_store(irq, this_cpu_ptr(s), ts);
-	}
-
-	/*
-	 * Look in the list of interrupts' statistics, the earliest
-	 * next event.
-	 */
-	idr_for_each_entry(&irqt_stats, s, i) {
-
-		irqs =3D this_cpu_ptr(s);
-
-		ts =3D __irq_timings_next_event(irqs, i, now);
-		if (ts <=3D now)
-			return now;
-
-		if (ts < next_evt)
-			next_evt =3D ts;
-	}
-
-	return next_evt;
-}
-
-void irq_timings_free(int irq)
-{
-	struct irqt_stat __percpu *s;
-
-	s =3D idr_find(&irqt_stats, irq);
-	if (s) {
-		free_percpu(s);
-		idr_remove(&irqt_stats, irq);
-	}
-}
-
-int irq_timings_alloc(int irq)
-{
-	struct irqt_stat __percpu *s;
-	int id;
-
-	/*
-	 * Some platforms can have the same private interrupt per cpu,
-	 * so this function may be called several times with the
-	 * same interrupt number. Just bail out in case the per cpu
-	 * stat structure is already allocated.
-	 */
-	s =3D idr_find(&irqt_stats, irq);
-	if (s)
-		return 0;
-
-	s =3D alloc_percpu(*s);
-	if (!s)
-		return -ENOMEM;
-
-	idr_preload(GFP_KERNEL);
-	id =3D idr_alloc(&irqt_stats, s, irq, irq + 1, GFP_NOWAIT);
-	idr_preload_end();
-
-	if (id < 0) {
-		free_percpu(s);
-		return id;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_TEST_IRQ_TIMINGS
-struct timings_intervals {
-	u64 *intervals;
-	size_t count;
-};
-
-/*
- * Intervals are given in nanosecond base
- */
-static u64 intervals0[] __initdata =3D {
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000, 500000,
-	10000, 50000, 200000,
-};
-
-static u64 intervals1[] __initdata =3D {
-	223947000, 1240000, 1384000, 1386000, 1386000,
-	217416000, 1236000, 1384000, 1386000, 1387000,
-	214719000, 1241000, 1386000, 1387000, 1384000,
-	213696000, 1234000, 1384000, 1386000, 1388000,
-	219904000, 1240000, 1385000, 1389000, 1385000,
-	212240000, 1240000, 1386000, 1386000, 1386000,
-	214415000, 1236000, 1384000, 1386000, 1387000,
-	214276000, 1234000,
-};
-
-static u64 intervals2[] __initdata =3D {
-	4000, 3000, 5000, 100000,
-	3000, 3000, 5000, 117000,
-	4000, 4000, 5000, 112000,
-	4000, 3000, 4000, 110000,
-	3000, 5000, 3000, 117000,
-	4000, 4000, 5000, 112000,
-	4000, 3000, 4000, 110000,
-	3000, 4000, 5000, 112000,
-	4000,
-};
-
-static u64 intervals3[] __initdata =3D {
-	1385000, 212240000, 1240000,
-	1386000, 214415000, 1236000,
-	1384000, 214276000, 1234000,
-	1386000, 214415000, 1236000,
-	1385000, 212240000, 1240000,
-	1386000, 214415000, 1236000,
-	1384000, 214276000, 1234000,
-	1386000, 214415000, 1236000,
-	1385000, 212240000, 1240000,
-};
-
-static u64 intervals4[] __initdata =3D {
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000, 50000, 10000, 50000,
-	10000,
-};
-
-static struct timings_intervals tis[] __initdata =3D {
-	{ intervals0, ARRAY_SIZE(intervals0) },
-	{ intervals1, ARRAY_SIZE(intervals1) },
-	{ intervals2, ARRAY_SIZE(intervals2) },
-	{ intervals3, ARRAY_SIZE(intervals3) },
-	{ intervals4, ARRAY_SIZE(intervals4) },
-};
-
-static int __init irq_timings_test_next_index(struct timings_intervals *ti)
-{
-	int _buffer[IRQ_TIMINGS_SIZE];
-	int buffer[IRQ_TIMINGS_SIZE];
-	int index, start, i, count, period_max;
-
-	count =3D ti->count - 1;
-
-	period_max =3D count > (3 * PREDICTION_PERIOD_MAX) ?
-		PREDICTION_PERIOD_MAX : count / 3;
-
-	/*
-	 * Inject all values except the last one which will be used
-	 * to compare with the next index result.
-	 */
-	pr_debug("index suite: ");
-
-	for (i =3D 0; i < count; i++) {
-		index =3D irq_timings_interval_index(ti->intervals[i]);
-		_buffer[i & IRQ_TIMINGS_MASK] =3D index;
-		pr_cont("%d ", index);
-	}
-
-	start =3D count < IRQ_TIMINGS_SIZE ? 0 :
-		count & IRQ_TIMINGS_MASK;
-
-	count =3D min_t(int, count, IRQ_TIMINGS_SIZE);
-
-	for (i =3D 0; i < count; i++) {
-		int index =3D (start + i) & IRQ_TIMINGS_MASK;
-		buffer[i] =3D _buffer[index];
-	}
-
-	index =3D irq_timings_next_event_index(buffer, count, period_max);
-	i =3D irq_timings_interval_index(ti->intervals[ti->count - 1]);
-
-	if (index !=3D i) {
-		pr_err("Expected (%d) and computed (%d) next indexes differ\n",
-		       i, index);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init irq_timings_next_index_selftest(void)
-{
-	int i, ret;
-
-	for (i =3D 0; i < ARRAY_SIZE(tis); i++) {
-
-		pr_info("---> Injecting intervals number #%d (count=3D%zd)\n",
-			i, tis[i].count);
-
-		ret =3D irq_timings_test_next_index(&tis[i]);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
-static int __init irq_timings_test_irqs(struct timings_intervals *ti)
-{
-	struct irqt_stat __percpu *s;
-	struct irqt_stat *irqs;
-	int i, index, ret, irq =3D 0xACE5;
-
-	ret =3D irq_timings_alloc(irq);
-	if (ret) {
-		pr_err("Failed to allocate irq timings\n");
-		return ret;
-	}
-
-	s =3D idr_find(&irqt_stats, irq);
-	if (!s) {
-		ret =3D -EIDRM;
-		goto out;
-	}
-
-	irqs =3D this_cpu_ptr(s);
-
-	for (i =3D 0; i < ti->count; i++) {
-
-		index =3D irq_timings_interval_index(ti->intervals[i]);
-		pr_debug("%d: interval=3D%llu ema_index=3D%d\n",
-			 i, ti->intervals[i], index);
-
-		__irq_timings_store(irq, irqs, ti->intervals[i]);
-		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] !=3D index) {
-			ret =3D -EBADSLT;
-			pr_err("Failed to store in the circular buffer\n");
-			goto out;
-		}
-	}
-
-	if (irqs->count !=3D ti->count) {
-		ret =3D -ERANGE;
-		pr_err("Count differs\n");
-		goto out;
-	}
-
-	ret =3D 0;
-out:
-	irq_timings_free(irq);
-
-	return ret;
-}
-
-static int __init irq_timings_irqs_selftest(void)
-{
-	int i, ret;
-
-	for (i =3D 0; i < ARRAY_SIZE(tis); i++) {
-		pr_info("---> Injecting intervals number #%d (count=3D%zd)\n",
-			i, tis[i].count);
-		ret =3D irq_timings_test_irqs(&tis[i]);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
-static int __init irq_timings_test_irqts(struct irq_timings *irqts,
-					 unsigned count)
-{
-	int start =3D count >=3D IRQ_TIMINGS_SIZE ? count - IRQ_TIMINGS_SIZE : 0;
-	int i, irq, oirq =3D 0xBEEF;
-	u64 ots =3D 0xDEAD, ts;
-
-	/*
-	 * Fill the circular buffer by using the dedicated function.
-	 */
-	for (i =3D 0; i < count; i++) {
-		pr_debug("%d: index=3D%d, ts=3D%llX irq=3D%X\n",
-			 i, i & IRQ_TIMINGS_MASK, ots + i, oirq + i);
-
-		irq_timings_push(ots + i, oirq + i);
-	}
-
-	/*
-	 * Compute the first elements values after the index wrapped
-	 * up or not.
-	 */
-	ots +=3D start;
-	oirq +=3D start;
-
-	/*
-	 * Test the circular buffer count is correct.
-	 */
-	pr_debug("---> Checking timings array count (%d) is right\n", count);
-	if (WARN_ON(irqts->count !=3D count))
-		return -EINVAL;
-
-	/*
-	 * Test the macro allowing to browse all the irqts.
-	 */
-	pr_debug("---> Checking the for_each_irqts() macro\n");
-	for_each_irqts(i, irqts) {
-
-		irq =3D irq_timing_decode(irqts->values[i], &ts);
-
-		pr_debug("index=3D%d, ts=3D%llX / %llX, irq=3D%X / %X\n",
-			 i, ts, ots, irq, oirq);
-
-		if (WARN_ON(ts !=3D ots || irq !=3D oirq))
-			return -EINVAL;
-
-		ots++; oirq++;
-	}
-
-	/*
-	 * The circular buffer should have be flushed when browsed
-	 * with for_each_irqts
-	 */
-	pr_debug("---> Checking timings array is empty after browsing it\n");
-	if (WARN_ON(irqts->count))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int __init irq_timings_irqts_selftest(void)
-{
-	struct irq_timings *irqts =3D this_cpu_ptr(&irq_timings);
-	int i, ret;
-
-	/*
-	 * Test the circular buffer with different number of
-	 * elements. The purpose is to test at the limits (empty, half
-	 * full, full, wrapped with the cursor at the boundaries,
-	 * wrapped several times, etc ...
-	 */
-	int count[] =3D { 0,
-			IRQ_TIMINGS_SIZE >> 1,
-			IRQ_TIMINGS_SIZE,
-			IRQ_TIMINGS_SIZE + (IRQ_TIMINGS_SIZE >> 1),
-			2 * IRQ_TIMINGS_SIZE,
-			(2 * IRQ_TIMINGS_SIZE) + 3,
-	};
-
-	for (i =3D 0; i < ARRAY_SIZE(count); i++) {
-
-		pr_info("---> Checking the timings with %d/%d values\n",
-			count[i], IRQ_TIMINGS_SIZE);
-
-		ret =3D irq_timings_test_irqts(irqts, count[i]);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
-static int __init irq_timings_selftest(void)
-{
-	int ret;
-
-	pr_info("------------------- selftest start -----------------\n");
-
-	/*
-	 * At this point, we don't except any subsystem to use the irq
-	 * timings but us, so it should not be enabled.
-	 */
-	if (static_branch_unlikely(&irq_timing_enabled)) {
-		pr_warn("irq timings already initialized, skipping selftest\n");
-		return 0;
-	}
-
-	ret =3D irq_timings_irqts_selftest();
-	if (ret)
-		goto out;
-
-	ret =3D irq_timings_irqs_selftest();
-	if (ret)
-		goto out;
-
-	ret =3D irq_timings_next_index_selftest();
-out:
-	pr_info("---------- selftest end with %s -----------\n",
-		ret ? "failure" : "success");
-
-	return ret;
-}
-early_initcall(irq_timings_selftest);
-#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939..7885475 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2551,14 +2551,6 @@ config TEST_PARMAN
=20
 	  If unsure, say N.
=20
-config TEST_IRQ_TIMINGS
-	bool "IRQ timings selftest"
-	depends on IRQ_TIMINGS
-	help
-	  Enable this option to test the irq timings code on boot.
-
-	  If unsure, say N.
-
 config TEST_LKM
 	tristate "Test module loading with 'hello world' module"
 	depends on m

