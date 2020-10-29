Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09A29EB8E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ2MPe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJ2MPd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B365C0613D2;
        Thu, 29 Oct 2020 05:15:33 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSt5Hm0obMIyOmJZIB1WiYcXA2ybHAGS0wHlDaVuauk=;
        b=JQuPuvewmmn20mf7Hd++1eh9yHzIQGVTrriabuHtfQ7zAxGXHWjioopSNZpZznec82qX1g
        wOxfC9z6ibpKu5QKjYOyezzjSY07/RoL2VIO00a/L3CFABRraQZTp6NbUs46Ac/gqf0Cwg
        riFZyzJaxqrYFvQAN8ozuVJ3cjaPK6tu9+c3XoKs++YA9AMuewp5OpwN/mQeYU2EVgqj1q
        NO/m4hLULW9a1qFae2plcjRcpORcXx6Mf54lUXSvpfCB7pNPuvFjEWPyHYWEEJ8kwV1i4m
        W6u+3OQwjtGrVJKiumJcN4I/4ICz0GI1XbhSEaODoSAk6tzzUcPeZ4L/jdBriA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSt5Hm0obMIyOmJZIB1WiYcXA2ybHAGS0wHlDaVuauk=;
        b=kXGMSegBFXUPefKs2VuLmZrj8wofwHI8aTWfWpdnBssxv4aOCB87zOBdMsMmyWerDSBTwJ
        kxlKXhdLGeAvdFBw==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/hyper-v: Disable IRQ pseudo-remapping if 15 bit
 APIC IDs are available
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-34-dwmw2@infradead.org>
References: <20201024213535.443185-34-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397372933.397.9905002467923942130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     bf27ef8a77d8da38c9f35f8f6aab013a2dcf175f
Gitweb:        https://git.kernel.org/tip/bf27ef8a77d8da38c9f35f8f6aab013a2dcf175f
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:31 +01:00

iommu/hyper-v: Disable IRQ pseudo-remapping if 15 bit APIC IDs are available

If the 15-bit APIC ID support is present in emulated MSI then there's no
need for the pseudo-remapping support.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-34-dwmw2@infradead.org

---
 drivers/iommu/hyperv-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index a629a6b..9438daa 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -121,6 +121,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 	int i;
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
+	    x86_init.hyper.msi_ext_dest_id() ||
 	    !x2apic_supported())
 		return -ENODEV;
 
