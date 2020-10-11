Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45028A90C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgJKSAV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbgJKR5b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:31 -0400
Date:   Sun, 11 Oct 2020 17:57:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fdEEpln0KZgVl3eTXemtecsF7y+ljvrrnP8jssXBZc8=;
        b=trRv6bUh2uV1slijL+i3FV3EbnunM8m8fK1ZVD4ZF/ea3hrbKGsskkkZlRdlW6yBzOobbX
        T+KgonMaXABX0LNK/YtS4Ei/z28xUey7zWeLKFbAAaYdlADow5751pgE1LHr+DeO3Y5oRY
        bJrovnpdyICXAHKKtnwn7JoYre+qlHvzdaIeWgxz7bx0rNIMW1/0Zruh1rNWPP8hbe/M4U
        BcspkgAyP6zaVYR8zVzwoVaQm8hYlCr0GJt9VvASuxoHsRpeihbCvpT9JKlVE/OfDZYOny
        vWJHhWANV/XQinT8XlGqLd2UUMrMpx5vVctu2Qf60RiZHaPpfDkwROrdK1iCOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fdEEpln0KZgVl3eTXemtecsF7y+ljvrrnP8jssXBZc8=;
        b=iRoIMMJJ27ps1axe6uwzJ6VKDz+51zXGyJsy7nx3sQ2P1ZOzN6stDsiFh4Md/GMxktANdZ
        n9/IfQ5KbyyPAFCA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm: Move ipi_teardown() to a CONFIG_HOTPLUG_CPU section
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243904845.7002.9242941989235213103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ac15a54e03d13686d2fc016a88311801b0734046
Gitweb:        https://git.kernel.org/tip/ac15a54e03d13686d2fc016a88311801b0734046
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 18 Sep 2020 17:19:46 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 18 Sep 2020 17:40:48 +01:00

arm: Move ipi_teardown() to a CONFIG_HOTPLUG_CPU section

ipi_teardown() is only used when CONFIG_HOTPLUG_CPU is enabled.
Move the function to a location guarded by this config option.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/kernel/smp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 00327fa..8425da5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -85,7 +85,6 @@ static int nr_ipi __read_mostly = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
 
 static void ipi_setup(int cpu);
-static void ipi_teardown(int cpu);
 
 static DECLARE_COMPLETION(cpu_running);
 
@@ -236,6 +235,17 @@ int platform_can_hotplug_cpu(unsigned int cpu)
 	return cpu != 0;
 }
 
+static void ipi_teardown(int cpu)
+{
+	int i;
+
+	if (WARN_ON_ONCE(!ipi_irq_base))
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_irq_base + i);
+}
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -707,17 +717,6 @@ static void ipi_setup(int cpu)
 		enable_percpu_irq(ipi_irq_base + i, 0);
 }
 
-static void ipi_teardown(int cpu)
-{
-	int i;
-
-	if (WARN_ON_ONCE(!ipi_irq_base))
-		return;
-
-	for (i = 0; i < nr_ipi; i++)
-		disable_percpu_irq(ipi_irq_base + i);
-}
-
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
 	int i;
