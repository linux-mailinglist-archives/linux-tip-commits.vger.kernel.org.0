Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4E39015F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhEYMyL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhEYMyJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 08:54:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0259C061574;
        Tue, 25 May 2021 05:52:39 -0700 (PDT)
Date:   Tue, 25 May 2021 12:52:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621947157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6t/GlcWjtBF4E090z8l8RZvT802ud2pFrOky6OUnqs=;
        b=ygdiupc3cYUeyBH+9looV5AjLtbVY4c0HA5bQaIgTevAxiDDeJ8MOISJ6n4XNtPOw8F96E
        MOPdZM+152P+i7r5hLUSuxFu31I3gzC/PL4ciIhoB9gAe1DfaFEsvWuSgS/1Coep9dn2Wl
        kSX5v3uvSwWAVq6j+pq1dDSfjRXIxnRhPjob4Owp7/wbGtf1CyTpiEwr81UoDw9sCerhL2
        vjTbVbMnDBxFmHxQatLFOyPTlEERDHbeAxICk/CDQk16wrb8eOeokaZeQx4AtILyxH0oPM
        7skwduWGXbu2UdibflqTrw0vp3DR8lyWsMlGunHyQ4XeoIORubeQ6B0wr/ajhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621947157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6t/GlcWjtBF4E090z8l8RZvT802ud2pFrOky6OUnqs=;
        b=8LBT9xTbnUkNaCptm4B8y/Qv0g439ewHiJr0kf3s3YSXj2biROdZQbahpSRxOZi60sKmvH
        xidOgtxv+hJn86CA==
From:   "tip-bot2 for David Bartley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/amd_nb: Add AMD family 19h model 50h PCI ids
Cc:     David Bartley <andareed@gmail.com>, Borislav Petkov <bp@suse.de>,
        Wei Huang <wei.huang2@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210520174130.94954-1-andareed@gmail.com>
References: <20210520174130.94954-1-andareed@gmail.com>
MIME-Version: 1.0
Message-ID: <162194715628.29796.6405985185138227774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2ade8fc65076095460e3ea1ca65a8f619d7d9a3a
Gitweb:        https://git.kernel.org/tip/2ade8fc65076095460e3ea1ca65a8f619d7d9a3a
Author:        David Bartley <andareed@gmail.com>
AuthorDate:    Thu, 20 May 2021 10:41:30 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 21 May 2021 12:01:38 +02:00

x86/amd_nb: Add AMD family 19h model 50h PCI ids

This is required to support Zen3 APUs in k10temp.

Signed-off-by: David Bartley <andareed@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Wei Huang <wei.huang2@amd.com>
Link: https://lkml.kernel.org/r/20210520174130.94954-1-andareed@gmail.com
---
 arch/x86/kernel/amd_nb.c | 3 +++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 0908309..23dda36 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -25,6 +25,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -57,6 +58,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{}
 };
 
@@ -72,6 +74,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4c3fa52..5356ccf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -555,6 +555,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
