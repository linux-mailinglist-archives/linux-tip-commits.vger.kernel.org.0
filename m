Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58B1FFB72
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jun 2020 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgFRTDv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Jun 2020 15:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgFRTDu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Jun 2020 15:03:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C769C06174E;
        Thu, 18 Jun 2020 12:03:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlzpC-0000we-N4; Thu, 18 Jun 2020 21:03:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F5CB1C0087;
        Thu, 18 Jun 2020 21:03:44 +0200 (CEST)
Date:   Thu, 18 Jun 2020 19:03:43 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm/32: Fix -Wmissing prototypes warnings for init.c
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200606123743.3277-1-b.thiel@posteo.de>
References: <20200606123743.3277-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <159250702393.16989.14264328319814076252.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     56ce93700eb630a8d894f5a578f166888ae8cba6
Gitweb:        https://git.kernel.org/tip/56ce93700eb630a8d894f5a578f166888ae8cba6
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Sat, 06 Jun 2020 14:37:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Jun 2020 18:04:00 +02:00

x86/mm/32: Fix -Wmissing prototypes warnings for init.c

Fix:

  arch/x86/mm/init.c:503:21:
  warning: no previous prototype for ‘init_memory_mapping’ [-Wmissing-prototypes]
  unsigned long __ref init_memory_mapping(unsigned long start,

  arch/x86/mm/init.c:745:13:
  warning: no previous prototype for ‘poking_init’ [-Wmissing-prototypes]
  void __init poking_init(void)

Lift init_memory_mapping() and poking_init() out of the ifdef
CONFIG_X86_64 to make the functions visible on 32-bit too.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200606123743.3277-1-b.thiel@posteo.de
---
 arch/x86/include/asm/pgtable.h |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 76aa21e..b836138 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -999,15 +999,12 @@ extern int direct_gbpages;
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 extern void memblock_find_dma_reserve(void);
-
-
-#ifdef CONFIG_X86_64
-extern pgd_t trampoline_pgd_entry;
-
 void __init poking_init(void);
-
 unsigned long init_memory_mapping(unsigned long start,
 				  unsigned long end, pgprot_t prot);
+
+#ifdef CONFIG_X86_64
+extern pgd_t trampoline_pgd_entry;
 #endif
 
 /* local pte updates need not use xchg for locking */
