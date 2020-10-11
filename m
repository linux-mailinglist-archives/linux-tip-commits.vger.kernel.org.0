Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0933B28A8BE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbgJKR6T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgJKR5t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A82C0613D5;
        Sun, 11 Oct 2020 10:57:49 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s8e8UFJrZTURyupWOH6QNRYNc5WyivmpknEr1ijwTn8=;
        b=MduGnISJFsNuMQCb5gblN3WW7iNn3VFvN9ktEJw1JVopXKLYvruILA3MR5YiwDm/Bea6QN
        PW33fxWhbC7ksAWpR7TEVpnAhC1jJKf2PSDKtSWmL99oPjqf60o+TQgSpvsqk5kM1uUbbr
        fvtEahoSIo3nK9SRHJE5drFm4J7O3pKmW7Af4++Byo1CDkiCRLMexbgjb0TDkLyi/P+YxS
        xn+5K4TBDmExg0N7l7Bl2Oh/h3BoE/FzwD1+d6P//qOSlblrbn3qVcLe+YOsShWVWozDFZ
        ALYmS9MPLlLPL5d78j+wX1RnnDLqxiaNQBNI0BDOj2GgPTS7ghFc/W0czzmuQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s8e8UFJrZTURyupWOH6QNRYNc5WyivmpknEr1ijwTn8=;
        b=DNlB3ivJytVM5L4ASFKWR4Ww5bUCS/H/H48yT4WEXTO409FzI96bAgmY71cbxujdUCaHJL
        W4OzU5DhFx6vDJBQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/git-v3-its: Implement irq_retrigger callback
 for device-triggered LPIs
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243906684.7002.567141069091288481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5f774f5e12512b850a611aa99b4601d7eac50edb
Gitweb:        https://git.kernel.org/tip/5f774f5e12512b850a611aa99b4601d7eac50edb
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 31 Jul 2020 11:33:13 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Sep 2020 18:26:13 +01:00

irqchip/git-v3-its: Implement irq_retrigger callback for device-triggered LPIs

It is pretty easy to provide a retrigger callback for the ITS,
as it we already have the required support in terms of
irq_set_irqchip_state().

Note that this only works for device-generated LPIs, and not
the GICv4 doorbells, which should never have to be retriggered
anyway.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 95f0974..2808545 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1720,6 +1720,11 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_irq_retrigger(struct irq_data *d)
+{
+	return !its_irq_set_irqchip_state(d, IRQCHIP_STATE_PENDING, true);
+}
+
 /*
  * Two favourable cases:
  *
@@ -1971,6 +1976,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 	.irq_set_irqchip_state	= its_irq_set_irqchip_state,
+	.irq_retrigger		= its_irq_retrigger,
 	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
 };
 
