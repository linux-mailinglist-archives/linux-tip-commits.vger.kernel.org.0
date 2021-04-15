Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D8360520
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhDOJB0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhDOJBZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 05:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04727C061574;
        Thu, 15 Apr 2021 02:01:02 -0700 (PDT)
Date:   Thu, 15 Apr 2021 09:00:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618477260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lefCfJ0JnIAclFIhMangSYD9z2I7g+v5fd7E3LDwGW0=;
        b=VOoGmconNMenTDgB5Po63xuJwAf2KVLrN+P1bLIx6/AxBO+D7efgFx6m3Ez3gI3v6Vevne
        gJkz3CM6FQ5XU3sp060ON6Bz/daHAlUs8+qUyz/7QROZlMeV83mOFWQjbVhzeJ3pqw/zZB
        Lidlvnibz35bxlYGoETXdRGgo2/umUa6kkng7srBWS3Aay/xel8jHnkk4W/0Wx/s8/JL6t
        pvTdkhfRFCjDM4xb1LCbTtblJB4SmNSMA9mBhb1yjnVgtAVUxb9AwsaaQHu58lHZVdKJqW
        zaDbHiFNtRdSeuR0VByZIhzjxR0PYJh5RjlRfTeHb0tZwWWTYrBtwhDey/jZUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618477260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lefCfJ0JnIAclFIhMangSYD9z2I7g+v5fd7E3LDwGW0=;
        b=Tqh0kJz0iDS5CI/xmj9N2ncaIyHaQ4bmCrxj+Kirm8ZeYoiiZO1LvVMULE5lfMnkudv+JS
        zdcIDy3TMPdheHAg==
From:   "tip-bot2 for Jean-Philippe Brucker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/dma: Tear down DMA ops on driver unbind
Cc:     "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210414082633.877461-1-jean-philippe@linaro.org>
References: <20210414082633.877461-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Message-ID: <161847725788.29796.15623166781765421094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9f8614f5567eb4e38579422d38a1bdfeeb648ffc
Gitweb:        https://git.kernel.org/tip/9f8614f5567eb4e38579422d38a1bdfeeb648ffc
Author:        Jean-Philippe Brucker <jean-philippe@linaro.org>
AuthorDate:    Wed, 14 Apr 2021 10:26:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 15 Apr 2021 10:27:29 +02:00

x86/dma: Tear down DMA ops on driver unbind

Since

  08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")

a user can switch a device between IOMMU and direct DMA through sysfs.
This doesn't work for AMD IOMMU at the moment because dev->dma_ops is
not cleared when switching from a DMA to an identity IOMMU domain. The
DMA layer thus attempts to use the dma-iommu ops on an identity domain,
causing an oops:

  # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/unbind
  # echo identity > /sys/bus/pci/devices/0000:00:05.0/iommu_group/type
  # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/bind
   ...
  BUG: kernel NULL pointer dereference, address: 0000000000000028
   ...
   Call Trace:
    iommu_dma_alloc
    e1000e_setup_tx_resources
    e1000e_open

Implement arch_teardown_dma_ops() on x86 to clear the device's dma_ops
pointer during driver unbind.

 [ bp: Massage commit message. ]

Fixes: 08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210414082633.877461-1-jean-philippe@linaro.org
---
 arch/x86/Kconfig          | 1 +
 arch/x86/kernel/pci-dma.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..2c90f8d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_TEARDOWN_DMA_OPS	if IOMMU_DMA
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de234e7..60a4ec2 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -154,3 +154,10 @@ static void via_no_dac(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_PCI, 8, via_no_dac);
 #endif
+
+#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
+void arch_teardown_dma_ops(struct device *dev)
+{
+	set_dma_ops(dev, NULL);
+}
+#endif
