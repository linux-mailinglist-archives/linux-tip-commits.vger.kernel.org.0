Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1641DEEBC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 May 2020 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgEVR6e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 May 2020 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgEVR6d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 May 2020 13:58:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B2C061A0E;
        Fri, 22 May 2020 10:58:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcBwD-0002D1-Ks; Fri, 22 May 2020 19:58:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3FB6B1C0475;
        Fri, 22 May 2020 19:58:29 +0200 (CEST)
Date:   Fri, 22 May 2020 17:58:29 -0000
From:   "tip-bot2 for Alexander Monakov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] hwmon: (k10temp) Add AMD family 17h model 60h PCI match
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200510204842.2603-3-amonakov@ispras.ru>
References: <20200510204842.2603-3-amonakov@ispras.ru>
MIME-Version: 1.0
Message-ID: <159017030914.17951.12371325330862682737.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     279f0b3a4b80660fba6faadc2ca2fa426bf3f7e9
Gitweb:        https://git.kernel.org/tip/279f0b3a4b80660fba6faadc2ca2fa426bf3f7e9
Author:        Alexander Monakov <amonakov@ispras.ru>
AuthorDate:    Sun, 10 May 2020 20:48:41 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 May 2020 18:39:07 +02:00

hwmon: (k10temp) Add AMD family 17h model 60h PCI match

Add support for retrieving Tdie and Tctl on AMD Renoir (4000-series
Ryzen CPUs).

It appears SMU offsets for reading current/voltage and CCD temperature
have changed for this generation (reads from currently used offsets
yield zeros), so those features cannot be enabled so trivially.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/20200510204842.2603-3-amonakov@ispras.ru
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3f37d5d..7ba82e0 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -632,6 +632,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
