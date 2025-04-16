Return-Path: <linux-tip-commits+bounces-5014-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4EFA8B9A8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 14:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F7116F288
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5A51C5A;
	Wed, 16 Apr 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSjPNwEZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHwSIA/m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1502184E;
	Wed, 16 Apr 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808200; cv=none; b=o10pV+mcBeH8P8GxE8T2AB9gHntnY7E0NuoHsjQ//DWTWkv/1+La8krIZP6pQo5v3NJElNSbHX1n29J4Rc4qNKhE8oJMJv1rDuT8fLvjGT2EYU7wvhXPXw5qkB9OuEW6qXA5UcZ3kLYD/d+xar1At2ntx/pHtHczoHLjstTdeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808200; c=relaxed/simple;
	bh=uX3O87AWZPxfZkORO3W8nePdskRN+Rjv+6WspIrqadg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sbvCzbI3slP1mYTuPmm2xv91QeWfnKVe2qTY2y/rGX+LV4YVWPoxpTvSg3aL+P7TXThjNjD3YiPwHfwwmOJRcjhaX5yW3PcpG3TOo+VrC++iPlRYuB2ikyhmwiUbhlWQ/UxJKVsPr8CSCXPpOZKZZrJ/oeFYsdcVftF6xJ4GhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSjPNwEZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHwSIA/m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 12:56:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744808197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2dWZBf1NHWVJPeEDkpar49IOCkSHszrPGKrNxrFs4o=;
	b=HSjPNwEZL26KED+0zayVcbOPthKjiVqxtYAFNzWmjHQgFMCLR+xy81EQFPilliUZX8BNE8
	ORU7K/sjhNDnd6bJdxCK2Wd/T+xoKHFCcOUSLKvGUWrxtoiqcNQwJV4ONBe+OZQQNxAMBO
	/gD/OLysfXJTtTv2Y47BtxLVjeZx7VIcDOJrlpFu+Fnt++ykLxx5UkfqBoCNK81M6GRkKQ
	KrN75kYVdkC0K0he3xzPfeaVqLhTabfDUldJHtmwQuK+/a/fkORA2cO654cAwEAYwQRtYc
	vZ+p/rDmFjBUXNYvbV4vBJZxAb82IboO9Gsh3muujG7B57HeDPv23iy0ylurMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744808197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2dWZBf1NHWVJPeEDkpar49IOCkSHszrPGKrNxrFs4o=;
	b=aHwSIA/mfEgVl1TUHHGOGdNtlFtWnLYjgb0ifs0B87OyQCuPBUP2nkQkFpfn9qwjdRftUk
	IGU+j3CSsBmH6hAA==
From: "tip-bot2 for Peter Robinson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-bcm2712-mip: Enable driver when
 ARCH_BCM2835 is enabled
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250416082523.179507-1-pbrobinson@gmail.com>
References: <20250416082523.179507-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174480819279.31282.1393797277803876115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9b3ae50cb902322a2b5922b9fcf8132d9b4c2a24
Gitweb:        https://git.kernel.org/tip/9b3ae50cb902322a2b5922b9fcf8132d9b4c2a24
Author:        Peter Robinson <pbrobinson@gmail.com>
AuthorDate:    Wed, 16 Apr 2025 09:25:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Apr 2025 14:39:25 +02:00

irqchip/irq-bcm2712-mip: Enable driver when ARCH_BCM2835 is enabled

The BCM2712 MIP driver is required for Raspberry PI5, but it's not
automatically enabled when ARCH_BCM2835 is enabled and depends on
ARCH_BRCMSTB.

ARCH_BCM2835 shares drivers with ARCH_BRCMSTB platforms, but Raspberry PI5
does not require the BRCMSTB specific drivers, which are selected via
ARCH_BRCMSTB.

Enable the interrupt controller for both ARCH_BRCMSTB and ARCH_BCM2835.

[ tglx: Massage changelog ]

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250416082523.179507-1-pbrobinson@gmail.com
---
 drivers/irqchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cec05e4..08bb3b0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -114,8 +114,8 @@ config I8259
 
 config BCM2712_MIP
 	tristate "Broadcom BCM2712 MSI-X Interrupt Peripheral support"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
-	default m if ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+	default m if ARCH_BRCMSTB || ARCH_BCM2835
 	depends on ARM_GIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN_HIERARCHY

