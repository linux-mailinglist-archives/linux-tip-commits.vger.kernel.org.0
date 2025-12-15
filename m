Return-Path: <linux-tip-commits+bounces-7716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB31CC003B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AA16301D4E8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80F3112B0;
	Mon, 15 Dec 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xay8leHh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hM+pyuRv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5830AD11;
	Mon, 15 Dec 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835222; cv=none; b=NacjEu5elnXUGf76aLHwbEF9vkUufDTT9JefNFiyurkksmGJ4vCZsVg7v3AnBJhC3MqSVTe3VgOyWSU1F5vwNBf6eIwfu6zU2Z4GD07azsN0VqGEEgtig+zgiJnaZ4IsIZv3KgLvobDXw0eUeAES4jlp0f4caQpG+Vcpr1yhFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835222; c=relaxed/simple;
	bh=U+i8vM5U2U6Bo7+AZAFwKexzm7KkbS20xbHhLdkomNU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jW2SwNNIAvHRrCu1OgCzTp3jMvUmEZffnReNzD5w2iSQrLdib+dO/OiPQZ5vGPM7FNNgIpmALH8Wpkeohuku4UwrXmWJevqVORw2gtBL2e17xQm5mKWXs9WU10CMUfsR93z+wkbopPfH6RETGmUCwXkayMeFzaJEbbEY2w0sH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xay8leHh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hM+pyuRv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:46:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lOKA/cUY8TVp7fYPZ5/ZsfDIWMf7PrHAexsf3ukYps=;
	b=Xay8leHhg+YHw/hPoVu4hjS8b9CU2CmMj5/heRvP2X6A/gX+ZGoTo/mcjyDTvFDu+rhvua
	ETwfpo1hqodn2n22sMjBT9zWewc4SehOjU5aR4bZbfNz8u0xtqq2rRjVxLm5NGlg0Do/wk
	rhMbc8c/ctOg/hMk5nYjmKwoyZnQ4dRzS4Hrn9nDs4k7CNibjWEwn7ApN8O8TuL7ooJpSR
	BkFtNuGWNC5bWOxVtNXNcO6Bm8D+sXKs2FNyY7qjyXeznmhrobEIVQNGjESdLvZeXkDdXz
	KRAuYXT2I2qlHx4VHZKeh82zugZd6bYaBbtXCwq5/iKQFNxzGhwbYvGbmjregg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lOKA/cUY8TVp7fYPZ5/ZsfDIWMf7PrHAexsf3ukYps=;
	b=hM+pyuRvADdgYCeZ57lLQrKVPmD7XfAn7MxEHDRXoZxWAK+oh8V4cIsa9mf3eZkMv1elWk
	4ymk7HaDAYyBo3Cg==
From: "tip-bot2 for Nick Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-imsic: Add a CPU pm notifier to
 restore the IMSIC on exit
Cc: Nick Hu <nick.hu@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Yong-Xuan Wang" <yongxuan.wang@sifive.com>, Cyan Yang <cyan.yang@sifive.com>,
 Anup Patel <anup@brainfault.org>, Nutty Liu <liujingqi@lanxincomputing.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251202-preserve-aplic-imsic-v3-1-1844fbf1fe92@sifive.com>
References: <20251202-preserve-aplic-imsic-v3-1-1844fbf1fe92@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583521790.510.1665731901615507646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f48b4bd0915bf61ac12b8c65c7939ebd03bc8abf
Gitweb:        https://git.kernel.org/tip/f48b4bd0915bf61ac12b8c65c7939ebd03b=
c8abf
Author:        Nick Hu <nick.hu@sifive.com>
AuthorDate:    Tue, 02 Dec 2025 14:07:40 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:33 +01:00

irqchip/riscv-imsic: Add a CPU pm notifier to restore the IMSIC on exit

The IMSIC might be reset when the system enters a low power state, but on
exit nothing restores the registers, which prevents interrupt delivery.

Solve this by registering a CPU power management notifier, which restores
the IMSIC on exit.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Link: https://patch.msgid.link/20251202-preserve-aplic-imsic-v3-1-1844fbf1fe9=
2@sifive.com
---
 drivers/irqchip/irq-riscv-imsic-early.c | 39 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
index 6bac67c..ba903fa 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "riscv-imsic: " fmt
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -123,14 +124,8 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
=20
-static int imsic_starting_cpu(unsigned int cpu)
+static void imsic_hw_states_init(void)
 {
-	/* Mark per-CPU IMSIC state as online */
-	imsic_state_online();
-
-	/* Enable per-CPU parent interrupt */
-	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
-
 	/* Setup IPIs */
 	imsic_ipi_starting_cpu();
=20
@@ -142,6 +137,18 @@ static int imsic_starting_cpu(unsigned int cpu)
=20
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
+}
+
+static int imsic_starting_cpu(unsigned int cpu)
+{
+	/* Mark per-CPU IMSIC state as online */
+	imsic_state_online();
+
+	/* Enable per-CPU parent interrupt */
+	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
+
+	/* Initialize the IMSIC registers to enable the interrupt delivery */
+	imsic_hw_states_init();
=20
 	return 0;
 }
@@ -157,6 +164,22 @@ static int imsic_dying_cpu(unsigned int cpu)
 	return 0;
 }
=20
+static int imsic_pm_notifier(struct notifier_block *self, unsigned long cmd,=
 void *v)
+{
+	switch (cmd) {
+	case CPU_PM_EXIT:
+		/* Initialize the IMSIC registers to enable the interrupt delivery */
+		imsic_hw_states_init();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block imsic_pm_notifier_block =3D {
+	.notifier_call =3D imsic_pm_notifier,
+};
+
 static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 {
 	struct irq_domain *domain;
@@ -194,7 +217,7 @@ static int __init imsic_early_probe(struct fwnode_handle =
*fwnode)
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:s=
tarting",
 			  imsic_starting_cpu, imsic_dying_cpu);
=20
-	return 0;
+	return cpu_pm_register_notifier(&imsic_pm_notifier_block);
 }
=20
 static int __init imsic_early_dt_init(struct device_node *node, struct devic=
e_node *parent)

