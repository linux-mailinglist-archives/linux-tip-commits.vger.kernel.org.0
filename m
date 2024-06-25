Return-Path: <linux-tip-commits+bounces-1546-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB077917130
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B01C22556
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4A17C7CD;
	Tue, 25 Jun 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFrP/vLD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aw2oLBI5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AE143882;
	Tue, 25 Jun 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344455; cv=none; b=MehKTwTaVY89eKTmGvorE3cuJFuBCzCmu9xO3Ra7TeAUJKk+MC04BP9kSJJmPzaIdyv4FzNa/44nYe+nT49iNa+rz+PKgzkaDTc1Dr/KAxBOOTMRTjxoDwZIdhD6LCHIzhhzdjT4zbnfc7lbFtSx7BxHZ7tNB0mxreuQ3+aHG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344455; c=relaxed/simple;
	bh=fMMIPl+SPYzwOMoL8dqMiSlysIzgNns93YOy0fa+Fjw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Pi/cubVdu2RDJMfThvGTLcppY5Cpe61PxtDOdyKtFsQmvC9g2KniqYyvqXn5sXFAI3x/wI7BnYLp/2oheiMlAzXCVUKOeQPExlCFhy+n2JWOpovTC6VW+V6JGrhXDpDrapD1z6qmC3iHsLraHeUfPE2W40T5yWi6RXt7w5z+emU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFrP/vLD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aw2oLBI5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 19:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719344451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ehh6XZSBVUDBjoPODQn4J/hu5q+WHdb+JvpPc9J45nI=;
	b=tFrP/vLDkyXvtUA2yHOIw2WCQDMGhYrvx9BxZc5q0l66+3TNHZNEJ3ISvfEpKHH+Nazg6f
	q/nHtQXpcbNeaIgsvrk3M5EHbPhwWcZ4/JJoFMB3oit9esL+qYqwbdBVIHY5MX/qb+z6r8
	oR9Rx38ax4eleM2AliICfWMtzkESLJW+G3k3Ame+j/Qax3RTXPAVqSBgDYlwj+rpL8cHII
	ovi38J8ayPmc6yPDG8ZhltuwuAKNkxESPv/qllVe0cDHfkZX7qTkZjm1tFxPs2ucRhqrwa
	zi6nwYhk4fMN0JLfun/+uzcQuYjZoCFxW64qm6jH9FrtOnIHMzlSavAa5kOYmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719344451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ehh6XZSBVUDBjoPODQn4J/hu5q+WHdb+JvpPc9J45nI=;
	b=aw2oLBI5ukAUjNotNIb9utc+0DXetqdN0jSzfyqQzEGTllJLhxBCt2Y1uWu3eax7ik+U+0
	F8g7p5hb2OBooKDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] Revert "irqchip/dw-apb-ictl: Support building as module"
Cc: Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jisheng Zhang <jszhang@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171934445127.2215.3526597621538197010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     be5e5f3a1120bada0cff1bc84c2a1805da308f6e
Gitweb:        https://git.kernel.org/tip/be5e5f3a1120bada0cff1bc84c2a1805da308f6e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Jun 2024 21:30:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Jun 2024 21:30:48 +02:00

Revert "irqchip/dw-apb-ictl: Support building as module"

This reverts commit 7cc4f309c933ec5d64eea31066fe86bbf9e48819.

Causes build fails.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <jszhang@kernel.org>
https://lore.kernel.org/oe-kbuild-all/202406250214.WZEjWnnU-lkp@intel.com/
---
 drivers/irqchip/Kconfig           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cbf49b6..344c484 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -145,7 +145,7 @@ config DAVINCI_CP_INTC
 	select IRQ_DOMAIN
 
 config DW_APB_ICTL
-	tristate "DesignWare APB Interrupt Controller"
+	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN_HIERARCHY
 
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 5eda6c4..d5c1c75 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -122,7 +122,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	int ret, nrirqs, parent_irq, i;
 	u32 reg;
 
-	if (!parent && IS_BUILTIN(CONFIG_DW_APB_ICTL)) {
+	if (!parent) {
 		/* Used as the primary interrupt controller */
 		parent_irq = 0;
 		domain_ops = &dw_apb_ictl_irq_domain_ops;
@@ -214,12 +214,5 @@ err_release:
 	release_mem_region(r.start, resource_size(&r));
 	return ret;
 }
-#if IS_BUILTIN(CONFIG_DW_APB_ICTL)
-IRQCHIP_DECLARE(dw_apb_ictl, "snps,dw-apb-ictl", dw_apb_ictl_init);
-#else
-IRQCHIP_PLATFORM_DRIVER_BEGIN(dw_apb_ictl)
-IRQCHIP_MATCH("snps,dw-apb-ictl", dw_apb_ictl_init)
-IRQCHIP_PLATFORM_DRIVER_END(dw_apb_ictl)
-MODULE_DESCRIPTION("DesignWare APB Interrupt Controller");
-MODULE_LICENSE("GPL v2");
-#endif
+IRQCHIP_DECLARE(dw_apb_ictl,
+		"snps,dw-apb-ictl", dw_apb_ictl_init);

