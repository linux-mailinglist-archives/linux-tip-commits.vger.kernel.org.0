Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E1390468
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhEYPCX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhEYPCW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 11:02:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93FC061574;
        Tue, 25 May 2021 08:00:52 -0700 (PDT)
Date:   Tue, 25 May 2021 15:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621954851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZqKE3F2NB7be73Rfm4RCR8QOVDoryXbjbilN9NM9VQ=;
        b=BxuZdaioP2BaNEtvBS+T3S7v9nbpFrKKUFv+xHEIdUQ6yX0HxZs6s0KZ4AYKl3vqi9+dE0
        sicdoaToxAtV6YXYMkYwGzFcAnyjj8MpqqJ+XBYa31GYcPSXA+vWLe0IACCAjI1tJK4R2P
        YZA+UiqHeKm2wuClrUA8NOIoUxpYL4QDHdvaW/GBwKbmx5JfcH0nNPpCGxxmT1taS62Cwx
        BRKhU3R9vJ0ZvMKg2AOpqhOQb2HuLoG6IVZUU2CcB6bncHgiLQiqz0wj6JjkcEY2oSvIOw
        fZm/U3lSp+onI9DskvBFXfc0ieErB+aV90FnrCbqIbcKHtaHfMVL4T7EU8L9ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621954851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZqKE3F2NB7be73Rfm4RCR8QOVDoryXbjbilN9NM9VQ=;
        b=MZa7LYjhksVNOoJ2QgORS7effiQwem0Eba47mJlIBirDgmnvOEaR+JjLNVP7s0Ifjm3tld
        vz09wqDzWIHMr9Ag==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Don't adjust CFLAGS for syscall tables
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524181707.132844-4-brgerst@gmail.com>
References: <20210524181707.132844-4-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <162195485062.29796.9940389426312997877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     48f7eee81cd53a94699d28959566b41a9dcac1d9
Gitweb:        https://git.kernel.org/tip/48f7eee81cd53a94699d28959566b41a9dcac1d9
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 24 May 2021 14:17:07 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 16:59:23 +02:00

x86/syscalls: Don't adjust CFLAGS for syscall tables

The syscall_*.c files only contain data (the syscall tables).  There
is no need to adjust CFLAGS for tracing and stack protector since they
contain no code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20210524181707.132844-4-brgerst@gmail.com

---
 arch/x86/entry/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 94d2843..7fec5dc 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -8,14 +8,8 @@ UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_x32.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
-CFLAGS_syscall_64.o		+= -fno-stack-protector
-CFLAGS_syscall_32.o		+= -fno-stack-protector
-CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
