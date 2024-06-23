Return-Path: <linux-tip-commits+bounces-1508-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49286913EF2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73081F2221C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5567518509E;
	Sun, 23 Jun 2024 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mq5UJ2zB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZNrGNR9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39183BBE2;
	Sun, 23 Jun 2024 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719181255; cv=none; b=mUBAY4TY1hwEWT1oGt32DcbyESYgdbP12IvixOiOdE5pGGaagczJAhRhHtXQW/VA4f9evHnD7lUitJ/JfiIqsTfkeKYZ9kZn13X8GXuv6WJJdMd/lp5DbVSX1CUqUWi+lTRJg7UBHWN8gyHKjGqViywbgIQ5ln6xm4i2+gvwG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719181255; c=relaxed/simple;
	bh=mfZLZrt6Mw40uoInoI9JWhpUzviFJ/GFdXDZBe1wjvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qpIuRQBpwboI1oo6qM0G98qB7EFM3w9tGAIYFyJhKeMxxu34cI+Gss7rdp9ksfSWUl6mQWkzmlu60Ml1zci40ttCd3x9O8dHyaqYqCypJBjm5rdvDOEVnexo1i2mx5PqK22IaxzADDcW4QH78SXYYJEWOuE5kzHpaH0nYn3SJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mq5UJ2zB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZNrGNR9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 22:20:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719181252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Gd/nkb5JlV0qRIhBwkIj46AsZhn9el55g8i0ac42lI=;
	b=Mq5UJ2zBUHDde8RGOhQ5Lf4kXpeICxWlaHpy2x3Mhk7vKVFotXfw6113MbH24JRRSz12ES
	OuOt5ofD6f/XoBcVIFYLGNtV4/iaQpOWlhb8QbwaiZwGFzOEvIJ0REHKOedUb4OZNOcOJZ
	Ue28Gv/24RiyAw8ZqXnxUNok8aHBqSvaZBYUk9/GvcUVVf0DMQahIA2ROsta4YqcEKw9Zs
	nfOjMne3kolem/zeqGCZ9LiJE6v2hrYY8s4NnQ/Dd6tBgKfoClLBTAa74Ei7PEFd6YpJaE
	Gyt6El8qREX/7MfNmi5Rvr5YJovGHAFptwOfPV6hrLKr9a651XdwsIPgLbOG+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719181252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Gd/nkb5JlV0qRIhBwkIj46AsZhn9el55g8i0ac42lI=;
	b=iZNrGNR9doKWEu9DW8rW+xqiZCtvjaJLxIGsp12SEQ4bBubl+b7W57Tg89t+4yqEwURyU8
	Hyy6B4kyHozSC/Bg==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] ARM: stm32: Allow build irq-stm32mp-exti driver as module
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-8-antonio.borneo@foss.st.com>
References: <20240620083115.204362-8-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171918125132.10875.12004074038725608153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2751ee69c150fa3013924cadba6f47eb7215086f
Gitweb:        https://git.kernel.org/tip/2751ee69c150fa3013924cadba6f47eb7215086f
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 24 Jun 2024 00:16:43 +02:00

ARM: stm32: Allow build irq-stm32mp-exti driver as module

Drop auto-selecting the driver, so it can be built either as a module or
built-in.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-8-antonio.borneo@foss.st.com

---
 arch/arm/mach-stm32/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index a401a99..630b992 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,6 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32MP_EXTI if ARCH_MULTI_V7
 	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	select STM32_FIREWALL
 	help

