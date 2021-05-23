Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1960A38DABE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhEWJsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhEWJsb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 05:48:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B841C06138B;
        Sun, 23 May 2021 02:47:04 -0700 (PDT)
Date:   Sun, 23 May 2021 09:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621763220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OrMoC7sW/3+bp0JQNPtsjzixWG8rfSzES+l9f/ugFwk=;
        b=P7HjwSNk9K+bLJb0aSMsn02f0K91kyxTBcAdAkOsR9Ijsw822kVnOg6Sn0Iv9+2komayZM
        y6i/UAe6qqNWVzgmVRo33HJnmY0Iiy/IRnn/YF1nAYT2gZWqVM5bhZAwV/RoF/32ezu2Ns
        LU325MKEyXduV87h2ww1fY7VQDY7MbjiBrNFyVgFjWuvo5RwzUBdhJVonA6JlB+4Jar6vC
        O5b54ZmS/Ta8KtAfm66HlEANyCf2XAZUw/0rdv9pGCjjn4Ljm827bMt5zSjr+YLRjI9tIN
        HdYF2g5wDglShg+gidR/NsdcT9fnBDvfiGtUC6yplJ8PEFPWli/398wsEZL0zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621763220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OrMoC7sW/3+bp0JQNPtsjzixWG8rfSzES+l9f/ugFwk=;
        b=uCXEYq49IgZw7aPk/NfalGhbQ+JaTleSwCLRFqm7zFIReTQj04/AjpWBPbW6TDBorPlut/
        0DjvxxCM23TjrXCA==
From:   "tip-bot2 for Heiner Kallweit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to
 be cleared
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176322031.29796.11878288049256642429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     45add3cc99feaaf57d4b6f01d52d532c16a1caee
Gitweb:        https://git.kernel.org/tip/45add3cc99feaaf57d4b6f01d52d532c16a1caee
Author:        Heiner Kallweit <hkallweit1@gmail.com>
AuthorDate:    Fri, 30 Apr 2021 16:22:51 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:05:13 +02:00

efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

UEFI spec 2.9, p.108, table 4-1 lists the scenario that both attributes
are cleared with the description "No memory access protection is
possible for Entry". So we can have valid entries where both attributes
are cleared, so remove the check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: 10f0d2f577053 ("efi: Implement generic support for the Memory Attributes table")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/memattr.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 5737cb0..0a9aba5 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -67,11 +67,6 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
 		return false;
 	}
 
-	if (!(in->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))) {
-		pr_warn("Entry attributes invalid: RO and XP bits both cleared\n");
-		return false;
-	}
-
 	if (PAGE_SIZE > EFI_PAGE_SIZE &&
 	    (!PAGE_ALIGNED(in->phys_addr) ||
 	     !PAGE_ALIGNED(in->num_pages << EFI_PAGE_SHIFT))) {
