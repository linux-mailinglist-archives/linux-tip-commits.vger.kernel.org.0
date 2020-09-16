Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347A826CDF7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgIPVH3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E6C0F26F8;
        Wed, 16 Sep 2020 08:17:03 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSo59h33dc6nySITp/u2Bwt0XDmW5EprP2r1+syfYJA=;
        b=01s8GI3iTpFL5Lfh6ZBu8UUgas1L0+WiiU9NDtKs5cDKqjr7jg11BMpSyz997gasohm7w0
        KQxjZqnWO3DlXNP/wEnVuDJSlnyNsaEf6Ul4J7ev+RUUHIv5MHbuwgNmD65Y4jt+XybPFR
        kIBymK4o6QC46CqrQ2zZg+4ygaQGQ6fVYuaiiC6JIOwHXyKs7uM+wOwUV3fvdBhPZVtVVh
        0vV5Nu0H5dr1/5yfueWIFDFAy1eGIwjtcb9urSxKBNbd5kZ3dz5fK31hgNgrSUiX8Kkz1G
        RP6llRSeds1F+dOkztl6iCklLCYElPy9vSGFcywfUkAYV8QQ1TvXVFpqYvDDeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSo59h33dc6nySITp/u2Bwt0XDmW5EprP2r1+syfYJA=;
        b=3QJnQyTf+EnIjjHjk8czebNaEA6txAt0d74o5K9mU91+ngR3ZZirOpKDrASJfMo9e6RQ5h
        46rBnLhnsMsqF8CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommu/amd: Remove domain search for PCI/MSI
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112334.400700807@linutronix.de>
References: <20200826112334.400700807@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912234.15536.14622372477221633420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     bc95fd0d7c4273034b9486aaf369777eaaa00cb7
Gitweb:        https://git.kernel.org/tip/bc95fd0d7c4273034b9486aaf369777eaaa00cb7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:38 +02:00

iommu/amd: Remove domain search for PCI/MSI

Now that the domain can be retrieved through device::msi_domain the domain
search for PCI_MSI[X] is not longer required. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112334.400700807@linutronix.de
---
 drivers/iommu/amd/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a9d8b32..ef64e01 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3562,9 +3562,6 @@ static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return iommu->ir_domain;
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return iommu->msi_domain;
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;
