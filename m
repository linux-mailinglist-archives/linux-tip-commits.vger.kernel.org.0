Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ABE2B82D1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKRRSQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRRSQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41394C0613D4;
        Wed, 18 Nov 2020 09:18:16 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUACd/DXMENWgHWR1UHzhNmWqQNE2W8yE2uF7k+W2dM=;
        b=xfXFwC25z9hG/Qm6LMzAeQoc/sYC1sfDYjL7Kel8cOcLte2EV8B2Kwp2jW/eD8N5kh/2cS
        Pp3dwvRpUzqc78W3Wrrz8p4UUBZsMVswW5u7RGjRWDY24dpWl+Izu7XC2nZCvdqvumy4Fs
        3gagn9WN51HwwBUMAePmdofDUXxGTL8pD5+jvFqHdImMHqaA1J57veV8U+5OQZGGUYiLTk
        HU+bsWKWrnRB/nLeZqQmUJ7n5Nf0J+pE5sy1Jcg6n2GbNSHJtYIYlytHPBSdQ5EjOWTRic
        oF5Y6NFqECdw2UPiVcFuSqwgAVWqKdy8mCjShUUYKKyQWsIIb4Z6+EXHKE6UJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUACd/DXMENWgHWR1UHzhNmWqQNE2W8yE2uF7k+W2dM=;
        b=dhY1x2idHHyXu1dOj8oqpdIxIo3s5YrvbLW+r7HiqpcBRtT9EEaNuFUWSr/8tDBKXobzvx
        /e+V3kzAvVR9jFDA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Remove unused finalize_identity_maps()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201005151208.2212886-2-nivedita@alum.mit.edu>
References: <20201005151208.2212886-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160571989365.11244.15278626511040475571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0ac317e89791b76055ef11b952625ef77a1d2eba
Gitweb:        https://git.kernel.org/tip/0ac317e89791b76055ef11b952625ef77a1d2eba
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 05 Oct 2020 11:12:07 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 16:04:23 +01:00

x86/boot: Remove unused finalize_identity_maps()

Commit

  8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in KASLR code")

removed all the references to finalize_identity_maps(), but neglected to
delete the actual function. Remove it.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201005151208.2212886-2-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/ident_map_64.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index a5e5db6..6bf2022 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -167,16 +167,6 @@ void initialize_identity_maps(void *rmode)
 	write_cr3(top_level_pgt);
 }
 
-/*
- * This switches the page tables to the new level4 that has been built
- * via calls to add_identity_map() above. If booted via startup_32(),
- * this is effectively a no-op.
- */
-void finalize_identity_maps(void)
-{
-	write_cr3(top_level_pgt);
-}
-
 static pte_t *split_large_pmd(struct x86_mapping_info *info,
 			      pmd_t *pmdp, unsigned long __address)
 {
