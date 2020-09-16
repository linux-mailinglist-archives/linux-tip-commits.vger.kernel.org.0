Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589026CDDB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgIPVGM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgIPQOx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE22C02C28C;
        Wed, 16 Sep 2020 08:17:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZ5nSqTxj8bkjZt6TKPeIgQb0bUjvEcAsmWlt4Ogd0M=;
        b=GTg4hqylqxoENRc1xMsS3rtAdHm1fuoXsyGZhNy+M4BVzcE6oBshfgm4FWXglg3hhijQIK
        N3qTTq+QpULQu1J7BjkOonYiKUJOK/hWf0gZyyzTB8TG8Iz2RWnx4fyRfyg2wypqifkQBu
        +M7CUni95CXZ9qFLY/QMHmLT5yQ/Cp65cLqAciRqbGwyChBuPwtXJhYdAgi6psIGWpg+oO
        CZmXDWCgnjw6XtGAEzSVVey+aXnd+pmwQrP2Ly33GZiUk1qo2igol3LOqgzKm/DDaESCPK
        sqVdu/2VyDHAuIQN/kzB+JNBp+LNSOU6lJp+mqkuG7ApgbyKp5kTagooJ0C5+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZ5nSqTxj8bkjZt6TKPeIgQb0bUjvEcAsmWlt4Ogd0M=;
        b=SYgpWGr5a/k3Owa7Qc5FsSdiXUwzR0dr3zy20Jz9FjrQZ6UhTWSCMAocnQ+9nX6fWTy1z3
        0/ZvNciQkhGarFDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] PCI: vmd: Dont abuse vector irqomain as parent
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112330.928952181@linutronix.de>
References: <20200826112330.928952181@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914815.15536.11787871151299516712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     585dfe8abc4460810c07114b64aca10a74fa2718
Gitweb:        https://git.kernel.org/tip/585dfe8abc4460810c07114b64aca10a74fa2718
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:28 +02:00

PCI: vmd: Dont abuse vector irqomain as parent

VMD has it's own PCI/MSI interrupt domain which is not in any way depending
on the x86 vector domain. PCI devices behind VMD share the VMD MSIX vector
entries via a VMD specific message translation to the actual VMD MSIX
vector. The VMD device interrupt handler for the VMD MSIX vectors invokes
all interrupt handlers of the devices which share a vector.

Making the x86 vector domain the actual parent of the VMD irq domain is
pointless and actually counterproductive. When a device interrupt is
requested then it will activate the interrupt which traverses down the
hierarchy and consumes an interrupt vector in the vector domain which is
never used.

The domain is self contained and has no parent dependencies, so just hand
in NULL for the parent and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112330.928952181@linutronix.de
---
 drivers/pci/controller/vmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f69ef8c..411eed6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -573,7 +573,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
-						    x86_vector_domain);
+						    NULL);
+
 	if (!vmd->irq_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENODEV;
