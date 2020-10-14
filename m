Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850C228E5D1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgJNR7R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgJNR7N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 13:59:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91EC061755;
        Wed, 14 Oct 2020 10:59:13 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602698350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6yrI/iMvyS2r1/ZNYeEYOpuKDwyngU97SsaUa2MKW4=;
        b=pzMjGsyARUc1amiOLo81bLLtZ1Sij6GB+DgJ94AQjDiY0iywp40p7e6Nd+Zc/8S/8N9ioo
        PFRCB9M4zCiOlF9Uo9oSvYE87UV/hdXQSxcx/9smdEoAdsaTrUnQ14kMuvkEEgQnwXrb1Y
        2XR7jPhv8FTyL31TQzKg62yEAdPssfGnr42pbRC16/GkHAsBRBoknPQ0KcQwPHhsBfrywM
        4QuAsoXBdrlijnzwU4WyUvUMPJ/vNtrT4FBrvcWzmsQ3uxjiXhzt1wTOVll2QCXJbQgWqc
        +ush3PAiXwYvj04gFcBgetx4wr/J+PLm4lJSTN9BxsG9liCl1mpoer/SsTsyyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602698350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6yrI/iMvyS2r1/ZNYeEYOpuKDwyngU97SsaUa2MKW4=;
        b=ZeO5GHu1z3/RrTXj9UsAD9WbtNIUgUOxPL+JYeD9EGmZpoOwxZFbYDTPA84PEN0Y6NgG9N
        jrYXOUxFHBdExTDA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/syscalls: Document the fact that syscalls
 512-547 are a legacy mistake
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6c56fb4ddd18fc60a238eb4d867e4b3d97c6351e.1602471055.git.luto@kernel.org>
References: <6c56fb4ddd18fc60a238eb4d867e4b3d97c6351e.1602471055.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <160269833427.7002.13535911080377553234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c3b484c439b0bab7a698495f33ef16286a1000c4
Gitweb:        https://git.kernel.org/tip/c3b484c439b0bab7a698495f33ef16286a1000c4
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Sun, 11 Oct 2020 19:51:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 19:53:40 +02:00

x86/syscalls: Document the fact that syscalls 512-547 are a legacy mistake

Since this commit:

  6365b842aae4 ("x86/syscalls: Split the x32 syscalls into their own table")

there is no need for special x32-specific syscall numbers.  I forgot to
update the comments in syscall_64.tbl.  Add comments to make it clear to
future contributors that this range is a legacy wart.

Reported-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/6c56fb4ddd18fc60a238eb4d867e4b3d97c6351e.1602471055.git.luto@kernel.org
---
 arch/x86/entry/syscalls/syscall_64.tbl | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae..4adb5d2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,10 +363,10 @@
 439	common	faccessat2		sys_faccessat2
 
 #
-# x32-specific system call numbers start at 512 to avoid cache impact
-# for native 64-bit operation. The __x32_compat_sys stubs are created
-# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
-# is defined.
+# Due to a historical design error, certain syscalls are numbered differently
+# in x32 as compared to native x86_64.  These syscalls have numbers 512-547.
+# Do not add new syscalls to this range.  Numbers 548 and above are available
+# for non-x32 use.
 #
 512	x32	rt_sigaction		compat_sys_rt_sigaction
 513	x32	rt_sigreturn		compat_sys_x32_rt_sigreturn
@@ -404,3 +404,5 @@
 545	x32	execveat		compat_sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
+# This is the end of the legacy x32 range.  Numbers 548 and above are
+# not special and are not to be used for x32-specific syscalls.
