Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7141E0832
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 May 2020 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbgEYHwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 25 May 2020 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389168AbgEYHwr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 25 May 2020 03:52:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB8C061A0E;
        Mon, 25 May 2020 00:52:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jd7uW-0004Sc-Se; Mon, 25 May 2020 09:52:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 62CEE1C0087;
        Mon, 25 May 2020 09:52:36 +0200 (CEST)
Date:   Mon, 25 May 2020 07:52:36 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Fix allnoconfig build warning
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159039315621.17951.16969252716558436781.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     d121f9483b18c423037ce6088feba24ae83891d1
Gitweb:        https://git.kernel.org/tip/d121f9483b18c423037ce6088feba24ae83891d1
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 25 May 2020 09:42:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 May 2020 09:45:27 +02:00

x86/entry: Fix allnoconfig build warning

The following commit:

  095b7a3e7745 ("x86/entry: Convert double fault exception to IDTENTRY_DF")

introduced a new build warning on 64-bit allnoconfig kernels, that have CONFIG_VMAP_STACK disabled:

  arch/x86/kernel/traps.c:332:16: warning: unused variable ‘address’ [-Wunused-variable]

This variable is only used if CONFIG_VMAP_STACK is defined, so make it
dependent on that, not CONFIG_X86_64.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 35298c1..9e5d81c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -328,7 +328,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_VMAP_STACK
 	unsigned long address = read_cr2();
 #endif
 
