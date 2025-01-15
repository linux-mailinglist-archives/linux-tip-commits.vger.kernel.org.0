Return-Path: <linux-tip-commits+bounces-3214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D3A11D22
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9583C1694DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D822F38F;
	Wed, 15 Jan 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y2Bse96m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4UFAbLsL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB91EEA4B;
	Wed, 15 Jan 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932587; cv=none; b=ROfMuB9or9A6wWfmB74Q38jyKhRU7Q42C6FpiunQdV+2GKaOgMvKmHrcuwStgYxYQuZkdVSWVP3DqDmp9UzNAvUzLVebFi6euKVYe8dGo24PNy/q+bsUkaAOT6wnU4nxsWuVnYj+3Ms4HVNhY0G5xqkI6dXCarcJvSAc1NW5Z6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932587; c=relaxed/simple;
	bh=GddAL766DLQhiodGCQ6V2hoJKzkNTfAVmlRf8iZboqA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VBW0ABkOHCYZ+IDUeLy2gN+st8DPPzecWg3PtNnq4A5r8meoscJBrb8osoP7hucfFTMUx3ZxqBSJnLS4gsk3y4aCND80a1YU2d34sS7wbqU8tRa1BMRkjPx1qiPS9pATTbAjGJRgH0aFbe37zn4IJV50qQ78hYffQtX9HtK0j9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y2Bse96m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4UFAbLsL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9ezqglHHazpNwdlkteT9DVMVL1H9hDLvjDUeCQIiHk=;
	b=y2Bse96mdqb34TzP8GIp/dB23d5+76EhT2E1GfvRULl9O3CnkmXn3/ffk0T885P4yBcOFa
	kueHzDCedV2zHF68b3FzGnJ8kTDBEMFxRBdNvQr7dBUl2tr4ZoxVj/LVJ+Te6Aexmo3K4d
	GIWRE6kfz9/VKZYYTYWEKcyzaVduvfDOC2OsvEhZ5zbQhKWuc8FXTaUHmyDfuf+jUmKiqa
	cxf/rNGrPy14+hMOX4GXPOnwJdgs2Ru5RxwFClAa4E3AnrcJnYM/2YfnL+4cIjGUKKfsm+
	+kUxhTo3dUriXFIdkgwh+uJ2yX9giV8Gh5GGK7StKrP+801htDpDZejcCnwoGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9ezqglHHazpNwdlkteT9DVMVL1H9hDLvjDUeCQIiHk=;
	b=4UFAbLsLOAKoNUrDcyhT4N0tNBxj7/ByiZP5YNu5ib6rkOLuPvmeUOlFtDz6hSZaXZjGrh
	d4CrhPTmbHBFZeAg==
From: "tip-bot2 for Philippe Simons" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sunxi-nmi: Add missing SKIP_WAKE flag
Cc: Philippe Simons <simons.philippe@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250112123402.388520-1-simons.philippe@gmail.com>
References: <20250112123402.388520-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257795.31546.843088760165157310.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     3a748d483d80f066ca4b26abe45cdc0c367d13e9
Gitweb:        https://git.kernel.org/tip/3a748d483d80f066ca4b26abe45cdc0c367d13e9
Author:        Philippe Simons <simons.philippe@gmail.com>
AuthorDate:    Sun, 12 Jan 2025 13:34:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:42:45 +01:00

irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Some boards with Allwinner SoCs connect the PMIC's IRQ pin to the SoC's NMI
pin instead of a normal GPIO. Since the power key is connected to the PMIC,
and people expect to wake up a suspended system via this key, the NMI IRQ
controller must stay alive when the system goes into suspend.

Add the SKIP_WAKE flag to prevent the sunxi NMI controller from going to
sleep, so that the power key can wake up those systems.

[ tglx: Fixed up coding style ]

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250112123402.388520-1-simons.philippe@gmail.com

---
 drivers/irqchip/irq-sunxi-nmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index bb92fd8..0b43121 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -186,7 +186,8 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED;
+	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+						  IRQCHIP_SKIP_SET_WAKE;
 	gc->chip_types[0].regs.ack		= reg_offs->pend;
 	gc->chip_types[0].regs.mask		= reg_offs->enable;
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;

