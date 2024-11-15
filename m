Return-Path: <linux-tip-commits+bounces-2867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA29CFB4F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Nov 2024 00:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042DD1F223F4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C119004D;
	Fri, 15 Nov 2024 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DEDe0Y20";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtMf0vKV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596251AE01B;
	Fri, 15 Nov 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731714646; cv=none; b=J2DZBX3h1TvgGV+bqaWuKkmngm86VUOjdHv5CBoGwhw1rFdXjXcBmeeN9E3+5jeecLMF6Lrc2M2mar3yTbjP/Y/Kwt75I+I1fimYfYbOqDLMtciT5x8krIMHWo7usZ9PSo/2Ddttpvs8Qt3TD2Uk69iu3YYcseuHtnvfbSwiLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731714646; c=relaxed/simple;
	bh=maBdDELOHQBd+g5+tIPYR6dABYPJfCxmDeyoGZ2b9OQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XH94zounNeyD2Y9hrOODDHZujXXHMo+LLAJi1f1S02SJs8NLD09yW/GHupGLXT2BTGsuBjLEg5DqfTVGha6fOL2GX954w49D25lkoPFtE2OMbD7mchgMnkn/s2cREMVGbCy3y/QfNn+rHMGcKVM3xBVx0QGc+ickLnHu9NV4xJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DEDe0Y20; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtMf0vKV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Nov 2024 23:50:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731714642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqNpDI7gI+gzJsQxMzcH8AMU0zhgHwx7w7ONikav/P8=;
	b=DEDe0Y20gC2gl2Jj6YlQzGElafP1suHZaQ59yQvzr+CeGc2KpknVFDpRs8btbI0YYQA1/A
	75HCmhJtbUpFYCiYXUKVbfcPd57u4DZlpi0n979SRT8phLVJl6em2U0zlG1oediEQURuGv
	bqWhMDfBa912IL6Wp2bXUKs0HrA6znZ/rhYX8v2AWIze0wt2W9dAU316O3yn2i+byq4j1Q
	l3WnetWrSPHvh0GVaEaF9OBAZ+jIJQOPAWTDNGR9eBnKhMghIU7jkHHmF0J/8y1XrfEDvX
	cX8ziASnpui1EJFfLzzCbMCoDHsHDYyp7R/rMqfBGRGs7jK/nNVaPaylns5RhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731714642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqNpDI7gI+gzJsQxMzcH8AMU0zhgHwx7w7ONikav/P8=;
	b=wtMf0vKVxOicMKLBMxdUL1zFObR3XCLDrkFScur2LBWTFaiJWkGJKPDqY9+lZe58TyLNY2
	nb4kBdPALiOb8vCA==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/riscv-aplic: Prevent crash when MSI domain is missing
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241114200133.3069460-1-samuel.holland@sifive.com>
References: <20241114200133.3069460-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173171464193.412.13982264589277396499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1f181d1cda56c2fbe379c5ace1aa1fac6306669e
Gitweb:        https://git.kernel.org/tip/1f181d1cda56c2fbe379c5ace1aa1fac6306669e
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Thu, 14 Nov 2024 12:01:30 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2024 00:45:37 +01:00

irqchip/riscv-aplic: Prevent crash when MSI domain is missing

If the APLIC driver is probed before the IMSIC driver, the parent MSI
domain will be missing, which causes a NULL pointer dereference in
msi_create_device_irq_domain().

Avoid this by deferring probe until the parent MSI domain is available. Use
dev_err_probe() to avoid printing an error message when returning
-EPROBE_DEFER.

Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241114200133.3069460-1-samuel.holland@sifive.com

---
 drivers/irqchip/irq-riscv-aplic-main.c | 3 ++-
 drivers/irqchip/irq-riscv-aplic-msi.c  | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 900e725..93e7c51 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -207,7 +207,8 @@ static int aplic_probe(struct platform_device *pdev)
 	else
 		rc = aplic_direct_setup(dev, regs);
 	if (rc)
-		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "direct");
+		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
+			      msi_mode ? "MSI" : "direct");
 
 #ifdef CONFIG_ACPI
 	if (!acpi_disabled)
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 945bff2..fb8d183 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -266,6 +266,9 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 			if (msi_domain)
 				dev_set_msi_domain(dev, msi_domain);
 		}
+
+		if (!dev_get_msi_domain(dev))
+			return -EPROBE_DEFER;
 	}
 
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,

