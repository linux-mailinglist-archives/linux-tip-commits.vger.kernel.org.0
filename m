Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AA319EA3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBLMjd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBLMiO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5FC06178C;
        Fri, 12 Feb 2021 04:37:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIc7b1Jgb+h01fGJn0mKsPWCdBEnrdewhfhh79hLknw=;
        b=aV4yM7/KYF9zlbkjDpX+krd2zgksxhStaoOkJ4zz49ePZ9e11cUluu38zZ9rEQkRtEhfA5
        ZmPVw6ii48n5kxi1OYGHVEvJC+qw1ee85T17kw4YJgyiWQckKlmFALOLk7vwJJd/2aZxRV
        1kyoNfjPzeOXWNwAREMy2f9vfcLLG8EwZX2jlikDsPz4UEDwQG5MI3O/eKFZYXSQ0V7xG/
        QIQReUTaNQCL4VmiI80q0WbPm3Pmsm8UDxPajxsbH4z2XtW8bXU0/TzM4P7Kq4Sm8798Ht
        U4MFB+M52lNUF22HbowxEKUKpiCwIsO5zr1025cv2je6o/5io6DfFZvUC1LLAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIc7b1Jgb+h01fGJn0mKsPWCdBEnrdewhfhh79hLknw=;
        b=/NPIrKYl0o3ywxPDU7ZJfQnJP8Zt3AoyI2QWCW1a9a7gJ44yaf4iNWhb0ruaNH9+aLeb1m
        PLTDoSUIGlDo0eBA==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Remove incorrect definitions of __ARCH_WANT_*
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210119153147.GA5083@paulmck-ThinkPad-P72>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Message-ID: <161313342537.23325.1930237319769790754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f65d7117785cb8ab04f1af55909807c7eb9ed30b
Gitweb:        https://git.kernel.org/tip/f65d7117785cb8ab04f1af55909807c7eb9ed30b
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:29 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:45 -08:00

tools/nolibc: Remove incorrect definitions of __ARCH_WANT_*

The __ARCH_WANT_* definitions were added in order to support aarch64
when it was missing some syscall definitions (including __NR_dup2,
__NR_fork, and __NR_getpgrp), but these __ARCH_WANT_* definitions were
actually wrong because these syscalls do not exist on this platform.
Defining these resulted in exposing invalid definitions, resulting in
failures on aarch64.

The missing syscalls were since implemented based on the newer ones
(__NR_dup3,  __NR_clone, __NR_getpgid) so these incorrect __ARCH_WANT_*
definitions are no longer needed.

Thanks to Mark Rutland for spotting this incorrect analysis and
explaining why it was wrong.

This is a port of nolibc's upstream commit 00b1b0d9b2a4 to the Linux
kernel.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/lkml/20210119153147.GA5083@paulmck-ThinkPad-P72
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 611d9d1..475d956 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -81,14 +81,6 @@
  *
  */
 
-/* Some archs (at least aarch64) don't expose the regular syscalls anymore by
- * default, either because they have an "_at" replacement, or because there are
- * more modern alternatives. For now we'd rather still use them.
- */
-#define __ARCH_WANT_SYSCALL_NO_AT
-#define __ARCH_WANT_SYSCALL_NO_FLAGS
-#define __ARCH_WANT_SYSCALL_DEPRECATED
-
 #include <asm/unistd.h>
 #include <asm/ioctls.h>
 #include <asm/errno.h>
