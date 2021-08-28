Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00243FA505
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhH1Kif (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Aug 2021 06:38:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhH1Kif (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Aug 2021 06:38:35 -0400
Date:   Sat, 28 Aug 2021 10:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630147064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GUBreEWSeJdI+xIgn8oqqOgSWLasoexxUz4WbzqcM6w=;
        b=2e1sQM7gZrHU8CcrVIwOWyDTxiRizUg7zwPXcl7ebXe/qnjSmdE4jpzjlz58xivYO1aobK
        nWvC4oQ8ORkY/W4FixWd8nIQvbrKMtErxBLNQHV8MGWvg+wDcWUvGApAM7qFWozfQmhRvX
        0lIXYTDnxoDMiswo45pIoQ0UsnHOoaQ5NW2fCvtlQg+ygl/xzM7xfldF2UBpARZNWmfKtI
        qi/vr2ua3xxFh3ABOCzgz0vPqIqrYjaoe8uRiITiavEPNFLcLtv6R5AL31aMF1pp5gBLAo
        lng+4Ska2o/ydR+k4qGi2bZ8sYPpg7cugqqGuKNHWt/j+TjxAQwtR3TNPHv5/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630147064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GUBreEWSeJdI+xIgn8oqqOgSWLasoexxUz4WbzqcM6w=;
        b=gYNVnionqJ7sFTpLkET7aHnWfSh4TfSIWZ0EAvRisvefM4CkKMdt1EgzOoPnQOAovRj2ij
        VSQyiofcBG5JHOAw==
From:   "tip-bot2 for Shuai Xue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: cper: check section header more appropriately
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163014706251.25758.11166991934016346418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     1be72c8e0786727df375f11c8178ce7e65eea20e
Gitweb:        https://git.kernel.org/tip/1be72c8e0786727df375f11c8178ce7e65eea20e
Author:        Shuai Xue <xueshuai@linux.alibaba.com>
AuthorDate:    Mon, 23 Aug 2021 19:56:54 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 27 Aug 2021 16:03:01 +02:00

efi: cper: check section header more appropriately

When checking a generic status block, we iterate over all the generic data
blocks. The loop condition checks that the generic data block is valid.
Because the size of data blocks (excluding error data) may vary depending
on the revision and the revision is contained within the data block, we
should ensure that enough of the current data block is valid appropriately
for different revision.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 1cb7097..73bdbd2 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -632,7 +632,7 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 	data_len = estatus->data_length;
 
 	apei_estatus_for_each_section(estatus, gdata) {
-		if (sizeof(struct acpi_hest_generic_data) > data_len)
+		if (acpi_hest_get_size(gdata) > data_len)
 			return -EINVAL;
 
 		record_size = acpi_hest_get_record_size(gdata);
