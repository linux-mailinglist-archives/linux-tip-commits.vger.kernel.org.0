Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D833E553B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhHJIbY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhHJIbX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 04:31:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526AC0613D3;
        Tue, 10 Aug 2021 01:31:01 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:30:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628584260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7HjRDIjNqfK+qFasi9Tib9scBguwaVdAtrtSBcq5/PM=;
        b=F1o2gFDc/8uCoogDeoI/9R6Hw4ObJ7N3Fmp/qONT0afnV1QXjbHwKZX641Q7FIz6UaxN+G
        dldAVCfqC0ZymHMXRJCf9uohLiFKnp6KqC7i1CXPdqTbFR2bDNRqI75ab9x49zhi7RAtC3
        Itr5eoAKI7kOyU7dVqIydkcIfQXOLCqU9UToahfko/+WaKWI4zhQRyTNsrLuNFnlOwrJsL
        oB8pKuT6YCFyYx0QjV2z5/4b6P8NNz3GaWk6ey+96fjnth85oMQl8qe3nNWiD+PMDFIe69
        +5MIhYXgt0gBgbMIC6JUqBAxN+TaOYwIBKmwot4E+xPmKOYOXsoGwuM+acqI0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628584260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7HjRDIjNqfK+qFasi9Tib9scBguwaVdAtrtSBcq5/PM=;
        b=oLa/CP9dJEu1BZcOCmLGtcnWLiUHBy5zdzy/TCeyJLIW/Jdt1gbOnG5DT62Z4pb7az75sn
        Rviy1zhUDHOPooDg==
From:   "tip-bot2 for Benjamin Herrenschmidt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] arm64: efi: kaslr: Fix occasional random alloc (and
 boot) failure
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162858425940.395.10120273996320273273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     4152433c397697acc4b02c4a10d17d5859c2730d
Gitweb:        https://git.kernel.org/tip/4152433c397697acc4b02c4a10d17d5859c2730d
Author:        Benjamin Herrenschmidt <benh@kernel.crashing.org>
AuthorDate:    Tue, 20 Jul 2021 21:14:05 +10:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 20 Jul 2021 16:49:48 +02:00

arm64: efi: kaslr: Fix occasional random alloc (and boot) failure

The EFI stub random allocator used for kaslr on arm64 has a subtle
bug. In function get_entry_num_slots() which counts the number of
possible allocation "slots" for the image in a given chunk of free
EFI memory, "last_slot" can become negative if the chunk is smaller
than the requested allocation size.

The test "if (first_slot > last_slot)" doesn't catch it because
both first_slot and last_slot are unsigned.

I chose not to make them signed to avoid problems if this is ever
used on architectures where there are meaningful addresses with the
top bit set. Instead, fix it with an additional test against the
allocation size.

This can cause a boot failure in addition to a loss of randomisation
due to another bug in the arm64 stub fixed separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 2ddbfc81eac8 ("efi: stub: add implementation of efi_random_alloc()")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index a408df4..724155b 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -30,6 +30,8 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
 			 (u64)ULONG_MAX);
+	if (region_end < size)
+		return 0;
 
 	first_slot = round_up(md->phys_addr, align);
 	last_slot = round_down(region_end - size + 1, align);
