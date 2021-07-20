Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B523CF8EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jul 2021 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhGTK5J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Jul 2021 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhGTK45 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Jul 2021 06:56:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD4C0613DC;
        Tue, 20 Jul 2021 04:37:22 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626781040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MDGMmPbtbF5/H2yZEINtmGA18N7ewwPqc7Ot/cO5wR4=;
        b=3uEAyQctMglA9Y8tUO8SASl8SVGABTGrkFFoLCJNo2cwiu/LGtZhYTzHaa1nJfXbFafJdl
        TrI2WHmk71tP/JaDznyVM4Jy/NWASYqVU7+Dlu+mt6xTSCDhawOuyw7IfMYaByFfqEu5Q9
        n64BUdvXxBKQlrwqsa9JwLa1JEpJgMklCe6QkrFSGzMuC+AoFptKcDBRRHUgP/E2Ep7nms
        MTDdVRv0fzvxU9vDV2MdNOXtY+ywa9O8nZsrccnpEQxkEjZ+2Q6z4Puf/uHzkhvTuQesG8
        pgpm8sIFwrTbS3GPLsz2wfJCR9RW5hnbz9xSqIrtI8HhOnKiVmSu/hkdP6wV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626781040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MDGMmPbtbF5/H2yZEINtmGA18N7ewwPqc7Ot/cO5wR4=;
        b=NeDyEnVuQdMWPO1Aur9cOsCXyiOHhE1drc9liEzhu0n7W5o7n9kfw4Z8YSIl6LKErzl/JQ
        JmVOx4Rtkwbd3bDA==
From:   "tip-bot2 for Michal Suchanek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/tpm: Differentiate missing and invalid final
 event log table.
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162678103984.395.15219402725448409606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     674a9f1f6815849bfb5bf385e7da8fc198aaaba9
Gitweb:        https://git.kernel.org/tip/674a9f1f6815849bfb5bf385e7da8fc198aaaba9
Author:        Michal Suchanek <msuchanek@suse.de>
AuthorDate:    Thu, 08 Jul 2021 11:46:54 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 16 Jul 2021 18:04:55 +02:00

efi/tpm: Differentiate missing and invalid final event log table.

Missing TPM final event log table is not a firmware bug.

Clearly if providing event log in the old format makes the final event
log invalid it should not be provided at least in that case.

Fixes: b4f1874c6216 ("tpm: check event log version before reading final events")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/tpm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index c1955d3..8f66567 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -62,9 +62,11 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
-	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
-		pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
+		pr_info("TPM Final Events table not present\n");
+		goto out;
+	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		pr_warn(FW_BUG "TPM Final Events table invalid\n");
 		goto out;
 	}
 
