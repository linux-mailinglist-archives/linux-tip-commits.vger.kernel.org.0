Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7581C6A95
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 May 2020 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgEFH4z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 May 2020 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728280AbgEFH4y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 May 2020 03:56:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB27C061A0F;
        Wed,  6 May 2020 00:56:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWEvB-0006V5-Kt; Wed, 06 May 2020 09:56:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E41081C0092;
        Wed,  6 May 2020 09:56:48 +0200 (CEST)
Date:   Wed, 06 May 2020 07:56:48 -0000
From:   "tip-bot2 for Andrew Morton" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Use $(CONFIG_SHELL)
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505211932.GE6880@zn.tnic>
References: <20200505211932.GE6880@zn.tnic>
MIME-Version: 1.0
Message-ID: <158875180875.8414.10395271850388166773.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     950a37078aa0ab63a57673e7027e8735e73d4bc6
Gitweb:        https://git.kernel.org/tip/950a37078aa0ab63a57673e7027e8735e73d4bc6
Author:        Andrew Morton <akpm@linux-foundation.org>
AuthorDate:    Tue, 05 May 2020 14:26:51 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 09:46:26 +02:00

x86/build: Use $(CONFIG_SHELL)

When scripts/x86-check-compiler.sh doesn't have the executable bit set:

  q:/usr/src/25> make clean
  make: execvp: ./scripts/x86-check-compiler.sh: Permission denied

Fix this by using $(CONFIG_SHELL).

This will happen if the user downloads and applies patch-5.7.tar.gz, since
patch(1) doesn't preserve the x bit.

Fixes: 73da86741e7f7 ("x86/build: Check whether the compiler is sane")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200505211932.GE6880@zn.tnic
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 38d3eec..9e22791 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -2,7 +2,7 @@
 # Unified Makefile for i386 and x86_64
 
 #  Check the compiler
-sane_compiler := $(shell $(srctree)/scripts/x86-check-compiler.sh $(CC))
+sane_compiler := $($(CONFIG_SHELL) $(srctree)/scripts/x86-check-compiler.sh $(CC))
 $(if $(sane_compiler),$(error $(CC) check failed. Aborting),)
 
 # select defconfig based on actual architecture
