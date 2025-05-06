Return-Path: <linux-tip-commits+bounces-5295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D649AAC5EA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C1C3B8892
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58691286D4A;
	Tue,  6 May 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awT5iPxc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mI/rQYFH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955BE286888;
	Tue,  6 May 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537636; cv=none; b=bUo/vFeOG686/U5CwkLOAUN03GaFzdzHxh3NtwlGJOAAiphA6PPS2xcJ2qTKDA5+21VZvKaxlmFQWbLxG1BL49y3tB9XQXQ/vo3X2IFOAwmIVccb6iH/wlSk7ZRVmIaa//02iBzGTomgeUqRZdRF4wWYlnnkbalq1hxfcuSPzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537636; c=relaxed/simple;
	bh=H7JWhgNe1oB2WEnRQAkuuaQK0q/glVHe8K3+A2xRoW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P3+IYfp5uSyELtR1QjncJQ60iqNUhHiPmVxlb772WujZ2/qWor0IF4qu18q6uoB2jwhYFh6/oBEdAOMoEwVQDVEFdaiKiNZVF7iOp+Vv+d1Xcz3ECW21Ga+EL02ql/3tOQeFKGgzFA8LSdXFjK7bg+3BW6+I11ih9jdeuxLmpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awT5iPxc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mI/rQYFH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZtaqhUofxa8ailewVNxx1ymhMDPbrqYbHQcSRymzGk=;
	b=awT5iPxc4cRNEBSJHOSfe0juZ5U3V5cMZf6S5ZD0kxEd76jussAP3fgujbHpX+2MbwufYy
	aOARFWQxdQSQkSgmi/HNGBjy1m8VTwJB+zD9pIMG4rVZc9A5ccc4/ts5VcSYtNt0oFqcna
	M+uBFev4UKVev/GgoEpRP510xJ8TJDo3614nnLiG070GCMll60Rc8AsiKaGJ5RrByn/uoH
	aIJ/LKH/fvVcqN4VMfoPmzTbdeJ91N+eGy9F+dCRbZToWoGAdIPufyDcfaL+oCoU9qJVac
	ZSdtCuXH33n94IhowuVEqMg/qvwko2hft1Npae0rLykfIDntbDsB6Je6Zez0pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZtaqhUofxa8ailewVNxx1ymhMDPbrqYbHQcSRymzGk=;
	b=mI/rQYFH8n0jUz1T6ug9929oUq5le4w3MCfW/JH97Bdxi6b+vhOA3lx55s2JZRUxXBhbn4
	CKv/ULIVMHaQ5rAQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] memory: omap-gpmc: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-24-jirislaby@kernel.org>
References: <20250319092951.37667-24-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653763226.406.11968649810822653034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     7ea14cd2a528a9b1209be16249807aefd6e81089
Gitweb:        https://git.kernel.org/tip/7ea14cd2a528a9b1209be16249807aefd6e81089
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:05 +02:00

memory: omap-gpmc: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-24-jirislaby@kernel.org

---
 drivers/memory/omap-gpmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 53f1888..d5bf324 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1455,10 +1455,8 @@ static int gpmc_setup_irq(struct gpmc_device *gpmc)
 	gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
 	gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
 
-	gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
-						gpmc->nirqs,
-						&gpmc_irq_domain_ops,
-						gpmc);
+	gpmc_irq_domain = irq_domain_create_linear(of_fwnode_handle(gpmc->dev->of_node),
+						   gpmc->nirqs, &gpmc_irq_domain_ops, gpmc);
 	if (!gpmc_irq_domain) {
 		dev_err(gpmc->dev, "IRQ domain add failed\n");
 		return -ENODEV;

