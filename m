Return-Path: <linux-tip-commits+bounces-6736-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36BBA1909
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA17B3A2317
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E9326D69;
	Thu, 25 Sep 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIn1HEDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVTKd2mw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87227326D4D;
	Thu, 25 Sep 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835999; cv=none; b=I4ROhE+0gHrZNsQAQikCpCDah8LNPK2nLQX3WqIwnzsLC6vKRLDO8oxN2MeNp9k7lS8p/WyG784kSiTJOQa+s5dVrafXSVR/BgNgcLKDm0u3K8UfOBotSh+WUXPLhCAjVkn+r5VhU7fjvoT+lP5GzFpMyQe6xMNfOyLH5Oz7Kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835999; c=relaxed/simple;
	bh=LXgwihnG5hX/pxAhmiczqqp3iBUY0PxKVflrh+gjzfA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dqH9Y40T8SWM7F4Jq3QUeyfHpLT6rLHAfZOA3urMmv+b1g+fmR/TPzJreQrC+QwueFT77M0BY1O2W4sGDc2eByOjqxOucl8Ij8J5OzYrVjXrqURlf6rjYya4ljVq4a7K+LBtrkEP0PScp2he3NiXJMX9aMj8IF/hh0T8shfVdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIn1HEDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVTKd2mw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J0S1D2giIxtNa2Wdto3dbewDI2hQv6nUHF05a/UKcMQ=;
	b=hIn1HEDRFNhrwC0r9pb9erbqsFXQe/kGM/T0xdzNUQuFyttHDNFsOoDwPcZLqZluzPjeKw
	XJ6a/Q0zbODjF0XPqKwH6hXcZ93mvnwHsPf0PK2VR16XS0rC8kHHhauKoxLNZk7oD97pIN
	hpttUwiU8BVf1qr+Gsko1lPsAq+GORa5kf7KL0uFZ05RtWGIurweJ6NB2NKJtlFWgR3156
	+ccexzZm6YJ4+42lSXXBFvi8owF63sTFKn9c60WK0YSOAY3ObKWI3k9pd0kyHa7fzZRL6M
	mF7jYhgZvIDkz32gfp2FqrAxuBA5+s1REwYKygt1mPCgpeU1jfcdhC/WUrxltQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J0S1D2giIxtNa2Wdto3dbewDI2hQv6nUHF05a/UKcMQ=;
	b=LVTKd2mwb2uxy1V9EiCMOBlq7ZKVyUrzKQcifMgrfkGWB2ZPDa3HOzwsXrfF6k0fWKdxs2
	4c6QO7X5w5gsDLCg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/arm_arch_timer: Add
 standalone MMIO driver
Cc: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599361.709179.12076890428900333727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     4891f01527bbbb0cf0e515c803ade67a17e247bb
Gitweb:        https://git.kernel.org/tip/4891f01527bbbb0cf0e515c803ade67a17e=
247bb
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 16:46:20 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:31:15 +02:00

clocksource/drivers/arm_arch_timer: Add standalone MMIO driver

Add a new driver for the MMIO side of the ARM architected timer.
Most of it has been lifted from the existing arch timer code,
massaged, and finally rewritten.

It supports both DT and ACPI as firmware descriptions.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250814154622.10193-3-maz@kernel.org
---
 MAINTAINERS                               |   1 +-
 drivers/clocksource/arm_arch_timer_mmio.c | 421 +++++++++++++++++++++-
 2 files changed, 422 insertions(+)
 create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fe16847..2243b72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1990,6 +1990,7 @@ S:	Maintained
 F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
+F:	drivers/clocksource/arm_arch_timer_mmio.c
=20
 ARM GENERIC INTERRUPT CONTROLLER DRIVERS
 M:	Marc Zyngier <maz@kernel.org>
diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/=
arm_arch_timer_mmio.c
new file mode 100644
index 0000000..3522d1d
--- /dev/null
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  ARM Generic Memory Mapped Timer support
+ *
+ *  Split from drivers/clocksource/arm_arch_timer.c
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ */
+
+#define pr_fmt(fmt) 	"arch_timer_mmio: " fmt
+
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#define CNTTIDR		0x08
+#define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
+
+#define CNTACR(n)	(0x40 + ((n) * 4))
+#define CNTACR_RPCT	BIT(0)
+#define CNTACR_RVCT	BIT(1)
+#define CNTACR_RFRQ	BIT(2)
+#define CNTACR_RVOFF	BIT(3)
+#define CNTACR_RWVT	BIT(4)
+#define CNTACR_RWPT	BIT(5)
+
+#define CNTPCT_LO	0x00
+#define CNTVCT_LO	0x08
+#define CNTFRQ		0x10
+#define CNTP_CVAL_LO	0x20
+#define CNTP_CTL	0x2c
+#define CNTV_CVAL_LO	0x30
+#define CNTV_CTL	0x3c
+
+enum arch_timer_access {
+	PHYS_ACCESS,
+	VIRT_ACCESS,
+};
+
+struct arch_timer {
+	struct clock_event_device	evt;
+	struct arch_timer_mem		*gt_block;
+	void __iomem			*base;
+	enum arch_timer_access		access;
+	u32				rate;
+};
+
+#define evt_to_arch_timer(e) container_of(e, struct arch_timer, evt)
+
+static void arch_timer_mmio_write(struct arch_timer *timer,
+				  enum arch_timer_reg reg, u64 val)
+{
+	switch (timer->access) {
+	case PHYS_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed((u32)val, timer->base + CNTP_CTL);
+			return;
+		case ARCH_TIMER_REG_CVAL:
+			/*
+			 * Not guaranteed to be atomic, so the timer
+			 * must be disabled at this point.
+			 */
+			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
+			return;
+		}
+		break;
+	case VIRT_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed((u32)val, timer->base + CNTV_CTL);
+			return;
+		case ARCH_TIMER_REG_CVAL:
+			/* Same restriction as above */
+			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
+			return;
+		}
+		break;
+	}
+
+	/* Should never be here */
+	WARN_ON_ONCE(1);
+}
+
+static u32 arch_timer_mmio_read(struct arch_timer *timer, enum arch_timer_re=
g reg)
+{
+	switch (timer->access) {
+	case PHYS_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			return readl_relaxed(timer->base + CNTP_CTL);
+		default:
+			break;
+		}
+		break;
+	case VIRT_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			return readl_relaxed(timer->base + CNTV_CTL);
+		default:
+			break;
+		}
+		break;
+	}
+
+	/* Should never be here */
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static noinstr u64 arch_counter_mmio_get_cnt(struct arch_timer *t)
+{
+	int offset_lo =3D t->access =3D=3D VIRT_ACCESS ? CNTVCT_LO : CNTPCT_LO;
+	u32 cnt_lo, cnt_hi, tmp_hi;
+
+	do {
+		cnt_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
+		cnt_lo =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
+		tmp_hi =3D __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo +=
 4));
+	} while (cnt_hi !=3D tmp_hi);
+
+	return ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static int arch_timer_mmio_shutdown(struct clock_event_device *clk)
+{
+	struct arch_timer *at =3D evt_to_arch_timer(clk);
+	unsigned long ctrl;
+
+	ctrl =3D arch_timer_mmio_read(at, ARCH_TIMER_REG_CTRL);
+	ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
+	arch_timer_mmio_write(at, ARCH_TIMER_REG_CTRL, ctrl);
+
+	return 0;
+}
+
+static int arch_timer_mmio_set_next_event(unsigned long evt,
+					  struct clock_event_device *clk)
+{
+	struct arch_timer *timer =3D evt_to_arch_timer(clk);
+	unsigned long ctrl;
+	u64 cnt;
+
+	ctrl =3D arch_timer_mmio_read(timer, ARCH_TIMER_REG_CTRL);
+
+	/* Timer must be disabled before programming CVAL */
+	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
+		ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_mmio_write(timer, ARCH_TIMER_REG_CTRL, ctrl);
+	}
+
+	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
+	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
+
+	cnt =3D arch_counter_mmio_get_cnt(timer);
+
+	arch_timer_mmio_write(timer, ARCH_TIMER_REG_CVAL, evt + cnt);
+	arch_timer_mmio_write(timer, ARCH_TIMER_REG_CTRL, ctrl);
+	return 0;
+}
+
+static irqreturn_t arch_timer_mmio_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D dev_id;
+	struct arch_timer *at =3D evt_to_arch_timer(evt);
+	unsigned long ctrl;
+
+	ctrl =3D arch_timer_mmio_read(at, ARCH_TIMER_REG_CTRL);
+	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
+		ctrl |=3D ARCH_TIMER_CTRL_IT_MASK;
+		arch_timer_mmio_write(at, ARCH_TIMER_REG_CTRL, ctrl);
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static struct arch_timer_mem_frame *find_best_frame(struct platform_device *=
pdev)
+{
+	struct arch_timer_mem_frame *frame, *best_frame =3D NULL;
+	struct arch_timer *at =3D platform_get_drvdata(pdev);
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+
+	cntctlbase =3D ioremap(at->gt_block->cntctlbase, at->gt_block->size);
+	if (!cntctlbase) {
+		dev_err(&pdev->dev, "Can't map CNTCTLBase @ %pa\n",
+			&at->gt_block->cntctlbase);
+		return NULL;
+	}
+
+	cnttidr =3D readl_relaxed(cntctlbase + CNTTIDR);
+
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (int i =3D 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		u32 cntacr =3D CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+
+		frame =3D &at->gt_block->frame[i];
+		if (!frame->valid)
+			continue;
+
+		/* Try enabling everything, and see what sticks */
+		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
+		cntacr =3D readl_relaxed(cntctlbase + CNTACR(i));
+
+		/* Pick a suitable frame for which we have an IRQ */
+		if ((cnttidr & CNTTIDR_VIRT(i)) &&
+		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT)) &&
+		    frame->virt_irq) {
+			best_frame =3D frame;
+			at->access =3D VIRT_ACCESS;
+			break;
+		}
+
+		if ((~cntacr & (CNTACR_RWPT | CNTACR_RPCT)) ||
+		     !frame->phys_irq)
+			continue;
+
+		at->access =3D PHYS_ACCESS;
+		best_frame =3D frame;
+	}
+
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
+{
+	at->evt =3D (struct clock_event_device) {
+		.features		   =3D (CLOCK_EVT_FEAT_ONESHOT |
+					      CLOCK_EVT_FEAT_DYNIRQ),
+		.name			   =3D "arch_mem_timer",
+		.rating			   =3D 400,
+		.cpumask		   =3D cpu_possible_mask,
+		.irq 			   =3D irq,
+		.set_next_event		   =3D arch_timer_mmio_set_next_event,
+		.set_state_oneshot_stopped =3D arch_timer_mmio_shutdown,
+		.set_state_shutdown	   =3D arch_timer_mmio_shutdown,
+	};
+
+	at->evt.set_state_shutdown(&at->evt);
+
+	clockevents_config_and_register(&at->evt, at->rate, 0xf,
+					(unsigned long)CLOCKSOURCE_MASK(56));
+
+	enable_irq(at->evt.irq);
+}
+
+static int arch_timer_mmio_frame_register(struct platform_device *pdev,
+					  struct arch_timer_mem_frame *frame)
+{
+	struct arch_timer *at =3D platform_get_drvdata(pdev);
+	struct device_node *np =3D pdev->dev.of_node;
+	int ret, irq;
+	u32 rate;
+
+	if (!devm_request_mem_region(&pdev->dev, frame->cntbase, frame->size,
+				     "arch_mem_timer"))
+		return -EBUSY;
+
+	at->base =3D devm_ioremap(&pdev->dev, frame->cntbase, frame->size);
+	if (!at->base) {
+		dev_err(&pdev->dev, "Can't map frame's registers\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Allow "clock-frequency" to override the probed rate. If neither
+	 * lead to something useful, use the CPU timer frequency as the
+	 * fallback. The nice thing about that last point is that we woudn't
+	 * made it here if we didn't have a valid frequency.
+	 */
+	rate =3D readl_relaxed(at->base + CNTFRQ);
+
+	if (!np || of_property_read_u32(np, "clock-frequency", &at->rate))
+		at->rate =3D rate;
+
+	if (!at->rate)
+		at->rate =3D arch_timer_get_rate();
+
+	irq =3D at->access =3D=3D VIRT_ACCESS ? frame->virt_irq : frame->phys_irq;
+	ret =3D devm_request_irq(&pdev->dev, irq, arch_timer_mmio_handler,
+			       IRQF_TIMER | IRQF_NO_AUTOEN, "arch_mem_timer",
+			       &at->evt);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request mem timer irq\n");
+		return ret;
+	}
+
+	/* Afer this point, we're not allowed to fail anymore */
+	arch_timer_mmio_setup(at, irq);
+	return 0;
+}
+
+static int of_populate_gt_block(struct platform_device *pdev,
+				struct arch_timer *at)
+{
+	struct resource res;
+
+	if (of_address_to_resource(pdev->dev.of_node, 0, &res))
+		return -EINVAL;
+
+	at->gt_block->cntctlbase =3D res.start;
+	at->gt_block->size =3D resource_size(&res);
+
+	for_each_available_child_of_node_scoped(pdev->dev.of_node, frame_node) {
+		struct arch_timer_mem_frame *frame;
+		u32 n;
+
+		if (of_property_read_u32(frame_node, "frame-number", &n)) {
+			dev_err(&pdev->dev, FW_BUG "Missing frame-number\n");
+			return -EINVAL;
+		}
+		if (n >=3D ARCH_TIMER_MEM_MAX_FRAMES) {
+			dev_err(&pdev->dev,
+				FW_BUG "Wrong frame-number, only 0-%u are permitted\n",
+			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
+			return -EINVAL;
+		}
+
+		frame =3D &at->gt_block->frame[n];
+
+		if (frame->valid) {
+			dev_err(&pdev->dev, FW_BUG "Duplicated frame-number\n");
+			return -EINVAL;
+		}
+
+		if (of_address_to_resource(frame_node, 0, &res))
+			return -EINVAL;
+
+		frame->cntbase =3D res.start;
+		frame->size =3D resource_size(&res);
+
+		frame->phys_irq =3D irq_of_parse_and_map(frame_node, 0);
+		frame->virt_irq =3D irq_of_parse_and_map(frame_node, 1);
+
+		frame->valid =3D true;
+	}
+
+	return 0;
+}
+
+static int arch_timer_mmio_probe(struct platform_device *pdev)
+{
+	struct arch_timer_mem_frame *frame;
+	struct arch_timer *at;
+	struct device_node *np;
+	int ret;
+
+	np =3D pdev->dev.of_node;
+
+	at =3D devm_kmalloc(&pdev->dev, sizeof(*at), GFP_KERNEL | __GFP_ZERO);
+	if (!at)
+		return -ENOMEM;
+
+	if (np) {
+		at->gt_block =3D devm_kmalloc(&pdev->dev, sizeof(*at->gt_block),
+					    GFP_KERNEL | __GFP_ZERO);
+		if (!at->gt_block)
+			return -ENOMEM;
+		ret =3D of_populate_gt_block(pdev, at);
+		if (ret)
+			return ret;
+	} else {
+		at->gt_block =3D dev_get_platdata(&pdev->dev);
+	}
+
+	platform_set_drvdata(pdev, at);
+
+	frame =3D find_best_frame(pdev);
+	if (!frame) {
+		dev_err(&pdev->dev,
+			"Unable to find a suitable frame in timer @ %pa\n",
+			&at->gt_block->cntctlbase);
+		return -EINVAL;
+	}
+
+	ret =3D arch_timer_mmio_frame_register(pdev, frame);
+	if (!ret)
+		dev_info(&pdev->dev,
+			 "mmio timer running at %lu.%02luMHz (%s)\n",
+			 (unsigned long)at->rate / 1000000,
+			 (unsigned long)(at->rate / 10000) % 100,
+			 at->access =3D=3D VIRT_ACCESS ? "virt" : "phys");
+
+	return ret;
+}
+
+static const struct of_device_id arch_timer_mmio_of_table[] =3D {
+	{ .compatible =3D "arm,armv7-timer-mem", },
+	{}
+};
+
+static struct platform_driver arch_timer_mmio_drv =3D {
+	.driver	=3D {
+		.name =3D "arch-timer-mmio",
+		.of_match_table	=3D arch_timer_mmio_of_table,
+	},
+	.probe	=3D arch_timer_mmio_probe,
+};
+builtin_platform_driver(arch_timer_mmio_drv);
+
+static struct platform_driver arch_timer_mmio_acpi_drv =3D {
+	.driver	=3D {
+		.name =3D "gtdt-arm-mmio-timer",
+	},
+	.probe	=3D arch_timer_mmio_probe,
+};
+builtin_platform_driver(arch_timer_mmio_acpi_drv);

