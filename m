Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E4306418
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbhA0TcY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhA0Tb6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7696C061788;
        Wed, 27 Jan 2021 11:31:17 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPEOhLZJzmbzf3d8dAa9fKlPcI50hvFQ2HrvwceYnhg=;
        b=OyJQJhYhzzZ1awKPWsbS+VElUP1b/7p/ssvNIYbbZDhtVNm7ZaYWX3EeKVOxQSg4ewgJbU
        t5gKyARbFjhFqiv+odm/qdhkhR+wSGgXk4zDs8Jabo9xUzLsLa5u3wRef87rmsDp2nLdmW
        8a99iY4/iJVt0dhePiEW6J0HYo23+PjhbfXnvuSgx74bdBCnbAhd5lfVp0R8pMeTQi7APm
        /G3sbXGAwnMLoY4VIN2cev4akO6I+IEqF0vxKC7Qh6VhMWGvrmPUcQ02eeJVXpy/jbH90k
        FU3Z21u0b1sXQB0miAM8zSpf33y1DiekJNhvt5OJc2uqK4EWdkijOeNiaUkcUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPEOhLZJzmbzf3d8dAa9fKlPcI50hvFQ2HrvwceYnhg=;
        b=A4wDEFl2lsTGkfMon2536SlzF4lkBGbK+2avcxWa6MSBxUjPMQQHNjht8OXQjOz/mFtujl
        1NRzGeUyjULM33AQ==
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
Message-ID: <161177587598.23325.9730602966018555061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3018a08401300005536817507dd14c2a7c4ffa69
Gitweb:        https://git.kernel.org/tip/3018a08401300005536817507dd14c2a7c4ffa69
Author:        Alejandro Colomar <alx.manpages@gmail.com>
AuthorDate:    Sat, 28 Nov 2020 13:39:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Jan 2021 12:30:02 +01:00

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

[ tglx: Make the same change to the compat syscall ]

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201128123945.4592-1-alx.manpages@gmail.com
---
 kernel/futex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
