Return-Path: <linux-tip-commits+bounces-7717-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE89CC0038
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C93C73011EDC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0032692B;
	Mon, 15 Dec 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ptsiCJk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJzDKbkG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0232E7F03;
	Mon, 15 Dec 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835222; cv=none; b=CW1p5Ea9fCvM3pv8IoJ1KrRqGYJoXeCIjrU2/XB302FtNhDMbEPE8WjXwNgWtwLRnCj3JblGwc0MRcGQqe5M+aW6HyyWlGBnkdU/tVGdRW2rplAp9qXpMPm6OrXlyTGyhjHnuLbe1J0Z26HFJij42i2OzNJwBERRXE8Td/o8DwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835222; c=relaxed/simple;
	bh=BlbuezDTIxrP+DvdlLH/61w4LdM6MsBFOqHu+if7JJE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EfOASNS6ykMWfiBgtWg6frmqRGfigzXf6h699Gm77Cp+/9pjF6mSi6NEZQpfWbfqT1iLLv6P3fZfRmVuMMaVM/rxOWnT5JCW0TjMCJPzap6DAUORq0tVEBHQklVFbcKhSd7th43ytSyDS64otfZkD86B6yuhUC6p/U+m3gKTyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ptsiCJk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJzDKbkG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:46:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFyw3codx/WOENuOJ6wIpyb7EKNgTs5fb5q7MNpQ5e0=;
	b=3ptsiCJk6QsW9iuklwEunVclHHYKnvm7BZv8bzSBZ2i466Ffk8lPF6AUY2pS91iW9PDt1i
	+UcvdV85EVn7q9tdRxMgWD+aGFTrEs5r/itAGSC7txjZ0LCjFYBLG+LNYL7QAu5LKSMsPx
	n4bjK8UXsDiKkH0QQmwysbZdYvjmXduOr2gXJ8aTGr/WceFFem2ExIZPUGpFfNPkXy634Q
	FLMDCvbf+S0mPWVQIT4SmadFqbvxYp7CDGwSW7Lw1fPlTomF3KB8kaf2CdGRiMhKfPHU+m
	RBeSuTtFgbJD4vI6UXiRBiSw/QsKgXLfSJhw01gyEScIC/RlOHn+YZL3s29VOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFyw3codx/WOENuOJ6wIpyb7EKNgTs5fb5q7MNpQ5e0=;
	b=aJzDKbkGYjWQfpb0ABzruS7SWcai8IyDwdy4Y2MohukMcIDTS55RVL85Ahe8zUQA5n5Csy
	g82UnmZNcC4/fAAA==
From: "tip-bot2 for Nick Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-aplic: Preserve APLIC states across
 suspend/resume
Cc: Nick Hu <nick.hu@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Yong-Xuan Wang" <yongxuan.wang@sifive.com>, Cyan Yang <cyan.yang@sifive.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251202-preserve-aplic-imsic-v3-2-1844fbf1fe92@sifive.com>
References: <20251202-preserve-aplic-imsic-v3-2-1844fbf1fe92@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583521667.510.12414622767226459620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     1c546bb4336188439c8486bd7472d4aa7b6d3585
Gitweb:        https://git.kernel.org/tip/1c546bb4336188439c8486bd7472d4aa7b6=
d3585
Author:        Nick Hu <nick.hu@sifive.com>
AuthorDate:    Tue, 02 Dec 2025 14:07:41 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:33 +01:00

irqchip/riscv-aplic: Preserve APLIC states across suspend/resume

The APLIC states might be reset when the platform enters a low power
state, but the register states are not being preserved and restored,
which prevents interrupt delivery after the platform resumes.
Solve this by adding a syscore ops and a power management notifier to
preserve and restore the APLIC states on suspend and resume.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://patch.msgid.link/20251202-preserve-aplic-imsic-v3-2-1844fbf1fe9=
2@sifive.com
---
 drivers/irqchip/irq-riscv-aplic-direct.c |  10 +-
 drivers/irqchip/irq-riscv-aplic-main.c   | 166 +++++++++++++++++++++-
 drivers/irqchip/irq-riscv-aplic-main.h   |  19 +++-
 3 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-r=
iscv-aplic-direct.c
index c2a75bf..5a96502 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
@@ -171,6 +172,15 @@ static void aplic_idc_set_delivery(struct aplic_idc *idc=
, bool en)
 	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
 }
=20
+void aplic_direct_restore_states(struct aplic_priv *priv)
+{
+	struct aplic_direct *direct =3D container_of(priv, struct aplic_direct, pri=
v);
+	int cpu;
+
+	for_each_cpu(cpu, &direct->lmask)
+		aplic_idc_set_delivery(per_cpu_ptr(&aplic_idcs, cpu), true);
+}
+
 static int aplic_direct_dying_cpu(unsigned int cpu)
 {
 	if (aplic_direct_parent_irq)
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
index 93e7c51..b760942 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -12,10 +12,165 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
+#include <linux/syscore_ops.h>
=20
 #include "irq-riscv-aplic-main.h"
=20
+static LIST_HEAD(aplics);
+
+static void aplic_restore_states(struct aplic_priv *priv)
+{
+	struct aplic_saved_regs *saved_regs =3D &priv->saved_hw_regs;
+	struct aplic_src_ctrl *srcs;
+	void __iomem *regs;
+	u32 nr_irqs, i;
+
+	regs =3D priv->regs;
+	writel(saved_regs->domaincfg, regs + APLIC_DOMAINCFG);
+#ifdef CONFIG_RISCV_M_MODE
+	writel(saved_regs->msiaddr, regs + APLIC_xMSICFGADDR);
+	writel(saved_regs->msiaddrh, regs + APLIC_xMSICFGADDRH);
+#endif
+	/*
+	 * The sourcecfg[i] has to be restored prior to the target[i], interrupt-pe=
nding and
+	 * interrupt-enable bits. The AIA specification states that "Whenever inter=
rupt source i is
+	 * inactive in an interrupt domain, the corresponding interrupt-pending and=
 interrupt-enable
+	 * bits within the domain are read-only zeros, and register target[i] is al=
so read-only
+	 * zero."
+	 */
+	nr_irqs =3D priv->nr_irqs;
+	for (i =3D 0; i < nr_irqs; i++) {
+		srcs =3D &priv->saved_hw_regs.srcs[i];
+		writel(srcs->sourcecfg, regs + APLIC_SOURCECFG_BASE + i * sizeof(u32));
+		writel(srcs->target, regs + APLIC_TARGET_BASE + i * sizeof(u32));
+	}
+
+	for (i =3D 0; i <=3D nr_irqs; i +=3D 32) {
+		srcs =3D &priv->saved_hw_regs.srcs[i];
+		writel(-1U, regs + APLIC_CLRIE_BASE + (i / 32) * sizeof(u32));
+		writel(srcs->ie, regs + APLIC_SETIE_BASE + (i / 32) * sizeof(u32));
+
+		/* Re-trigger the interrupts if it forwards interrupts to target harts by =
MSIs */
+		if (!priv->nr_idcs)
+			writel(readl(regs + APLIC_CLRIP_BASE + (i / 32) * sizeof(u32)),
+			       regs + APLIC_SETIP_BASE + (i / 32) * sizeof(u32));
+	}
+
+	if (priv->nr_idcs)
+		aplic_direct_restore_states(priv);
+}
+
+static void aplic_save_states(struct aplic_priv *priv)
+{
+	struct aplic_src_ctrl *srcs;
+	void __iomem *regs;
+	u32 i, nr_irqs;
+
+	regs =3D priv->regs;
+	nr_irqs =3D priv->nr_irqs;
+	/* The valid interrupt source IDs range from 1 to N, where N is priv->nr_ir=
qs */
+	for (i =3D 0; i < nr_irqs; i++) {
+		srcs =3D &priv->saved_hw_regs.srcs[i];
+		srcs->target =3D readl(regs + APLIC_TARGET_BASE + i * sizeof(u32));
+
+		if (i % 32)
+			continue;
+
+		srcs->ie =3D readl(regs + APLIC_SETIE_BASE + (i / 32) * sizeof(u32));
+	}
+
+	/* Save the nr_irqs bit if needed */
+	if (!(nr_irqs % 32)) {
+		srcs =3D &priv->saved_hw_regs.srcs[nr_irqs];
+		srcs->ie =3D readl(regs + APLIC_SETIE_BASE + (nr_irqs / 32) * sizeof(u32));
+	}
+}
+
+static int aplic_syscore_suspend(void)
+{
+	struct aplic_priv *priv;
+
+	list_for_each_entry(priv, &aplics, head)
+		aplic_save_states(priv);
+
+	return 0;
+}
+
+static void aplic_syscore_resume(void)
+{
+	struct aplic_priv *priv;
+
+	list_for_each_entry(priv, &aplics, head)
+		aplic_restore_states(priv);
+}
+
+static struct syscore_ops aplic_syscore_ops =3D {
+	.suspend =3D aplic_syscore_suspend,
+	.resume =3D aplic_syscore_resume,
+};
+
+static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action=
, void *data)
+{
+	struct aplic_priv *priv =3D container_of(nb, struct aplic_priv, genpd_nb);
+
+	switch (action) {
+	case GENPD_NOTIFY_PRE_OFF:
+		aplic_save_states(priv);
+		break;
+	case GENPD_NOTIFY_ON:
+		aplic_restore_states(priv);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void aplic_pm_remove(void *data)
+{
+	struct aplic_priv *priv =3D data;
+	struct device *dev =3D priv->dev;
+
+	list_del(&priv->head);
+	if (dev->pm_domain)
+		dev_pm_genpd_remove_notifier(dev);
+}
+
+static int aplic_pm_add(struct device *dev, struct aplic_priv *priv)
+{
+	struct aplic_src_ctrl *srcs;
+	int ret;
+
+	srcs =3D devm_kzalloc(dev, (priv->nr_irqs + 1) * sizeof(*srcs), GFP_KERNEL);
+	if (!srcs)
+		return -ENOMEM;
+
+	priv->saved_hw_regs.srcs =3D srcs;
+	list_add(&priv->head, &aplics);
+	if (dev->pm_domain) {
+		priv->genpd_nb.notifier_call =3D aplic_pm_notifier;
+		ret =3D dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
+		if (ret)
+			goto remove_head;
+
+		ret =3D devm_pm_runtime_enable(dev);
+		if (ret)
+			goto remove_notifier;
+	}
+
+	return devm_add_action_or_reset(dev, aplic_pm_remove, priv);
+
+remove_notifier:
+	dev_pm_genpd_remove_notifier(dev);
+remove_head:
+	list_del(&priv->head);
+	return ret;
+}
+
 void aplic_irq_unmask(struct irq_data *d)
 {
 	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
@@ -60,6 +215,8 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int ty=
pe)
 	sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
 	writel(val, sourcecfg);
=20
+	priv->saved_hw_regs.srcs[d->hwirq - 1].sourcecfg =3D val;
+
 	return 0;
 }
=20
@@ -82,6 +239,7 @@ int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u=
32 gsi_base,
=20
 void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
 {
+	struct aplic_saved_regs *saved_regs =3D &priv->saved_hw_regs;
 	u32 val;
 #ifdef CONFIG_RISCV_M_MODE
 	u32 valh;
@@ -95,6 +253,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool ms=
i_mode)
 		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
 		writel(val, priv->regs + APLIC_xMSICFGADDR);
 		writel(valh, priv->regs + APLIC_xMSICFGADDRH);
+		saved_regs->msiaddr =3D val;
+		saved_regs->msiaddrh =3D valh;
 	}
 #endif
=20
@@ -106,6 +266,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool m=
si_mode)
 	writel(val, priv->regs + APLIC_DOMAINCFG);
 	if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
 		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
+
+	saved_regs->domaincfg =3D val;
 }
=20
 static void aplic_init_hw_irqs(struct aplic_priv *priv)
@@ -176,7 +338,7 @@ int aplic_setup_priv(struct aplic_priv *priv, struct devi=
ce *dev, void __iomem *
 	/* Setup initial state APLIC interrupts */
 	aplic_init_hw_irqs(priv);
=20
-	return 0;
+	return aplic_pm_add(dev, priv);
 }
=20
 static int aplic_probe(struct platform_device *pdev)
@@ -209,6 +371,8 @@ static int aplic_probe(struct platform_device *pdev)
 	if (rc)
 		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
 			      msi_mode ? "MSI" : "direct");
+	else
+		register_syscore_ops(&aplic_syscore_ops);
=20
 #ifdef CONFIG_ACPI
 	if (!acpi_disabled)
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-ris=
cv-aplic-main.h
index b0ad8cd..2d8ad71 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -23,7 +23,25 @@ struct aplic_msicfg {
 	u32			lhxw;
 };
=20
+struct aplic_src_ctrl {
+	u32			sourcecfg;
+	u32			target;
+	u32			ie;
+};
+
+struct aplic_saved_regs {
+	u32			domaincfg;
+#ifdef CONFIG_RISCV_M_MODE
+	u32			msiaddr;
+	u32			msiaddrh;
+#endif
+	struct aplic_src_ctrl	*srcs;
+};
+
 struct aplic_priv {
+	struct list_head	head;
+	struct notifier_block	genpd_nb;
+	struct aplic_saved_regs	saved_hw_regs;
 	struct device		*dev;
 	u32			gsi_base;
 	u32			nr_irqs;
@@ -40,6 +58,7 @@ int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u3=
2 gsi_base,
 			      unsigned long *hwirq, unsigned int *type);
 void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs);
+void aplic_direct_restore_states(struct aplic_priv *priv);
 int aplic_direct_setup(struct device *dev, void __iomem *regs);
 #ifdef CONFIG_RISCV_APLIC_MSI
 int aplic_msi_setup(struct device *dev, void __iomem *regs);

