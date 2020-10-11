Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161D428A8D4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgJKR7H (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388482AbgJKR5m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:42 -0400
Date:   Sun, 11 Oct 2020 17:57:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Zh8C+okg9rONeC3RjxJMSojz8Kir2MqR+hjKssC0i0=;
        b=hJPrVtym5rM04XwgOQ5+XWxOq7s5A/m/nPB3bdPbeom37GQlgnZnT50/Je0xHi+4nMOY3G
        Y4SaE11cl5bMGTx10Eys4pB7Mm1tqn12Q5aH+QBG/j9XomYIaI+6mguCgNVxpCPKa2DNGy
        p+Wa9LsaRTqnHgf7Iyddhuc3tnSjSm2mdmdFbnSiZCrxCDLuh/86RehNQbdLSuCy/Rs/lw
        OJJj03Ka0hzQtsm2BxWRPK43E7DQxbUedetaquGHO447eRJqiVLLYms46FCsR5+w7ZjoKk
        8ZqAGedwyJGUc/P2T+294o+KctKjc4F9uLH+8RrPyT5AOUfCB2O0x8kYhkH9Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Zh8C+okg9rONeC3RjxJMSojz8Kir2MqR+hjKssC0i0=;
        b=7JOwMV1m3A9hvqngkA0cNR8ydgoIZnSfWDmpGd6CwFtqrS8G5hTsGhVRxc2fn7PCrm+fyC
        ntVbLgJOX2kowfBw==
From:   "tip-bot2 for Alexandru Elisei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Spell out when pseudo-NMIs are enabled
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200912153707.667731-2-alexandru.elisei@arm.com>
References: <20200912153707.667731-2-alexandru.elisei@arm.com>
MIME-Version: 1.0
Message-ID: <160243906017.7002.16254456675472272691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4e594ad1068ea1db359d6161f580f03edecf6cb0
Gitweb:        https://git.kernel.org/tip/4e594ad1068ea1db359d6161f580f03edecf6cb0
Author:        Alexandru Elisei <alexandru.elisei@arm.com>
AuthorDate:    Sat, 12 Sep 2020 16:37:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:51:35 +01:00

irqchip/gic-v3: Spell out when pseudo-NMIs are enabled

When NMIs cannot be enabled, the driver prints a message stating that
unambiguously. When they are enabled, the only feedback we get is a message
regarding the use of synchronization for ICC_PMR_EL1 writes, which is not
as useful for a user who is not intimately familiar with how NMIs are
implemented.

Let's make it obvious that pseudo-NMIs are enabled. Keep the message about
using a barrier for ICC_PMR_EL1 writes, because it has a non-negligible
impact on performance.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200912153707.667731-2-alexandru.elisei@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 850842f..aa9b43d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1564,8 +1564,8 @@ static void gic_enable_nmi_support(void)
 	if (gic_read_ctlr() & ICC_CTLR_EL1_PMHE_MASK)
 		static_branch_enable(&gic_pmr_sync);
 
-	pr_info("%s ICC_PMR_EL1 synchronisation\n",
-		static_branch_unlikely(&gic_pmr_sync) ? "Forcing" : "Relaxing");
+	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
+		static_branch_unlikely(&gic_pmr_sync) ? "forced" : "relaxed");
 
 	static_branch_enable(&supports_pseudo_nmis);
 
