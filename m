Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE59314D8E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Feb 2021 11:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhBIKwf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 9 Feb 2021 05:52:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhBIKub (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 9 Feb 2021 05:50:31 -0500
Date:   Tue, 09 Feb 2021 10:49:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612867787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8+b4Xc5jM4icogxo50AsI6S5yyz0tfbGfOXoe4V7wM=;
        b=cf2c/8Kxf3xqQrqBtMJLLMUFz2CVQ3Ru/YwZXZt9JB/MvQxg4OrYz6vR2nahQ873f6+2Lb
        msftbFKidt6MgdZ7Rkgm5+uPdFE9mm549d70BT5EWS2HTudK0d4O0LigJ7FFV/8TKFbtJb
        JorIFbb2ezjiN6RjizshgmmJKjb0iq9aMfaz0V8quBH5UH/+KA8Lnqc5gilYvlflQG3hb/
        TJNWn2V6MBDHSjg7Dy+31UONNz68hXCL+sQs8eWA2cIaCRIqFbB29FQ7cjZEYGQC0Zyyhq
        Klbe56M1OFIpBD0d8Sdj22kM/qMWPD8JPZm96Z68Mc5ll/aJ+587ShgEyWnLWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612867787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8+b4Xc5jM4icogxo50AsI6S5yyz0tfbGfOXoe4V7wM=;
        b=RflkZXVwqomxIurN5bH8QBw6wat6A0s8a4UKxAkarl1Wj/jmaBMgG3yPVkpgXAxHBBV4ah
        sFZ4Zw0kE64p/gBw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Disable CET instrumentation in the
 kernel for 32-bit too
Cc:     AC <achirvasub@gmail.com>, Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <xT4ex@arch-chirva.localdomain>
References: <xT4ex@arch-chirva.localdomain>
MIME-Version: 1.0
Message-ID: <161286778686.23325.10302847745526792763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     256b92af784d5043eeb7d559b6d5963dcc2ecb10
Gitweb:        https://git.kernel.org/tip/256b92af784d5043eeb7d559b6d5963dcc2ecb10
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 08 Feb 2021 16:43:30 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 09 Feb 2021 11:23:47 +01:00

x86/build: Disable CET instrumentation in the kernel for 32-bit too

Commit

  20bf2b378729 ("x86/build: Disable CET instrumentation in the kernel")

disabled CET instrumentation which gets added by default by the Ubuntu
gcc9 and 10 by default, but did that only for 64-bit builds. It would
still fail when building a 32-bit target. So disable CET for all x86
builds.

Fixes: 20bf2b378729 ("x86/build: Disable CET instrumentation in the kernel")
Reported-by: AC <achirvasub@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: AC <achirvasub@gmail.com>
Link: https://lkml.kernel.org/r/YCCIgMHkzh/xT4ex@arch-chirva.localdomain
---
 arch/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5857917..30920d7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -50,6 +50,9 @@ export BITS
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
 KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
 
+# Intel CET isn't enabled in the kernel
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
@@ -120,9 +123,6 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-
-	# Intel CET isn't enabled in the kernel
-	KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
 ifdef CONFIG_X86_X32
