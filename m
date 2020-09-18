Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1BF26F831
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIRIax (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIRIax (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BEEC06174A;
        Fri, 18 Sep 2020 01:30:53 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPdzdiptcSZjkzQG05H9ui92oeeNDOpTGXnYHK924OE=;
        b=jBTqhG6l1MjmY2cQC3InUJTU0If2XOK65g4LhfQ9nTcP6OC2yRtvvmT64s11ingjv0MDmH
        dEs6oJXohxBE3YPVXdxFUgW/lLzLvVIxcIGE2w0bMpM16mY7JwP6dzAwBh1FPcekkDWng3
        qBPjWS/NUfdC/OBlBq8Dw9jIlOhN5AlcfWpPdVDSotJd3BojSbghaEuD8t4cd5+ISmI6Me
        EdAKB2sLVc1uzL7LhKpWIyTTBqFqYBuzSZ5HFubWF9bUi+S/FWxE673w/AzU8IvONY7nc/
        /NjDvP35qjX7OsFgVQzClWPyUqOLHUAXpkcg/wVPNiEEuaov2JvOca597d3h7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPdzdiptcSZjkzQG05H9ui92oeeNDOpTGXnYHK924OE=;
        b=Xjsqu1r4r1pc9dyvyjPT8pUwSbXStRUIE6CpN1/RLZylcsEQbSOYQCOmO9665z7atErS0u
        r2jyAv5b/axLHjCg==
From:   "tip-bot2 for Alex Kluver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] cper,edac,efi: Memory Error Record: bank
 group/address and chip id
Cc:     Alex Kluver <alex.kluver@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819143544.155096-3-alex.kluver@hpe.com>
References: <20200819143544.155096-3-alex.kluver@hpe.com>
MIME-Version: 1.0
Message-ID: <160041785032.15536.13725748175597825918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     744de4180a43cb5264c1ba39d98c9eadcb228491
Gitweb:        https://git.kernel.org/tip/744de4180a43cb5264c1ba39d98c9eadcb228491
Author:        Alex Kluver <alex.kluver@hpe.com>
AuthorDate:    Wed, 19 Aug 2020 09:35:44 -05:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

cper,edac,efi: Memory Error Record: bank group/address and chip id

Updates to the UEFI 2.8 Memory Error Record allow splitting the bank field
into bank address and bank group, and using the last 3 bits of the extended
field as a chip identifier.

When needed, print correct version of bank field, bank group, and chip
identification.

Based on UEFI 2.8 Table 299. Memory Error Record.

Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
Reviewed-by: Russ Anderson <russ.anderson@hpe.com>
Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20200819143544.155096-3-alex.kluver@hpe.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/edac/ghes_edac.c    |  9 +++++++++
 drivers/firmware/efi/cper.c |  9 +++++++++
 include/linux/cper.h        |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 741e760..8a44f32 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -372,6 +372,12 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "rank:%d ", mem_err->rank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
 		p += sprintf(p, "bank:%d ", mem_err->bank);
+	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_GROUP)
+		p += sprintf(p, "bank_group:%d ",
+			     mem_err->bank >> CPER_MEM_BANK_GROUP_SHIFT);
+	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
+		p += sprintf(p, "bank_address:%d ",
+			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
 		u32 row = mem_err->row;
 
@@ -399,6 +405,9 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			strcpy(e->label, dimm->label);
 		}
 	}
+	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
+		p += sprintf(p, "chipID: %d ",
+			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
 	if (p > e->location)
 		*(p - 1) = '\0';
 
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index a60acd1..e15d484 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -232,6 +232,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "rank: %d ", mem->rank);
 	if (mem->validation_bits & CPER_MEM_VALID_BANK)
 		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
+	if (mem->validation_bits & CPER_MEM_VALID_BANK_GROUP)
+		n += scnprintf(msg + n, len - n, "bank_group: %d ",
+			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
+	if (mem->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
+		n += scnprintf(msg + n, len - n, "bank_address: %d ",
+			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
 		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
 	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
@@ -254,6 +260,9 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
 		scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
 			  mem->target_id);
+	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
+		scnprintf(msg + n, len - n, "chip_id: %d ",
+			  mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
 	msg[n] = '\0';
 	return n;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index bd2d8a7..6a511a1 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -231,10 +231,18 @@ enum {
 #define CPER_MEM_VALID_CARD_HANDLE		0x10000
 #define CPER_MEM_VALID_MODULE_HANDLE		0x20000
 #define CPER_MEM_VALID_ROW_EXT			0x40000
+#define CPER_MEM_VALID_BANK_GROUP		0x80000
+#define CPER_MEM_VALID_BANK_ADDRESS		0x100000
+#define CPER_MEM_VALID_CHIP_ID			0x200000
 
 #define CPER_MEM_EXT_ROW_MASK			0x3
 #define CPER_MEM_EXT_ROW_SHIFT			16
 
+#define CPER_MEM_BANK_ADDRESS_MASK		0xff
+#define CPER_MEM_BANK_GROUP_SHIFT		8
+
+#define CPER_MEM_CHIP_ID_SHIFT			5
+
 #define CPER_PCIE_VALID_PORT_TYPE		0x0001
 #define CPER_PCIE_VALID_VERSION			0x0002
 #define CPER_PCIE_VALID_COMMAND_STATUS		0x0004
