Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080B426F85D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIRIa5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:30:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgIRIa5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:57 -0400
Date:   Fri, 18 Sep 2020 08:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlF8SM7dNhyi8QRCoTByoJJnoWPhdK4YHO/H4BBCE4w=;
        b=qaU3eyM3s5OliJRZpST/IhD8Jx0Mv2Yt9cU2cU4S465wOEEWKQcgtYvYrd5qSTgRep62Y5
        KD4HD2Q/NKm/kXRnzeDkxpKhRI81+/nr6aNCL/W2ovFOWU7hCYdXj6nha/ObbZQJsrFNcz
        wBmiK6BNs4zOJzf/mQjXkeY8W8auymF/sUJpL5p2SeWBWwrNIe+ksewcmqYuOKswDCvKPD
        3vCfAeg181QJw/RCp9jhHaG420TKchXbaDG4n5QVinKmXLgy+rzNcVf45q6LqfIGt77oTW
        6vzUgSRS7ZYD1QGhH99g5v3SFzTgRjsKLK9GX9vgRccGmaYA46dwvhX+oq5o+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlF8SM7dNhyi8QRCoTByoJJnoWPhdK4YHO/H4BBCE4w=;
        b=p7TwpDK5/jZkGvOjKqNovHgpDn5xxUoCxhVj5V/OubSmTCYTDK++Z3azSFcVd1WzsuVqAS
        5cF75o63xr1rC4BA==
From:   "tip-bot2 for Lenny Szubowicz" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] integrity: Move import of MokListRT certs to a
 separate routine
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200905013107.10457-3-lszubowi@redhat.com>
References: <20200905013107.10457-3-lszubowi@redhat.com>
MIME-Version: 1.0
Message-ID: <160041785420.15536.14745076474618952848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     38a1f03aa24094b4a8de846700cb6cb21cc06468
Gitweb:        https://git.kernel.org/tip/38a1f03aa24094b4a8de846700cb6cb21cc06468
Author:        Lenny Szubowicz <lszubowi@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 21:31:06 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

integrity: Move import of MokListRT certs to a separate routine

Move the loading of certs from the UEFI MokListRT into a separate
routine to facilitate additional MokList functionality.

There is no visible functional change as a result of this patch.
Although the UEFI dbx certs are now loaded before the MokList certs,
they are loaded onto different key rings. So the order of the keys
on their respective key rings is the same.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Link: https://lore.kernel.org/r/20200905013107.10457-3-lszubowi@redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 security/integrity/platform_certs/load_uefi.c | 63 ++++++++++++------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 253fb9a..c1c622b 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -66,6 +66,43 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 }
 
 /*
+ * load_moklist_certs() - Load MokList certs
+ *
+ * Load the certs contained in the UEFI MokListRT database into the
+ * platform trusted keyring.
+ *
+ * Return:	Status
+ */
+static int __init load_moklist_certs(void)
+{
+	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
+	void *mok;
+	unsigned long moksize;
+	efi_status_t status;
+	int rc;
+
+	/* Get MokListRT. It might not exist, so it isn't an error
+	 * if we can't get it.
+	 */
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
+	if (mok) {
+		rc = parse_efi_signature_list("UEFI:MokListRT",
+					      mok, moksize, get_handler_for_db);
+		kfree(mok);
+		if (rc)
+			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+		return rc;
+	}
+	if (status == EFI_NOT_FOUND)
+		pr_debug("MokListRT variable wasn't found\n");
+	else
+		pr_info("Couldn't get UEFI MokListRT\n");
+	return 0;
+}
+
+/*
+ * load_uefi_certs() - Load certs from UEFI sources
+ *
  * Load the certs contained in the UEFI databases into the platform trusted
  * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
  * keyring.
@@ -73,17 +110,16 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 static int __init load_uefi_certs(void)
 {
 	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
-	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
-	void *db = NULL, *dbx = NULL, *mok = NULL;
-	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
+	void *db = NULL, *dbx = NULL;
+	unsigned long dbsize = 0, dbxsize = 0;
 	efi_status_t status;
 	int rc = 0;
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return false;
 
-	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
-	 * an error if we can't get them.
+	/* Get db and dbx.  They might not exist, so it isn't an error
+	 * if we can't get them.
 	 */
 	if (!uefi_check_ignore_db()) {
 		db = get_cert_list(L"db", &secure_var, &dbsize, &status);
@@ -102,20 +138,6 @@ static int __init load_uefi_certs(void)
 		}
 	}
 
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
-	if (!mok) {
-		if (status == EFI_NOT_FOUND)
-			pr_debug("MokListRT variable wasn't found\n");
-		else
-			pr_info("Couldn't get UEFI MokListRT\n");
-	} else {
-		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
-		if (rc)
-			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-		kfree(mok);
-	}
-
 	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
 	if (!dbx) {
 		if (status == EFI_NOT_FOUND)
@@ -131,6 +153,9 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}
 
+	/* Load the MokListRT certs */
+	rc = load_moklist_certs();
+
 	return rc;
 }
 late_initcall(load_uefi_certs);
