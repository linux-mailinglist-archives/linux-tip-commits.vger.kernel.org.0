Return-Path: <linux-tip-commits+bounces-5974-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8FAF0497
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 22:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F193B8A49
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17083264A76;
	Tue,  1 Jul 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpnSlRYN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBxcp+lt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D625D53C;
	Tue,  1 Jul 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401025; cv=none; b=OwVGv3oBpqw9GpPQSzo73DbLhcAfAYqMtPDmlqUezmk8+uebfq9AJGee0zECRjzOalK2ItspA08SbHo+aTfwo3GQncUSIEHuLIynjIpACR1JgVwXZ4dBYUaCOvlNSDcIUPDN+5rip1pxJnkVMvXFPZLVlXs4L4PfYwmD1xM2ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401025; c=relaxed/simple;
	bh=8IPawSjEI+IQRM3V7xIkdJ2/YD0+dJq78sMHXUzZ3co=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PlvZcPQuNOdBufYsOyLBSTV4hEKE+Pxv2zWgz2ycI5vYw3g5qrKeiFVsrsxpDD99qfN+OCvI765vmehXW7ifloXdGQkSFkxPiQh38CS1dciFskQrNn8Zs1OeTK/Z4WjkBwOv/ZovgJ1a2l6i04CJ0MXz8uQxb9T28trYE7pGZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpnSlRYN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBxcp+lt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 20:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751401020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HLAiTVB1cg3fAKh7mfOYKDCDvHVAis4174dvm6CiW8=;
	b=YpnSlRYN+2QmmoyVXhuVZpOwOWHLAH3/zyNhtIHi4Q/eRkVKBs1j9awmPZ2SY74WSY1Wbi
	leapKuxQg84NQdzcFc6R/CppoWOvx+yC/c/8C/AkTA2EgGuEDEWUgxonaqnKM8xf7ZG3Fe
	B67oHYaOfZlWprL5BwCAsTSHW15FS8kKzEuF9yB1Yr9CfEEeZpYnxBzp/0v8ltgaoMA1ht
	09l3U7hrF0VBcaNbweD5zIrVraEUPL1JCSVCx92fCxrIl3fkGAwy6cI2D01K2NXzaqMVpD
	/quWzaYfTz5upfW2RUvX4UZ7y256f3HVfO5EDvd43ahpCAJEz+d4UCWZ3tv/jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751401020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HLAiTVB1cg3fAKh7mfOYKDCDvHVAis4174dvm6CiW8=;
	b=sBxcp+ltoVjcrjJ+OEcOMqGjOkTzgLR/5Ftn7zjTT5laPiFo4L8pKuCbWceNdpYw4qvedA
	PY8SHDKp7J85+mDQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and
 MASK_ON_SUSPEND
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250701105923.52151-1-biju.das.jz@bp.renesas.com>
References: <20250701105923.52151-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175140101942.406.18213547229156452587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     de2942828e7670526289f098df7e50b112e8ff1e
Gitweb:        https://git.kernel.org/tip/de2942828e7670526289f098df7e50b112e8ff1e
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 01 Jul 2025 11:59:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 22:13:32 +02:00

irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

The interrupt controller found on RZ/G3E doesn't provide any facility to
configure the wakeup sources. That's the reason why the driver lacks the
irq_set_wake() callback for the interrupt chip.

But this prevent to properly enter power management states like "suspend to
idle".

Enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND so the
interrupt suspend logic can handle the chip correctly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250701105923.52151-1-biju.das.jz@bp.renesas.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 57c5a3c..3daa5de 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -427,7 +427,9 @@ static const struct irq_chip rzv2h_icu_chip = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= rzv2h_icu_set_type,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs,

