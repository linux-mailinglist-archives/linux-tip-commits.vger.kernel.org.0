Return-Path: <linux-tip-commits+bounces-1824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923549410C3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69131C23293
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41419E828;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqmqXFko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aclNVMxZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306719885F;
	Tue, 30 Jul 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339602; cv=none; b=Arx70m+EkgufAlzv4f/okEdImIXzJo7I3i7ClfP8FtV7LAN5uEeiqyTGJi+eDSJmuBVZwJyJLZxGKHc8rraIIDAq1bTVb+r64JMLQGQJENlrp+DDAeFnf6d50ITQ4XtNdGTc0GM2XWTngdkgoaTwRo6f2RFYou2fT3OD4YOJpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339602; c=relaxed/simple;
	bh=H+Kp6kyUydnXVJhVXjNIfYfm1X9kg8ndwspzwGW/4KQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qk8mZi3IEHhLZ4r+ItMa9/97M3exMFfdn3RXm1jE0S42PyRvbYPHnxDFObrH7YYWXKdQeOR9n1iNVoYyom+n4kJvvMiabmwLHG8pUPGZSybafEgXzICcyH0uk5je90gb3IolV1jhAOpzfoM5PvbvdBs4UmXIMQCyONB+8Or6Yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqmqXFko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aclNVMxZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBsbWsHyx6NXs2mucfxa2fPq5MhtQEszz3nelaOXNfo=;
	b=yqmqXFko6E/2ug668CgwLleleRS2/PflUCv4LWF9GU2i5mUhoIXezcHAof8FOUTM+Sz2Ro
	P2s3cOGZH7i0FQx5afyI2ELEWDuXgsXq143s7MmF0JD8KIhn0BDda1Y9WSQ1ol3FFuOL2h
	u0PeOsrpVa7hmOtkdq8zQE1gefCugwY25pFfpfG2m5qux8hr7wRgF4KljfHApw24IsIXf5
	IHEhk4Pq3mDVk9hOcLc6uv5f595k/TIJh7oUfiEFSCX9VzHsMD5EJ9M8hauyldrhWNKs4R
	Xhwe4Op6N9L94qutmLOINuRlMZFWpE3gVySw/b3EHy9w1BEADCv0fPzUT1DlNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBsbWsHyx6NXs2mucfxa2fPq5MhtQEszz3nelaOXNfo=;
	b=aclNVMxZp7Y52PHIstIR2A28p94Feb+m1Grr+LUBrYtMWX/zbMT87AwERuc4iJKv9dNRIV
	WcUHUlyBnDr5IFBQ==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Remove asmlinkage for handlers registered
 with set_handle_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240729112606.1581732-1-ruanjinjie@huawei.com>
References: <20240729112606.1581732-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959718.2215.11290343671136753768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b8fb82e4ffec3da153a6100d4cd6229fbfd3a22c
Gitweb:        https://git.kernel.org/tip/b8fb82e4ffec3da153a6100d4cd6229fbfd3a22c
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Mon, 29 Jul 2024 19:26:06 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:49 +02:00

irqchip: Remove asmlinkage for handlers registered with set_handle_irq()

All architectures with use set_handle_irq() to set the root chip interrupt
handler call that handler from C code, so there's no need for these
handlers to be marked asmlinkage.

Remove asmlinkage for all handlers registered with set_handle_irq().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/all/20240729112606.1581732-1-ruanjinjie@huawei.com


---
 drivers/irqchip/irq-atmel-aic.c       | 3 +--
 drivers/irqchip/irq-atmel-aic5.c      | 3 +--
 drivers/irqchip/irq-clps711x.c        | 2 +-
 drivers/irqchip/irq-davinci-cp-intc.c | 3 +--
 drivers/irqchip/irq-ftintc010.c       | 2 +-
 drivers/irqchip/irq-gic-v3.c          | 2 +-
 drivers/irqchip/irq-ixp4xx.c          | 3 +--
 drivers/irqchip/irq-omap-intc.c       | 3 +--
 drivers/irqchip/irq-sa11x0.c          | 3 +--
 drivers/irqchip/irq-versatile-fpga.c  | 2 +-
 10 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 4631f68..3839ad7 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -57,8 +57,7 @@
 
 static struct irq_domain *aic_domain;
 
-static asmlinkage void __exception_irq_entry
-aic_handle(struct pt_regs *regs)
+static void __exception_irq_entry aic_handle(struct pt_regs *regs)
 {
 	struct irq_domain_chip_generic *dgc = aic_domain->gc;
 	struct irq_chip_generic *gc = dgc->gc[0];
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535b..c0f55dc 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -67,8 +67,7 @@
 
 static struct irq_domain *aic5_domain;
 
-static asmlinkage void __exception_irq_entry
-aic5_handle(struct pt_regs *regs)
+static void __exception_irq_entry aic5_handle(struct pt_regs *regs)
 {
 	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(aic5_domain, 0);
 	u32 irqnr;
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index e731e07..806ebb1 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -69,7 +69,7 @@ static struct {
 	struct irq_domain_ops	ops;
 } *clps711x_intc;
 
-static asmlinkage void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
+static void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
 {
 	u32 irqstat;
 
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
index 7482c8e..f4f8e9f 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -116,8 +116,7 @@ static struct irq_chip davinci_cp_intc_irq_chip = {
 	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
-static asmlinkage void __exception_irq_entry
-davinci_cp_intc_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry davinci_cp_intc_handle_irq(struct pt_regs *regs)
 {
 	int gpir, irqnr, none;
 
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 359efc1..b91c358 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -125,7 +125,7 @@ static struct irq_chip ft010_irq_chip = {
 /* Local static for the IRQ entry call */
 static struct ft010_irq_data firq;
 
-static asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
 {
 	struct ft010_irq_data *f = &firq;
 	int irq;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c19083b..0efa344 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -930,7 +930,7 @@ static void __gic_handle_irq_from_irqsoff(struct pt_regs *regs)
 	__gic_handle_nmi(irqnr, regs);
 }
 
-static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	if (unlikely(gic_supports_nmi() && !interrupts_enabled(regs)))
 		__gic_handle_irq_from_irqsoff(regs);
diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 5fba907..f23b02f 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -105,8 +105,7 @@ static void ixp4xx_irq_unmask(struct irq_data *d)
 	}
 }
 
-static asmlinkage void __exception_irq_entry
-ixp4xx_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
 {
 	struct ixp4xx_irq *ixi = &ixirq;
 	unsigned long status;
diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index dc82162..ad84a2f 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -325,8 +325,7 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
 	return ret;
 }
 
-static asmlinkage void __exception_irq_entry
-omap_intc_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry omap_intc_handle_irq(struct pt_regs *regs)
 {
 	extern unsigned long irq_err_count;
 	u32 irqnr;
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
index 31c202a..9d0b802 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -127,8 +127,7 @@ static int __init sa1100irq_init_devicefs(void)
 
 device_initcall(sa1100irq_init_devicefs);
 
-static asmlinkage void __exception_irq_entry
-sa1100_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
 {
 	uint32_t icip, icmr, mask;
 
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 5018a06..ca471c6 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -128,7 +128,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
  * Keep iterating over all registered FPGA IRQ controllers until there are
  * no pending interrupts.
  */
-static asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
 {
 	int i, handled;
 

