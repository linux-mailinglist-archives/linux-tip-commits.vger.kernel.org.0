Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671EA2A1FBE
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKARAZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgKARAP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:15 -0500
Date:   Sun, 01 Nov 2020 17:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jmdoaar37IqAXZ07GE3W64YNAZXQnEnP82/waIN0AnA=;
        b=twKZpw7SRVVV1ZLQePRoG58xmD8NbXkp+X9DYDRU5vFvLpEv1arwJSJkpmTU0TlMhlcV+O
        1ZD9QdSTaVT4EyqaNHa+vDS+r1wfw4i+Qp9oktXkOA5wODsaNrF/g27BmoTlH/RtczHddL
        CKavWaOFYubaqiUhCOn23gYsNUjsyyzg90Ku3k5RN8s/kwwJ0X2EhdReZkJUUhQeeuh6N2
        O4YpyNYZI8D6WIyYR8HelDC/C392foV20xK2H6RtQanrz7SKP2znf7smn9NBtRYfjCTZGQ
        JEM/4r0sK1q5/AcWV13oQvu9RaehJc7b1hDSJSzxs2N0YooueJvrSgtarW9eKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jmdoaar37IqAXZ07GE3W64YNAZXQnEnP82/waIN0AnA=;
        b=jJ1eOhpw+w5MYh40hIgjxr0HS1njrHfaHUmROFQ/Yc6T7r636Vj/FCNNC84mi62PenCDVB
        zNNidB6RtbKcnkAw==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK
 or ARCH_MSTARV7
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Palmer <daniel@thingy.jp>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014131703.18021-1-geert+renesas@glider.be>
References: <20201014131703.18021-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160425001268.397.15085158658972395403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     61b0648d569aca932eab87a67f7ca0ffd3ea2b68
Gitweb:        https://git.kernel.org/tip/61b0648d569aca932eab87a67f7ca0ffd3ea2b68
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 14 Oct 2020 15:17:03 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 15 Oct 2020 22:28:35 +01:00

irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7

The MStar interrupt controller is only found on MStar, SigmaStar, and
Mediatek SoCs.  Hence add dependencies on ARCH_MEDIATEK and
ARCH_MSTARV7, to prevent asking the user about the MStar interrupt
controller driver when configuring a kernel without support for MStar,
SigmaStar, and Mediatek SoCs.

Fixes: ad4c938c92af9130 ("irqchip/irq-mst: Add MStar interrupt controller support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Daniel Palmer <daniel@thingy.jp>
Link: https://lore.kernel.org/r/20201014131703.18021-1-geert+renesas@glider.be
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 570a770..cd734df 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -583,6 +583,7 @@ config LOONGSON_PCH_MSI
 
 config MST_IRQ
 	bool "MStar Interrupt Controller"
+	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
 	default ARCH_MEDIATEK
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
