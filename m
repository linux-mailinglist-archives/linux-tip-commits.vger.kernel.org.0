Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D974728A8A6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbgJKR5l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgJKR5Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF8C0613D2;
        Sun, 11 Oct 2020 10:57:24 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbznGtbR9kc1ZwSBHQMsLp5rWkuz2Gqx0KsG1ZyAhtI=;
        b=I7aS2VelfIVFfaCMqjEhVkvOO6ZD881ntyBcuU6Rvlh2uelOiQ/IMWyS2NW4LKWpDpkVQJ
        Zy6WM6Hz7IQ99T0J8pM07z2a7/bcSQ5nVgQGN92sl8y8QWhxv/vbXXFpLGNUvAGT7QgR4B
        /OiG7lg5Qyq5LNTTSs2uLk9AuEcVLfu7yNwivtoIpyidr8fPCagayiX3RxSSpW9Z4L97lU
        rEYl+BPWxIMdkUg+99C8ggugnq/hVA3WSQFbUM0d/amqNS+iSx+zz4BBfOkiHsXTJU5bB7
        pvFGRRVDN60M3bS+jr3C02I857EA2NB254yxjK3MIufxVLiPYrZur/NAX0DTWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbznGtbR9kc1ZwSBHQMsLp5rWkuz2Gqx0KsG1ZyAhtI=;
        b=6bfolZg4wLKX1oQ7juRUkhayQ5swnO74BqPaddZnvbgESY7VxyTGUI7rTYHQqDLkSX3/An
        75qoZQ8S4R60AYDA==
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-pdc: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
Cc:     Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601267524-20199-6-git-send-email-mkshah@codeaurora.org>
References: <1601267524-20199-6-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <160243904173.7002.6796040733303076781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     299d7890792e75065b906f83fcb0ca92e5c8c072
Gitweb:        https://git.kernel.org/tip/299d7890792e75065b906f83fcb0ca92e5c8c072
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 28 Sep 2020 10:02:03 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 06 Oct 2020 11:26:34 +01:00

irqchip/qcom-pdc: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag

Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag to enable/unmask the
wakeirqs during suspend entry.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1601267524-20199-6-git-send-email-mkshah@codeaurora.org
---
 drivers/irqchip/qcom-pdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f..acc0620 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -205,7 +205,8 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_set_type		= qcom_pdc_gic_set_type,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE,
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
