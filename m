Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8ED2D7EE7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 19:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgLKSzi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 13:55:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391964AbgLKSzH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 13:55:07 -0500
Date:   Fri, 11 Dec 2020 18:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607712862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrJpOWZsZJaNiMVh6baH+jQxMV5OKcMhJ8KwGrkiELg=;
        b=ZEzFUPadWn6N5Hi7Sf/PMIqSDCPOfWt3f7oxRhhCSNxKYaguAYtEhIpTgICcvucXh74G+M
        xuiVnhUZ1lJYV9VeHq4tkjNpdDetz4Kc6HNtelPRfnguYdE032/YJZUuzfRS6IYvAx2ewT
        1fTPtfsPDSp9k7iVR9sEZKwGXaUw/OXlDonqry7WKiTZz3Nd4dwpAZclHkZpddZrUVV8K/
        TxA0rejRXP5SMTTJvDMd7vOcCh/aJMRzQNkoGbVIm4l8sWkIRhpKsUPOz25ONorIyDxJKC
        tTX5JFLdJYehhq3bfxO8y+Hb17XrzrAi/oxTn3MS/y+CBf+yaWDnPn3gqk+p/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607712862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrJpOWZsZJaNiMVh6baH+jQxMV5OKcMhJ8KwGrkiELg=;
        b=TsEN1Tzt1FrbFY/bm3euHpEq23BuZxogPKFH9cOZZm49IabOVLU68s64fAzckmyabYT+n6
        o9A3AB+GVpOihPAQ==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ia32_signal: Propagate __user annotation properly
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201207124141.21859-1-lukas.bulwahn@gmail.com>
References: <20201207124141.21859-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <160771286080.3364.15021065980824456713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     9a02fd8b19247e80e2354a227b6e2392e8fae78a
Gitweb:        https://git.kernel.org/tip/9a02fd8b19247e80e2354a227b6e2392e8fae78a
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Mon, 07 Dec 2020 13:41:41 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Dec 2020 19:44:31 +01:00

x86/ia32_signal: Propagate __user annotation properly

Commit

  57d563c82925 ("x86: ia32_setup_rt_frame(): consolidate uaccess areas")

dropped a __user annotation in a cast when refactoring __put_user() to
unsafe_put_user().

Hence, since then, sparse warns in arch/x86/ia32/ia32_signal.c:350:9:

  warning: cast removes address space '__user' of expression
  warning: incorrect type in argument 1 (different address spaces)
    expected void const volatile [noderef] __user *ptr
    got unsigned long long [usertype] *

Add the __user annotation to restore the propagation of address spaces.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201207124141.21859-1-lukas.bulwahn@gmail.com
---
 arch/x86/ia32/ia32_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 81cf223..5e3d9b7 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -347,7 +347,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(*(__u64 *)set, (__u64 *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
 
 	if (__copy_siginfo_to_user32(&frame->info, &ksig->info))
