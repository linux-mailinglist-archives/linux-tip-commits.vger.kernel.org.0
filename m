Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEBE38AFE0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbhETNZI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbhETNZB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B96C061761;
        Thu, 20 May 2021 06:23:39 -0700 (PDT)
Date:   Thu, 20 May 2021 13:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9bNZCWuJjfwl/f3RwrdEYzd0G76m4VFtxN/cTVfgpw=;
        b=14UEC5bb6m+UwPx9xxntHxFZmIwdWT27J4htfWk8PudhGd/+1LvIim+BtIr7b5ymCtSM9l
        h0TIANlFo5fOjzeU7xibjtWqT22t02GBMrS6l6tipnLXWTvki2FGTpirXF475e1Fq5vRkk
        SO4lbgQ5VaSyV7j5+h7PDSbu4uPRy6JpqlIbuucy+KxOn6+E8HmLXKDdo1TUKYKPYxsc4B
        pnXbTvoS1tsyJjEgk4fkfzm6f3HGJ/oPGdifLqCLzJT0mlobzQOxKBeM38RetWiib1DYEm
        CoT/QMMVn+aLHb9OeHvJ7J+PLrFLXQEHBuiaIXURlw5d5s+rH5ZylL7Jy1Q5Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9bNZCWuJjfwl/f3RwrdEYzd0G76m4VFtxN/cTVfgpw=;
        b=h3s2ujNgzLwkPNfDYV1S8WY1xXJ7hZE1uePBdNGDxPb5uRxVtxMN6G0CvsjYNTy1WX/ICr
        s6qvVe1CXxBI9PDw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/unistd: Define X32_NR_syscalls only for 64-bit kernel
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517073815.97426-5-masahiroy@kernel.org>
References: <20210517073815.97426-5-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162151701394.29796.3420253526498482459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f63815eb1d909a4121806e60928108ff040bf291
Gitweb:        https://git.kernel.org/tip/f63815eb1d909a4121806e60928108ff040bf291
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 17 May 2021 16:38:12 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:03:59 +02:00

x86/unistd: Define X32_NR_syscalls only for 64-bit kernel

X32_NR_syscalls is needed only when building a 64bit kernel.

Move it to proper #ifdef guard.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210517073815.97426-5-masahiroy@kernel.org

---
 arch/x86/include/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index c1c3d31..1bc6020 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -26,11 +26,11 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
+#  define X32_NR_syscalls (__NR_x32_syscall_max + 1)
 
 # endif
 
 # define NR_syscalls (__NR_syscall_max + 1)
-# define X32_NR_syscalls (__NR_x32_syscall_max + 1)
 # define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
 
 # define __ARCH_WANT_NEW_STAT
