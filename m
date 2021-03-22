Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACE73452FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 00:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCVXae (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhCVXa1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 19:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB11C061756;
        Mon, 22 Mar 2021 16:30:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:30:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616455824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXdBg6gL7itvmnS+CNGMGXcOXyJhoMUSMnqIaL9Ht8o=;
        b=Tq2yJ9tI+ydzWpHmVFkRQ/P8Sk4gGRdm7qfC7UA9MUuFvXnXVgnBuzva110+gRyN5I6dVu
        zLZ8mXfDEPXzUEaJbk2aSXKbUCmBGAd2P5Yl2U60jwCY1B7t/o2Iray4rkSYjxj4PeDJQH
        vOud8ppt6DONPZc/KQzcL8TiP8tNQyJ9q8TdvTrXBmiuurH9mFtQ770N0DoUxhPv3kNWoK
        8VEP0FkyFrh8MBOmkBCiRKw5RRln2SnyrYweBpp0CQKhy3ckEzD7QELL4eWxyDBENjmbZN
        kfM1Ve1DS+sPD4skXeO68incxv/1iSUfqGPEMSvNLV2UUzxhnkJYHhqVMwN5BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616455824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXdBg6gL7itvmnS+CNGMGXcOXyJhoMUSMnqIaL9Ht8o=;
        b=3UOgtQmCA80D2Z7Yi7L9g+sc2Kfj8NbVyRjJdAM+RhObhC4iNvcMQPOk04TCKU+g4LPVtB
        HlnMeF2zOIoq3JCQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/tboot: Avoid Wstringop-overread-warning
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Sebor <msebor@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322160253.4032422-3-arnd@kernel.org>
References: <20210322160253.4032422-3-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161645582418.398.5061276980736897038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     cdc34cb8f25d3125d30868376b8eae6fe690119b
Gitweb:        https://git.kernel.org/tip/cdc34cb8f25d3125d30868376b8eae6fe690119b
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 Mar 2021 17:02:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Mar 2021 00:16:13 +01:00

x86/boot/tboot: Avoid Wstringop-overread-warning

gcc-11 warns about using string operations on pointers that are
defined at compile time as offsets from a NULL pointer. Unfortunately
that also happens on the result of fix_to_virt(), which is a
compile-time constant for a constant input:

  arch/x86/kernel/tboot.c: In function 'tboot_probe':
  arch/x86/kernel/tboot.c:70:13: error: '__builtin_memcmp_eq' specified bound 16 exceeds source size 0 [-Werror=stringop-overread]
     70 |         if (memcmp(&tboot_uuid, &tboot->uuid, sizeof(tboot->uuid))) {
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I hope this can get addressed in gcc-11 before the release.

As a workaround, split up the tboot_probe() function in two halves
to separate the pointer generation from the usage. This is a bit
ugly, and hopefully gcc understands that the code is actually correct
before it learns to peek into the noinline function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Sebor <msebor@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
Link: https://lore.kernel.org/r/20210322160253.4032422-3-arnd@kernel.org
---
 arch/x86/kernel/tboot.c | 44 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4c09ba1..f9af561 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -49,6 +49,30 @@ bool tboot_enabled(void)
 	return tboot != NULL;
 }
 
+/* noinline to prevent gcc from warning about dereferencing constant fixaddr */
+static noinline __init bool check_tboot_version(void)
+{
+	if (memcmp(&tboot_uuid, &tboot->uuid, sizeof(tboot->uuid))) {
+		pr_warn("tboot at 0x%llx is invalid\n", boot_params.tboot_addr);
+		return false;
+	}
+
+	if (tboot->version < 5) {
+		pr_warn("tboot version is invalid: %u\n", tboot->version);
+		return false;
+	}
+
+	pr_info("found shared page at phys addr 0x%llx:\n",
+		boot_params.tboot_addr);
+	pr_debug("version: %d\n", tboot->version);
+	pr_debug("log_addr: 0x%08x\n", tboot->log_addr);
+	pr_debug("shutdown_entry: 0x%x\n", tboot->shutdown_entry);
+	pr_debug("tboot_base: 0x%08x\n", tboot->tboot_base);
+	pr_debug("tboot_size: 0x%x\n", tboot->tboot_size);
+
+	return true;
+}
+
 void __init tboot_probe(void)
 {
 	/* Look for valid page-aligned address for shared page. */
@@ -66,25 +90,9 @@ void __init tboot_probe(void)
 
 	/* Map and check for tboot UUID. */
 	set_fixmap(FIX_TBOOT_BASE, boot_params.tboot_addr);
-	tboot = (struct tboot *)fix_to_virt(FIX_TBOOT_BASE);
-	if (memcmp(&tboot_uuid, &tboot->uuid, sizeof(tboot->uuid))) {
-		pr_warn("tboot at 0x%llx is invalid\n", boot_params.tboot_addr);
+	tboot = (void *)fix_to_virt(FIX_TBOOT_BASE);
+	if (!check_tboot_version())
 		tboot = NULL;
-		return;
-	}
-	if (tboot->version < 5) {
-		pr_warn("tboot version is invalid: %u\n", tboot->version);
-		tboot = NULL;
-		return;
-	}
-
-	pr_info("found shared page at phys addr 0x%llx:\n",
-		boot_params.tboot_addr);
-	pr_debug("version: %d\n", tboot->version);
-	pr_debug("log_addr: 0x%08x\n", tboot->log_addr);
-	pr_debug("shutdown_entry: 0x%x\n", tboot->shutdown_entry);
-	pr_debug("tboot_base: 0x%08x\n", tboot->tboot_base);
-	pr_debug("tboot_size: 0x%x\n", tboot->tboot_size);
 }
 
 static pgd_t *tboot_pg_dir;
