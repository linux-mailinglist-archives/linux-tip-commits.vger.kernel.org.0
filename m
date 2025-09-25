Return-Path: <linux-tip-commits+bounces-6735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DDEBA1912
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E9B189D1D3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236F324B3D;
	Thu, 25 Sep 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Du95/gl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yFgwItMW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F932252A;
	Thu, 25 Sep 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835996; cv=none; b=HonUwZuySYtWdLjXdEqr5dI+Z8vo7QFiyB7BKogloO7LXnF28QsQYQzlS6tQhDPpkX9RlMvf49KqLXW1uvuNsZg4hrzddSDjYY4yNgoxZld0LKbR4DSfkHq02fX7n18vCDnfatQ79kcu2zq+rblueFuwBS6ykPvl7LkTrJuHmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835996; c=relaxed/simple;
	bh=PkrY0FGvsnlcSpCjfSmXiOz4gF6pbIZG3LvIj9jB+Ig=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=d2QzmN5DzCD+JH325Kt2VyPukDLxO6fNj4tIOBUdG7JjeEbTgnwUzN0HyNgRhe2rjZtm86VJr5xdlonhPK19FlSen+ATPtmjD8ZPhZLL+3Hjf6Uz0sq9xW2OvkIFmL5mgx13MTUFvzTiFzGbOcMdYVibm3HqIJjSIkB+S7cvQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Du95/gl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yFgwItMW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DS/I33V3afgYEdiHJ1S9A8AsQ57UzH0YqeaQDTGMHlA=;
	b=0Du95/glPqR2Lu3YdYXdo5V0lu+8wPfFMiiSaDtaTTKRg1bY8qIG6S9l8B73Swo3a3LymR
	UoFRcTsPlFcmgYcwvLw3rEkcv9Y7clk55WqYshULhi/thp8mDDxBq8/b11ZWRHaI4/83vK
	B5vBxIkCfE6o2CsO1UEBo8hm1hhgWMTP8behVUkiDvpyrvjAaLxr1pJEgk0lc8fhI2HZVj
	X/rZAYFZ8GVshXpRGmgTjxQetOZglcnJdEwKmabkUjmqHU+wugbLq6XRUTlJvHJlkF6geN
	FzCW7w5jNO9Lp9aHW4iWAcJKlyv8B9oFXDBkd/PR+VCdoxyKqy+TQ7yMOfzGOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DS/I33V3afgYEdiHJ1S9A8AsQ57UzH0YqeaQDTGMHlA=;
	b=yFgwItMW4hRKPwG3PujbDeL0K+Ai/I6X4siDBGHAms9tY3KozYx6XY6b+2at6mIImEvEaI
	IfmZhuM7R8kPXdBg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/arm_arch_timer_mmio:
 Switch over to standalone driver
Cc: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599026.709179.16408420138935588783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     0f67b56d84b4c49adfd61f19f81f84ec613ab51a
Gitweb:        https://git.kernel.org/tip/0f67b56d84b4c49adfd61f19f81f84ec613=
ab51a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 16:46:21 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:31:50 +02:00

clocksource/drivers/arm_arch_timer_mmio: Switch over to standalone driver

Remove all the MMIO support from the per-CPU timer driver, and switch
over to the standalove driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250814154622.10193-4-maz@kernel.org
---
 drivers/clocksource/Makefile         |   1 +-
 drivers/clocksource/arm_arch_timer.c | 686 ++------------------------
 include/clocksource/arm_arch_timer.h |   5 +-
 3 files changed, 66 insertions(+), 626 deletions(-)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 77a0f08..ec4452e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_REALTEK_OTTO_TIMER)	+=3D timer-rtl-otto.o
=20
 obj-$(CONFIG_ARC_TIMERS)		+=3D arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer.o
+obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer_mmio.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+=3D arm_global_timer.o
 obj-$(CONFIG_ARMV7M_SYSTICK)		+=3D armv7m_systick.o
 obj-$(CONFIG_ARM_TIMER_SP804)		+=3D timer-sp804.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 80ba6a5..90aeff4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -34,42 +34,12 @@
=20
 #include <clocksource/arm_arch_timer.h>
=20
-#define CNTTIDR		0x08
-#define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
-
-#define CNTACR(n)	(0x40 + ((n) * 4))
-#define CNTACR_RPCT	BIT(0)
-#define CNTACR_RVCT	BIT(1)
-#define CNTACR_RFRQ	BIT(2)
-#define CNTACR_RVOFF	BIT(3)
-#define CNTACR_RWVT	BIT(4)
-#define CNTACR_RWPT	BIT(5)
-
-#define CNTPCT_LO	0x00
-#define CNTVCT_LO	0x08
-#define CNTFRQ		0x10
-#define CNTP_CVAL_LO	0x20
-#define CNTP_CTL	0x2c
-#define CNTV_CVAL_LO	0x30
-#define CNTV_CTL	0x3c
-
 /*
  * The minimum amount of time a generic counter is guaranteed to not roll ov=
er
  * (40 years)
  */
 #define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
=20
-static unsigned arch_timers_present __initdata;
-
-struct arch_timer {
-	void __iomem *base;
-	struct clock_event_device evt;
-};
-
-static struct arch_timer *arch_timer_mem __ro_after_init;
-
-#define to_arch_timer(e) container_of(e, struct arch_timer, evt)
-
 static u32 arch_timer_rate __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
=20
@@ -85,7 +55,6 @@ static struct clock_event_device __percpu *arch_timer_evt;
=20
 static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init =3D ARCH_T=
IMER_VIRT_PPI;
 static bool arch_timer_c3stop __ro_after_init;
-static bool arch_timer_mem_use_virtual __ro_after_init;
 static bool arch_counter_suspend_stop __ro_after_init;
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default =3D VDSO_CLOCKMODE_ARCHTIMER;
@@ -121,76 +90,6 @@ static int arch_counter_get_width(void)
 /*
  * Architected system timer support.
  */
-
-static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
-			  struct clock_event_device *clk)
-{
-	if (access =3D=3D ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed((u32)val, timer->base + CNTP_CTL);
-			break;
-		case ARCH_TIMER_REG_CVAL:
-			/*
-			 * Not guaranteed to be atomic, so the timer
-			 * must be disabled at this point.
-			 */
-			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else if (access =3D=3D ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed((u32)val, timer->base + CNTV_CTL);
-			break;
-		case ARCH_TIMER_REG_CVAL:
-			/* Same restriction as above */
-			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else {
-		arch_timer_reg_write_cp15(access, reg, val);
-	}
-}
-
-static __always_inline
-u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
-			struct clock_event_device *clk)
-{
-	u32 val;
-
-	if (access =3D=3D ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val =3D readl_relaxed(timer->base + CNTP_CTL);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else if (access =3D=3D ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer =3D to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val =3D readl_relaxed(timer->base + CNTV_CTL);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else {
-		val =3D arch_timer_reg_read_cp15(access, reg);
-	}
-
-	return val;
-}
-
 static noinstr u64 raw_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
@@ -424,7 +323,7 @@ void erratum_set_next_event_generic(const int access, uns=
igned long evt,
 	unsigned long ctrl;
 	u64 cval;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
 	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
=20
@@ -436,7 +335,7 @@ void erratum_set_next_event_generic(const int access, uns=
igned long evt,
 		write_sysreg(cval, cntv_cval_el0);
 	}
=20
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
=20
 static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
@@ -667,10 +566,10 @@ static __always_inline irqreturn_t timer_handler(const =
int access,
 {
 	unsigned long ctrl;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, evt);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
 		ctrl |=3D ARCH_TIMER_CTRL_IT_MASK;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, evt);
+		arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 		evt->event_handler(evt);
 		return IRQ_HANDLED;
 	}
@@ -692,28 +591,14 @@ static irqreturn_t arch_timer_handler_phys(int irq, voi=
d *dev_id)
 	return timer_handler(ARCH_TIMER_PHYS_ACCESS, evt);
 }
=20
-static irqreturn_t arch_timer_handler_phys_mem(int irq, void *dev_id)
-{
-	struct clock_event_device *evt =3D dev_id;
-
-	return timer_handler(ARCH_TIMER_MEM_PHYS_ACCESS, evt);
-}
-
-static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
-{
-	struct clock_event_device *evt =3D dev_id;
-
-	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
-}
-
 static __always_inline int arch_timer_shutdown(const int access,
 					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
=20
 	return 0;
 }
@@ -728,23 +613,13 @@ static int arch_timer_shutdown_phys(struct clock_event_=
device *clk)
 	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
=20
-static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
-{
-	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
-}
-
-static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
-{
-	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
-}
-
 static __always_inline void set_next_event(const int access, unsigned long e=
vt,
 					   struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 	u64 cnt;
=20
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl =3D arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
 	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
=20
@@ -753,8 +628,8 @@ static __always_inline void set_next_event(const int acce=
ss, unsigned long evt,
 	else
 		cnt =3D __arch_counter_get_cntvct();
=20
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CVAL, evt + cnt);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
=20
 static int arch_timer_set_next_event_virt(unsigned long evt,
@@ -771,60 +646,6 @@ static int arch_timer_set_next_event_phys(unsigned long =
evt,
 	return 0;
 }
=20
-static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset=
_lo)
-{
-	u32 cnt_lo, cnt_hi, tmp_hi;
-
-	do {
-		cnt_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
-		cnt_lo =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
-		tmp_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
-	} while (cnt_hi !=3D tmp_hi);
-
-	return ((u64) cnt_hi << 32) | cnt_lo;
-}
-
-static __always_inline void set_next_event_mem(const int access, unsigned lo=
ng evt,
-					   struct clock_event_device *clk)
-{
-	struct arch_timer *timer =3D to_arch_timer(clk);
-	unsigned long ctrl;
-	u64 cnt;
-
-	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
-
-	/* Timer must be disabled before programming CVAL */
-	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
-		ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-	}
-
-	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
-	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
-
-	if (access =3D=3D  ARCH_TIMER_MEM_VIRT_ACCESS)
-		cnt =3D arch_counter_get_cnt_mem(timer, CNTVCT_LO);
-	else
-		cnt =3D arch_counter_get_cnt_mem(timer, CNTPCT_LO);
-
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-}
-
-static int arch_timer_set_next_event_virt_mem(unsigned long evt,
-					      struct clock_event_device *clk)
-{
-	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
-	return 0;
-}
-
-static int arch_timer_set_next_event_phys_mem(unsigned long evt,
-					      struct clock_event_device *clk)
-{
-	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
-	return 0;
-}
-
 static u64 __arch_timer_check_delta(void)
 {
 #ifdef CONFIG_ARM64
@@ -850,63 +671,41 @@ static u64 __arch_timer_check_delta(void)
 	return CLOCKSOURCE_MASK(arch_counter_get_width());
 }
=20
-static void __arch_timer_setup(unsigned type,
-			       struct clock_event_device *clk)
+static void __arch_timer_setup(struct clock_event_device *clk)
 {
+	typeof(clk->set_next_event) sne;
 	u64 max_delta;
=20
 	clk->features =3D CLOCK_EVT_FEAT_ONESHOT;
=20
-	if (type =3D=3D ARCH_TIMER_TYPE_CP15) {
-		typeof(clk->set_next_event) sne;
-
-		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
-
-		if (arch_timer_c3stop)
-			clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
-		clk->name =3D "arch_sys_timer";
-		clk->rating =3D 450;
-		clk->cpumask =3D cpumask_of(smp_processor_id());
-		clk->irq =3D arch_timer_ppi[arch_timer_uses_ppi];
-		switch (arch_timer_uses_ppi) {
-		case ARCH_TIMER_VIRT_PPI:
-			clk->set_state_shutdown =3D arch_timer_shutdown_virt;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_virt;
-			sne =3D erratum_handler(set_next_event_virt);
-			break;
-		case ARCH_TIMER_PHYS_SECURE_PPI:
-		case ARCH_TIMER_PHYS_NONSECURE_PPI:
-		case ARCH_TIMER_HYP_PPI:
-			clk->set_state_shutdown =3D arch_timer_shutdown_phys;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_phys;
-			sne =3D erratum_handler(set_next_event_phys);
-			break;
-		default:
-			BUG();
-		}
+	arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
=20
-		clk->set_next_event =3D sne;
-		max_delta =3D __arch_timer_check_delta();
-	} else {
-		clk->features |=3D CLOCK_EVT_FEAT_DYNIRQ;
-		clk->name =3D "arch_mem_timer";
-		clk->rating =3D 400;
-		clk->cpumask =3D cpu_possible_mask;
-		if (arch_timer_mem_use_virtual) {
-			clk->set_state_shutdown =3D arch_timer_shutdown_virt_mem;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_virt_mem;
-			clk->set_next_event =3D
-				arch_timer_set_next_event_virt_mem;
-		} else {
-			clk->set_state_shutdown =3D arch_timer_shutdown_phys_mem;
-			clk->set_state_oneshot_stopped =3D arch_timer_shutdown_phys_mem;
-			clk->set_next_event =3D
-				arch_timer_set_next_event_phys_mem;
-		}
-
-		max_delta =3D CLOCKSOURCE_MASK(56);
+	if (arch_timer_c3stop)
+		clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
+	clk->name =3D "arch_sys_timer";
+	clk->rating =3D 450;
+	clk->cpumask =3D cpumask_of(smp_processor_id());
+	clk->irq =3D arch_timer_ppi[arch_timer_uses_ppi];
+	switch (arch_timer_uses_ppi) {
+	case ARCH_TIMER_VIRT_PPI:
+		clk->set_state_shutdown =3D arch_timer_shutdown_virt;
+		clk->set_state_oneshot_stopped =3D arch_timer_shutdown_virt;
+		sne =3D erratum_handler(set_next_event_virt);
+		break;
+	case ARCH_TIMER_PHYS_SECURE_PPI:
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+	case ARCH_TIMER_HYP_PPI:
+		clk->set_state_shutdown =3D arch_timer_shutdown_phys;
+		clk->set_state_oneshot_stopped =3D arch_timer_shutdown_phys;
+		sne =3D erratum_handler(set_next_event_phys);
+		break;
+	default:
+		BUG();
 	}
=20
+	clk->set_next_event =3D sne;
+	max_delta =3D __arch_timer_check_delta();
+
 	clk->set_state_shutdown(clk);
=20
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
@@ -1029,7 +828,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk =3D this_cpu_ptr(arch_timer_evt);
 	u32 flags;
=20
-	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
+	__arch_timer_setup(clk);
=20
 	flags =3D check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
@@ -1075,22 +874,12 @@ static void __init arch_timer_of_configure_rate(u32 ra=
te, struct device_node *np
 		pr_warn("frequency not available\n");
 }
=20
-static void __init arch_timer_banner(unsigned type)
+static void __init arch_timer_banner(void)
 {
-	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
-		type =3D=3D (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ?
-			" and " : "",
-		type & ARCH_TIMER_TYPE_MEM ? "mmio" : "",
+	pr_info("cp15 timer running at %lu.%02luMHz (%s).\n",
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
-		type & ARCH_TIMER_TYPE_CP15 ?
-			(arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
-			"",
-		type =3D=3D (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
-		type & ARCH_TIMER_TYPE_MEM ?
-			arch_timer_mem_use_virtual ? "virt" : "phys" :
-			"");
+		(arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) ? "virt" : "phys");
 }
=20
 u32 arch_timer_get_rate(void)
@@ -1108,11 +897,6 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
=20
-static noinstr u64 arch_counter_get_cntvct_mem(void)
-{
-	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
-}
-
 static struct arch_timer_kvm_info arch_timer_kvm_info;
=20
 struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
@@ -1120,42 +904,35 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(vo=
id)
 	return &arch_timer_kvm_info;
 }
=20
-static void __init arch_counter_register(unsigned type)
+static void __init arch_counter_register(void)
 {
 	u64 (*scr)(void);
+	u64 (*rd)(void);
 	u64 start_count;
 	int width;
=20
-	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_TIMER_TYPE_CP15) {
-		u64 (*rd)(void);
-
-		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
-		    arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) {
-			if (arch_timer_counter_has_wa()) {
-				rd =3D arch_counter_get_cntvct_stable;
-				scr =3D raw_counter_get_cntvct_stable;
-			} else {
-				rd =3D arch_counter_get_cntvct;
-				scr =3D arch_counter_get_cntvct;
-			}
+	if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
+	    arch_timer_uses_ppi =3D=3D ARCH_TIMER_VIRT_PPI) {
+		if (arch_timer_counter_has_wa()) {
+			rd =3D arch_counter_get_cntvct_stable;
+			scr =3D raw_counter_get_cntvct_stable;
 		} else {
-			if (arch_timer_counter_has_wa()) {
-				rd =3D arch_counter_get_cntpct_stable;
-				scr =3D raw_counter_get_cntpct_stable;
-			} else {
-				rd =3D arch_counter_get_cntpct;
-				scr =3D arch_counter_get_cntpct;
-			}
+			rd =3D arch_counter_get_cntvct;
+			scr =3D arch_counter_get_cntvct;
 		}
-
-		arch_timer_read_counter =3D rd;
-		clocksource_counter.vdso_clock_mode =3D vdso_default;
 	} else {
-		arch_timer_read_counter =3D arch_counter_get_cntvct_mem;
-		scr =3D arch_counter_get_cntvct_mem;
+		if (arch_timer_counter_has_wa()) {
+			rd =3D arch_counter_get_cntpct_stable;
+			scr =3D raw_counter_get_cntpct_stable;
+		} else {
+			rd =3D arch_counter_get_cntpct;
+			scr =3D arch_counter_get_cntpct;
+		}
 	}
=20
+	arch_timer_read_counter =3D rd;
+	clocksource_counter.vdso_clock_mode =3D vdso_default;
+
 	width =3D arch_counter_get_width();
 	clocksource_counter.mask =3D CLOCKSOURCE_MASK(width);
 	cyclecounter.mask =3D CLOCKSOURCE_MASK(width);
@@ -1303,76 +1080,10 @@ out:
 	return err;
 }
=20
-static int __init arch_timer_mem_register(void __iomem *base, unsigned int i=
rq)
-{
-	int ret;
-	irq_handler_t func;
-
-	arch_timer_mem =3D kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
-	if (!arch_timer_mem)
-		return -ENOMEM;
-
-	arch_timer_mem->base =3D base;
-	arch_timer_mem->evt.irq =3D irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
-
-	if (arch_timer_mem_use_virtual)
-		func =3D arch_timer_handler_virt_mem;
-	else
-		func =3D arch_timer_handler_phys_mem;
-
-	ret =3D request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_me=
m->evt);
-	if (ret) {
-		pr_err("Failed to request mem timer irq\n");
-		kfree(arch_timer_mem);
-		arch_timer_mem =3D NULL;
-	}
-
-	return ret;
-}
-
-static const struct of_device_id arch_timer_of_match[] __initconst =3D {
-	{ .compatible   =3D "arm,armv7-timer",    },
-	{ .compatible   =3D "arm,armv8-timer",    },
-	{},
-};
-
-static const struct of_device_id arch_timer_mem_of_match[] __initconst =3D {
-	{ .compatible   =3D "arm,armv7-timer-mem", },
-	{},
-};
-
-static bool __init arch_timer_needs_of_probing(void)
-{
-	struct device_node *dn;
-	bool needs_probing =3D false;
-	unsigned int mask =3D ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
-
-	/* We have two timers, and both device-tree nodes are probed. */
-	if ((arch_timers_present & mask) =3D=3D mask)
-		return false;
-
-	/*
-	 * Only one type of timer is probed,
-	 * check if we have another type of timer node in device-tree.
-	 */
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
-		dn =3D of_find_matching_node(NULL, arch_timer_mem_of_match);
-	else
-		dn =3D of_find_matching_node(NULL, arch_timer_of_match);
-
-	if (dn && of_device_is_available(dn))
-		needs_probing =3D true;
-
-	of_node_put(dn);
-
-	return needs_probing;
-}
-
 static int __init arch_timer_common_init(void)
 {
-	arch_timer_banner(arch_timers_present);
-	arch_counter_register(arch_timers_present);
+	arch_timer_banner();
+	arch_counter_register();
 	return arch_timer_arch_init();
 }
=20
@@ -1421,13 +1132,11 @@ static int __init arch_timer_of_init(struct device_no=
de *np)
 	u32 rate;
 	bool has_names;
=20
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
+	if (arch_timer_evt) {
 		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
=20
-	arch_timers_present |=3D ARCH_TIMER_TYPE_CP15;
-
 	has_names =3D of_property_present(np, "interrupt-names");
=20
 	for (i =3D ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
@@ -1472,283 +1181,22 @@ static int __init arch_timer_of_init(struct device_n=
ode *np)
 	if (ret)
 		return ret;
=20
-	if (arch_timer_needs_of_probing())
-		return 0;
-
 	return arch_timer_common_init();
 }
 TIMER_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 TIMER_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
=20
-static u32 __init
-arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
-{
-	void __iomem *base;
-	u32 rate;
-
-	base =3D ioremap(frame->cntbase, frame->size);
-	if (!base) {
-		pr_err("Unable to map frame @ %pa\n", &frame->cntbase);
-		return 0;
-	}
-
-	rate =3D readl_relaxed(base + CNTFRQ);
-
-	iounmap(base);
-
-	return rate;
-}
-
-static struct arch_timer_mem_frame * __init
-arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame, *best_frame =3D NULL;
-	void __iomem *cntctlbase;
-	u32 cnttidr;
-	int i;
-
-	cntctlbase =3D ioremap(timer_mem->cntctlbase, timer_mem->size);
-	if (!cntctlbase) {
-		pr_err("Can't map CNTCTLBase @ %pa\n",
-			&timer_mem->cntctlbase);
-		return NULL;
-	}
-
-	cnttidr =3D readl_relaxed(cntctlbase + CNTTIDR);
-
-	/*
-	 * Try to find a virtual capable frame. Otherwise fall back to a
-	 * physical capable frame.
-	 */
-	for (i =3D 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		u32 cntacr =3D CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
-
-		frame =3D &timer_mem->frame[i];
-		if (!frame->valid)
-			continue;
-
-		/* Try enabling everything, and see what sticks */
-		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
-		cntacr =3D readl_relaxed(cntctlbase + CNTACR(i));
-
-		if ((cnttidr & CNTTIDR_VIRT(i)) &&
-		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
-			best_frame =3D frame;
-			arch_timer_mem_use_virtual =3D true;
-			break;
-		}
-
-		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
-			continue;
-
-		best_frame =3D frame;
-	}
-
-	iounmap(cntctlbase);
-
-	return best_frame;
-}
-
-static int __init
-arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
-{
-	void __iomem *base;
-	int ret, irq;
-
-	if (arch_timer_mem_use_virtual)
-		irq =3D frame->virt_irq;
-	else
-		irq =3D frame->phys_irq;
-
-	if (!irq) {
-		pr_err("Frame missing %s irq.\n",
-		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		return -EINVAL;
-	}
-
-	if (!request_mem_region(frame->cntbase, frame->size,
-				"arch_mem_timer"))
-		return -EBUSY;
-
-	base =3D ioremap(frame->cntbase, frame->size);
-	if (!base) {
-		pr_err("Can't map frame's registers\n");
-		return -ENXIO;
-	}
-
-	ret =3D arch_timer_mem_register(base, irq);
-	if (ret) {
-		iounmap(base);
-		return ret;
-	}
-
-	arch_timers_present |=3D ARCH_TIMER_TYPE_MEM;
-
-	return 0;
-}
-
-static int __init arch_timer_mem_of_init(struct device_node *np)
-{
-	struct arch_timer_mem *timer_mem;
-	struct arch_timer_mem_frame *frame;
-	struct resource res;
-	int ret =3D -EINVAL;
-	u32 rate;
-
-	timer_mem =3D kzalloc(sizeof(*timer_mem), GFP_KERNEL);
-	if (!timer_mem)
-		return -ENOMEM;
-
-	if (of_address_to_resource(np, 0, &res))
-		goto out;
-	timer_mem->cntctlbase =3D res.start;
-	timer_mem->size =3D resource_size(&res);
-
-	for_each_available_child_of_node_scoped(np, frame_node) {
-		u32 n;
-		struct arch_timer_mem_frame *frame;
-
-		if (of_property_read_u32(frame_node, "frame-number", &n)) {
-			pr_err(FW_BUG "Missing frame-number.\n");
-			goto out;
-		}
-		if (n >=3D ARCH_TIMER_MEM_MAX_FRAMES) {
-			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
-			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
-			goto out;
-		}
-		frame =3D &timer_mem->frame[n];
-
-		if (frame->valid) {
-			pr_err(FW_BUG "Duplicated frame-number.\n");
-			goto out;
-		}
-
-		if (of_address_to_resource(frame_node, 0, &res))
-			goto out;
-
-		frame->cntbase =3D res.start;
-		frame->size =3D resource_size(&res);
-
-		frame->virt_irq =3D irq_of_parse_and_map(frame_node,
-						       ARCH_TIMER_VIRT_SPI);
-		frame->phys_irq =3D irq_of_parse_and_map(frame_node,
-						       ARCH_TIMER_PHYS_SPI);
-
-		frame->valid =3D true;
-	}
-
-	frame =3D arch_timer_mem_find_best_frame(timer_mem);
-	if (!frame) {
-		pr_err("Unable to find a suitable frame in timer @ %pa\n",
-			&timer_mem->cntctlbase);
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	rate =3D arch_timer_mem_frame_get_cntfrq(frame);
-	arch_timer_of_configure_rate(rate, np);
-
-	ret =3D arch_timer_mem_frame_register(frame);
-	if (!ret && !arch_timer_needs_of_probing())
-		ret =3D arch_timer_common_init();
-out:
-	kfree(timer_mem);
-	return ret;
-}
-TIMER_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
-		       arch_timer_mem_of_init);
-
 #ifdef CONFIG_ACPI_GTDT
-static int __init
-arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame;
-	u32 rate;
-	int i;
-
-	for (i =3D 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		frame =3D &timer_mem->frame[i];
-
-		if (!frame->valid)
-			continue;
-
-		rate =3D arch_timer_mem_frame_get_cntfrq(frame);
-		if (rate =3D=3D arch_timer_rate)
-			continue;
-
-		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
-			&frame->cntbase,
-			(unsigned long)rate, (unsigned long)arch_timer_rate);
-
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init arch_timer_mem_acpi_init(int platform_timer_count)
-{
-	struct arch_timer_mem *timers, *timer;
-	struct arch_timer_mem_frame *frame, *best_frame =3D NULL;
-	int timer_count, i, ret =3D 0;
-
-	timers =3D kcalloc(platform_timer_count, sizeof(*timers),
-			    GFP_KERNEL);
-	if (!timers)
-		return -ENOMEM;
-
-	ret =3D acpi_arch_timer_mem_init(timers, &timer_count);
-	if (ret || !timer_count)
-		goto out;
-
-	/*
-	 * While unlikely, it's theoretically possible that none of the frames
-	 * in a timer expose the combination of feature we want.
-	 */
-	for (i =3D 0; i < timer_count; i++) {
-		timer =3D &timers[i];
-
-		frame =3D arch_timer_mem_find_best_frame(timer);
-		if (!best_frame)
-			best_frame =3D frame;
-
-		ret =3D arch_timer_mem_verify_cntfrq(timer);
-		if (ret) {
-			pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
-			goto out;
-		}
-
-		if (!best_frame) /* implies !frame */
-			/*
-			 * Only complain about missing suitable frames if we
-			 * haven't already found one in a previous iteration.
-			 */
-			pr_err("Unable to find a suitable frame in timer @ %pa\n",
-				&timer->cntctlbase);
-	}
-
-	if (best_frame)
-		ret =3D arch_timer_mem_frame_register(best_frame);
-out:
-	kfree(timers);
-	return ret;
-}
-
-/* Initialize per-processor generic timer and memory-mapped timer(if present=
) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	int ret, platform_timer_count;
+	int ret;
=20
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
+	if (arch_timer_evt) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
=20
-	arch_timers_present |=3D ARCH_TIMER_TYPE_CP15;
-
-	ret =3D acpi_gtdt_init(table, &platform_timer_count);
+	ret =3D acpi_gtdt_init(table, NULL);
 	if (ret)
 		return ret;
=20
@@ -1790,10 +1238,6 @@ static int __init arch_timer_acpi_init(struct acpi_tab=
le_header *table)
 	if (ret)
 		return ret;
=20
-	if (platform_timer_count &&
-	    arch_timer_mem_acpi_init(platform_timer_count))
-		pr_err("Failed to initialize memory-mapped timer.\n");
-
 	return arch_timer_common_init();
 }
 TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_a=
rch_timer.h
index ce6521a..2eda895 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -9,9 +9,6 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
=20
-#define ARCH_TIMER_TYPE_CP15		BIT(0)
-#define ARCH_TIMER_TYPE_MEM		BIT(1)
-
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -51,8 +48,6 @@ enum arch_timer_spi_nr {
=20
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
-#define ARCH_TIMER_MEM_PHYS_ACCESS	2
-#define ARCH_TIMER_MEM_VIRT_ACCESS	3
=20
 #define ARCH_TIMER_MEM_MAX_FRAMES	8
=20

