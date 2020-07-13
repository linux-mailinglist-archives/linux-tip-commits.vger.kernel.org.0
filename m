Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72087219C04
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jul 2020 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGIJWx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Jul 2020 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGIJWx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Jul 2020 05:22:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DC1C08C5CE;
        Thu,  9 Jul 2020 02:22:52 -0700 (PDT)
Date:   Thu, 09 Jul 2020 09:22:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594286571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGId8U2cedMbx7gJQvu1HmwVF5zXHV3xKtHP5HlHA5g=;
        b=jKn3zvuA4Y/6V8B1eE7G/P/vKOVyL4LsSPWxopeJdkMz4Do+Mm8FKEYZDcRQq5upIdtW2m
        rS67XtXnDyn5riCcZjF5lNV96ZrGvwjJPhZzaXOc+r3rYia96S0tedQP387eaaLx+JRTGR
        5d9fm/i/P1zClMS2HPbToJ2kypU1R+vYVIyFvRsHbIsBVyL5pXkh/xAC6FHlKueoUq1U+q
        1jZjArl+i6a2jhfRI6OfHMHLsR1Wp9zDiu+hl1JepNCG+nhq5E0T6UQzxYyCi8JbJHIYy5
        j4c9u4+2qit50sWjK8swEJ4nBBWz6tRwyrnu4OPD9Q+ff1/woaeTFBGfh08bHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594286571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGId8U2cedMbx7gJQvu1HmwVF5zXHV3xKtHP5HlHA5g=;
        b=kWs5mzMC1tsTOXKeWA/uKSnO/eTsDbWjiajDLXB7IjZd/Il9JetpzLrEOwxVCUJq8bvm8J
        90z9fHj3KSsE2BCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Mark check_user_regs() noinstr
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708192934.191497962@linutronix.de>
References: <20200708192934.191497962@linutronix.de>
MIME-Version: 1.0
Message-ID: <159428657046.4006.8686721076754110176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     006e1ced516d2bfd9db63a32b5dba3c2abf43b04
Gitweb:        https://git.kernel.org/tip/006e1ced516d2bfd9db63a32b5dba3c2abf43b04
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Jul 2020 21:28:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jul 2020 11:18:29 +02:00

x86/entry: Mark check_user_regs() noinstr

It's called from the non-instrumentable section.

Fixes: c9c26150e61d ("x86/entry: Assert that syscalls are on the right stack")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200708192934.191497962@linutronix.de

---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e83b3f1..ea7b515 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -46,7 +46,7 @@
 #include <trace/events/syscalls.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
-static void check_user_regs(struct pt_regs *regs)
+static noinstr void check_user_regs(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*
