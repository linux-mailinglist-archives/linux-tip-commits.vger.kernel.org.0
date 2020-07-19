Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3093225183
	for <lists+linux-tip-commits@lfdr.de>; Sun, 19 Jul 2020 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgGSLIu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 19 Jul 2020 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgGSLIu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 19 Jul 2020 07:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF3C0619D2;
        Sun, 19 Jul 2020 04:08:49 -0700 (PDT)
Date:   Sun, 19 Jul 2020 11:08:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595156927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7KpxnjlF09zH8K4byK41OC5OazMD869zEXDUxnGD+c=;
        b=B46ErlI/Dj1WPJ0azblXDcK4TCUHIcYGlb9XRDHoNrp3+hnT3Hvd7wbRsNnrT5sbiIF6CN
        LbxHYpRiqKjaaoCuoTdH87iuPMZXIPWTg4XsEvUpmOzu8Kv14qqTZEwQcS8wxo2+8KwUxP
        588Fr81mPF4Eb+bSu5Tyd/bAnyzf5/eIF5QeHIbAOst0C+MxQzadaTeWwQaxijb3tL8GRX
        lmJlni9uFUMV9z+2JCCY+fFft3bMGmiRJIgrwU4Wke6b//UYUD6VHJGXfib24fjE6Fya51
        Pwx26Eo0oUG/ESGZPuKwmUQlxkCXP15x0wxtEdy4ylUHF1VeyGczLmWDyWK/qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595156927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7KpxnjlF09zH8K4byK41OC5OazMD869zEXDUxnGD+c=;
        b=Z2+gDbB3Tw0zjTilfvEXIdNAX1tzFCCbxQtP70Gln0TgvOPlfYldzR4uWdksdARaaOcLqj
        Hk/Va5cO2YPp3aBw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Actually disable stack protector
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <202006261333.585319CA6B@keescook>
References: <202006261333.585319CA6B@keescook>
MIME-Version: 1.0
Message-ID: <159515692670.4006.16427533642222007723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     58ac3154b83938515129c20aa76d456a4c9202a8
Gitweb:        https://git.kernel.org/tip/58ac3154b83938515129c20aa76d456a4c9202a8
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 26 Jun 2020 13:34:25 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 19 Jul 2020 13:07:10 +02:00

x86/entry: Actually disable stack protector

Some builds of GCC enable stack protector by default. Simply removing
the arguments is not sufficient to disable stack protector, as the stack
protector for those GCC builds must be explicitly disabled. Remove the
argument removals and add -fno-stack-protector. Additionally include
missed x32 argument updates, and adjust whitespace for readability.

Fixes: 20355e5f73a7 ("x86/entry: Exclude low level entry code from sanitizing")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/202006261333.585319CA6B@keescook

---
 arch/x86/entry/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index b7a5790..08bf95d 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,12 +7,20 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
-CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
-CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
+CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_x32.o	= $(CC_FLAGS_FTRACE)
+
+CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_syscall_64.o		+= -fno-stack-protector
+CFLAGS_syscall_32.o		+= -fno-stack-protector
+CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
+CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
+
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
