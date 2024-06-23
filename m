Return-Path: <linux-tip-commits+bounces-1509-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607E913EF5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 00:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69E21C2118E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F2F186296;
	Sun, 23 Jun 2024 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0XtJEAu7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ym88w3Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3275FEED;
	Sun, 23 Jun 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719181256; cv=none; b=Gf/eHIX1ZZZaUokRaaMfaQ9UP/gk0kRU0KOopX0O5M9eMKgl7E/NHrRSHpihldnHlTS5BOGKuh5WUfQZ2J9RbgcnadlWON5vw97+Md1G0pGp7//Jb+FvDF4uHg+YvSt+VsZMeHCcttGiioquet/f6i5hTbVPHze7LoC56bTf/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719181256; c=relaxed/simple;
	bh=I6+M845uubDkwm0iYrOuZbOyUHHlc4YY8owuivPKnfE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aNTYzUjXr4hPkOXKoIa0N4ONPm8PbrgDIcRqHKBixyH4lbHqY92+3Va2pWIwE4EkKRXCnSyCHDKNeUZt9btRTdhVm9rqVgen2+XIwV1FMzu8SJMf+Vym53KVEARtpswkOm2WOYaJa7Gb/031Z1NgNebrmFLxaaDl5ibCYGcVz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0XtJEAu7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ym88w3Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 22:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719181252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOviPp/v7neCjMyOV3cLCNqwhnRYCcFtPK6Iar19Usk=;
	b=0XtJEAu7m6AdawlTkS22CfKcJbyrunfFt/uHgxGtrckDl6pV9JXPY5/Rwji9sJZQX4pWwB
	KZ2yPNN4i5s0chXiiDT9lVBu9cuWzo9jLxyQu1UTrxmUih/x6xwjitqQhdLu7QwQLwzWDv
	j4WnynwLoi2HBN9ePxYs8O6TgS++n8zlRmFWHsEng3jtEQ5t1to9J+1i8n0BCnhxoO1LnH
	SOyfn2t4EHq1Uiml5S055aqZkeAfvUohlgIgGx9uGlWYsLkFq7167mlRUmDo+FK6cmUQsB
	QIvpX66rvhzDSLKFUCOERxm0Va6ZzIrWQq3U2CJqM9tjAXon9reCFilTSlYhNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719181252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOviPp/v7neCjMyOV3cLCNqwhnRYCcFtPK6Iar19Usk=;
	b=1ym88w3Qsqc5mkFh4Zj6NKbiNgrx6EKehxakJLKijJujtfRkmdWoXcNacQEWx4VTx257lV
	oXV3YisLB6nplYAQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32mp-exti: Allow building as module
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-7-antonio.borneo@foss.st.com>
References: <20240620083115.204362-7-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171918125205.10875.15410755034870534766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0be58e0553812fcbd37c0c2d89e2b5bc296f04ea
Gitweb:        https://git.kernel.org/tip/0be58e0553812fcbd37c0c2d89e2b5bc296f04ea
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 24 Jun 2024 00:16:43 +02:00

irqchip/stm32mp-exti: Allow building as module

Allow to build the driver as a module by adding the necessarily hooks in
Kconfig and in the driver's code.

Since all the probe dependencies linked to this driver have already been
fixed, remove the not longer relevant 'arch_initcall'.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-7-antonio.borneo@foss.st.com

---
 drivers/irqchip/Kconfig            |  8 ++++++--
 drivers/irqchip/irq-stm32mp-exti.c | 15 ++++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 978639d..cbf49b6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -405,9 +405,13 @@ config PARTITION_PERCPU
 	bool
 
 config STM32MP_EXTI
-	bool
-	select IRQ_DOMAIN
+	tristate "STM32MP extended interrupts and event controller"
+	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
+	default y
+	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
+	help
+	  Support STM32MP EXTI (extended interrupts and event) controller.
 
 config STM32_EXTI
 	bool
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 727859e..33e0cfd 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -722,15 +722,8 @@ static struct platform_driver stm32mp_exti_driver = {
 	},
 };
 
-static int __init stm32mp_exti_arch_init(void)
-{
-	return platform_driver_register(&stm32mp_exti_driver);
-}
-
-static void __exit stm32mp_exti_arch_exit(void)
-{
-	return platform_driver_unregister(&stm32mp_exti_driver);
-}
+module_platform_driver(stm32mp_exti_driver);
 
-arch_initcall(stm32mp_exti_arch_init);
-module_exit(stm32mp_exti_arch_exit);
+MODULE_AUTHOR("Maxime Coquelin <mcoquelin.stm32@gmail.com>");
+MODULE_DESCRIPTION("STM32MP EXTI driver");
+MODULE_LICENSE("GPL");

