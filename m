Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86383370AD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Mar 2021 11:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhCKK6l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Mar 2021 05:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhCKK6V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Mar 2021 05:58:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59FC061574;
        Thu, 11 Mar 2021 02:58:21 -0800 (PST)
Date:   Thu, 11 Mar 2021 10:58:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615460297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnrYOiwTFZaDNVyCNtVPxv+svxcZAVs3Yc64JkNyUvc=;
        b=Vp4bQFolZHblbeM9TdKI5MIOMC1D8E6ZQUBta7LGsG2YziUpPFCghsF+mFqyv9gTYXd/W2
        OnxsIsatKQNtK91K1ZrfLrNCoAcEBdTyP9tLVv3h2huUo7zk8pkLI30lmtqt90SDVQq1V9
        WbAVb8VMWrtkReeTfIBcwHZcLLg8YDLGMsZeTNYSfiVZJCtSuGoMdvhTOmrQm0bdRbLrjX
        P6ibq8h8Zs0pnXhAUhNerzX2N2QBqI4RBqVkS/LqhFTe4WN9q7ozlZHA22YNViPCqUMmj0
        gjz30+tfm6PXWkfAgqWYkWA30nnOjSOy4+7/fJZ635c+N60/SPy6X91tBctjZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615460297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnrYOiwTFZaDNVyCNtVPxv+svxcZAVs3Yc64JkNyUvc=;
        b=Mo0w2rXf2oxnDt6prSmjduOewrpp5d31F7vVsZ/0tWQkaQYNjVNCMqfDAVIUi4BUjcaee3
        IOPrANQ4gKq4WkBA==
From:   "tip-bot2 for Cao jin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Remove unused RESERVE_BRK_ARRAY()
Cc:     Cao jin <jojing64@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210311083919.27530-1-jojing64@gmail.com>
References: <20210311083919.27530-1-jojing64@gmail.com>
MIME-Version: 1.0
Message-ID: <161546029670.398.10659315178601851593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     81519f778830d1ab02274eeaaeab6797fdc4ec52
Gitweb:        https://git.kernel.org/tip/81519f778830d1ab02274eeaaeab6797fdc4ec52
Author:        Cao jin <jojing64@gmail.com>
AuthorDate:    Thu, 11 Mar 2021 16:39:19 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 11:47:37 +01:00

x86/setup: Remove unused RESERVE_BRK_ARRAY()

Since a13f2ef168cb ("x86/xen: remove 32-bit Xen PV guest support"),
RESERVE_BRK_ARRAY() has no user anymore so drop it.

Update related comments too.

Signed-off-by: Cao jin <jojing64@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210311083919.27530-1-jojing64@gmail.com
---
 arch/x86/include/asm/setup.h | 5 -----
 arch/x86/kernel/setup.c      | 6 +++---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 389d851..a12458a 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -130,11 +130,6 @@ void *extend_brk(size_t size, size_t align);
 			: : "i" (sz));					\
 	}
 
-/* Helper for reserving space for arrays of things */
-#define RESERVE_BRK_ARRAY(type, name, entries)		\
-	type *name;					\
-	RESERVE_BRK(name, sizeof(type) * entries)
-
 extern void probe_roms(void);
 #ifdef __i386__
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176..cdf7bbd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -65,7 +65,7 @@ RESERVE_BRK(dmi_alloc, 65536);
 
 /*
  * Range of the BSS area. The size of the BSS area is determined
- * at link time, with RESERVE_BRK*() facility reserving additional
+ * at link time, with RESERVE_BRK() facility reserving additional
  * chunks.
  */
 unsigned long _brk_start = (unsigned long)__brk_base;
@@ -1038,8 +1038,8 @@ void __init setup_arch(char **cmdline_p)
 
 	/*
 	 * Need to conclude brk, before e820__memblock_setup()
-	 *  it could use memblock_find_in_range, could overlap with
-	 *  brk area.
+	 * it could use memblock_find_in_range, could overlap with
+	 * brk area.
 	 */
 	reserve_brk();
 
