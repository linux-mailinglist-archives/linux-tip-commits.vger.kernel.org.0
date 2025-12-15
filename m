Return-Path: <linux-tip-commits+bounces-7721-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C362CC0056
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B9273020519
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC832F74B;
	Mon, 15 Dec 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvjYz5Hv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1QJeine"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433932C955;
	Mon, 15 Dec 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835229; cv=none; b=B1zkMrcAzlqm1AV77MkjcWCRLedMu0eCFwxva3wPRx40VWEYLrSYNvbgi8BFbb9X9GeIvTMZ2GHjRVYKc2OUv9aEP/GucfSNb+OOUfoqxcNByxYsGcKXm749zSl9k1gk4aDARiUmPvPUQ1QOx0TyCz1bu9XOfr7wot4DL9Tkt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835229; c=relaxed/simple;
	bh=Zr+/pbyO37KewaYOBJ6+G3lHB+asQQp4r1Yql8EDxFE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YEMgIKSYlWmW15AblrDlHVH5HCPMLQQfyeecQDRQvO1YJkseefKhRWt9UwCqYgjFdtphbOGYqI4OkfTZLRb7LMuTxSPTqP7UUokv8zN254s+5KcirESwH6KJr0yF0X5RiOf+r0tt5AILOMTsm0iVGFm5zYM28P00TL93RQP5hY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvjYz5Hv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1QJeine; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0lTOvYUJCbqwUMvBsfh8nNmadkq7SPZxXmHxef5DIE=;
	b=zvjYz5HvkZ5px/tb7jOmBhPZMFWOwBdefClUM89poAFk/hAIn8xfSd2yRZEfTzll/gHlxF
	qKj9VXQ5q9VATE7QEcwCqo1utmH4tiORIoIH17ivAgr6YbgP8qodhzHsyMU5eyClf5s4Jh
	R72b4fRQoAMaXkDoMjC04FZXT4cIGPEs5NprIfPEJAbxAwlO5mTlgZ+te9LS2k1keeYaWv
	kQwesdYeEHx/AEvaqwOVMu+7273XEr1gxQDtXyPeW6kCuHgsm58kE3DEHiR6W9PhvA+CHi
	1w+8+RrrNhL/0DSLI/46XVhUBaX9qgrEejZJr3BNH/ZE6spsgBo4ju2ZV6qGKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0lTOvYUJCbqwUMvBsfh8nNmadkq7SPZxXmHxef5DIE=;
	b=X1QJeine/zvb+7RDaP9lSlA1nonEfM0gtj3cbk3Kg3LlGu9U5+t7va1Qck47CnvdFH1Uew
	iAV0PXtENTDEO1Cw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Add support for RZ/V2N SoC
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127162447.320971-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251127162447.320971-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583522388.510.12977624452072124304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     8d4c354bef3cc438db93f362e4657b317db03392
Gitweb:        https://git.kernel.org/tip/8d4c354bef3cc438db93f362e4657b317db=
03392
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 27 Nov 2025 16:24:47=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:32 +01:00

irqchip/renesas-rzv2h: Add support for RZ/V2N SoC

Add support for the RZ/V2N Interrupt Control Unit (ICU) by introducing a
dedicated compatible string in the irqchip driver. While the RZ/V2N ICU
differs from the RZ/V2H(P) version in its register layout primarily due
to a reduced set of ECCRAM related registers the irqchip driver does not
currently access these registers.

As a result, the RZ/V2N ICU can be safely handled by rzv2h_icu_probe for
now, but it still requires a distinct compatible so that future changes
can differentiate the SoCs when needed.

[ tglx: Fixed up the made up subject prefix ]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127162447.320971-3-prabhakar.mahadev-lad.=
rj@bp.renesas.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index 899a423..0c44b61 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -616,6 +616,7 @@ static int rzv2h_icu_probe(struct platform_device *pdev, =
struct device_node *par
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_probe)
+IRQCHIP_MATCH("renesas,r9a09g056-icu", rzv2h_icu_probe)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_probe)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");

