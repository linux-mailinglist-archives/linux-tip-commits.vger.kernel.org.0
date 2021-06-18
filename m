Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D933ACFAE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhFRQFx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhFRQFu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57392C06175F;
        Fri, 18 Jun 2021 09:03:41 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+teraaN3vG4rGVN2967B+R2wDwxXRvLpF3/H+2NV64U=;
        b=Zh/PtnuaN7uXTwPl55a8LhHEltV+JQYhPsTbtMdobF+BZL+gB3zDRiwt4UB6R1kphsBlVN
        tcNXZYCw6HCZZQHf0ITQq5hjDj06YRfQGnBvKc7YqZ7uc8kFUTev0YJFbvI3DbKhmXs2u3
        5FnfBNvoN9VaHbT12kqC+3yt/5IjJ/rfwoOtRDuOCuIIfurrd5k+a512UauGT9p3QYehf7
        uQSB1DvrEDHr4Fo7fTYt9A/dInqmrCQKzf9lbi3JPzuRf7FSzp5/qPTHkp3rh07kVL7mK9
        ZI2o5psz+aVuP8DL+BBabZ4FmQX6Eh7CuhInpB6M2IqHWKiYD7YezwnC/e6wJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+teraaN3vG4rGVN2967B+R2wDwxXRvLpF3/H+2NV64U=;
        b=GSdDc+p2P0lu4Ul95xXjyDVunMoNPcrXcHBLEASMJENOQH1YWZ8+6kqr/7mPUJILuXfc2F
        wTeW40K3nDS0znCQ==
From:   "tip-bot2 for Andrea Merello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Implement
 rate compensation whenever source clock changes
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        soren.brinkmann@xilinx.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
In-Reply-To: <20210406130045.15491-2-andrea.merello@gmail.com>
References: <20210406130045.15491-2-andrea.merello@gmail.com>
MIME-Version: 1.0
Message-ID: <162403221927.19906.8467239088560360589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     171b45a4a70eef2fd36bb794ce4f5a48c440361e
Gitweb:        https://git.kernel.org/tip/171b45a4a70eef2fd36bb794ce4f5a48c44=
0361e
Author:        Andrea Merello <andrea.merello@gmail.com>
AuthorDate:    Tue, 06 Apr 2021 15:00:44 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Jun 2021 17:33:04 +02:00

clocksource/drivers/arm_global_timer: Implement rate compensation whenever so=
urce clock changes

This patch adds rate change notification support for the parent clock;
should that clock change, then we try to adjust the our prescaler in order
to compensate (i.e. we adjust to still get the same timer frequency).

This is loosely based on what it's done in timer-cadence-ttc. timer-sun51,
mips-gic-timer and smp_twd.c also seem to look at their parent clock rate
and to perform some kind of adjustment whenever needed.

In this particular case we have only one single counter and prescaler for
all clocksource, clockevent and timer_delay, and we just update it for all
(i.e. we don't let it go and call clockevents_update_freq() to notify to
the kernel that our rate has changed).

Note that, there is apparently no other way to fixup things, because once
we call register_current_timer_delay(), specifying the timer rate, it seems
that that rate is not supposed to change ever.

In order for this mechanism to work, we have to make assumptions about how
much the initial clock is supposed to eventually decrease from the initial
one, and set our initial prescaler to a value that we can eventually
decrease enough to compensate. We provide an option in KConfig for this.

In case we end up in a situation in which we are not able to compensate the
parent clock change, we fail returning NOTIFY_BAD.

This fixes a real-world problem with Zynq arch not being able to use this
driver and CPU_FREQ at the same time (because ARM global timer is fed by
the CPU clock, which may keep changing when CPU_FREQ is enabled).

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210406130045.15491-2-andrea.merello@gmail.c=
om
---
 drivers/clocksource/Kconfig            |  13 +++-
 drivers/clocksource/arm_global_timer.c | 122 ++++++++++++++++++++++--
 2 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 39aa21d..19fc5f8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -358,6 +358,19 @@ config ARM_GLOBAL_TIMER
 	help
 	  This option enables support for the ARM global timer unit.
=20
+config ARM_GT_INITIAL_PRESCALER_VAL
+	int "ARM global timer initial prescaler value"
+	default 1
+	depends on ARM_GLOBAL_TIMER
+	help
+	  When the ARM global timer initializes, its current rate is declared
+	  to the kernel and maintained forever. Should it's parent clock
+	  change, the driver tries to fix the timer's internal prescaler.
+	  On some machs (i.e. Zynq) the initial prescaler value thus poses
+	  bounds about how much the parent clock is allowed to decrease or
+	  increase wrt the initial clock value.
+	  This affects CPU_FREQ max delta from the initial frequency.
+
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index 88b2d38..60a8047 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -31,6 +31,10 @@
 #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
+#define GT_CONTROL_PRESCALER_SHIFT      8
+#define GT_CONTROL_PRESCALER_MAX        0xF
+#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
+					 GT_CONTROL_PRESCALER_SHIFT)
=20
 #define GT_INT_STATUS	0x0c
 #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
@@ -39,6 +43,7 @@
 #define GT_COMP1	0x14
 #define GT_AUTO_INC	0x18
=20
+#define MAX_F_ERR 50
 /*
  * We are expecting to be clocked by the ARM peripheral clock.
  *
@@ -46,7 +51,8 @@
  * the units for all operations.
  */
 static void __iomem *gt_base;
-static unsigned long gt_clk_rate;
+struct notifier_block gt_clk_rate_change_nb;
+static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
=20
@@ -96,7 +102,10 @@ static void gt_compare_set(unsigned long delta, int perio=
dic)
 	unsigned long ctrl;
=20
 	counter +=3D delta;
-	ctrl =3D GT_CONTROL_TIMER_ENABLE;
+	ctrl =3D readl(gt_base + GT_CONTROL);
+	ctrl &=3D ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
+		  GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
+	ctrl |=3D GT_CONTROL_TIMER_ENABLE;
 	writel_relaxed(ctrl, gt_base + GT_CONTROL);
 	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
 	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
@@ -123,7 +132,7 @@ static int gt_clockevent_shutdown(struct clock_event_devi=
ce *evt)
=20
 static int gt_clockevent_set_periodic(struct clock_event_device *evt)
 {
-	gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
+	gt_compare_set(DIV_ROUND_CLOSEST(gt_target_rate, HZ), 1);
 	return 0;
 }
=20
@@ -177,7 +186,7 @@ static int gt_starting_cpu(unsigned int cpu)
 	clk->cpumask =3D cpumask_of(cpu);
 	clk->rating =3D 300;
 	clk->irq =3D gt_ppi;
-	clockevents_config_and_register(clk, gt_clk_rate,
+	clockevents_config_and_register(clk, gt_target_rate,
 					1, 0xffffffff);
 	enable_percpu_irq(clk->irq, IRQ_TYPE_NONE);
 	return 0;
@@ -232,9 +241,28 @@ static struct delay_timer gt_delay_timer =3D {
 	.read_current_timer =3D gt_read_long,
 };
=20
+static void gt_write_presc(u32 psv)
+{
+	u32 reg;
+
+	reg =3D readl(gt_base + GT_CONTROL);
+	reg &=3D ~GT_CONTROL_PRESCALER_MASK;
+	reg |=3D psv << GT_CONTROL_PRESCALER_SHIFT;
+	writel(reg, gt_base + GT_CONTROL);
+}
+
+static u32 gt_read_presc(void)
+{
+	u32 reg;
+
+	reg =3D readl(gt_base + GT_CONTROL);
+	reg &=3D GT_CONTROL_PRESCALER_MASK;
+	return reg >> GT_CONTROL_PRESCALER_SHIFT;
+}
+
 static void __init gt_delay_timer_init(void)
 {
-	gt_delay_timer.freq =3D gt_clk_rate;
+	gt_delay_timer.freq =3D gt_target_rate;
 	register_current_timer_delay(&gt_delay_timer);
 }
=20
@@ -243,18 +271,81 @@ static int __init gt_clocksource_init(void)
 	writel(0, gt_base + GT_CONTROL);
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
-	/* enables timer on all the cores */
-	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+	/* set prescaler and enable timer on all the cores */
+	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
+		GT_CONTROL_PRESCALER_SHIFT)
+	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
=20
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
+	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
 #endif
-	return clocksource_register_hz(&gt_clocksource, gt_clk_rate);
+	return clocksource_register_hz(&gt_clocksource, gt_target_rate);
+}
+
+static int gt_clk_rate_change_cb(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata =3D data;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+	{
+		int psv;
+
+		psv =3D DIV_ROUND_CLOSEST(ndata->new_rate,
+					gt_target_rate);
+
+		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+			return NOTIFY_BAD;
+
+		psv--;
+
+		/* prescaler within legal range? */
+		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+			return NOTIFY_BAD;
+
+		/*
+		 * store timer clock ctrl register so we can restore it in case
+		 * of an abort.
+		 */
+		gt_psv_bck =3D gt_read_presc();
+		gt_psv_new =3D psv;
+		/* scale down: adjust divider in post-change notification */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_DONE;
+
+		/* scale up: adjust divider now - before frequency change */
+		gt_write_presc(psv);
+		break;
+	}
+	case POST_RATE_CHANGE:
+		/* scale up: pre-change notification did the adjustment */
+		if (ndata->new_rate > ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* scale down: adjust divider now - after frequency change */
+		gt_write_presc(gt_psv_new);
+		break;
+
+	case ABORT_RATE_CHANGE:
+		/* we have to undo the adjustment in case we scale up */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* restore original register value */
+		gt_write_presc(gt_psv_bck);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
 }
=20
 static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
+	static unsigned long gt_clk_rate;
 	int err =3D 0;
=20
 	/*
@@ -292,11 +383,20 @@ static int __init global_timer_of_register(struct devic=
e_node *np)
 	}
=20
 	gt_clk_rate =3D clk_get_rate(gt_clk);
+	gt_target_rate =3D gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+	gt_clk_rate_change_nb.notifier_call =3D
+		gt_clk_rate_change_cb;
+	err =3D clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
+	if (err) {
+		pr_warn("Unable to register clock notifier\n");
+		goto out_clk;
+	}
+
 	gt_evt =3D alloc_percpu(struct clock_event_device);
 	if (!gt_evt) {
 		pr_warn("global-timer: can't allocate memory\n");
 		err =3D -ENOMEM;
-		goto out_clk;
+		goto out_clk_nb;
 	}
=20
 	err =3D request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
@@ -326,6 +426,8 @@ out_irq:
 	free_percpu_irq(gt_ppi, gt_evt);
 out_free:
 	free_percpu(gt_evt);
+out_clk_nb:
+	clk_notifier_unregister(gt_clk, &gt_clk_rate_change_nb);
 out_clk:
 	clk_disable_unprepare(gt_clk);
 out_unmap:
