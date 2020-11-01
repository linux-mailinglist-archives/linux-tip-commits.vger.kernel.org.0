Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEED2A1FC2
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKARAd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgKARAN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:13 -0500
Date:   Sun, 01 Nov 2020 17:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOXTsO5fj7oXT6arEKGa5RsDMjRtxSJNRbHhNMzllu0=;
        b=0VKzhCA8yIBnh02c9XAE23gsk8jeSnfyjCjBGzo3bk8LZZCi70ySap6FusQ1JirTYyp8kj
        h2oWLi+V1HyjSHv5XjMxgIvljAyoz2QIFcyNrMSYA39TVj0y4zkUHLTpKcizk1kwj3Z+N+
        T1Lyi62dvD/UWZYLQMM6QBIg0WBP2ot39l4Wog9xc4bt1AXDv4N4+SNV+If0GEgNINPpef
        Ut/AKpPXa9XXqEHbNiWc4Ustx+zlR8WdidbFRbSSFdxjSMHs6vlwtLJvwZTSw54smIf7DM
        YMXke9G+G4O4zGXP633HpBFS3JC4I5oZ57LHuCFEOMMv3C6asJcVJFxcA3r/1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOXTsO5fj7oXT6arEKGa5RsDMjRtxSJNRbHhNMzllu0=;
        b=Ez0z//wcpMEggOU+r1WneqFLNfUYKB53GGstZ1DCQM+38odnvMSrtnDSp+oWuvBNZzBlAl
        pbK4lXaC0xHcbzBQ==
From:   "tip-bot2 for Fabrice Gasnier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/stm32-exti: Add all LP timer exti direct
 events support
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1602859219-15684-2-git-send-email-fabrice.gasnier@st.com>
References: <1602859219-15684-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Message-ID: <160425001041.397.1365831489049144753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a00e85b581fd5ee47e770b6b8d2038dbebbe81f9
Gitweb:        https://git.kernel.org/tip/a00e85b581fd5ee47e770b6b8d2038dbebbe81f9
Author:        Fabrice Gasnier <fabrice.gasnier@st.com>
AuthorDate:    Fri, 16 Oct 2020 16:40:17 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 25 Oct 2020 12:04:13 

irqchip/stm32-exti: Add all LP timer exti direct events support

Add all remaining LP timer exti direct events, e.g. for LP Timer 2 to 5.
LP timer 1 is already listed (e.g. exti 47).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1602859219-15684-2-git-send-email-fabrice.gasnier@st.com
---
 drivers/irqchip/irq-stm32-exti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0c2c61d..8662d7b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -195,6 +195,10 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 48, .irq_parent = 138, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 50, .irq_parent = 139, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 52, .irq_parent = 140, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 53, .irq_parent = 141, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 54, .irq_parent = 135, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 61, .irq_parent = 100, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 65, .irq_parent = 144, .chip = &stm32_exti_h_chip },
