Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7EB23E48D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgHFXjB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:39:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgHFXjA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:00 -0400
Date:   Thu, 06 Aug 2020 23:38:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoGwbeniZcTcC+/aO5s8sy1siKGbmbzC9qilfsWJ9cw=;
        b=oOwKOdDUFN712jZW3717UqSaaQBAQdVOS2B3IJ2EbBefWzXM8bB1vzgqYP9DXNiebS3J0A
        M54waJMheSFcipBBg4WzeYpPkrUggeRgX3LMWutG6BanflYN7+gpdjH6R3EiHppyQ15Vda
        rM+evyyAugWrgBd/0Zyvvac4MDckR0gAZhu1Mv7mXd5EbZyUhIPjY2IUL6sHlQadOJPjwv
        nT9MkfIQDPl1ezyityXACEsN06g3aGrdO/KR2tawZLOEqZD7cP+p0HcdY0qgsVAIHjTLEX
        fcA25Mr+gRm6wCaXZjv+nVox3hbmB/suWJNM83jx9dBDMCMnjH/dTJs0kidQfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoGwbeniZcTcC+/aO5s8sy1siKGbmbzC9qilfsWJ9cw=;
        b=+iyxTgflByffOv3KvHmacDqaDjKM08r+H2lcV9ddkIYqgNdfOrb2G4ecdv/LIh0s1A/1ZN
        UOy+JbuUYqUbDoCw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Fix off-by-one error in process_gb_huge_pages()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-11-nivedita@alum.mit.edu>
References: <20200728225722.67457-11-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713763.3192.15033718411509821639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     79c2fd2afe55944098047721c33e06fd48654e57
Gitweb:        https://git.kernel.org/tip/79c2fd2afe55944098047721c33e06fd48654e57
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:11 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Fix off-by-one error in process_gb_huge_pages()

If the remaining size of the region is exactly 1Gb, there is still one
hugepage that can be reserved.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-11-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d074986..0df513e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -562,7 +562,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 		size = region->size - (addr - region->start);
 
 	/* Check how many 1GB huge pages can be filtered out: */
-	while (size > PUD_SIZE && max_gb_huge_pages) {
+	while (size >= PUD_SIZE && max_gb_huge_pages) {
 		size -= PUD_SIZE;
 		max_gb_huge_pages--;
 		i++;
