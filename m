Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06BA341E2E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCSN3j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCSN3S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 09:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE22C06175F;
        Fri, 19 Mar 2021 06:29:11 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:29:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616160549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W8cadyBPa/8J2mo72Ftnwcgf1KBVe6QICBL0FOunmDo=;
        b=2sFBpEJ0upvd6oozi7Qk8wY+FzDGpNfZQ7ZYjWXFmGvrQHhVemTh4qLH/Lo11iW7rwXASn
        IyTwHx4pl5+bEA6IvEqJQ+DuHiNycG2KLgeROIQkFdciOai4/RsOt828uLcbMfLUOqAqTr
        CL597LpnhdM9lIMu0IONkmZGOSOcNB8z02oVVmjPkggn3i1iHYob7akC3QphTY6axUYubg
        5tIdfs9Dxo6MAxKHmjFkluhs2QYWv+zVMo9sdIvpWIWwVRBL/PN19B82I3rWZmnAJENVqc
        yPb2R+n5wv1hotBvFGGu4TdH9w2bCTJVGSuFV3ix1oHVhC5MTm43hEeKNz5RxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616160549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W8cadyBPa/8J2mo72Ftnwcgf1KBVe6QICBL0FOunmDo=;
        b=IzSBxznkF3ybIEWChepudKcBUAyxwUDSIL1WnFSLBQLEpHAclFQ7uw44Ro5tnEwK8tR/xx
        r4POvsaCJpV8S1CA==
From:   "tip-bot2 for Lv Yunlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] firmware/efi: Fix a use after bug in
 efi_mem_reserve_persistent
Cc:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161616054920.398.5501549197969092499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     9ceee7d0841a8f7d7644021ba7d4cc1fbc7966e3
Gitweb:        https://git.kernel.org/tip/9ceee7d0841a8f7d7644021ba7d4cc1fbc7966e3
Author:        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
AuthorDate:    Wed, 10 Mar 2021 00:31:27 -08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 19 Mar 2021 07:44:27 +01:00

firmware/efi: Fix a use after bug in efi_mem_reserve_persistent

In the for loop in efi_mem_reserve_persistent(), prsv = rsv->next
use the unmapped rsv. Use the unmapped pages will cause segment
fault.

Fixes: 18df7577adae6 ("efi/memreserve: deal with memreserve entries in unmapped memory")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index df3f9bc..4b7ee3f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -927,7 +927,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	}
 
 	/* first try to find a slot in an existing linked list entry */
-	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+	for (prsv = efi_memreserve_root->next; prsv; ) {
 		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
@@ -937,6 +937,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			memunmap(rsv);
 			return efi_mem_reserve_iomem(addr, size);
 		}
+		prsv = rsv->next;
 		memunmap(rsv);
 	}
 
