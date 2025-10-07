Return-Path: <linux-tip-commits+bounces-6777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A37BC09FA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 07 Oct 2025 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2F3B443A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  7 Oct 2025 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487802D3228;
	Tue,  7 Oct 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbjH5PVP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IfyEnCiV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535861E489;
	Tue,  7 Oct 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825677; cv=none; b=GGYZj8RVozQi23XRyQoSor0KO9pPPvuGZnFRjSV87aauLppOqaqwnXjqg4gUnMKMH9672gYnRvvjqAtPh8HDdBo0HY1B9aj1tHBqKzfsxtQHSLA4OIE+AonRhU63zQnn7zHwmkkSKqcTZqM053otbUnO/xqFIwAmCz/TpsraUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825677; c=relaxed/simple;
	bh=mcwX9e2XpR+pKZYpPMxaohb83Nu0wV+MSEamq/f25Ro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DZXhFqcsQAvkIaqjOX4VbYBzBitq+9sLkATQIDjcgqDWciTXj9CxoJTY+vXWKXlvwWUP159+Edarrzp7MEEYqrYRDG+3Mu4xaS5nGOhYLwjW7kDn+qXPKfc/drQdBt/jjSUWdnlFf1I3RVy+eDf/BHU4EGLxx0vwtgqaB6Za/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbjH5PVP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IfyEnCiV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 07 Oct 2025 08:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759825673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3l8+zpDz9JZXRXJrmWxHI7/Ps+nQNQUM2rCKs+/NQE=;
	b=wbjH5PVPGGbT7/Ook8BI4R//MjRSGplIyAotA9R+EvMgYunXvj8RiROo/UmJyqkpPivHmw
	QI9mjgDDDMiGXZFt5RCJIE5Z3AI+uRDBtUGS0ZhwjHhjJELobyTI2te6XbdvKsnFxEK4ZJ
	WU7UGV2TQDCFglqheAioTBHC9OtOkZKIxdqugnllo+zVLYtc5GeThO53syinakbGXY2kKk
	SY83P+aijyeIl3m5mbNqHHuotglvGfEoJQlKwiFWZRam601E9p+A88ksqdkOvUMTWe5edR
	pxRtue/5EvDE5Iy7fA093PYst0+OVJCvdA2zJOuPF3EmT/aQYBfmKBoZhg75DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759825673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3l8+zpDz9JZXRXJrmWxHI7/Ps+nQNQUM2rCKs+/NQE=;
	b=IfyEnCiV942A7HoB1Ccb8T08f1CoeJzNYUY55Msb6VvlKKx7EtW+3hxBlcVwBwwVxCvGeb
	BUVX1hlTDlaVbQDw==
From: "tip-bot2 for Lucas Zampieri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Avoid interrupt ID 0 handling
 during suspend/resume
Cc: Jia Wang <wangjia@ultrarisc.com>, Charles Mirabile <cmirabil@redhat.com>,
 Lucas Zampieri <lzampier@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250923144319.955868-1-lzampier@redhat.com>
References: <20250923144319.955868-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175982566785.709179.17178660704346674375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f75e07bf5226da640fa99a0594687c780d9bace4
Gitweb:        https://git.kernel.org/tip/f75e07bf5226da640fa99a0594687c780d9=
bace4
Author:        Lucas Zampieri <lzampier@redhat.com>
AuthorDate:    Tue, 23 Sep 2025 15:43:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 07 Oct 2025 10:23:22 +02:00

irqchip/sifive-plic: Avoid interrupt ID 0 handling during suspend/resume

According to the PLIC specification[1], global interrupt sources are
assigned small unsigned integer identifiers beginning at the value 1.
An interrupt ID of 0 is reserved to mean "no interrupt".

The current plic_irq_resume() and plic_irq_suspend() functions incorrectly
start the loop from index 0, which accesses the register space for the
reserved interrupt ID 0.

Change the loop to start from index 1, skipping the reserved
interrupt ID 0 as per the PLIC specification.

This prevents potential undefined behavior when accessing the reserved
register space during suspend/resume cycles.

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibe=
rnation")
Co-developed-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Co-developed-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 559fda8..cbd7697 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -254,7 +254,8 @@ static int plic_irq_suspend(void)
=20
 	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
=20
-	for (i =3D 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i =3D 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
@@ -285,7 +286,8 @@ static void plic_irq_resume(void)
=20
 	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
=20
-	for (i =3D 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i =3D 1; i < priv->nr_irqs; i++) {
 		index =3D BIT_WORD(i);
 		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);

