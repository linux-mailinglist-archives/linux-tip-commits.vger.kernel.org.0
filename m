Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E7A2D86A1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438942AbgLLNAV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438931AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E0C0617B0;
        Sat, 12 Dec 2020 04:58:43 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VULeEb7njoHAqQ+fb2MEh+DwCLVXgfHMSDZu9BycRi0=;
        b=BjxCyoSmTTERRvudPww78rftl8EFJxhNmevtDsUtP/5MiPsC6yw2FsG/gmytWz/4F+eK6p
        gchACB669AVh//81LXIJPWfMc5uYAZSNX3QiIL9hcdH1oT9X3NORDHhWA7+hz3zF7WHO0Z
        NAAzMVhCL1flORBoE/ZlE1y8QtFBv5sOGBhhIkGUS+n2nZdYKxxty8YcjB2hh1k+Pcys3Q
        iRLz12ZoT0YCa6xze4nmNlGLt5s3l2azHtk/T7EXcgJqkyjRS0T69N36NFfijRfMYPtTz6
        I+uCX3SE+vlnNj0OZEStSVU6cqbThvz2z7InfASKwxL7B01RwO4KHdZSff0/9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VULeEb7njoHAqQ+fb2MEh+DwCLVXgfHMSDZu9BycRi0=;
        b=DZQzu2uhwnoshC3iT2l7I9/rUl8vQRF9sGWrT7MuO7qNjkeZ3+uhor47d6os7RQ29/DI9Z
        p6IF3dz3Y1AduIDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] drm/i915/pmu: Replace open coded kstat_irqs() copy
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.957046529@linutronix.de>
References: <20201210194043.957046529@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791851.3364.15987015543292366110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b64217174467e1c4c3da04a7f7835393fa234818
Gitweb:        https://git.kernel.org/tip/b64217174467e1c4c3da04a7f7835393fa2=
34818
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

drm/i915/pmu: Replace open coded kstat_irqs() copy

Driver code has no business with the internals of the irq descriptor.

Aside of that the count is per interrupt line and therefore takes
interrupts from other devices into account which share the interrupt line
and are not handled by the graphics driver.

Replace it with a pmu private count which only counts interrupts which
originate from the graphics card.

To avoid atomics or heuristics of some sort make the counter field
'unsigned long'. That limits the count to 4e9 on 32bit which is a lot and
postprocessing can easily deal with the occasional wraparound.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Link: https://lore.kernel.org/r/20201210194043.957046529@linutronix.de

---
 drivers/gpu/drm/i915/i915_irq.c | 34 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/i915/i915_pmu.c | 19 +------------------
 drivers/gpu/drm/i915/i915_pmu.h |  8 ++++++++-
 3 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 759f523..e741cd7 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -60,6 +60,24 @@
  * and related files, but that will be described in separate chapters.
  */
=20
+/*
+ * Interrupt statistic for PMU. Increments the counter only if the
+ * interrupt originated from the the GPU so interrupts from a device which
+ * shares the interrupt line are not accounted.
+ */
+static inline void pmu_irq_stats(struct drm_i915_private *i915,
+				 irqreturn_t res)
+{
+	if (unlikely(res !=3D IRQ_HANDLED))
+		return;
+
+	/*
+	 * A clever compiler translates that into INC. A not so clever one
+	 * should at least prevent store tearing.
+	 */
+	WRITE_ONCE(i915->pmu.irq_count, i915->pmu.irq_count + 1);
+}
+
 typedef bool (*long_pulse_detect_func)(enum hpd_pin pin, u32 val);
=20
 static const u32 hpd_ilk[HPD_NUM_PINS] =3D {
@@ -1599,6 +1617,8 @@ static irqreturn_t valleyview_irq_handler(int irq, void=
 *arg)
 		valleyview_pipestat_irq_handler(dev_priv, pipe_stats);
 	} while (0);
=20
+	pmu_irq_stats(dev_priv, ret);
+
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
=20
 	return ret;
@@ -1676,6 +1696,8 @@ static irqreturn_t cherryview_irq_handler(int irq, void=
 *arg)
 		valleyview_pipestat_irq_handler(dev_priv, pipe_stats);
 	} while (0);
=20
+	pmu_irq_stats(dev_priv, ret);
+
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
=20
 	return ret;
@@ -2103,6 +2125,8 @@ static irqreturn_t ilk_irq_handler(int irq, void *arg)
 	if (sde_ier)
 		raw_reg_write(regs, SDEIER, sde_ier);
=20
+	pmu_irq_stats(i915, ret);
+
 	/* IRQs are synced during runtime_suspend, we don't require a wakeref */
 	enable_rpm_wakeref_asserts(&i915->runtime_pm);
=20
@@ -2419,6 +2443,8 @@ static irqreturn_t gen8_irq_handler(int irq, void *arg)
=20
 	gen8_master_intr_enable(regs);
=20
+	pmu_irq_stats(dev_priv, IRQ_HANDLED);
+
 	return IRQ_HANDLED;
 }
=20
@@ -2514,6 +2540,8 @@ __gen11_irq_handler(struct drm_i915_private * const i91=
5,
=20
 	gen11_gu_misc_irq_handler(gt, gu_misc_iir);
=20
+	pmu_irq_stats(i915, IRQ_HANDLED);
+
 	return IRQ_HANDLED;
 }
=20
@@ -3688,6 +3716,8 @@ static irqreturn_t i8xx_irq_handler(int irq, void *arg)
 		i8xx_pipestat_irq_handler(dev_priv, iir, pipe_stats);
 	} while (0);
=20
+	pmu_irq_stats(dev_priv, ret);
+
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
=20
 	return ret;
@@ -3796,6 +3826,8 @@ static irqreturn_t i915_irq_handler(int irq, void *arg)
 		i915_pipestat_irq_handler(dev_priv, iir, pipe_stats);
 	} while (0);
=20
+	pmu_irq_stats(dev_priv, ret);
+
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
=20
 	return ret;
@@ -3941,6 +3973,8 @@ static irqreturn_t i965_irq_handler(int irq, void *arg)
 		i965_pipestat_irq_handler(dev_priv, iir, pipe_stats);
 	} while (0);
=20
+	pmu_irq_stats(dev_priv, IRQ_HANDLED);
+
 	enable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
=20
 	return ret;
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 69c0fa2..3b88cb0 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -4,7 +4,6 @@
  * Copyright =C2=A9 2017-2018 Intel Corporation
  */
=20
-#include <linux/irq.h>
 #include <linux/pm_runtime.h>
=20
 #include "gt/intel_engine.h"
@@ -423,22 +422,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *=
hrtimer)
 	return HRTIMER_RESTART;
 }
=20
-static u64 count_interrupts(struct drm_i915_private *i915)
-{
-	/* open-coded kstat_irqs() */
-	struct irq_desc *desc =3D irq_to_desc(i915->drm.pdev->irq);
-	u64 sum =3D 0;
-	int cpu;
-
-	if (!desc || !desc->kstat_irqs)
-		return 0;
-
-	for_each_possible_cpu(cpu)
-		sum +=3D *per_cpu_ptr(desc->kstat_irqs, cpu);
-
-	return sum;
-}
-
 static void i915_pmu_event_destroy(struct perf_event *event)
 {
 	struct drm_i915_private *i915 =3D
@@ -581,7 +564,7 @@ static u64 __i915_pmu_event_read(struct perf_event *event)
 				   USEC_PER_SEC /* to MHz */);
 			break;
 		case I915_PMU_INTERRUPTS:
-			val =3D count_interrupts(i915);
+			val =3D READ_ONCE(pmu->irq_count);
 			break;
 		case I915_PMU_RC6_RESIDENCY:
 			val =3D get_rc6(&i915->gt);
diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
index 941f0c1..9e49c64 100644
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@ -108,6 +108,14 @@ struct i915_pmu {
 	 */
 	ktime_t sleep_last;
 	/**
+	 * @irq_count: Number of interrupts
+	 *
+	 * Intentionally unsigned long to avoid atomics or heuristics on 32bit.
+	 * 4e9 interrupts are a lot and postprocessing can really deal with an
+	 * occasional wraparound easily. It's 32bit after all.
+	 */
+	unsigned long irq_count;
+	/**
 	 * @events_attr_group: Device events attribute group.
 	 */
 	struct attribute_group events_attr_group;
