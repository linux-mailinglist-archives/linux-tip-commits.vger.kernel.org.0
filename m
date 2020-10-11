Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58A028A90F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgJKSBB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbgJKR5X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A4FC0613D0;
        Sun, 11 Oct 2020 10:57:23 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuZ10mAL+l0Nz/GblEK5GBOtUpOL23tqeHwYw9k95Zg=;
        b=uX+Rk63pugUc3drd2fCQ8RJHlSJrnGjvHrrl8q8tSFTIwGBoRMK3yynR+JfK6kLmAw/QkH
        2usZTQe8ZCRs92QWbSoAXz8/dxz4VodB1eVXso8+mjHDGS/UpdC/NFfBsxmlj5wz/FR0D/
        c7TdjtVToS9WECWq2Ab9NVEu82yA1oPcsDtmm9GTECJ0TShmZgEuSQiTh5Ma+wMAE4wnlM
        xk6JxLD8d6QahlEc29Sv8QK9emAKh9ChKa69IFVm3vIjCyOXJIZIu4ybPUPX+SGmrRlfV6
        ku2nnHC8Oyx/Z+bV9L7IdrEJFtrFNv7UQD23oS7PB0U9iizT8XMe23H1zyrFKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuZ10mAL+l0Nz/GblEK5GBOtUpOL23tqeHwYw9k95Zg=;
        b=OLCdhIYarZFqUFLCVdpfvMZtizGe18hjp4FXYQBIOXjHOw0Z5yMGs/JR+/pXnDeoothpbL
        hTn+getCuYSD2PBw==
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-pdc: Reset PDC interrupts during init
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601267524-20199-7-git-send-email-mkshah@codeaurora.org>
References: <1601267524-20199-7-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <160243904120.7002.16402371248887672522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d7bc63fa20b8a3b0d0645bed1887848c65c01529
Gitweb:        https://git.kernel.org/tip/d7bc63fa20b8a3b0d0645bed1887848c65c01529
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 28 Sep 2020 10:02:04 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 06 Oct 2020 11:26:41 +01:00

irqchip/qcom-pdc: Reset PDC interrupts during init

Kexec can directly boot into a new kernel without going to complete
reboot. This can leave the previous kernel's configuration for PDC
interrupts as is.

Clear previous kernel's configuration during init by setting interrupts
in enable bank to zero. The IRQs specified in qcom,pdc-ranges property
are the only ones that can be used by the new kernel so clear only those
IRQs. The remaining ones may be in use by a different kernel and should
not be set by new kernel.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1601267524-20199-7-git-send-email-mkshah@codeaurora.org
---
 drivers/irqchip/qcom-pdc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index acc0620..bd39e9d 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -341,7 +341,8 @@ static const struct irq_domain_ops qcom_pdc_gpio_ops = {
 
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
-	int ret, n;
+	int ret, n, i;
+	u32 irq_index, reg_index, val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -370,6 +371,14 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 						 &pdc_region[n].cnt);
 		if (ret)
 			return ret;
+
+		for (i = 0; i < pdc_region[n].cnt; i++) {
+			reg_index = (i + pdc_region[n].pin_base) >> 5;
+			irq_index = (i + pdc_region[n].pin_base) & 0x1f;
+			val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
+			val &= ~BIT(irq_index);
+			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+		}
 	}
 
 	return 0;
