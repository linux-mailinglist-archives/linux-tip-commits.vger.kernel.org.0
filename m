Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891126C42D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIPP1q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:27:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49572 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgIPPUf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:20:35 -0400
Date:   Wed, 16 Sep 2020 15:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XShnuAVfJXI1cOLzapJcK97rZospi+0lwl8WB9b3GR4=;
        b=RGuqRlyOfI4YnxzXh+t1dXlrRm8pwj3tQNzO/1WtPCVE5h71Z1SYvUifDcqZA/CzXWwU+N
        IJ9/iALlqD6Fhmd/CRgOma8UfqBvl37ecqivWmBc+Q7y0viFX60UXKTdrwlKTN9kbnGewt
        8RqfC0JQ6mIGZd9j1/F0dmTTg3zPPmWWF9wqYKmwgIupMRzcZn71uItA2/Z0d4NW5hyo2T
        d/dkPOxx3rNyIBXyNHqxg2L6jVhTqLyii+gDYrxpTKqlCL63aICqIDs+y3wfRbx2eCRYo9
        URnmyFdIK6Y6OcitqYnHDHb5e9Ckp5IQzdhTTCrVwFtMqsChXazPVY4TGy2rpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XShnuAVfJXI1cOLzapJcK97rZospi+0lwl8WB9b3GR4=;
        b=/xO281or5E3qxebpbocnU1wpUSXJrUWHwYD1JIurK24lYz59Z1qoOw/CIrte1bqg8lMf9v
        TjQvO8kijpfsWuCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/msi: Remove pointless vcpu_affinity callback
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.250130127@linutronix.de>
References: <20200826112331.250130127@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914600.15536.6653703064323334991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     9d55f02ad4e8bc67439ff6f8508e2275c3c5d41c
Gitweb:        https://git.kernel.org/tip/9d55f02ad4e8bc67439ff6f8508e2275c3c5d41c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:29 +02:00

x86/msi: Remove pointless vcpu_affinity callback

Setting the irq_set_vcpu_affinity() callback to
irq_chip_set_vcpu_affinity_parent() is a pointless exercise because the
function which utilizes it searchs the domain hierarchy to find a parent
domain which has such a callback.

Remove the useless indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112331.250130127@linutronix.de

---
 arch/x86/kernel/apic/msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 5e8465e..f4ed814 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -278,7 +278,6 @@ static struct irq_chip pci_msi_ir_controller = {
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
