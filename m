Return-Path: <linux-tip-commits+bounces-3342-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E801A2BD6C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Feb 2025 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A387C1695DA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Feb 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC02343D2;
	Fri,  7 Feb 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjBNHNEP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ia3gtQ78"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FC2343BC;
	Fri,  7 Feb 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915309; cv=none; b=npGLVE0w5hahvD195YtxBiLhnq1xYPUY0aa1AEUHKrTiPd/gOXqMMnrbgysRMU6LMaT4Eb8AE6cHm2LI4dxH4PPkZ9mcNfAIO8oQAq323mwXWV4sAHtO1yhPN5AD+SWx1l8CAolKPjlPstNiGa0ZgLVowdfxTWw11pVrohsPyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915309; c=relaxed/simple;
	bh=3rMvWoOtLaJ+Z7QqaoajsG/OrJLXOM4xY3HYD1xa47A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cNemxOm3KJW/Lw7aT3Ul/MuWI9U0G497v2evfT2iF9Y6FFdGX4M4To1OG6eZUohHTlyD3+5QRBE8v17YFm7NPjlOLQllQZv0Z/awdQYlm0mnu/M58dwtC2+faLpXrnEFHhTUsaBwzvwnTnnNisHGMyT/wnd9hZHWU1Tacu/tuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjBNHNEP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ia3gtQ78; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Feb 2025 08:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738915304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sW48a3cSmmR2FFjdA4oXHlDwP0T7kF+57GaD0UDVPKk=;
	b=rjBNHNEP/dtTvBOq0NtCMnjRXaPNU42R3yVqILpo7JfT7UZwaXxH/fo7QgwpSi+g537Fw2
	lDWleo6xZ/oXN7xldYdQAg+NWV+58xqaKkVM4FcZezCds0tOZ10OiuAQqvXTzqj0QQwVIZ
	PbeERWbdNz6GnZrk5iJKCWQWtopMmwCtDuv9Fa7UOPklHbUXjvmbkbsFDFXx+48j4Mabhe
	20or2dMXeY/Lfjjig4rIlV7cKemEMMrKtodRCziSPTdi0Pm60bSDe9lRovjycAFRpMsC2U
	uWUaB3A6FRWXoqv/Y9C6MAv1Hd0mTnt5YVwfm7qJCqdFCeoBUyPYmud54z4lAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738915304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sW48a3cSmmR2FFjdA4oXHlDwP0T7kF+57GaD0UDVPKk=;
	b=Ia3gtQ78//TIIHqfJ1ZwU6PUjZFaPFgWPaacSvPg+l5HY7lDqyU907neiyf+Lyi4p5kWme
	9s93fQ41cS/zLOCw==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Remove leading space from
 irq_chip::irq_print_chip() callbacks
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C893f7e9646d8933cd6786d5a1ef3eb076d263768=2E17387?=
 =?utf-8?q?64803=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C893f7e9646d8933cd6786d5a1ef3eb076d263768=2E173876?=
 =?utf-8?q?4803=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173891530013.10177.8122884860301721928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     29a61a1f40637ae010b828745fb41f60301c3a3d
Gitweb:        https://git.kernel.org/tip/29a61a1f40637ae010b828745fb41f60301c3a3d
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 05 Feb 2025 15:22:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Feb 2025 08:56:01 +01:00

genirq: Remove leading space from irq_chip::irq_print_chip() callbacks

The space separator was factored out from the multiple chip name prints,
but several irq_chip::irq_print_chip() callbacks still print a leading
space.  Remove the superfluous double spaces.

Fixes: 9d9f204bdf7243bf ("genirq/proc: Add missing space separator back")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/893f7e9646d8933cd6786d5a1ef3eb076d263768.1738764803.git.geert+renesas@glider.be

---
 arch/powerpc/sysdev/fsl_msi.c          | 2 +-
 drivers/bus/moxtet.c                   | 2 +-
 drivers/irqchip/irq-partition-percpu.c | 2 +-
 drivers/soc/qcom/smp2p.c               | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 1aa0cb0..7b9a5ea 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -75,7 +75,7 @@ static void fsl_msi_print_chip(struct irq_data *irqd, struct seq_file *p)
 	srs = (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK;
 	cascade_virq = msi_data->cascade_array[srs]->virq;
 
-	seq_printf(p, " fsl-msi-%d", cascade_virq);
+	seq_printf(p, "fsl-msi-%d", cascade_virq);
 }
 
 
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 6276551..1e57ebf 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -657,7 +657,7 @@ static void moxtet_irq_print_chip(struct irq_data *d, struct seq_file *p)
 
 	id = moxtet->modules[pos->idx];
 
-	seq_printf(p, " moxtet-%s.%i#%i", mox_module_name(id), pos->idx,
+	seq_printf(p, "moxtet-%s.%i#%i", mox_module_name(id), pos->idx,
 		   pos->bit);
 }
 
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 8e76d29..4441ffe 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -98,7 +98,7 @@ static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
 	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
 	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
 
-	seq_printf(p, " %5s-%lu", chip->name, data->hwirq);
+	seq_printf(p, "%5s-%lu", chip->name, data->hwirq);
 }
 
 static struct irq_chip partition_irq_chip = {
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 4783ab1..a3e88ce 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -365,7 +365,7 @@ static void smp2p_irq_print_chip(struct irq_data *irqd, struct seq_file *p)
 {
 	struct smp2p_entry *entry = irq_data_get_irq_chip_data(irqd);
 
-	seq_printf(p, " %8s", dev_name(entry->smp2p->dev));
+	seq_printf(p, "%8s", dev_name(entry->smp2p->dev));
 }
 
 static struct irq_chip smp2p_irq_chip = {

