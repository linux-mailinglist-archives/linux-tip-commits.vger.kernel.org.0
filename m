Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C193A052E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jun 2021 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhFHUhs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 8 Jun 2021 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhFHUhs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 8 Jun 2021 16:37:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D79C061574;
        Tue,  8 Jun 2021 13:35:54 -0700 (PDT)
Date:   Tue, 08 Jun 2021 20:35:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623184552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sRlTCEMFiILDT/as65fHemqYYsAH0re9GJwoPd5mC0=;
        b=N1Li5HSF5xJ0sPfLank/Ql1hLD3s0gWmRRWqF9Bn1uXSRH3j3+PptFFrLUpJjtC7zHJiM3
        fZMfcQsIDCWNkq2fRJq5WTr5XypMOKeF7bOkBYDMbqAEntomFco9tpTTjcemUdhbwvIhqQ
        k4tUhNXlzkHywqii2RbsZ4zA+hiz3JZsuwPUfdysqClCK/8bmuXzZWddHlKyMZ3wfDfZSk
        OdHiFUNiDbrgQXepy3Vcbi6MILZ+cg0VgiMBqiOAYdZSfydLhWHL9+9aNLxF1s2YWMRCOL
        /3ElcrA8d5yQKQCYjL+Qye02jJqLi91TROZa1xHLYC8g0F0BmOCy3e0OUVwYvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623184552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sRlTCEMFiILDT/as65fHemqYYsAH0re9GJwoPd5mC0=;
        b=fmKHycqt8iQuRuXnUg5X+jgR5K4Y0O07T7FfRWHetSurypwcYalInV2y5u0m7ax5ExGa04
        upBJJ2swnm0oEnAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Document that Windows reserves the first MiB
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CMWHPR21MB159330952629D36EEDE706B3D7379=40MWHPR21MB?=
 =?utf-8?q?1593=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CMWHPR21MB159330952629D36EEDE706B3D7379=40MWHPR21M?=
 =?utf-8?q?B1593=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <162318455123.29796.8536472725477120608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ec35d1d93bf8976f0668cb1026ea8c7d7bcad3c1
Gitweb:        https://git.kernel.org/tip/ec35d1d93bf8976f0668cb1026ea8c7d7bcad3c1
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 08 Jun 2021 22:17:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Jun 2021 22:26:43 +02:00

x86/setup: Document that Windows reserves the first MiB

It does so unconditionally too, on Intel and AMD machines, to work
around BIOS bugs, as confirmed by Microsoft folks (see Link for full
details).

Reflow the paragraph, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com
---
 arch/x86/kernel/setup.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 7638ac6..85acd22 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1060,17 +1060,18 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	/*
-	 * Find free memory for the real mode trampoline and place it
-	 * there.
-	 * If there is not enough free memory under 1M, on EFI-enabled
-	 * systems there will be additional attempt to reclaim the memory
-	 * for the real mode trampoline at efi_free_boot_services().
+	 * Find free memory for the real mode trampoline and place it there. If
+	 * there is not enough free memory under 1M, on EFI-enabled systems
+	 * there will be additional attempt to reclaim the memory for the real
+	 * mode trampoline at efi_free_boot_services().
 	 *
-	 * Unconditionally reserve the entire first 1M of RAM because
-	 * BIOSes are know to corrupt low memory and several
-	 * hundred kilobytes are not worth complex detection what memory gets
-	 * clobbered. Moreover, on machines with SandyBridge graphics or in
-	 * setups that use crashkernel the entire 1M is reserved anyway.
+	 * Unconditionally reserve the entire first 1M of RAM because BIOSes
+	 * are known to corrupt low memory and several hundred kilobytes are not
+	 * worth complex detection what memory gets clobbered. Windows does the
+	 * same thing for very similar reasons.
+	 *
+	 * Moreover, on machines with SandyBridge graphics or in setups that use
+	 * crashkernel the entire 1M is reserved anyway.
 	 */
 	reserve_real_mode();
 
