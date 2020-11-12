Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7228D2B06ED
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Nov 2020 14:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKLNsU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Nov 2020 08:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKLNsU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Nov 2020 08:48:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA94C0613D1;
        Thu, 12 Nov 2020 05:48:20 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605188898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxcKLusCpufT+m8ruOGOq6YJs7J/asijBD9ZKdep9R8=;
        b=ZIBE8m9EtcY69mOO8lxsgrxWkOnfXMOo7L//UfdTpLveKQgoPoRRfOiDE1oy/VoM1EP2Qj
        CVHaMKl5APXWbmj6NZwUHSbbSUD1aBtfPbVywX+P3YhcEarvzeLwG8FbyXSCUkHh6bXGoZ
        NyGoM73u0w4hNA0NVUbyymVNgK2YVHt0wiSfiiMkZdAUU6+t6L2prOY9jVuG8jVSGPKORa
        oB4nWsSlVNCx1nMd0OCaMuAYz/zpv43Yasy+kPQ1wOkVPl0TNRJMJf1Ju8H4GNvE4HTtm0
        Rvi67ZgpM2ISLJKuxdXtAeUyJMCtWMzOnVVQIdmpujxxfT9IbaBWh8crKizdow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605188898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxcKLusCpufT+m8ruOGOq6YJs7J/asijBD9ZKdep9R8=;
        b=lVQqU4zJje9KxG1JvspBMrzQmbQ+DQH2/aj0ybrcoUd5wVsGYC38TeDY22Ip7TXdLx9e0J
        89zpjqyelCxmfpCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mm/highmem: Take kmap_high_get() properly into account
Cc:     vtolkm@googlemail.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87y2j6n8mj.fsf@nanos.tec.linutronix.de>
References: <87y2j6n8mj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160518889672.11244.12357999747948053258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     2a656cad337e0e1ca582f58847d7b0c7eeba4dc8
Gitweb:        https://git.kernel.org/tip/2a656cad337e0e1ca582f58847d7b0c7eeba4dc8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 Nov 2020 11:59:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Nov 2020 14:44:38 +01:00

mm/highmem: Take kmap_high_get() properly into account

kunmap_local() warns when the virtual address to unmap is below
PAGE_OFFSET. This is correct except for the case that the mapping was
obtained via kmap_high_get() because the PKMAP addresses are right below
PAGE_OFFSET.

Cure it by skipping the WARN_ON() when the unmap was handled by
kunmap_high().

Fixes: 298fa1ad5571 ("highmem: Provide generic variant of kmap_atomic*")
Reported-by: vtolkm@googlemail.com
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/87y2j6n8mj.fsf@nanos.tec.linutronix.de

---
 mm/highmem.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 54bd233..78c481a 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -426,12 +426,15 @@ static inline void *arch_kmap_local_high_get(struct page *page)
 #endif
 
 /* Unmap a local mapping which was obtained by kmap_high_get() */
-static inline void kmap_high_unmap_local(unsigned long vaddr)
+static inline bool kmap_high_unmap_local(unsigned long vaddr)
 {
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
-	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP))
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
 		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+		return true;
+	}
 #endif
+	return false;
 }
 
 static inline int kmap_local_calc_idx(int idx)
@@ -491,10 +494,14 @@ void kunmap_local_indexed(void *vaddr)
 
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
 	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
-		WARN_ON_ONCE(addr < PAGE_OFFSET);
-
-		/* Handle mappings which were obtained by kmap_high_get() */
-		kmap_high_unmap_local(addr);
+		/*
+		 * Handle mappings which were obtained by kmap_high_get()
+		 * first as the virtual address of such mappings is below
+		 * PAGE_OFFSET. Warn for all other addresses which are in
+		 * the user space part of the virtual address space.
+		 */
+		if (!kmap_high_unmap_local(addr))
+			WARN_ON_ONCE(addr < PAGE_OFFSET);
 		return;
 	}
 
