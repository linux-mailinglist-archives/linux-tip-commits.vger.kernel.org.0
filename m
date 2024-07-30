Return-Path: <linux-tip-commits+bounces-1832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B69410CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0ED1C23777
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F31991C9;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cha7yN4B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuHlT9jp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832719F478;
	Tue, 30 Jul 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339605; cv=none; b=kESsSwNOPnI7wy3aX5Ycb0nk6LSB2IWsX7zUN6yoysoHmIUWt0daYjz9P6mm7ABuxRiPMTd5PvzVzRpWLl+zGJRn5oanLIzI550PjZcKJYCwDhVk3tKSnmuhqbmmg8YPkHyxRLlpTN5WNZvebk5LTCVoTncy/GJdWfB73KlCPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339605; c=relaxed/simple;
	bh=7IwWojJ0e2r3CS4hm72MVcK8ZEKSUUjC5azBUFUHjo4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qww4EOp0Jd/Wd7OfoJOVWplPmP9y3Tn2NwS0gypUfgY8JZCyXPWh2tiqKyQj6XTzjVhFSv4rZeuNRmfJvmWzEr2d9knUPtxnXv+ZhSFOoNg2kLBKCeIOyp+3SXNCPKXc4Zi9Rkc6/Z+HkUaOLQ67KoX97kzxkHaeQcfSxEJelD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cha7yN4B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuHlT9jp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92tqhReCSunvEinzZ+hQXV6RGSA9uglH7iuVxinPlbk=;
	b=cha7yN4BL+DBJR0LVKkqxPf8h2FyrVILXyVmQ+yI7QdHvNf/t7By9gLOinbuE/FgtZMcI4
	osnh640i+HS5kmP7ufTlR6o9x2VL5MnZ4tN2zatUPn2pmADz6zUPEZozn252CtXNhiGn84
	nkje0zZ1eGfivsTlXL4KxORfHr2cmHbGz/Cf3F0oxWd91HtpynNPsTfqnk1TORUBCS7EwF
	aBDFep8h5w6J0W9DlzLMhb2m+JniE+pV+pp83jQSJh/HcCsPDtfbSbX/c/+2C1oYJqMiUk
	ihJUXnpelCGaDxvvb+nAJYq3KEeVMCuOKtJqtamlJAkGJ8GjD8IGFpJYvly3tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92tqhReCSunvEinzZ+hQXV6RGSA9uglH7iuVxinPlbk=;
	b=XuHlT9jpSzD7m32YRgVEgPChIYi0YUD2YVI5w6NZlrMmJe12X7XP90tC8KZW6C8AXQ//FG
	XRCnBNYlVl5YwzAA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Don't read number of supported
 interrupts multiple times
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-8-kabel@kernel.org>
References: <20240711115748.30268-8-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960054.2215.13758750324090897274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5ecafc9a640f7c1e5690375cf3a82848d669abb9
Gitweb:        https://git.kernel.org/tip/5ecafc9a640f7c1e5690375cf3a82848d66=
9abb9
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:47 +02:00

irqchip/armada-370-xp: Don't read number of supported interrupts multiple tim=
es

Use mpic_domain::hwirq_max at runtime instead of reading the same value
over and over from the MPIC_INT_CONTROL register.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-8-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 2758834..e43eb26 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -494,13 +494,7 @@ static int mpic_set_affinity(struct irq_data *d, const s=
truct cpumask *mask_val,
=20
 static void mpic_smp_cpu_init(void)
 {
-	u32 control;
-	int nr_irqs;
-
-	control =3D readl(main_int_base + MPIC_INT_CONTROL);
-	nr_irqs =3D (control >> 2) & 0x3ff;
-
-	for (int i =3D 0; i < nr_irqs; i++)
+	for (int i =3D 0; i < mpic_domain->hwirq_max; i++)
 		writel(i, per_cpu_int_base + MPIC_INT_SET_MASK);
=20
 	if (!mpic_is_ipi_available())
@@ -706,10 +700,9 @@ static int mpic_suspend(void)
 static void mpic_resume(void)
 {
 	bool src0, src1;
-	int nirqs;
+
 	/* Re-enable interrupts */
-	nirqs =3D (readl(main_int_base + MPIC_INT_CONTROL) >> 2) & 0x3ff;
-	for (irq_hw_number_t irq =3D 0; irq < nirqs; irq++) {
+	for (irq_hw_number_t irq =3D 0; irq < mpic_domain->hwirq_max; irq++) {
 		struct irq_data *data;
 		unsigned int virq;
=20

