Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E065244D39B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 09:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhKKJAm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 04:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhKKJAk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 04:00:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37632C061766;
        Thu, 11 Nov 2021 00:57:51 -0800 (PST)
Date:   Thu, 11 Nov 2021 08:57:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636621068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3her4b2W0InOLTQZVJXk0zXoqbmmg6n/wjz0E4dGFo=;
        b=QUu3QEiWgLvqhKhvPgdgb9MCcb0d5565goCLi79OvePeYofJT8kp2RI+idl2foeGAPSSmt
        kQfldOqFPhF3uGA/NtnhQr6ACniut3+Hd7XUHatehbOD/lZTkQFUFxPknMn20W/R/q8wJ2
        hs4a1wvzPrW042KK6anNqUa7icmVTc2VnuJ4zBuyn5tE4lFQ13EfXG3npI4EZcKTgxK2x8
        LXkazoiiPEiEvJDBb6asZXwKGl6X0rlWYFhLez34Opkits8Ta+USkE132Db6rwkBiQVYjI
        V5GFtCJsdHqTo+LkOITjOoOd7ybZpGTGx8to2eqdHoJZzlRcNUD5Qa1FjazT9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636621068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3her4b2W0InOLTQZVJXk0zXoqbmmg6n/wjz0E4dGFo=;
        b=JEwyQsLMWbg9AzTb+I+bu8Jy6ZSu6KjoqcZA4aEQAlc17M4F8t/Ntvs4SsRieEht+FGtPN
        ragZfJxNhAllvPAg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI: Add MSI masking quirk for Nvidia ION AHCI
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <163662106738.414.16460014997838326648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f21082fb20dbfb3e42b769b59ef21c2a7f2c7c1f
Gitweb:        https://git.kernel.org/tip/f21082fb20dbfb3e42b769b59ef21c2a7f2c7c1f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 04 Nov 2021 18:01:30 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Nov 2021 09:50:31 +01:00

PCI: Add MSI masking quirk for Nvidia ION AHCI

The ION AHCI device pretends that MSI masking isn't a thing, while it
actually implements it and needs MSIs to be unmasked to work. Add a quirk
to that effect.

Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/r/CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com
Link: https://lore.kernel.org/r/20211104180130.3825416-3-maz@kernel.org
---
 drivers/pci/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index aedb78c..003950c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5851,3 +5851,9 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
+
+static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
