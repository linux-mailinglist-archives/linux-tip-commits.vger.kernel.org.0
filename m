Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31E2E7BAD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Dec 2020 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL3Ru6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Dec 2020 12:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3Ru6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Dec 2020 12:50:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DEC061573;
        Wed, 30 Dec 2020 09:50:17 -0800 (PST)
Date:   Wed, 30 Dec 2020 17:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609350615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94/oJqFeXHpo1xmMGiYLl4yNf/K6/PEFDbGQOaEMgSA=;
        b=Z+LF0THJAejubPac4dh9SK4tam2+FRofinKrXRufJ1qvGXMm/4jZryBr4Ex7Xv2wai69Df
        KWNv/w99rbCPqr2i8jG4/aacpfV25huvWx54WzeZ+q1juiXPO45YwPV2gFPBD5QwnjjeD2
        WUcel+udvXY+Lon2jMtXXiu0CU/koUDJ0/RIbbzRUvS2WK5YxvFq4bbyn6xyHU2yh8BbAe
        f87F5kEitLCX9TAxczTmJp/ZSiKzgMaRP98tO2Rvwmsq926bq62k9RVKzbJ0cLUKRqjxZY
        r5ly8iZE/fhyg8PZiGL7wSy5/0HK7gNrH0/VvPm9p6CeSTFFEFYwZOl4voZWOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609350615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94/oJqFeXHpo1xmMGiYLl4yNf/K6/PEFDbGQOaEMgSA=;
        b=T8Ia6xfRbSn2xuhxANi6pPS5eXz+fnwOKXdJ23Vb8WuwjOhKt4dBKCjWM5xSiKZwoWzoyQ
        I0D7dX7BxgbqcnDQ==
From:   "tip-bot2 for Heiner Kallweit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/reboot: Add Zotac ZBOX CI327 nano PCI reboot quirk
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com>
References: <1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com>
MIME-Version: 1.0
Message-ID: <160935061419.414.5228048100044741334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     4b2d8ca9208be636b30e924b1cbcb267b0740c93
Gitweb:        https://git.kernel.org/tip/4b2d8ca9208be636b30e924b1cbcb267b0740c93
Author:        Heiner Kallweit <hkallweit1@gmail.com>
AuthorDate:    Tue, 01 Dec 2020 12:39:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Dec 2020 18:38:39 +01:00

x86/reboot: Add Zotac ZBOX CI327 nano PCI reboot quirk

On this system the M.2 PCIe WiFi card isn't detected after reboot, only
after cold boot. reboot=pci fixes this behavior. In [0] the same issue
is described, although on another system and with another Intel WiFi
card. In case it's relevant, both systems have Celeron CPUs.

Add a PCI reboot quirk on affected systems until a more generic fix is
available.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=202399

 [ bp: Massage commit message. ]

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com
---
 arch/x86/kernel/reboot.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index db11594..9991c59 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -477,6 +477,15 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 		},
 	},
 
+	{	/* PCIe Wifi card isn't detected after reboot otherwise */
+		.callback = set_pci_reboot,
+		.ident = "Zotac ZBOX CI327 nano",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "NA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZBOX-CI327NANO-GS-01"),
+		},
+	},
+
 	/* Sony */
 	{	/* Handle problems with rebooting on Sony VGN-Z540N */
 		.callback = set_bios_reboot,
