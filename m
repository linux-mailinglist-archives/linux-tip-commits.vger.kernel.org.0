Return-Path: <linux-tip-commits+bounces-1495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8E913C65
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9AD282306
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86C1836C9;
	Sun, 23 Jun 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="01/BOlzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ws9TaSpU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AF183062;
	Sun, 23 Jun 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156635; cv=none; b=SWKjmBjvbrgDaXRxBW1cGkhVVTumdwIooloLfY03OjOQxLKnFhqknRi1sUCspgSVnaApLoZO6F9v5KjAplWUhEjMkTC3qsCDgLp7zIMXu7XBmPXm9RKa6f0vgm7DvFI8fx0hhwzVdq6dHUyCoqKaTSgM2BQ1RTRfIRl5cv6GAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156635; c=relaxed/simple;
	bh=cPWnJKlEq/y8yHdBQ02QH1AV+xGWcIzxChjkDYqWhGk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SL92+bJEfDpX+YUp/Tczd8yGyiq2xqozrsV1vTl3p0OhOyBeur00ae9s1vxftQ0ErGRaGJA4pmhPxheUL0H3kaxjNwJBAwBe7pMwUyRQVdAtWOyhcMNcsFSyvUGXeWdhsjng2rribMOzcvCh5ZPK67l7zv24YDuvKE6q0zLGpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=01/BOlzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ws9TaSpU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXTVerW/QvKm3OULcbwiBYVU4Gr8sYpFSVNaynawIT4=;
	b=01/BOlzSbRUQ0rVs+MQPZMzzZIrUbV8rjVzQjdcHk9dDC+E6iL5UN/C3p+PlkiAfEHdMsJ
	YOGOp19yqxYfahO72SWy9wVwDVVrQmSA5RXslpcQ5mbWVU4qIEZ4ExccKI8M/g0fq1gfWN
	2jAFgyV12QJnXHiqFB/d01+2H7YC3FR7ydlS9YjC4iYVB9v9scKHxiNsS7WwV73gSRKn4O
	DuJH3MKkM97rR+Yux+781VgxmllTSDiQ6Le+VgeQLqR/CCO50EWSX8vZsgiTGgcU+7TNC9
	UV3Zr/PfmXIKiIJriq5cfiYCEXVuP4NIVLDPYkgM3MeB+ylWjrUQDKN23UU+9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXTVerW/QvKm3OULcbwiBYVU4Gr8sYpFSVNaynawIT4=;
	b=ws9TaSpUFo3VzAx/T8slXUOUBxhHsY5gEE3CxV29TVXMBivMbD0ZuFTRyTGja7Yjxaleqm
	q0W1g0C+23lWMaAA==
From: "tip-bot2 for Jeff Johnson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add missing MODULE_DESCRIPTION() macros
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240608-md-drivers-irqchip-v1-1-dd02c3229277@quicinc.com>
References: <20240608-md-drivers-irqchip-v1-1-dd02c3229277@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662949.10875.14795836348233091091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b1c387506d2738b655f0806d3ee3e6fc94ecb910
Gitweb:        https://git.kernel.org/tip/b1c387506d2738b655f0806d3ee3e6fc94ecb910
Author:        Jeff Johnson <quic_jjohnson@quicinc.com>
AuthorDate:    Sat, 08 Jun 2024 09:14:37 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip: Add missing MODULE_DESCRIPTION() macros

On x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/irqchip/irq-ts4800.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/irqchip/irq-meson-gpio.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().  This includes a 3rd file,
irq-mvebu-pic.c, which did not produce a warning with the x86
allmodconfig, but which may cause this warning with other kernel
configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240608-md-drivers-irqchip-v1-1-dd02c3229277@quicinc.com

---
 drivers/irqchip/irq-meson-gpio.c | 1 +
 drivers/irqchip/irq-mvebu-pic.c  | 1 +
 drivers/irqchip/irq-ts4800.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 9a17919..27e30ce 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -608,5 +608,6 @@ IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
 IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
 
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_DESCRIPTION("Meson GPIO Interrupt Multiplexer driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:meson-gpio-intc");
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index d17d9c0..08b0cc8 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -193,6 +193,7 @@ module_platform_driver(mvebu_pic_driver);
 
 MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Armada 7K/8K PIC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:mvebu_pic");
 
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 57f610d..b5dddb3 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -163,5 +163,6 @@ static struct platform_driver ts4800_ic_driver = {
 module_platform_driver(ts4800_ic_driver);
 
 MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
+MODULE_DESCRIPTION("Multiplexed-IRQs driver for TS-4800's FPGA");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:ts4800_irqc");

