Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448CC27E02E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgI3FWe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI3FWZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF6C0613D0;
        Tue, 29 Sep 2020 22:22:25 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ktoE9HIQRkjQ8Uk2grnAdlixIkQr4pzMLC20cg3DSg=;
        b=YgimaRX4N+GP5nX+KCrzc97Pd2bQ4ZrSwhCDMF3oJWerWWxjC3vGg5ATOAn7HRsaxahFSg
        fnPgj4KS+WXk+UT+ekJJh9gqT542bZgDpYkkXYhLb/mjoUYthalRns0GRQhuhm7ZBN5L0I
        MKo9xN1nRVMmQ/mTvZTVQrdNR4U7kdiAxzuR5ZOfq5R5GSburhrCsmjZx5nDWS9ldc/fV0
        I8VyUM7qwnncHBwSHW18wZ1jtrI6TdfL8bWbPd8I9FkZOvP++9UkJt0nZq5lo9bIn2pKsj
        /Ets9V9kHWaM9+rcqP6p0JbqjcudCtFWrOEcz7T8ezx2cQV+qcfo5aZYZgGdeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ktoE9HIQRkjQ8Uk2grnAdlixIkQr4pzMLC20cg3DSg=;
        b=fcw57bFFcmPditNrAi9L/u993gkAjrrpgu4qXSgd7ho93dqjbVGSfwCHPWUnkKe93BSEYI
        RiWvHj5r6C18LdBg==
From:   "tip-bot2 for Alex Kluver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] edac,ghes,cper: Add Row Extension to Memory Error Record
Cc:     Alex Kluver <alex.kluver@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819143544.155096-2-alex.kluver@hpe.com>
References: <20200819143544.155096-2-alex.kluver@hpe.com>
MIME-Version: 1.0
Message-ID: <160144334312.7002.4729772508224882553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     9baf68cc4544056f33797b78ec09388f54ecc8f0
Gitweb:        https://git.kernel.org/tip/9baf68cc4544056f33797b78ec09388f54ecc8f0
Author:        Alex Kluver <alex.kluver@hpe.com>
AuthorDate:    Wed, 19 Aug 2020 09:35:43 -05:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 17 Sep 2020 10:19:52 +03:00

edac,ghes,cper: Add Row Extension to Memory Error Record

Memory errors could be printed with incorrect row values since the DIMM
size has outgrown the 16 bit row field in the CPER structure. UEFI
Specification Version 2.8 has increased the size of row by allowing it to
use the first 2 bits from a previously reserved space within the structure.

When needed, add the extension bits to the row value printed.

Based on UEFI 2.8 Table 299. Memory Error Record

Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
Tested-by: Russ Anderson <russ.anderson@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20200819143544.155096-2-alex.kluver@hpe.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/edac/ghes_edac.c    |  8 ++++++--
 drivers/firmware/efi/cper.c |  9 +++++++--
 include/linux/cper.h        | 16 ++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index da60c29..741e760 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -372,8 +372,12 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "rank:%d ", mem_err->rank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
 		p += sprintf(p, "bank:%d ", mem_err->bank);
-	if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
-		p += sprintf(p, "row:%d ", mem_err->row);
+	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
+		u32 row = mem_err->row;
+
+		row |= cper_get_mem_extension(mem_err->validation_bits, mem_err->extended);
+		p += sprintf(p, "row:%d ", row);
+	}
 	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
 		p += sprintf(p, "col:%d ", mem_err->column);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index f564e15..a60acd1 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -234,8 +234,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
 		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
-	if (mem->validation_bits & CPER_MEM_VALID_ROW)
-		n += scnprintf(msg + n, len - n, "row: %d ", mem->row);
+	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
+		u32 row = mem->row;
+
+		row |= cper_get_mem_extension(mem->validation_bits, mem->extended);
+		n += scnprintf(msg + n, len - n, "row: %d ", row);
+	}
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
 		n += scnprintf(msg + n, len - n, "column: %d ", mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
@@ -292,6 +296,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->requestor_id = mem->requestor_id;
 	cmem->responder_id = mem->responder_id;
 	cmem->target_id = mem->target_id;
+	cmem->extended = mem->extended;
 	cmem->rank = mem->rank;
 	cmem->mem_array_handle = mem->mem_array_handle;
 	cmem->mem_dev_handle = mem->mem_dev_handle;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 8537e92..bd2d8a7 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -230,6 +230,10 @@ enum {
 #define CPER_MEM_VALID_RANK_NUMBER		0x8000
 #define CPER_MEM_VALID_CARD_HANDLE		0x10000
 #define CPER_MEM_VALID_MODULE_HANDLE		0x20000
+#define CPER_MEM_VALID_ROW_EXT			0x40000
+
+#define CPER_MEM_EXT_ROW_MASK			0x3
+#define CPER_MEM_EXT_ROW_SHIFT			16
 
 #define CPER_PCIE_VALID_PORT_TYPE		0x0001
 #define CPER_PCIE_VALID_VERSION			0x0002
@@ -443,7 +447,7 @@ struct cper_sec_mem_err_old {
 	u8	error_type;
 };
 
-/* Memory Error Section (UEFI >= v2.3), UEFI v2.7 sec N.2.5 */
+/* Memory Error Section (UEFI >= v2.3), UEFI v2.8 sec N.2.5 */
 struct cper_sec_mem_err {
 	u64	validation_bits;
 	u64	error_status;
@@ -461,7 +465,7 @@ struct cper_sec_mem_err {
 	u64	responder_id;
 	u64	target_id;
 	u8	error_type;
-	u8	reserved;
+	u8	extended;
 	u16	rank;
 	u16	mem_array_handle;	/* "card handle" in UEFI 2.4 */
 	u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
@@ -483,8 +487,16 @@ struct cper_mem_err_compact {
 	u16	rank;
 	u16	mem_array_handle;
 	u16	mem_dev_handle;
+	u8      extended;
 };
 
+static inline u32 cper_get_mem_extension(u64 mem_valid, u8 mem_extended)
+{
+	if (!(mem_valid & CPER_MEM_VALID_ROW_EXT))
+		return 0;
+	return (mem_extended & CPER_MEM_EXT_ROW_MASK) << CPER_MEM_EXT_ROW_SHIFT;
+}
+
 /* PCI Express Error Section, UEFI v2.7 sec N.2.7 */
 struct cper_sec_pcie {
 	u64		validation_bits;
