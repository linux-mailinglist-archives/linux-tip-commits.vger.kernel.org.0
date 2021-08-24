Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B933F58D4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Aug 2021 09:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhHXHVP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Aug 2021 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbhHXHVO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Aug 2021 03:21:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFAC061575;
        Tue, 24 Aug 2021 00:20:30 -0700 (PDT)
Date:   Tue, 24 Aug 2021 07:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629789629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koFu0mLGCF6o2X/1LaBNrEmvRKzB76SFAIX0nAbd/oU=;
        b=LUo+mxaBS5JvKi+GtINXy1O62wi9hx1c2vcRelXcsh+MM7uhX1gcUwsmw4JjjO/JGy1inU
        KkzwHjMpFI8HkFLCR92J/7x5SCHd77RsslFtgMKaeOPOOJetAdjPOPBX7ouqXcfMjlaa+c
        heemABojBLboc3FN6ghsQazj+qImeK4MMDLnHu7qcKH2otL3LTDfVKJkaAuJIBHmNy6mKH
        i/5mlotyBIeOENDmC36zv43I5YQoh7AhAmJ66BP9Wry40frX0SnD9OLRdCkqNkRWAFNtsk
        NtnxwbsyU2Zgb3v47eAC5PgVadayUSXlUWrveVGM0RGZtY1OBE2XoeDAiX9fzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629789629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koFu0mLGCF6o2X/1LaBNrEmvRKzB76SFAIX0nAbd/oU=;
        b=LCjkg8BCDOFMvgjvNso3B963G5DwjlByVsb79aRHCUCSRXvAZM8McRhLaAUtxRfOpgwzJa
        Pb2H9cxKcXEvQUBg==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] platform-msi: Add ABI to show msi_irqs of platform devices
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210813035628.6844-3-21cnbao@gmail.com>
References: <20210813035628.6844-3-21cnbao@gmail.com>
MIME-Version: 1.0
Message-ID: <162978962795.25758.15709206714387292964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     00ed1401a0058e8cca4cc1b6ba14b893e5df746e
Gitweb:        https://git.kernel.org/tip/00ed1401a0058e8cca4cc1b6ba14b893e5df746e
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Fri, 13 Aug 2021 15:56:28 +12:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Aug 2021 09:16:20 +02:00

platform-msi: Add ABI to show msi_irqs of platform devices

PCI devices expose the associated MSI interrupts via sysfs, but platform
devices which utilize MSI interrupts do not. This information is important
for user space tools to optimize affinity settings.

Utilize the generic MSI sysfs facility to expose this information for
platform MSI.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210813035628.6844-3-21cnbao@gmail.com

---
 Documentation/ABI/testing/sysfs-bus-platform | 14 +++++++++++++-
 drivers/base/platform-msi.c                  | 20 ++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
index 194ca70..ff30728 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -28,3 +28,17 @@ Description:
 		value comes from an ACPI _PXM method or a similar firmware
 		source. Initial users for this file would be devices like
 		arm smmu which are populated by arm64 acpi_iort.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		The /sys/devices/.../msi_irqs directory contains a variable set
+		of files, with each file being named after a corresponding msi
+		irq vector allocated to that device.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/<N>
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		This attribute will show "msi" if <N> is a valid msi irq
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0b72b13..3d6c8f9 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -21,11 +21,12 @@
  * and the callback to write the MSI message.
  */
 struct platform_msi_priv_data {
-	struct device		*dev;
-	void 			*host_data;
-	msi_alloc_info_t	arg;
-	irq_write_msi_msg_t	write_msg;
-	int			devid;
+	struct device			*dev;
+	void				*host_data;
+	const struct attribute_group    **msi_irq_groups;
+	msi_alloc_info_t		arg;
+	irq_write_msi_msg_t		write_msg;
+	int				devid;
 };
 
 /* The devid allocator */
@@ -272,8 +273,16 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (err)
 		goto out_free_desc;
 
+	priv_data->msi_irq_groups = msi_populate_sysfs(dev);
+	if (IS_ERR(priv_data->msi_irq_groups)) {
+		err = PTR_ERR(priv_data->msi_irq_groups);
+		goto out_free_irqs;
+	}
+
 	return 0;
 
+out_free_irqs:
+	msi_domain_free_irqs(dev->msi_domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -293,6 +302,7 @@ void platform_msi_domain_free_irqs(struct device *dev)
 		struct msi_desc *desc;
 
 		desc = first_msi_entry(dev);
+		msi_destroy_sysfs(dev, desc->platform.msi_priv_data->msi_irq_groups);
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 
