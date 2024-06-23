Return-Path: <linux-tip-commits+bounces-1499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1E913D5F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 19:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0C01F232E2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10721836F3;
	Sun, 23 Jun 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U7IoAodD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/uDGw5Hg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267A1836EB;
	Sun, 23 Jun 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165135; cv=none; b=DQ3LXYPLlWeyWDomhRd5jKSCRDJ0YTIGquEtlrse3E9KUGFmzqFL4KxzNgZgSbq5dm6EQEavKkLsrKV0S2z7rvHxz4NEEOZCLncUxympEoRzs52FJZjYxRfDQ+1CBDWiRDBEb3QV7oMzW/ZGIg7/ZRGmQciSGiYVf8lG3Edhpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165135; c=relaxed/simple;
	bh=gxcRrVgIJXC3jd60OIM8KJFMC6+1nHd/FrFyfGWIpDw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b1eujb47tBx8aNQ2EPG77PNrm8OxCmHk8yTyZVinQHgNbDuD+a5gD/Zh+pgtEBDjC5AxFdMHkUUSJPZnX+QeabJVzRt9p+y2yqkgKt+R6StCwz0XK8MyZDDEttshnTi/MAqo2i/NsreHmSByIJjJTq1LFryW1Jt4nQKM3qxHLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U7IoAodD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/uDGw5Hg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 17:52:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719165132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzeRjPNFkkxQzwCFqeeH3O/AXeARFTKXmMTi1D8iGtE=;
	b=U7IoAodDkLQOLFthMQAka3QwMAbWXXv/UfxQVJuMYbeMnSDkeJELzJxQrOHQYaWqcyJQ+5
	dfdhK9rIPd7CZbQD96KHPsSZ71nVV5WEmLyDbRONpuEXaRaO+jitA/lE523tNoz264NUSQ
	JNXTQ/2OZtJv2ENkXXQQH8Ry9/cPHo8rTePTpHEl6/O+bXgZVBfSd0x/6wUOrKHW9DUbxT
	RRSnllV80BvjRoS8k33SWVfGZCnKPRfr41G00DWm7Fe4QDyydupxkYhV9N/9K35ZUZ1HMc
	ZSwywrmVYJ1PwfGnsT3F/102oBYeVs8Svc23edoeXDQSa7QSCP+tJ3ex9g89mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719165132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzeRjPNFkkxQzwCFqeeH3O/AXeARFTKXmMTi1D8iGtE=;
	b=/uDGw5HgIC6JHJuRz99SybPY0MW2js0/tJ+rWGEjwhvm8Asa/7K7gE5usWoEXTGoIWp+sI
	RaVBFwBEHfaV3qDw==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] ARM: stm32: Use different EXTI driver on ARMv7m and ARMv7a
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-3-antonio.borneo@foss.st.com>
References: <20240620083115.204362-3-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916513209.10875.8628624919091956184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     721cdbd68c588a0e883d8a7658bc6a56237eaa71
Gitweb:        https://git.kernel.org/tip/721cdbd68c588a0e883d8a7658bc6a56237eaa71
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:49:44 +02:00

ARM: stm32: Use different EXTI driver on ARMv7m and ARMv7a

Build the proper driver by selecting the appropriate config flag.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-3-antonio.borneo@foss.st.com

---
 arch/arm/mach-stm32/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index ae21a9f..a401a99 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,8 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32_EXTI
+	select STM32MP_EXTI if ARCH_MULTI_V7
+	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	select STM32_FIREWALL
 	help
 	  Support for STMicroelectronics STM32 processors.

