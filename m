Return-Path: <linux-tip-commits+bounces-6240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949BDB1C258
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Aug 2025 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424B83BF0BA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Aug 2025 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B9721ADB9;
	Wed,  6 Aug 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G64FW73t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY5CELSy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789E1F5846;
	Wed,  6 Aug 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469865; cv=none; b=rDpwTU+xWShRVfJXSWs9sFg2no0XJUh8JKjboPfa8KlzoMEC9YCOOMq99Vn4Wwz/mbc2RuSOkAZRi1DU5qwaTwYCog5dTuVZW/Eb3ZM60gK3rpErsFLpTftvP8/Rbytr1BMWq3Hm0UYIwjMuhE5pYsZkw18r5SQiWgZG/eOd/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469865; c=relaxed/simple;
	bh=Dbd+W1s9oyj8NgD+1CGxz3nl50TqCDWRxY9FUxfpjNg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l90Fh/qQCt6m1RzpfH3XEykwjxL2bUYjnLQj2ukQ14twdP1FwaNUf8pohbJXvO/YaSM3vqPtni0363vC8DhqWHuDqbNv1upXGe9OF8Vf7zcPX32vQx2927X+gujhmfh7hsLrMHj1ZRRdZmlEcWVsHRo1pkcP7SXY1ExoIPnBoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G64FW73t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY5CELSy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Aug 2025 08:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754469862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D20MjaPzXV6HvhMff/Alk7qhRJvlDP1z4VPeHd/TDIs=;
	b=G64FW73tU2+b/TRC9I75t0oXkchsflhO3pOwKsG/aOr6uQYYs5ceBA47Gs1421H5Vo5D6Z
	6KRojtZb69Gx+rWQ+0r5cdnq+TQCinWX1PMQ1pBElFWZA2DveZhw40Y7JHJJWdj1VRdge/
	X7i/WUagM2KhheTaMoQk6LY++org3GJfdPi+urwsJaGHStKA9TVB1gKKyyAIY1QT4QsYoq
	g0TIaSytlPOXpZNVyiwHIZlbyB0ObJGCPDjB/3JjFxHz/7P80si7q0auKQ1DR2LAJkJ6o9
	pyPivlZyopz+76BDit4HBakSzT+eqhvvEqP1m1Z6nEnm4wFLDt2CBoDOCfFIBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754469862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D20MjaPzXV6HvhMff/Alk7qhRJvlDP1z4VPeHd/TDIs=;
	b=WY5CELSy582OrlNUBsM/VFraz8ZThVW/WpMo8mOC+Yk3BYVPERW6/FoQy3AQsE/evn1Nob
	XMZniLkYV7d0ooAg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Build IMX_MU_MSI only on ARM
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250805160952.4006075-1-arnd@kernel.org>
References: <20250805160952.4006075-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175446986041.1420.8628108142336518288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     3b6a18f0da8720d612d8a682ea5c55870da068e0
Gitweb:        https://git.kernel.org/tip/3b6a18f0da8720d612d8a682ea5c55870da=
068e0
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 05 Aug 2025 18:09:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Aug 2025 10:35:45 +02:00

irqchip: Build IMX_MU_MSI only on ARM

Compile-testing IMX_MU_MSI on x86 without PCI_MSI support results in a
build failure:

drivers/gpio/gpio-sprd.c:8:
include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete type
drivers/iommu/iommufd/viommu.c:4:
include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type

Tighten the dependency further to only allow compile testing on Arm.
This could be refined further to allow certain x86 configs.

This was submitted before to address a different build failure, which was
fixed differently, but the problem has now returned in a different form.

Fixes: 70afdab904d2d1e6 ("irqchip: Add IMX MU MSI controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250805160952.4006075-1-arnd@kernel.org
Link: https://lore.kernel.org/all/20221215164109.761427-1-arnd@kernel.org/

---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 39a6ae1..6d12c6a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -554,6 +554,7 @@ config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARM || ARM64
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY

