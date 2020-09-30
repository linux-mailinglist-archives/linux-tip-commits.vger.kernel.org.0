Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD027E050
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgI3F2B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:28:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3F14 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:27:56 -0400
Date:   Wed, 30 Sep 2020 05:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zHuJBJyVEe4I5RoUUf2rEqqijN4uB8L+/ZP0p0P7Sb0=;
        b=EC8ewSzvf8FLlJ8wN3M8+XaJwkQ8smdveNnqixWukEAGs6UEv/YEaBO+4S2QBrhUYSaAD5
        mhayAu57NIPjzt8+oGRCjW6QICCnm5w2QQnDQPTunDkbKO2HlTOpslXZgwRVfaIzMh4ZXr
        Z3idVS6lX1gczYPQCG73BpiRmMLTI80NuUJz0LM//K2QtFAWgB6h0rZUnOKToZKjvIYcHb
        P/qza+OM0WSYbKYZ3bGRw03IlCFbYi7bn7/sbiJ8KM8D/1wUmOCeektWTkdX9sf4Kds+vM
        p+d8G2p7ZZbDMK3ZuVADEOyQPZz9uF78tyzsCWDxTwou7LHqJsJDFBDRs1XhKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zHuJBJyVEe4I5RoUUf2rEqqijN4uB8L+/ZP0p0P7Sb0=;
        b=tHYEbreyU6An/oxusUZrRdn+sq/Kw7nFsuToKG9o8B0DGaCtnFo2VJO4yvVRQ7PO1m9o/s
        4eQXiBtAmTAN0xBA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Add definition of EFI_MEMORY_CPU_CRYPTO and
 ability to report it
Cc:     Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144367294.7002.834008798403063519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     6277e374b0b07c1a93c829f0a27e38739b3b7a1b
Gitweb:        https://git.kernel.org/tip/6277e374b0b07c1a93c829f0a27e38739b3b7a1b
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 24 Sep 2020 13:52:24 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 25 Sep 2020 23:29:04 +02:00

efi: Add definition of EFI_MEMORY_CPU_CRYPTO and ability to report it

Incorporate the definition of EFI_MEMORY_CPU_CRYPTO from the UEFI
specification v2.8, and wire it into our memory map dumping routine
as well.

To make a bit of space in the output buffer, which is provided by
the various callers, shorten the descriptive names of the memory
types.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 47 ++++++++++++++++++-------------------
 include/linux/efi.h        |  1 +-
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3aa07c3..ebb59e5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -714,7 +714,7 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
 		vendor);
 }
 
-static __initdata char memory_type_name[][20] = {
+static __initdata char memory_type_name[][13] = {
 	"Reserved",
 	"Loader Code",
 	"Loader Data",
@@ -722,14 +722,14 @@ static __initdata char memory_type_name[][20] = {
 	"Boot Data",
 	"Runtime Code",
 	"Runtime Data",
-	"Conventional Memory",
-	"Unusable Memory",
-	"ACPI Reclaim Memory",
-	"ACPI Memory NVS",
-	"Memory Mapped I/O",
-	"MMIO Port Space",
+	"Conventional",
+	"Unusable",
+	"ACPI Reclaim",
+	"ACPI Mem NVS",
+	"MMIO",
+	"MMIO Port",
 	"PAL Code",
-	"Persistent Memory",
+	"Persistent",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
@@ -756,26 +756,27 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 	if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
-		     EFI_MEMORY_NV | EFI_MEMORY_SP |
+		     EFI_MEMORY_NV | EFI_MEMORY_SP | EFI_MEMORY_CPU_CRYPTO |
 		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
-			 attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
-			 attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
-			 attr & EFI_MEMORY_SP      ? "SP"  : "",
-			 attr & EFI_MEMORY_NV      ? "NV"  : "",
-			 attr & EFI_MEMORY_XP      ? "XP"  : "",
-			 attr & EFI_MEMORY_RP      ? "RP"  : "",
-			 attr & EFI_MEMORY_WP      ? "WP"  : "",
-			 attr & EFI_MEMORY_RO      ? "RO"  : "",
-			 attr & EFI_MEMORY_UCE     ? "UCE" : "",
-			 attr & EFI_MEMORY_WB      ? "WB"  : "",
-			 attr & EFI_MEMORY_WT      ? "WT"  : "",
-			 attr & EFI_MEMORY_WC      ? "WC"  : "",
-			 attr & EFI_MEMORY_UC      ? "UC"  : "");
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 attr & EFI_MEMORY_RUNTIME		? "RUN" : "",
+			 attr & EFI_MEMORY_MORE_RELIABLE	? "MR"  : "",
+			 attr & EFI_MEMORY_CPU_CRYPTO   	? "CC"  : "",
+			 attr & EFI_MEMORY_SP			? "SP"  : "",
+			 attr & EFI_MEMORY_NV			? "NV"  : "",
+			 attr & EFI_MEMORY_XP			? "XP"  : "",
+			 attr & EFI_MEMORY_RP			? "RP"  : "",
+			 attr & EFI_MEMORY_WP			? "WP"  : "",
+			 attr & EFI_MEMORY_RO			? "RO"  : "",
+			 attr & EFI_MEMORY_UCE			? "UCE" : "",
+			 attr & EFI_MEMORY_WB			? "WB"  : "",
+			 attr & EFI_MEMORY_WT			? "WT"  : "",
+			 attr & EFI_MEMORY_WC			? "WC"  : "",
+			 attr & EFI_MEMORY_UC			? "UC"  : "");
 	return buf;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 73db1ae..f216c02 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -122,6 +122,7 @@ typedef	struct {
 				((u64)0x0000000000010000ULL)	/* higher reliability */
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
 #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
+#define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
