Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA17F26F858
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIRIa6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIRIa4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D80C061756;
        Fri, 18 Sep 2020 01:30:55 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu8hCDfmfONQdGPMFOoROjhn29gXANXvs04IakJ+o8g=;
        b=mGj/65zSbf3czpGOgOWBhCOv/T0cEIlOHKzIwIZdQqnir348KIhh3AC0VgvuvNVpqraOR3
        hUMTx1C3z1DrFGYeI+pyqedXJyVe7rj+FYSM4m91bT3xJfixLrQ/o4eiyXiCmPs9juEDFR
        xlZI6YTSDuiw85e3OxnfYirRn+J168ymoYSvdphk8Oa/bdeD7l6NWMF2NjT4avGql5loIk
        hZnTXqkj4x8xa/rMoONiEYiCiosNTHU8OhnssApLna704gh4Th0Fri255XjITXSCojw/zE
        WVxZFTt0Jo6ERa5/03Tp9ZlSjDm+27rGN2iKKqF/Y4yJnpGvSnPY8xxRHic7TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu8hCDfmfONQdGPMFOoROjhn29gXANXvs04IakJ+o8g=;
        b=v321Kd9GbGgX1CW/QgJBT/O8ykC5I+2EK2Fj9q+uRBtZeu+13KcZqRx5/5b8sPhm0CJsqX
        hsu2SJHrMo5TaWCw==
From:   "tip-bot2 for Lenny Szubowicz" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] integrity: Load certs from the EFI MOK config table
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200905013107.10457-4-lszubowi@redhat.com>
References: <20200905013107.10457-4-lszubowi@redhat.com>
MIME-Version: 1.0
Message-ID: <160041785349.15536.8943726923312699440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     726bd8965a5f112d9601f7ce68effa1e46e02bf2
Gitweb:        https://git.kernel.org/tip/726bd8965a5f112d9601f7ce68effa1e46e02bf2
Author:        Lenny Szubowicz <lszubowi@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 21:31:07 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

integrity: Load certs from the EFI MOK config table

Because of system-specific EFI firmware limitations, EFI volatile
variables may not be capable of holding the required contents of
the Machine Owner Key (MOK) certificate store when the certificate
list grows above some size. Therefore, an EFI boot loader may pass
the MOK certs via a EFI configuration table created specifically for
this purpose to avoid this firmware limitation.

An EFI configuration table is a much more primitive mechanism
compared to EFI variables and is well suited for one-way passage
of static information from a pre-OS environment to the kernel.

This patch adds the support to load certs from the MokListRT
entry in the MOK variable configuration table, if it's present.
The pre-existing support to load certs from the MokListRT EFI
variable remains and is used if the EFI MOK configuration table
isn't present or can't be successfully used.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Link: https://lore.kernel.org/r/20200905013107.10457-4-lszubowi@redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 security/integrity/platform_certs/load_uefi.c | 22 ++++++++++++++++++-
 1 file changed, 22 insertions(+)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c1c622b..ee4b4c6 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -71,16 +71,38 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
  * Load the certs contained in the UEFI MokListRT database into the
  * platform trusted keyring.
  *
+ * This routine checks the EFI MOK config table first. If and only if
+ * that fails, this routine uses the MokListRT ordinary UEFI variable.
+ *
  * Return:	Status
  */
 static int __init load_moklist_certs(void)
 {
+	struct efi_mokvar_table_entry *mokvar_entry;
 	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
 	void *mok;
 	unsigned long moksize;
 	efi_status_t status;
 	int rc;
 
+	/* First try to load certs from the EFI MOKvar config table.
+	 * It's not an error if the MOKvar config table doesn't exist
+	 * or the MokListRT entry is not found in it.
+	 */
+	mokvar_entry = efi_mokvar_entry_find("MokListRT");
+	if (mokvar_entry) {
+		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
+					      mokvar_entry->data,
+					      mokvar_entry->data_size,
+					      get_handler_for_db);
+		/* All done if that worked. */
+		if (!rc)
+			return rc;
+
+		pr_err("Couldn't parse MokListRT signatures from EFI MOKvar config table: %d\n",
+		       rc);
+	}
+
 	/* Get MokListRT. It might not exist, so it isn't an error
 	 * if we can't get it.
 	 */
