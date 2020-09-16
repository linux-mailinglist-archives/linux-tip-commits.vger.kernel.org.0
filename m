Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81D26CDBD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIPVEU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIPQPB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA9DC0F26FF;
        Wed, 16 Sep 2020 08:17:11 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skbCsUayOYIrbQCywICTzEJ8/hBTyw52Rpz7l1HK4VA=;
        b=0a8JwKnvKV4vRfs/QqRNJKqLH+zzguQNf1Fz3WaTEk0fcdLhhVHFdqyeM58/Eb9MM58AM4
        MK071kXAl81xcPCtQRfOdEmh12Un/QiUKd0vJUpbbMRd+GJCQ7WRjW1XmJ+3rTwm7Xoev3
        h9rU5beb7Q9/xzBYLXj85LHLadLBnRlY7IU6A8x3Do0xsTppIoIGgCc2BNmZFUXcluFlpb
        omqFAu5zTdmPWUY5R5dkkiYx6EQ098/0A2FcfhmXNYKtsjv8XF/oTqof0djMz4L8+F1Kih
        UP6tGa2AK/mHMP+siIDaY4+PM0H4rz8m4B4xcE36YsySPiebSjE1kGBIWHiu/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skbCsUayOYIrbQCywICTzEJ8/hBTyw52Rpz7l1HK4VA=;
        b=VS1Tr3Pud6y1xvaHAa2qdbVHUixE8BTJ69bLLev1rYu9l69G++6DM4CvO7dVHYOJlu+mfg
        mKHimk8GS63WniBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/xen: Make xen_msi_init() static and rename it to
 xen_hvm_msi_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.234097629@linutronix.de>
References: <20200826112333.234097629@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913132.15536.11660067591863387294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2905c50b7d3eabd0fe718247aac86eeff3924ff8
Gitweb:        https://git.kernel.org/tip/2905c50b7d3eabd0fe718247aac86eeff3924ff8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:36 +02:00

x86/xen: Make xen_msi_init() static and rename it to xen_hvm_msi_init()

The only user is in the same file and the name is too generic because this
function is only ever used for HVM domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross<jgross@suse.com>
Link: https://lore.kernel.org/r/20200826112333.234097629@linutronix.de

---
 arch/x86/pci/xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 89395a5..ba8dc94 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -420,7 +420,7 @@ int __init pci_xen_init(void)
 }
 
 #ifdef CONFIG_PCI_MSI
-void __init xen_msi_init(void)
+static void __init xen_hvm_msi_init(void)
 {
 	if (!disable_apic) {
 		/*
@@ -460,7 +460,7 @@ int __init pci_xen_hvm_init(void)
 	 * We need to wait until after x2apic is initialized
 	 * before we can set MSI IRQ ops.
 	 */
-	x86_platform.apic_post_init = xen_msi_init;
+	x86_platform.apic_post_init = xen_hvm_msi_init;
 #endif
 	return 0;
 }
