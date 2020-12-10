Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6722D59BC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgLJLvo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 06:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgLJLuf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC97C061793;
        Thu, 10 Dec 2020 03:49:52 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:49:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5GQN4mn1P1KL//i0g2/QPiHW8lyaRpwwOVoX1FdFmIs=;
        b=c8ls0MzoO4vXCkToDHKsA6NxvgbmroowC+XSkrzj6lxWiq9qJFMc4spE0+G06DiiRgZoGg
        SMbTKhS9b0MR1418uy20DPABiiLbzVbTpuVs0uKXJl0+kb2+uxrfPFH4sxxN4sJpvPX9mH
        vUtJXFTTp9+BhDTNrH524EyYjQipDaQuZCQMJyKTrrMjzuQyy0hNs69OKRzAKgu2VgJ3tv
        qbb91S4tRKTEZ7u/UXqLVcvVV6K0cLDTgzKZqRkMLPcMdkStr71igz0a26C5nHKI6OSbZb
        K6RZxgn2xKR+fcdSEjdJjOngl0eRjOvmlKTQclie56CCopPWEctr7Uljfr/GEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5GQN4mn1P1KL//i0g2/QPiHW8lyaRpwwOVoX1FdFmIs=;
        b=ycQ7rLW96Tc00kW8e0emb+28UcY/WbhXR9QtTD+fSHKGeGGwDIZHpqKSZJU3WWoCH3sz1f
        gBbr6xtefocmS1AA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: capsule: use atomic kmap for transient sglist mappings
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160760099049.3364.7954271687064316032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     91c1c092f27da4164d55ca81e0a483108f8a3235
Gitweb:        https://git.kernel.org/tip/91c1c092f27da4164d55ca81e0a483108f8a3235
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Dec 2020 17:33:33 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 07 Dec 2020 19:31:43 +01:00

efi: capsule: use atomic kmap for transient sglist mappings

Don't use the heavy-weight kmap() API to create short-lived mappings
of the scatter-gather list entries that are released as soon as the
entries are written. Instead, use kmap_atomic(), which is more suited
to this purpose.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/capsule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/capsule.c b/drivers/firmware/efi/capsule.c
index 598b780..43f6fe7 100644
--- a/drivers/firmware/efi/capsule.c
+++ b/drivers/firmware/efi/capsule.c
@@ -244,7 +244,7 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 	for (i = 0; i < sg_count; i++) {
 		efi_capsule_block_desc_t *sglist;
 
-		sglist = kmap(sg_pages[i]);
+		sglist = kmap_atomic(sg_pages[i]);
 
 		for (j = 0; j < SGLIST_PER_PAGE && count > 0; j++) {
 			u64 sz = min_t(u64, imagesize,
@@ -265,7 +265,7 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 		else
 			sglist[j].data = page_to_phys(sg_pages[i + 1]);
 
-		kunmap(sg_pages[i]);
+		kunmap_atomic(sglist);
 	}
 
 	mutex_lock(&capsule_mutex);
