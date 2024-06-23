Return-Path: <linux-tip-commits+bounces-1507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9841A913EF1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 00:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132E51F21DB4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022E17FACE;
	Sun, 23 Jun 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xeg3F80J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vjt8Qx80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08A65C;
	Sun, 23 Jun 2024 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719181254; cv=none; b=gCoADDacQuWPX8NSRmbwtGbb+9pbWEqLIOPdbZkv24vubT+gcnzzMaRzrzBEIWE6j4Lvyx5/lK8Yx0dLPHadcmusAYqMlRqxxegRbVzCfzK8N3jFCVoCjGO9xczK70wpSDfVPtGtKC436qfqlFte12ivKfnyR0v5CmqorotWK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719181254; c=relaxed/simple;
	bh=7OD1VQt/0bbcOmLt0jPyLO5Yig/ovLZ1G84XkoeAhgc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=olc3xT8vBcEHyHTAWeffdQ5/Itu62C3deYgAr0tlqU6TJnTSUJJI2Yz93qbYBCutzr9X/U8DarDM5D2qIt1tQyh+bnMGa91j+tXPQI8o4SMYhT1grwYuCeax7fbbY/lSeBLgNUwwVlv0OMfOOSoaZJlsb5ltr6/BnTYpAEnNObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xeg3F80J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vjt8Qx80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 22:20:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719181251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORBKXDqSDK42gEliCjuF9u9/vR+3QL0jsEaGXr1VkBw=;
	b=xeg3F80JVGGQ2Lz7bU+tglxPLIhjmkYJ/CqDVkWUpoP4hEYSfgZGETjaBEh1GF1Pe2JifW
	CcWeFMtVRtajMI7U5Wmc3zr9PGbpTH1lAxZ8gvxLdSZnERT26XdMhCmrrjtprTa5SoSsSi
	oXnt+YSEjAw9vMTKNbBx3eagH+vN4CjI1PcKxiSJ6ossicAkrllfUui6+XuTUzSK8X0wDI
	fsIvOdPEV10om9kfsce50EFwzVdGyHEjLwwLB/lWJRA4c4/2LZjMfTUXRCWJtj3IqMGvac
	cKj5sfd7o9egytb0L4ocgslgJH9aGdikzPhNaO7u1IqdMg4xde0sePMyC0g3mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719181251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORBKXDqSDK42gEliCjuF9u9/vR+3QL0jsEaGXr1VkBw=;
	b=Vjt8Qx80VZBoNKQ7kxWnV1C8tswj7eat+9XZErFEkXzGwDV5pawn1rgStAiP2KJM2yEDPh
	VKbIUFRwTSnCPgAQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] arm64: Kconfig: Allow build irq-stm32mp-exti driver as module
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-9-antonio.borneo@foss.st.com>
References: <20240620083115.204362-9-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171918125036.10875.9064892129949171461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f2605e1715dd28e8943b557453fed3a40421d3b5
Gitweb:        https://git.kernel.org/tip/f2605e1715dd28e8943b557453fed3a40421d3b5
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 24 Jun 2024 00:16:43 +02:00

arm64: Kconfig: Allow build irq-stm32mp-exti driver as module

Drop auto-selecting the driver, so it can be built either as a
module or built-in.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-9-antonio.borneo@foss.st.com

---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index be86298..a028ea3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -309,7 +309,6 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
-	select STM32MP_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI

