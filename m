Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C762A1FC3
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgKARAd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgKARAN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499DBC0617A6;
        Sun,  1 Nov 2020 09:00:13 -0800 (PST)
Date:   Sun, 01 Nov 2020 17:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s5AZdk0XCfUoH5lp8AmyMTajySS/XSoD0Zwn/GCreT8=;
        b=MDUQkVkyZIrEOTc/uFtYJNrrNmtPh21qj+h2Ik4FioGXMykUCuXbgMAGsP0FmGuDdV1UPx
        rxYmoAiVzfoNO2Yv+LJb1PmhWTdehA72LLx9Fn6jkBPLQuovGQoWV4blM3fK+ayl/G+oqU
        +oT9iQc0R4ogcFu/V0q02hnEffnXN/SkCNkJq2DxkR2TWjXagpIXGKooLfIlFdx6YmNHJt
        smKd/x7MVU5VgFvabM/DzuOjq1Al5pB5R6VO+uFEEF/hw0dtAmU4JMDgtgJRjl1T4smp18
        qjVXPenInIB6rcOVziHFyoKbDCVTvM6xWM3SIops+TOafUoLWiapoCczzeLWDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s5AZdk0XCfUoH5lp8AmyMTajySS/XSoD0Zwn/GCreT8=;
        b=hR7o0cbxYm65Vq/wJuks0ac1TD0IPTz62Przn8zlvkVE+mKlqgRJW4gYG4SLrsz1gWEQSS
        cIy3hZguWcVNNQDg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/bcm2836: Fix missing __init annotation
Cc:     kernel test robot <lkp@intel.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160425001099.397.15342637381773654216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     57733e009f0c7e0526e10a18be12f56996c5460e
Gitweb:        https://git.kernel.org/tip/57733e009f0c7e0526e10a18be12f56996c5460e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 25 Oct 2020 11:10:29 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 25 Oct 2020 11:10:29 

irqchip/bcm2836: Fix missing __init annotation

bcm2836_arm_irqchip_smp_init() calls set_smp_ipi_range(), which has
an __init annotation. Make sure the caller has the same annotation.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 97838eb..cbc7c74 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -244,7 +244,7 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 
 #define BITS_PER_MBOX	32
 
-static void bcm2836_arm_irqchip_smp_init(void)
+static void __init bcm2836_arm_irqchip_smp_init(void)
 {
 	struct irq_fwspec ipi_fwspec = {
 		.fwnode		= intc.domain->fwnode,
