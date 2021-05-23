Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19E538DAD2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhEWKGQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 06:06:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhEWKGP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 06:06:15 -0400
Date:   Sun, 23 May 2021 10:04:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621764288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9kAskHeRt8G2JjNpyIqoKujlPCpNRYu+ZYSuo50DwBM=;
        b=OQJHBdeFinZ3eYYnXclrSF9MYePBJMVunRBJG4rF9R77aSHdG2FAjEi3OG2uCRfhkL+kLX
        whou0azRNwsoAgNfpGGDwGHRuK+ZvrAmLtuiPDi7qc6256FcqGzkiINw7nCbzM2VqAPGYj
        sFCDac7QzxUomHjgCt0doFVEDKhKecWlxVTsqHwJS0WrLb6166NI/AFJcSfUEb3uKz41KH
        xZxtSJMCqTXVJNtal597ZgNt+AARcfjIBAXMKBYp7J/TK3EBmgL2XNJDdT5T0pJC5WKnwj
        NIfxPiijKUzD+KtPcLum2Y2ESnRp6EPwVpvBYCxNh7zKX9t5xtWZm5vh7Z1rHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621764288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9kAskHeRt8G2JjNpyIqoKujlPCpNRYu+ZYSuo50DwBM=;
        b=BfLt3umxQKmXKL+DKeQJpmk+SjpU5uQbZJMukDG7zFt/SpvlcAP4/79YsLE/1/loPS/VeD
        X0vzqk2rQ6bmFSBQ==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/dev-path-parser: Switch to use for_each_acpi_dev_match()
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176428751.29796.9919190375386740818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     edbd1bc4951eff8da65732dbe0d381e555054428
Gitweb:        https://git.kernel.org/tip/edbd1bc4951eff8da65732dbe0d381e555054428
Author:        Andy Shevchenko <andy.shevchenko@gmail.com>
AuthorDate:    Sun, 04 Apr 2021 21:12:16 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:07:00 +02:00

efi/dev-path-parser: Switch to use for_each_acpi_dev_match()

Switch to use for_each_acpi_dev_match() instead of home grown analogue.
No functional change intended.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/dev-path-parser.c | 49 +++++++++----------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 5c9625e..10d4457 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -12,52 +12,39 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 
-struct acpi_hid_uid {
-	struct acpi_device_id hid[2];
-	char uid[11]; /* UINT_MAX + null byte */
-};
-
-static int __init match_acpi_dev(struct device *dev, const void *data)
-{
-	struct acpi_hid_uid hid_uid = *(const struct acpi_hid_uid *)data;
-	struct acpi_device *adev = to_acpi_device(dev);
-
-	if (acpi_match_device_ids(adev, hid_uid.hid))
-		return 0;
-
-	if (adev->pnp.unique_id)
-		return !strcmp(adev->pnp.unique_id, hid_uid.uid);
-	else
-		return !strcmp("0", hid_uid.uid);
-}
-
 static long __init parse_acpi_path(const struct efi_dev_path *node,
 				   struct device *parent, struct device **child)
 {
-	struct acpi_hid_uid hid_uid = {};
+	char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
+	struct acpi_device *adev;
 	struct device *phys_dev;
 
 	if (node->header.length != 12)
 		return -EINVAL;
 
-	sprintf(hid_uid.hid[0].id, "%c%c%c%04X",
+	sprintf(hid, "%c%c%c%04X",
 		'A' + ((node->acpi.hid >> 10) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
 			node->acpi.hid >> 16);
-	sprintf(hid_uid.uid, "%u", node->acpi.uid);
-
-	*child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
-				 match_acpi_dev);
-	if (!*child)
+	sprintf(uid, "%u", node->acpi.uid);
+
+	for_each_acpi_dev_match(adev, hid, NULL, -1) {
+		if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
+			break;
+		if (!adev->pnp.unique_id && node->acpi.uid == 0)
+			break;
+		acpi_dev_put(adev);
+	}
+	if (!adev)
 		return -ENODEV;
 
-	phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
+	phys_dev = acpi_get_first_physical_node(adev);
 	if (phys_dev) {
-		get_device(phys_dev);
-		put_device(*child);
-		*child = phys_dev;
-	}
+		*child = get_device(phys_dev);
+		acpi_dev_put(adev);
+	} else
+		*child = &adev->dev;
 
 	return 0;
 }
