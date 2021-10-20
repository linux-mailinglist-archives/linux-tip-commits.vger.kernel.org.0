Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5C434C7E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJTNrl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhJTNrD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE5C06176C;
        Wed, 20 Oct 2021 06:44:41 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuUsLtBe2P6W+kQK01O2fYRuN+4sqeaAGeZTk9SyWHM=;
        b=P1LaEXdQJeF8z9/rxk3t2buhkwIkR4eTTZ7PbylGk8bqsR43m2XnHJHAdrhnZBhzRuPke6
        mfNYI3OW61yN4wbxgaJjdPR814W88fMa4cnA2FIM193r9L+isZ8Io6unlMCo7BxOhJQSeJ
        uswF1N7UTU33lHDoSeyQ1bf+yxMyvRaL3VFf1zq4Fcs/To1SJJo6u81MNNmNE3y0hUMz/0
        eboMvEw7NbqQ9MZ/vhWTtM9qhU+5ZDqVK0ysNZB8KxgSP8NsvX5B6lp1NM3b34DTs+hQcG
        ZUzKQYq4tChij62RZ+XL3VxoVPYmHd9Jla/yW9vuY59WZ5juZWiSCtyYPBMC4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuUsLtBe2P6W+kQK01O2fYRuN+4sqeaAGeZTk9SyWHM=;
        b=amqNLwa5hRwhNWMEvNJiIcTSofYpGabQmo06Amzs94oNgXTSAKhcxuNRhE98c2ClR4zXCH
        ho6oF69Q+u9fLbAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Mark all init only functions __init
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.017919252@linutronix.de>
References: <20211015011539.017919252@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747960.25758.3224856095054028352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     63cf05a19a5d3fb6e66b5f7ceb76e77dfc2695f2
Gitweb:        https://git.kernel.org/tip/63cf05a19a5d3fb6e66b5f7ceb76e77dfc2695f2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:27 +02:00

x86/fpu/xstate: Mark all init only functions __init

No point to keep them around after boot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.017919252@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a2bdc0c..b35ecfa 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -462,7 +462,7 @@ static int validate_user_xstate_header(const struct xstate_header *hdr)
 	return 0;
 }
 
-static void __xstate_dump_leaves(void)
+static void __init __xstate_dump_leaves(void)
 {
 	int i;
 	u32 eax, ebx, ecx, edx;
@@ -502,7 +502,7 @@ static void __xstate_dump_leaves(void)
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void check_xstate_against_struct(int nr)
+static void __init check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -544,7 +544,7 @@ static void check_xstate_against_struct(int nr)
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
-static void do_extra_xstate_size_checks(void)
+static void __init do_extra_xstate_size_checks(void)
 {
 	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
@@ -646,7 +646,7 @@ static unsigned int __init get_xsave_size(void)
  * Will the runtime-enumerated 'xstate_size' fit in the init
  * task's statically-allocated buffer?
  */
-static bool is_supported_xstate_size(unsigned int test_xstate_size)
+static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
 {
 	if (test_xstate_size <= sizeof(union fpregs_state))
 		return true;
@@ -691,7 +691,7 @@ static int __init init_xstate_size(void)
  * We enabled the XSAVE hardware, but something went wrong and
  * we can not use it.  Disable it.
  */
-static void fpu__init_disable_system_xstate(void)
+static void __init fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask_all = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
