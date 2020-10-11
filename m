Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960DD28A89F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbgJKR52 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbgJKR51 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:27 -0400
Date:   Sun, 11 Oct 2020 17:57:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/G/tUPazSSNzJewfLdIUAUs2Sf12fWzICzeGE4AiTY=;
        b=YCKJpKfTjlN0ZFjwREA70qeWYibnQ5UNGzrB8BB4hdxGvb6X80qOQQjuSRDF9JIU34SZOk
        JcFuKGF2thOQ+5qm+fnVU3N8mu90ey/XeZZf/3dU3fztx/mT+37ebUlcDn93qwNU08iudb
        Oh3L8fE0Yh1zHSck8huDwdrSitIhJDalVxv1rC6E12qVNzFdN46qkKlwaFRUBpumOKX57b
        VHfEoRtksxDif27lKtYOumeDv1kw5qvV5DTuUM5bVmrcW0+mm94SPb2SMDZ8N+4Dvj0UGz
        8+TDbIilZyaWAXhPXHnnsCnxOkNwcyjPnn+1Ja7c9ThGAs63/PhOWkHw7dm5Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/G/tUPazSSNzJewfLdIUAUs2Sf12fWzICzeGE4AiTY=;
        b=vsSjjmtXX1WvP1oLyMbfEfMzhY8p6ZUs+VIS4mXDTWzlHUKIfse60XR/ywXJmr+GrfnAhN
        x5TbP+FBB70cXjDA==
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl: qcom: Set IRQCHIP_SET_TYPE_MASKED and
 IRQCHIP_MASK_ON_SUSPEND flags
Cc:     Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601267524-20199-2-git-send-email-mkshah@codeaurora.org>
References: <1601267524-20199-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <160243904378.7002.14160679629987199021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c5f72aeb659eb2f809b9531d759651514d42aa3a
Gitweb:        https://git.kernel.org/tip/c5f72aeb659eb2f809b9531d759651514d42aa3a
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 28 Sep 2020 10:01:59 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 06 Oct 2020 11:23:13 +01:00

pinctrl: qcom: Set IRQCHIP_SET_TYPE_MASKED and IRQCHIP_MASK_ON_SUSPEND flags

Both IRQCHIP_SET_TYPE_MASKED and IRQCHIP_MASK_ON_SUSPEND flags are already
set for msmgpio's parent PDC irqchip but GPIO interrupts do not get masked
during suspend or during setting irq type since genirq checks irqchip flag
of msmgpio irqchip which forwards these calls to its parent PDC irqchip.

Add irqchip specific flags for msmgpio irqchip to mask non wakeirqs during
suspend and mask before setting irq type. Masking before changing type make
sures any spurious interrupt is not detected during this operation.

Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1601267524-20199-2-git-send-email-mkshah@codeaurora.org
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2567e7..1c23f5c 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1243,6 +1243,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
 	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
+	pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
+				IRQCHIP_SET_TYPE_MASKED;
 
 	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
