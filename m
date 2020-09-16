Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9026CDF3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIPVH2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90098C0F26F9;
        Wed, 16 Sep 2020 08:17:03 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PgmC10FY/9sR5EPJGUkqpjKGpjCwyAz4YuasK36tRg=;
        b=b05LefPgn8XWUUl5D7A1vEoxziRiVmLNUS4HJuO6r3gcrZrJnoDpXjCd8AY5wycQb/X9nu
        k1pF2d6HPRx8hVujj4Qzd54RFrJxc3kjLgeLebF9fnp07Br4nO5DYaFwhDrOEw66yeNtZc
        ICUkT8uZ06D78+7jdmvF43HMjLZnqN2RNyvaAwUUGAmxtUZWHcOcz66C36Un7OaU2rcKbZ
        amqV/95LI3hiwyou33mbH1oFrTBxZSWt8vt4dfxP3CARD0ATA1VaI73m5IRbHFIve8blkR
        m+LkkipFzj9j/V2H8akWBGUAYp0UDpDLpEOoWIFfmmEZ74gZyzC3qnT3F0eJBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PgmC10FY/9sR5EPJGUkqpjKGpjCwyAz4YuasK36tRg=;
        b=ybIBdbP9LtUKi2bw/U0uVS/NsqgYNCqYCSwfMIsn9e++5y9ISHn3RK8L8pClG7QIFpRaKf
        bIUgm7A5WJkUR9BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommu/vt-d: Remove domain search for PCI/MSI[X]
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112334.305699301@linutronix.de>
References: <20200826112334.305699301@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912312.15536.14068875726960416231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     9f0ffb4bb3008e56fcd7ad5ff24467a8b7f1f2e7
Gitweb:        https://git.kernel.org/tip/9f0ffb4bb3008e56fcd7ad5ff24467a8b7f1f2e7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:38 +02:00

iommu/vt-d: Remove domain search for PCI/MSI[X]

Now that the domain can be retrieved through device::msi_domain the domain
search for PCI_MSI[X] is not longer required. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112334.305699301@linutronix.de

---
 drivers/iommu/intel/irq_remapping.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 68692a4..0cfce1d 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1138,9 +1138,6 @@ static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 		return map_ioapic_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return map_hpet_to_ir(info->devid);
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return map_dev_to_ir(msi_desc_to_pci_dev(info->desc));
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;
