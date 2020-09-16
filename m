Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5F26C589
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIPRFg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgIPRD1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123DC02C299;
        Wed, 16 Sep 2020 08:20:17 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1wj7qg91X7RzQDbDZ5mghJZkvaJvrpi1oqV10JN3SQ=;
        b=REkf6L+Xux9B+QzkFsREL+Qsndmr5QDbgt4/CHD6L/RJX+Ln+WfAKVERUutIpg3av5l4Hp
        JY3t9eor7dgrjsuJ8wwnVZ7Y21YXBehwL1z7ifFkmpMwE/I/I1XJtrBUS4wu1V3mru5RD0
        VSTnD1lLoBhiIsERx+q4Db3HcKWqfxB9ZbQH8Z4R7BA+eBlg314FOE4UZeTypcYJNp4/n/
        fcw2dO5OQzFvILTRZzJD/vZffm9IdHvAsIUM7jZXfxSwTIwlp8wuk46SU8wwLie5AkvbG5
        LcU2B756sGT3DYwndC/wQ5d57HZ211jVo4RkVkLLaoQHqqzL9UK3MHuUE9t+Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1wj7qg91X7RzQDbDZ5mghJZkvaJvrpi1oqV10JN3SQ=;
        b=WeJN8dIKU2X1EtNc2OvNNHlUBzgETYxED/DGpcpzpjNbFEvWPRvtR3xcJybBdvbl2p/OSR
        RL/WSKGuxS1N02DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] PCI_vmd_Mark_VMD_irqdomain_with_DOMAIN_BUS_VMD_MSI
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.047315047@linutronix.de>
References: <20200826112333.047315047@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913273.15536.11397850873726668349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     d7f954e54079b4bf6088956d59f43768ec71269a
Gitweb:        https://git.kernel.org/tip/d7f954e54079b4bf6088956d59f43768ec71269a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:36 +02:00

PCI_vmd_Mark_VMD_irqdomain_with_DOMAIN_BUS_VMD_MSI

Devices on the VMD bus use their own MSI irq domain, but it is not
distinguishable from regular PCI/MSI irq domains. This is required
to exclude VMD devices from getting the irq domain pointer set by
interrupt remapping.

Override the default bus token.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112333.047315047@linutronix.de

---
 drivers/pci/controller/vmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 411eed6..aa1b12b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -580,6 +580,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}
 
+	/*
+	 * Override the irq domain bus token so the domain can be distinguished
+	 * from a regular PCI/MSI domain.
+	 */
+	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
