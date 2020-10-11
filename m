Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5A28A904
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgJKSAY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbgJKR5Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B64C0613D5;
        Sun, 11 Oct 2020 10:57:24 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXwnqe1MAlKp8sbirNdSRi+numj1CzPqXg50S+Gr30o=;
        b=gPeKA6VwwOGIzARQFmHG09Rvn5SMfxXSSwTOaFkudsuwpQ39eUnm5nI7val9QJ+1eZz7pY
        T6PSrpLTZMI2yHK1JxzNQoCnZRL5evDNatF0T1EHAiLsNgmTLvkKPnkQwJQAIAOEmylELT
        gXKBN+JAYiyba4zV/f2pciPVBdVMedZN7ovHuVJyxmIrlfCpl9ESeNk4oiy7tZVDrCVue4
        dsS+XPbzCzTjEwxdAaygjXlVm/ZFUBE69SPqAUX865tqYD2k0N23Tg7HS/Ie/ieZfaVWIU
        SD1lZ8EZXjrvhg6Aw/H429AOMLJr76Whzb4BrqcFvmnGJSUgqpIPwmMJNYdHdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXwnqe1MAlKp8sbirNdSRi+numj1CzPqXg50S+Gr30o=;
        b=b20QOlU9hl3r4myuf7pyL/wmaqubz3tP5BU0cEGR80lPGaO4fV5PU1GoXQ5i0noaAN8GWe
        K+14IqScWoA+hBDA==
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl: qcom: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
Cc:     Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601267524-20199-5-git-send-email-mkshah@codeaurora.org>
References: <1601267524-20199-5-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <160243904224.7002.5168077659207930884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     dd87bd09822c294a3c7c4daf11f11a9f81222f80
Gitweb:        https://git.kernel.org/tip/dd87bd09822c294a3c7c4daf11f11a9f81222f80
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 28 Sep 2020 10:02:02 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 06 Oct 2020 11:26:34 +01:00

pinctrl: qcom: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag

Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag to enable/unmask the
wakeirqs during suspend entry.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1601267524-20199-5-git-send-email-mkshah@codeaurora.org
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1df2322..c4bcda9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1242,7 +1242,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
 	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
 	pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
-				IRQCHIP_SET_TYPE_MASKED;
+				IRQCHIP_SET_TYPE_MASKED |
+				IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND;
 
 	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
