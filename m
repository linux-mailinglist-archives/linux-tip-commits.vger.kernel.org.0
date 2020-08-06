Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE623E48B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHFXjo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:39:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHFXjC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:02 -0400
Date:   Thu, 06 Aug 2020 23:38:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIGrTTZO8Vb6uguCHq7CReG5mB4gQDWIPh2rz0ZRPps=;
        b=WGVHDR7mYrK3xuLf0IN3ZHC3AIPLhO+y4bPGyuSJxgOsWKnmzCU5Vo4FNKf02ghyIlFT6U
        NYRu/RImwPIcJp0ZqZtPb+9+/Y5LG/meq7cyBVSrUoSzQtB5bA9OgW4yjCRGDZavPkZ8yY
        j0z6hiiZ8zAqEGJaiBTwCDW3j0LOy6xz3oUxeRwqvHP6x7wSgvQif/gSOxg+5f6ZvZCkSm
        WV/MZRQcDavtTdVVObpuZ4m0/YO5BTseLQZJqGwHWjuUGasL6xXstpGgZ/GPwYxDW6hcXy
        86ZFGjk1iLN3KRrJ6FYW/rY3R1v5XPFOtixvIEeMUNTylgyTiMmaGYWRDWAs/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIGrTTZO8Vb6uguCHq7CReG5mB4gQDWIPh2rz0ZRPps=;
        b=zRgfygqie4KZ4cgy03Ge3KzHNj6g+rDT7Qn7/sygl6lU9fXeuE1vTOsheE7txKnbU+JXeQ
        MeyGHuHoiH2fDWAA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Eliminate 'start_orig' local variable
 from __process_mem_region()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-8-nivedita@alum.mit.edu>
References: <20200728225722.67457-8-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713954.3192.11679980179045433723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     ee435ee6490d147c1b9963cc8b331665e4cea634
Gitweb:        https://git.kernel.org/tip/ee435ee6490d147c1b9963cc8b331665e4cea634
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:08 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Eliminate 'start_orig' local variable from __process_mem_region()

Set the region.size within the loop, which removes the need for
start_orig.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-8-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index f2454ee..e978c35 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -623,7 +623,7 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long start_orig, end;
+	unsigned long end;
 
 	/* Ignore entries entirely below our minimum. */
 	if (entry->start + entry->size < minimum)
@@ -635,12 +635,9 @@ static void __process_mem_region(struct mem_vector *entry,
 		return;
 
 	region.start = entry->start;
-	region.size = end - entry->start;
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
-		start_orig = region.start;
-
 		/* Potentially raise address to minimum location. */
 		if (region.start < minimum)
 			region.start = minimum;
@@ -653,7 +650,7 @@ static void __process_mem_region(struct mem_vector *entry,
 			return;
 
 		/* Reduce size by any delta from the original address. */
-		region.size -= region.start - start_orig;
+		region.size = end - region.start;
 
 		/* Return if region can't contain decompressed kernel */
 		if (region.size < image_size)
@@ -679,7 +676,6 @@ static void __process_mem_region(struct mem_vector *entry,
 			return;
 
 		/* Clip off the overlapping region and start over. */
-		region.size -= overlap.start - region.start + overlap.size;
 		region.start = overlap.start + overlap.size;
 	}
 }
