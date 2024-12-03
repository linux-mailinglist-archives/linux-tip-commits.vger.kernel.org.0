Return-Path: <linux-tip-commits+bounces-2968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA209E27F5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 17:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4099D16942B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41A1F8EEE;
	Tue,  3 Dec 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpNO17yG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfCmn6mi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF11F8EE8;
	Tue,  3 Dec 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244324; cv=none; b=napZA79BLRj1VZBu/87T/m9z6HqqMRUgzC55QtAl1ASNervjZqlKqyZ3X6x5z+SeSKapELN1yomRgcO3pO1kYQOPW/Rky0qpb4X5AxflaCdep4a0P9zEz4Zp1PbWYc0ewxX/qelwh7nUqAGxKKkoGaxmrc8zh68q5zfYgBHn5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244324; c=relaxed/simple;
	bh=1Bw0F+SxSTnmR8dNHiR66xY/jvQrWs8B9IBh14mL3xk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BHg/+thHpOfPd18id8MzLflLL+B/ngSoGaUD7vpOfGdKT6D3XUdMNwo5jS5jmwHxfrvi6dYSrLtCyiRXiIDU9NG2Z4bLxdajVFYMByHmHBnhfBYyQ/OVeosF1lD5+0vWJjxgdRIErj2/2hRRZlv7kfv9gKRgsOv676huZKAZa2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpNO17yG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfCmn6mi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 16:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeQ/5R0x1kZEGyRLFZJnmfj/7Aw1+ksokYH2Jf7fc90=;
	b=zpNO17yGbB9IHpGbH4CjdDZJMEzpdLcV7/sqHqpCDLRmk0KHL/HN0HzQ43wyUaDCjDIL/m
	ui0jEqnqF8BEZhlOvLAIh4uaQyxOn6bIuiYSoqTnpyAN/UIGWoQjoGffX21G22P/IFm2qv
	Whfl+aGrfQLToZT98Jo6fbAAtngJrbNv9Gb+YMrI0w5MbpnwG5jZWw4w9Ev/Vy5OK9Dnnj
	i4486lGU7lHiI9zihIPQEkFwWzlsAfbnqLguR870rWIJ246V2XG5YAXi+H3eeTmUumQiQ9
	Lo5FRWBvdNeozxOe1AapBmip3skD0cFvQ1GKNl8fBLeZZcISjy5Hllk47qwdhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeQ/5R0x1kZEGyRLFZJnmfj/7Aw1+ksokYH2Jf7fc90=;
	b=cfCmn6mi6pJ/+XDxPtSoHNFSzAJVedqBBoxK1pUZMBR76KaE2WS9D6awdTmiXNQRuVMijk
	WGaBFUjNpwaAl0AQ==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/stm32mp-exti: CONFIG_STM32MP_EXTI should
 not default to y when compile-testing
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3Cef5ec063b23522058f92087e072419ea233acfe9=2E17332?=
 =?utf-8?q?43115=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cef5ec063b23522058f92087e072419ea233acfe9=2E173324?=
 =?utf-8?q?3115=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173324432003.412.3343520734679406090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9151299ee5101e03eeed544c1280b0e14b89a8a4
Gitweb:        https://git.kernel.org/tip/9151299ee5101e03eeed544c1280b0e14b89a8a4
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 03 Dec 2024 17:27:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Dec 2024 17:40:30 +01:00

irqchip/stm32mp-exti: CONFIG_STM32MP_EXTI should not default to y when compile-testing

Merely enabling compile-testing should not enable additional functionality.

Fixes: 0be58e0553812fcb ("irqchip/stm32mp-exti: Allow building as module")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/ef5ec063b23522058f92087e072419ea233acfe9.1733243115.git.geert+renesas@glider.be

---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 55d7122..9bee02d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -415,7 +415,7 @@ config PARTITION_PERCPU
 config STM32MP_EXTI
 	tristate "STM32MP extended interrupts and event controller"
 	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
-	default y
+	default ARCH_STM32 && !ARM_SINGLE_ARMV7M
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
 	help

