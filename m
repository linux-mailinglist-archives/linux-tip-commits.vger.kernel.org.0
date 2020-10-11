Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2228A8DC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgJKR7X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388471AbgJKR5l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:41 -0400
Date:   Sun, 11 Oct 2020 17:57:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmOQErZ1ZQn8wtKOMZgW4MCm8Clu7jlci4YVgt/lHro=;
        b=4tzIJ8v3qK7eMWgfD3gBDaC7ptb9xJPZyyjvdDgULCfm6tVDj7f0/PeLwtmYvLb5E7RI14
        eY6+YTz0lSj/Ke2kqaJQ0S6Css42Rlttb/s9eUWFX35f+3cKCEbeh7BUBWflNWmFOvdwAf
        x0UglLw0l7Tv0AmyZ55KICHK8h07VRWdSpwG2dmevyumJeNx1k2C5Yun8PaL0CRpzQPeND
        DuKsdcG1oY+9oBsv5Av8E5wxzIseIObL0uN+BwFve3OyuoR9e/Nc56CbaZu4/sHPvXbjyI
        vM2ptvMX/M3zyWqMhDe2GX3h4z2kceZhYSNnv06zgENDJq2reV+ZLpyZQ4JI1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmOQErZ1ZQn8wtKOMZgW4MCm8Clu7jlci4YVgt/lHro=;
        b=I5cO74jn3XXGIS95FIphcuZjT+Twzk9Oxa+QDSRCGHP48Wtr3xVAiabXTKe/LDroT0w8Yr
        MntF4myPezOiWkCQ==
From:   "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Kconfig: Update description for RENESAS_IRQC config
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200911100439.19878-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200911100439.19878-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <160243905917.7002.1217068223941640433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     72d44c0cbc4369cc028429b85f4697957226282c
Gitweb:        https://git.kernel.org/tip/72d44c0cbc4369cc028429b85f4697957226282c
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Fri, 11 Sep 2020 11:04:39 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 18:06:21 +01:00

irqchip: Kconfig: Update description for RENESAS_IRQC config

irq-renesas-irqc driver is also used on Renesas RZ/G{1,2} SoC's, update
the same to reflect the description for RENESAS_IRQC config.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200911100439.19878-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 drivers/irqchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719..cdb7693 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -232,12 +232,12 @@ config RENESAS_INTC_IRQPIN
 	  interrupt pins, as found on SH/R-Mobile and R-Car Gen1 SoCs.
 
 config RENESAS_IRQC
-	bool "Renesas R-Mobile APE6 and R-Car IRQC support" if COMPILE_TEST
+	bool "Renesas R-Mobile APE6, R-Car Gen{2,3} and RZ/G{1,2} IRQC support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
 	  Enable support for the Renesas Interrupt Controller for external
-	  devices, as found on R-Mobile APE6, R-Car Gen2, and R-Car Gen3 SoCs.
+	  devices, as found on R-Mobile APE6, R-Car Gen{2,3} and RZ/G{1,2} SoCs.
 
 config RENESAS_RZA1_IRQC
 	bool "Renesas RZ/A1 IRQC support" if COMPILE_TEST
