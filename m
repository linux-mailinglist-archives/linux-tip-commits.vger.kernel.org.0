Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73357A06FA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1QJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 12:09:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1QJ4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 12:09:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i30W4-0007lM-Jo; Wed, 28 Aug 2019 18:09:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3D5C51C07D2;
        Wed, 28 Aug 2019 18:09:48 +0200 (CEST)
Date:   Wed, 28 Aug 2019 16:09:48 -0000
From:   "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Add -Wnoaddress-of-packed-member to
 REALMODE_CFLAGS, to silence GCC9 build warning
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156700858811.17792.2639553640756953980.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     42e0e95474fc6076b5cd68cab8fa0340a1797a72
Gitweb:        https://git.kernel.org/tip/42e0e95474fc6076b5cd68cab8fa0340a1797a72
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Wed, 28 Aug 2019 10:56:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Aug 2019 17:31:31 +02:00

x86/build: Add -Wnoaddress-of-packed-member to REALMODE_CFLAGS, to silence GCC9 build warning

One of the very few warnings I have in the current build comes from
arch/x86/boot/edd.c, where I get the following with a gcc9 build:

   arch/x86/boot/edd.c: In function ‘query_edd’:
   arch/x86/boot/edd.c:148:11: warning: taking address of packed member of ‘struct boot_params’ may result in an unaligned pointer value [-Waddress-of-packed-member]
     148 |  mbrptr = boot_params.edd_mbr_sig_buffer;
         |           ^~~~~~~~~~~

This warning triggers because we throw away all the CFLAGS and then make
a new set for REALMODE_CFLAGS, so the -Wno-address-of-packed-member we
added in the following commit is not present:

  6f303d60534c ("gcc-9: silence 'address-of-packed-member' warning")

The simplest solution for now is to adjust the warning for this version
of CFLAGS as well, but it would definitely make sense to examine whether
REALMODE_CFLAGS could be derived from CFLAGS, so that it picks up changes
in the compiler flags environment automatically.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 56e748a..94df086 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -38,6 +38,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
 export REALMODE_CFLAGS
 
