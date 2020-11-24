Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528AE2C294B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgKXOU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:20:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbgKXOU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:58 -0500
Date:   Tue, 24 Nov 2020 14:20:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOlvKbwtqvidlv9IbLs7NOkcr9pQYeP8LAS76xG21Qg=;
        b=wQgeptMM4+rSJTWdBB+F1/pj/IvJGGSdeKOnbv3cHB+mM4C8i0S5UA7gZD7GTI1EJZqxyo
        wvSUe+AMdnXRZ1iWMIDto4I/mdYlADxqjdBWZHCRuKX88B+K7VYjTp+UxlMP1M3lP8otFU
        mxe2LBAQ43RIaPWsveOyTGp/hRUzFOZ5pyBlpDXNIP+APrQz3j5Oe9BpkyyyC9cxETeTt2
        9D2VGb8pOQHoOrbdEeyqwnWlwbz5dWd/NPrtbv5+nEoyTGu98r9ydWZofszsUfyg8OuSBn
        +uFfhCVG1PFC3ZOPhyUfvT3w9No3Hk3dP4Dkp79YeURBbOcGzXPTlsIj1em5Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOlvKbwtqvidlv9IbLs7NOkcr9pQYeP8LAS76xG21Qg=;
        b=yz+NM4iTbDk/H5bMgLIYIUJGcsKf+2o6P7fYmwSpdRQaCZs6GUUDSdUU8ZHEFzuIwrNegj
        /hk8GbxLdAGJnIBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.028261233@linutronix.de>
References: <20201118204007.028261233@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765526.11115.1698682998375970525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     0e91a0c6984c837a7c6760e3f28e8e1c532abf87
Gitweb:        https://git.kernel.org/tip/0e91a0c6984c837a7c6760e3f28e8e1c532abf87
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:08 +01:00

mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP

CONFIG_DEBUG_KMAP_LOCAL, which is selected by CONFIG_DEBUG_HIGHMEM is only
providing guard pages, but does not provide a mechanism to enforce the
usage of the kmap_local() infrastructure.

Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP which forces the temporary
mapping even for lowmem pages. This needs to be a seperate config switch
because this only works on architectures which do not have cache aliasing
problems.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.028261233@linutronix.de

---
 lib/Kconfig.debug | 14 ++++++++++++++
 mm/highmem.c      | 12 +++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f24fa15..e952f89 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -856,9 +856,23 @@ config DEBUG_KMAP_LOCAL
 	  This option enables additional error checking for the kmap_local
 	  infrastructure.  Disable for production use.
 
+config ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	bool
+
+config DEBUG_KMAP_LOCAL_FORCE_MAP
+	bool "Enforce kmap_local temporary mappings"
+	depends on DEBUG_KERNEL && ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	select KMAP_LOCAL
+	select DEBUG_KMAP_LOCAL
+	help
+	  This option enforces temporary mappings through the kmap_local
+	  mechanism for non-highmem pages and on non-highmem systems.
+	  Disable this for production systems!
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
+	select DEBUG_KMAP_LOCAL_FORCE_MAP if ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
 	select DEBUG_KMAP_LOCAL
 	help
 	  This option enables additional error checking for high memory
diff --git a/mm/highmem.c b/mm/highmem.c
index fab128d..39aaca1 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -474,7 +474,12 @@ void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
 {
 	void *kmap;
 
-	if (!PageHighMem(page))
+	/*
+	 * To broaden the usage of the actual kmap_local() machinery always map
+	 * pages when debugging is enabled and the architecture has no problems
+	 * with alias mappings.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
 		return page_address(page);
 
 	/* Try kmap_high_get() if architecture has it enabled */
@@ -494,6 +499,11 @@ void kunmap_local_indexed(void *vaddr)
 
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
 	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
+		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP)) {
+			/* This _should_ never happen! See above. */
+			WARN_ON_ONCE(1);
+			return;
+		}
 		/*
 		 * Handle mappings which were obtained by kmap_high_get()
 		 * first as the virtual address of such mappings is below
