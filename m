Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105713075DE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Jan 2021 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhA1MW0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Jan 2021 07:22:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhA1MWT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Jan 2021 07:22:19 -0500
Date:   Thu, 28 Jan 2021 12:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611836497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LslpcB3AyGotL2KI01W1ClWrrjkz+1Vg/yXoYRHxQCQ=;
        b=yIs5Cl9W221XjDKESLg2weqXkGXhU5io/G5n2H4Ao6aXlJeNQLYCxzDChBKzFbWPwbnSxe
        eWlyX/xEZ7hpUlkwDq6jxmsIfERgsbAvTMzx04RRl1RtkDVD5fYLsy7jACONQnubsZ9/np
        aLEWAqTBaR+O+IsNgJE85vJDbIlBzW3smtWJKUKTUdzam0AwFOLkxsSPmgGrDGe/IuZD0w
        Vmx7REKIqAM4FlWrcPa7a2Zz15POJglKbI0zTVCBC5+nMn1gprG+INnFJ/rM/gaFaaywAS
        z4hduh206hd0+HUHFtv2RmZ2RQpn1iokk5mZ6UPaWeNnhwsPJqUzENG/u1KG6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611836497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LslpcB3AyGotL2KI01W1ClWrrjkz+1Vg/yXoYRHxQCQ=;
        b=JVCuBrxi6rcfz53aMYDY615YI8s9KghimmsAbacwUqQvbowlUCpxvmG+IHpQA6Z5/H/qdJ
        omaGnEutKlGkC4Ag==
From:   "tip-bot2 for Alejandro Colomar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Change utime parameter to be 'const ... *'
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128123945.4592-1-alx.manpages@gmail.com>
References: <20201128123945.4592-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Message-ID: <161183649667.23325.9060242419668454443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1ce53e2c2ac069e7b3c400a427002a70deb4a916
Gitweb:        https://git.kernel.org/tip/1ce53e2c2ac069e7b3c400a427002a70deb4a916
Author:        Alejandro Colomar <alx.manpages@gmail.com>
AuthorDate:    Sat, 28 Nov 2020 13:39:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jan 2021 13:20:18 +01:00

futex: Change utime parameter to be 'const ... *'

futex(2) says that 'utime' is a pointer to 'const'.  The implementation
doesn't use 'const'; however, it _never_ modifies the contents of utime.

- futex() either uses 'utime' as a pointer to struct or as a 'u32'.

- In case it's used as a 'u32', it makes a copy of it, and of course it is
  not dereferenced.

- In case it's used as a 'struct __kernel_timespec __user *', the pointer
  is not dereferenced inside the futex() definition, and it is only passed
  to a function: get_timespec64(), which accepts a 'const struct
  __kernel_timespec __user *'.

[ tglx: Make the same change to the compat syscall and fixup the prototypes. ]

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201128123945.4592-1-alx.manpages@gmail.com

---
 include/linux/syscalls.h | 8 ++++----
 kernel/futex.c           | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f3929af..5cb74ed 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -583,11 +583,11 @@ asmlinkage long sys_unshare(unsigned long unshare_flags);
 
 /* kernel/futex.c */
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
-			struct __kernel_timespec __user *utime, u32 __user *uaddr2,
-			u32 val3);
+			  const struct __kernel_timespec __user *utime,
+			  u32 __user *uaddr2, u32 val3);
 asmlinkage long sys_futex_time32(u32 __user *uaddr, int op, u32 val,
-			struct old_timespec32 __user *utime, u32 __user *uaddr2,
-			u32 val3);
+				 const struct old_timespec32 __user *utime,
+				 u32 __user *uaddr2, u32 val3);
 asmlinkage long sys_get_robust_list(int pid,
 				    struct robust_list_head __user * __user *head_ptr,
 				    size_t __user *len_ptr);
diff --git a/kernel/futex.c b/kernel/futex.c
index c47d101..d0775aa 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3790,8 +3790,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
-		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
-		u32, val3)
+		const struct __kernel_timespec __user *, utime,
+		u32 __user *, uaddr2, u32, val3)
 {
 	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
@@ -3986,7 +3986,7 @@ err_unlock:
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
-		struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
+		const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
 	struct timespec64 ts;
