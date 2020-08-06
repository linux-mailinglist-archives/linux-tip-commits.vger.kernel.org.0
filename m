Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED723E486
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHFXjd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:39:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHFXjD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:03 -0400
Date:   Thu, 06 Aug 2020 23:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbGZi1eZc6TtzevOnBf91sbjHgLai7dijbdLr8UQ+Dg=;
        b=q9P/FZV0juIRExkQCl4w1lu+de/IDSfo1dUA3mT7YT2hViIz43cI8rvX+TGifod/GjyfaC
        EBUwIQYiulR+vbdyLGH9JQnIdjkSC9wwxU/aVBmxxY1tj4xi8Cu/thDj2O5uiwAjjnyEBb
        8CfxfLDZz+n6wKyGeEFdZ3MwF9JS3y/Hovt4rF3HU0Kzork+v1+kkSW2JFHUzlNTMKIakq
        iv9Cc26tZcum7I58qreDCGHE9nu1Q8PIjUlRIyDa2I/bDPotCYeN30Z2IKEN0Tg+il9Xs5
        oHNKG/MdwcvFn9DMsIDght93bOvZUVU8LuIOwVX00v/9PnEGOAdOxMaeAc2iog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbGZi1eZc6TtzevOnBf91sbjHgLai7dijbdLr8UQ+Dg=;
        b=+HS39mQ4AEnUOjIO/qRz7wR5w+Zc14cbj2ZNwCqfM72s2HW4E9ZpEHuyK4DKBdA2igolw5
        L8POtghZdCJTY3Cg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Fix off-by-one error in __process_mem_region()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-6-nivedita@alum.mit.edu>
References: <20200728225722.67457-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675714094.3192.4263482900685835481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     8d1cf8595860f4807f4ff1f8f1fc53e7576e0d71
Gitweb:        https://git.kernel.org/tip/8d1cf8595860f4807f4ff1f8f1fc53e7576e0d71
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:06 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Fix off-by-one error in __process_mem_region()

In case of an overlap, the beginning of the region should be used even
if it is exactly image_size, not just strictly larger.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-6-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index da45e66..848346f 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -669,7 +669,7 @@ static void __process_mem_region(struct mem_vector *entry,
 		}
 
 		/* Store beginning of region if holds at least image_size. */
-		if (overlap.start > region.start + image_size) {
+		if (overlap.start >= region.start + image_size) {
 			struct mem_vector beginning;
 
 			beginning.start = region.start;
