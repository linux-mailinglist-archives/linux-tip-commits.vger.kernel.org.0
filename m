Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73EB9A517
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 03:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfHWBz2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 21:55:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbfHWBz2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 21:55:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0ynV-0000h0-AW; Fri, 23 Aug 2019 03:55:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DEF5B1C07E4;
        Fri, 23 Aug 2019 03:55:24 +0200 (CEST)
Date:   Fri, 23 Aug 2019 01:55:22 -0000
From:   tip-bot2 for Heiner Kallweit <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Check for VECTOR_UNUSED directly
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <caeaca93-5ee1-cea1-8894-3aa0d5b19241@gmail.com>
References: <caeaca93-5ee1-cea1-8894-3aa0d5b19241@gmail.com>
MIME-Version: 1.0
Message-ID: <156652532293.10807.7293668982290326038.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     8725fcd99a3084a7a15a6e70882bfa3fe7925f52
Gitweb:        https://git.kernel.org/tip/8725fcd99a3084a7a15a6e70882bfa3fe7925f52
Author:        Heiner Kallweit <hkallweit1@gmail.com>
AuthorDate:    Mon, 19 Aug 2019 21:36:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Aug 2019 23:19:07 +02:00

x86/irq: Check for VECTOR_UNUSED directly

It's simpler and more intuitive to directly check for VECTOR_UNUSED than
checking whether the other error codes are not set.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/caeaca93-5ee1-cea1-8894-3aa0d5b19241@gmail.com

---
 arch/x86/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 3eae012..21efee3 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -251,7 +251,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	} else {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
+		if (desc == VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
