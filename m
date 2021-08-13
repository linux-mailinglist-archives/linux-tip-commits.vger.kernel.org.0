Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBB3EB42A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Aug 2021 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhHMKnY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Aug 2021 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbhHMKnY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Aug 2021 06:43:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E39C061756;
        Fri, 13 Aug 2021 03:42:57 -0700 (PDT)
Date:   Fri, 13 Aug 2021 10:42:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628851375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gYaPQC1iR/8lxOIJ6UaW6f1/CfQJrXbXQIPCGSOB3wM=;
        b=sqwsIftx4VKdad1QTzwLkw+nfRqIazNaJVtfpY5aJdgdxg/vjOUZ1KOc5fsvEmmWTfmd5G
        s+XSIV4mCb4Q8i2jdhKEltXZLWcN/g4j0CVI2doo03AD3mSpjuRUB/asmX2wKkh5DFJA32
        qEpk0YiRvbLp23QtTZaRq6OIl04qvJaJyfS2X+p3BXJUmVMmJ06kcAT63wJM6dJ23UiJXs
        GQKejAWCZffilwpgq5inX61NIrh44r/HTTMPPfuQS95pQztvpX8hZ+LXQbb9FEXCb5+3Qr
        g3VxjBc9efqTQ1uZleUjkIDHHH35su2MgWEb2PZPPrA2YU333ewAL6daoft3Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628851375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gYaPQC1iR/8lxOIJ6UaW6f1/CfQJrXbXQIPCGSOB3wM=;
        b=WspQEkISx0C+Qgf1tHPsJiSWb+GqLi+M5sBaL2V1A8dn0M+nc3Fk/5jXP6e9DUVXTpbIDQ
        oJYnpkXUU61nfwDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] driver core: Add missing kernel doc for device::msi_lock
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
MIME-Version: 1.0
Message-ID: <162885137454.395.4291921020038807852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7a3dc4f35bf8e1a07e5c3f8ecc8ac923f48493fe
Gitweb:        https://git.kernel.org/tip/7a3dc4f35bf8e1a07e5c3f8ecc8ac923f48493fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Aug 2021 12:36:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Aug 2021 12:38:48 +02:00

driver core: Add missing kernel doc for device::msi_lock

Fixes: 77e89afc25f3 ("PCI/MSI: Protect msi_desc::masked for multi-MSI")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index e53aa50..65d84b6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -407,6 +407,7 @@ struct dev_links_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
+ * @msi_lock:	Lock to protect MSI mask cache and mask register
  * @msi_list:	Hosts MSI descriptors
  * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
