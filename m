Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4192431BB90
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBOO4s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBOO4g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:36 -0500
Date:   Mon, 15 Feb 2021 14:55:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1eASvYadIIT4y70/oDguxlQbfNzceHuTsTMVAsmd4Q=;
        b=bFMecu2bFFChjn0F1+o34+6VS+F5Ova6qA+DMtZ2IhY229ZRQbJUEmmEJVYmdVKLL/0Phn
        FqbobKU8/TtgzHTpmI1Jdfdcc+K4WseQvzsyXyqXOeFbVrcpoqmLL2ZmsXSBg52mpUfPf8
        o73THVwEdVTcpBZksDYOWXHBjFtlNC8vhy8jN+ht2cv51kw/GJTfszqB2Zs2TUjfe2MYex
        fIeSC7Kp173Y39xQl+gR725C4ZFwlQ16ZkNC8HSBzZ6g8tx91znfDANG1zI9QNOUvGU9b1
        3PnFR4KFpb98fU2lvDC0VE/U6KwbeqD4XP6IwBSRKBQi7AZQNkqKU4HlxFH2jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1eASvYadIIT4y70/oDguxlQbfNzceHuTsTMVAsmd4Q=;
        b=eWbJqqKPMuKwUYOuW8LilfrgLM16rCMGpOBtDGwEG41ODVVau3LioVjzOGP4c2wMJt25MK
        bNgcMu1RusTZPlAQ==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx: IMX_INTMUX should not default to y,
 unconditionally
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210208145605.422943-1-geert+renesas@glider.be>
References: <20210208145605.422943-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <161340095388.20312.2760230142921071931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a890caeb2ba40ca183969230e204ab144f258357
Gitweb:        https://git.kernel.org/tip/a890caeb2ba40ca183969230e204ab144f258357
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 08 Feb 2021 15:56:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 14 Feb 2021 12:01:16 

irqchip/imx: IMX_INTMUX should not default to y, unconditionally

Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
To fix this, restrict the automatic enabling of IMX_INTMUX to ARCH_MXC,
and ask the user in case of compile-testing.

Fixes: 66968d7dfc3f5451 ("irqchip: Add COMPILE_TEST support for IMX_INTMUX")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210208145605.422943-1-geert+renesas@glider.be
---
 drivers/irqchip/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 030895c..da7b3cf 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -452,7 +452,8 @@ config IMX_IRQSTEER
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
 config IMX_INTMUX
-	def_bool y if ARCH_MXC || COMPILE_TEST
+	bool "i.MX INTMUX support" if COMPILE_TEST
+	default y if ARCH_MXC
 	select IRQ_DOMAIN
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
