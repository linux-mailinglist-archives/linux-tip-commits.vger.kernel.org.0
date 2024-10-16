Return-Path: <linux-tip-commits+bounces-2484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DF9A134C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78241C2352F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03921B437;
	Wed, 16 Oct 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MM5/+DCk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cym6FWEM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9021A717;
	Wed, 16 Oct 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109065; cv=none; b=Azmi1Fej6aE3Vhu2eabJwgiWV4Ckpuanmpp3rm4yggIiBykuRuIzTosTpZwZsjvCvd3Y2XFKiwEiKkJAXRKWSszumSDqRscwCU7o8wwsGwamD1ulMIzZkVF9kc/Gug050mYIPHkC0UasL9pSVJmrqxaDBtqQOi8+iPYSNgZHwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109065; c=relaxed/simple;
	bh=ON5Rhi/rLSoaim/fxxxlcqqt7CCazy/EOMwHDZZJJQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pRyxL5zjnP2hkJXfCTnPjaW2K0l1be7DqmuOJUWFe7Vddh4EMIlnucDsrsIfblK9W2h5zZLpuA+5bwwh0//H2O7S2OEuhrO/Bg2hqHVNlvO3jeY0jpRn242s6Sv3OxEAvg/hFGHXevYMG4QgKORJyPuTk/vAQzP5hymJIYl0zPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MM5/+DCk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cym6FWEM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Naq5Ayuq0JfGVp1xi0WpK3yQg0b7CWmprSr6Ymf8tDs=;
	b=MM5/+DCka735Gyw89O9qFGyEyzLPlq98yw1SG/bmRDbJcpFtn4FRrK/9ZiS1NiVaZwrKD/
	n2gB6nOvqwT4bLtwbnAzGH02I4X5LUk4Cu6trMGc4ZQwafS0AVlKf1IqEe+YhXIMvI/G8B
	nixRrbBDPK/2INKsuMwELeN0A1TPx/jkn5SDDi45UxrptKJ5qtw6xKN17RBWP4zaNg+heJ
	kHuONPEMBDBLhrEalw1zV2APRsaFXlx6Jir8pDDFtuheVBWtzwKoCPZj4uCnEUXHfoLs3n
	o4Nq/f51xzpliHOEVO8N48RVvvw6/bsp+XuyCrcsVPq7/qhuIM5gh1fC7PdCFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Naq5Ayuq0JfGVp1xi0WpK3yQg0b7CWmprSr6Ymf8tDs=;
	b=Cym6FWEMkkMTDYK74Bn8T+lXrPjvqZusNP+TM6sJPP4jMu5edXj+m8hZlKhYJoq66VufIp
	LWOnRtMBOvc8eZAg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net: 3com: 3c59x: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-9-bvanassche@acm.org>
References: <20241015190953.1266194-9-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906184.1442.10332063705086792153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fb474ac2f4898b3c63ec9439219c0665c0773bb1
Gitweb:        https://git.kernel.org/tip/fb474ac2f4898b3c63ec9439219c0665c0773bb1
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:39 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

net: 3com: 3c59x: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-9-bvanassche@acm.org

---
 drivers/net/ethernet/3com/3c59x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index 082388b..7902709 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1302,7 +1302,7 @@ static int vortex_probe1(struct device *gendev, void __iomem *ioaddr, int irq,
 	if (print_info)
 		pr_cont(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
-	if (dev->irq <= 0 || dev->irq >= nr_irqs)
+	if (dev->irq <= 0 || dev->irq >= irq_get_nr_irqs())
 		pr_warn(" *** Warning: IRQ %d is unlikely to work! ***\n",
 			dev->irq);
 

