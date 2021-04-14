Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E135ED2C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Apr 2021 08:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349157AbhDNGWk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Apr 2021 02:22:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhDNGWi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Apr 2021 02:22:38 -0400
Date:   Wed, 14 Apr 2021 06:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618381335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sj8bKQs3EzaDo1n24IZ7KqWvkhErmm1PrSIWnyuBl1I=;
        b=asast63DGsjZ1sz8ZaEtepCNbMu9OG/HV8166DvS+9Ta28rHVooyJLFmBOMxG0yTfAAkAU
        RE2nQK0QCiMqJKX/zbo9oVRJi3PbMkUhJ2T9bfVAI5oEaY4Qiw/eD5JMN2J9/WR+x1htGj
        RVgrgetUVRKK27JCcKW0U6NWKoMx1QrRielCTKLp/RaxbbUwSONEu77AwLyxJWOrWulZfj
        FkdoATUhLJfVLfearKjuukuzS5eFkgt85zffaB7r+yBOkS0AeCmiqqxXD4k2Z9SHpfWs/y
        uSOrFP9sphVCW3QU8fI9f00vgy8pZeSc7pL7FR2Golzmp2CD85KkqxNuazmQ8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618381335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sj8bKQs3EzaDo1n24IZ7KqWvkhErmm1PrSIWnyuBl1I=;
        b=5wIhF45LzyXhv//dLiJ6MzpzsG9ZAngO+VD3oiwt9IFzVmPskk+T3oROAKItX6PSPBrAmS
        PGrVX+1nAkdoxgCA==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Move trim_snb_memory() later in
 setup_arch() to fix boot hangs
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@suse.de>, Hugh Dickins <hughd@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f67d3e03-af90-f790-baf4-8d412fe055af@infradead.org>
References: <f67d3e03-af90-f790-baf4-8d412fe055af@infradead.org>
MIME-Version: 1.0
Message-ID: <161838133498.29796.12540775721070465830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     c361e5d4d07d63768880e1994c7ed999b3a94cd9
Gitweb:        https://git.kernel.org/tip/c361e5d4d07d63768880e1994c7ed999b3a94cd9
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Tue, 13 Apr 2021 21:08:39 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 14 Apr 2021 08:16:48 +02:00

x86/setup: Move trim_snb_memory() later in setup_arch() to fix boot hangs

Commit

  a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")

moved reservation of the memory inaccessible by Sandy Bride integrated
graphics very early, and, as a result, on systems with such devices
the first 1M was reserved by trim_snb_memory() which prevented the
allocation of the real mode trampoline and made the boot hang very
early.

Since the purpose of trim_snb_memory() is to prevent problematic pages
ever reaching the graphics device, it is safe to reserve these pages
after memblock allocations are possible.

Move trim_snb_memory() later in boot so that it will be called after
reserve_real_mode() and make comments describing trim_snb_memory()
operation more elaborate.

 [ bp: Massage a bit. ]

Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Hugh Dickins <hughd@google.com>
Link: https://lkml.kernel.org/r/f67d3e03-af90-f790-baf4-8d412fe055af@infradead.org
---
 arch/x86/kernel/setup.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 776fc9b..e93283e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -633,11 +633,16 @@ static void __init trim_snb_memory(void)
 	printk(KERN_DEBUG "reserving inaccessible SNB gfx pages\n");
 
 	/*
-	 * Reserve all memory below the 1 MB mark that has not
-	 * already been reserved.
+	 * SandyBridge integrated graphics devices have a bug that prevents
+	 * them from accessing certain memory ranges, namely anything below
+	 * 1M and in the pages listed in bad_pages[] above.
+	 *
+	 * To avoid these pages being ever accessed by SNB gfx devices
+	 * reserve all memory below the 1 MB mark and bad_pages that have
+	 * not already been reserved at boot time.
 	 */
 	memblock_reserve(0, 1<<20);
-	
+
 	for (i = 0; i < ARRAY_SIZE(bad_pages); i++) {
 		if (memblock_reserve(bad_pages[i], PAGE_SIZE))
 			printk(KERN_WARNING "failed to reserve 0x%08lx\n",
@@ -746,8 +751,6 @@ static void __init early_reserve_memory(void)
 
 	reserve_ibft_region();
 	reserve_bios_regions();
-
-	trim_snb_memory();
 }
 
 /*
@@ -1081,6 +1084,13 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_real_mode();
 
+	/*
+	 * Reserving memory causing GPU hangs on Sandy Bridge integrated
+	 * graphics devices should be done after we allocated memory under
+	 * 1M for the real mode trampoline.
+	 */
+	trim_snb_memory();
+
 	init_mem_mapping();
 
 	idt_setup_early_pf();
