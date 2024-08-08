Return-Path: <linux-tip-commits+bounces-2009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D594C0FB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9B1C20D71
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE511917FB;
	Thu,  8 Aug 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xas9bJvV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk/gyvpB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F769190693;
	Thu,  8 Aug 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130508; cv=none; b=ByxFiGVZTjgGkAhc631SljwtqnV5Vjt9titzFtohW+M8OeMPEs0/AS7G9hVbf63+QQGdiAMVq1AD5QIDbtXUjy0TBGvJknemu1O8Dnigjq277f3VhOuDv4I/X/f1XYQGF6RaV8+lLqhKmB+iX7LW5V00dVXYDt1XbHeDBhvsW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130508; c=relaxed/simple;
	bh=KPeRS63BSD2Jv1enE63C8ujJLM6HjA60A90Mf8jwhvM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DUIaLkdc0uwbVA4tUsQeMal+gjxB0O0wR2YzETlu9G/N9sKZhW8wsDAObCCoaUEgwWJrLI3nM4f/YXjOpSKUf/R8YaI2Kj7+2lks126Y6n8WuVMG6jGvEdW9YPIBhllWjhQVGXgnMYLgRw6PkxMc48lRd0GkLBrYj1VWKqnduYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xas9bJvV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk/gyvpB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kQNKqE9rrs9uCbBXCPNYonYTXJ6bZeG7iV7JlTqqMhI=;
	b=Xas9bJvVw5+KHk+HGn6/THCxcRpIM/W9zzvptLvNqh2atjOQ/+t6JclwXA7NBmf2VcYNDT
	HNK3ji/vkqMfLN2HfmcJEJQo+oWaQp+mcFPRIiXGSqes7fR799X6VYSippgbrRNf5wHX+o
	eAb/Kq5zsqgK/rTAFMx/PGYUwohNlhi+w8BqqXnbFakr+TG1d0bsXfMuq/xtstW095LN7r
	EI9vl6Mxb2vIcA5ulhSmK9m16+pr0NG0yOlBCwuhFx0l0wgSRtnRGO1pqjk7kTTIZ0PxFg
	rngN7TtSmnisJ8vcOdSAv7VeKNwqmYIsyj54RT+43DqOdaRWLHuLYer/CkffSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kQNKqE9rrs9uCbBXCPNYonYTXJ6bZeG7iV7JlTqqMhI=;
	b=mk/gyvpBsheOxo2XhCnGRy5OZbe11+iyw9/xY/0Y5lD5jjvPJzeCsy1fx8Um3VyfFSQpOf
	zI48icPB92Zq4zBg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Fix reenabling last per-CPU interrupt
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
  <stable+noautosel@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050375.2215.2940684759508404994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2793f68749c1fb035e255cdffb10108ef023f608
Gitweb:        https://git.kernel.org/tip/2793f68749c1fb035e255cdffb10108ef02=
3f608
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:41:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

irqchip/armada-370-xp: Fix reenabling last per-CPU interrupt

The number of per-CPU interrupts is 29 (0 to 28). This is described by
the constant MPIC_MAX_PER_CPU_IRQS, set to 28 (the maximum per-CPU
interrupt).

Commit 0fa4ce746d1d ("irqchip/armada-370-xp: Re-enable per-CPU
interrupts at resume time") used the constant incorrectly in the
for-loop, it used the operator < instead of <=3D, causing it to iterate
only the first 28 interrupts (0 to 27), ignoring the last, 28th,
per-CPU interrupt.

To avoid this kind of confusions, fix this issue by renaming the constant
to MPIC_PER_CPU_IRQS_NR and set it to 29, the number of per-CPU IRQs.
Update its use in mpic_is_percpu_irq() accordingly.

Fixes: 0fa4ce746d1d ("irqchip/armada-370-xp: Re-enable per-CPU interrupts at =
resume time")
Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable+noautosel@kernel.org> # The 29th interrupt is not used in any dev=
ice-tree
---
 drivers/irqchip/irq-armada-370-xp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index f8658a2..83afc3a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -133,7 +133,7 @@
 #define MPIC_INT_FABRIC_MASK			0x54
 #define MPIC_INT_CAUSE_PERF(cpu)		BIT(cpu)
=20
-#define MPIC_MAX_PER_CPU_IRQS			28
+#define MPIC_PER_CPU_IRQS_NR			29
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
 #define IPI_DOORBELL_NR				8
@@ -202,7 +202,7 @@ static inline bool mpic_is_ipi_available(struct mpic *mpi=
c)
=20
 static inline bool mpic_is_percpu_irq(irq_hw_number_t hwirq)
 {
-	return hwirq <=3D MPIC_MAX_PER_CPU_IRQS;
+	return hwirq < MPIC_PER_CPU_IRQS_NR;
 }
=20
 /*
@@ -545,7 +545,7 @@ static void mpic_smp_cpu_init(struct mpic *mpic)
 static void mpic_reenable_percpu(struct mpic *mpic)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
-	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
+	for (irq_hw_number_t i =3D 0; i < MPIC_PER_CPU_IRQS_NR; i++) {
 		unsigned int virq =3D irq_linear_revmap(mpic->domain, i);
 		struct irq_data *d;
=20

