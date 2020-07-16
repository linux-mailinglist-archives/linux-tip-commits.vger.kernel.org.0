Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D764222704
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jul 2020 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgGPPah (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Jul 2020 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgGPPag (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Jul 2020 11:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67BC061755;
        Thu, 16 Jul 2020 08:30:36 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:30:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594913434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQ/sBhBjSgAmz+Xpp5cNpgbzQiTMNd29YJCKR9OgmVs=;
        b=p6KFpuckZMD5b+WIILEkjN03SzhwaqOn1N2rXaz6coUuda/sv636v1HHPEVmrxFP0iFqkn
        cmzfjX+2N/qikppSu5CYi0qtxoe2auEmb6z7WPP0JDDTrVmL6I9YndVyVjV3/ANar5r/NH
        /sxdepCZy8XV4xQ1YajUVH5YqqZHu8U8E3lgHlQ2i5Yjb40EMAhFJZcEiBKhdq+Yknn1Di
        3CSF/5jX6YIIchHSCE7AVPtIigLrIP19AIs+6r/POOScEdZWtOhB/o1hq7o7v334qH7T6y
        kmEyrPpEHKhA6Afo3Wf+tGl4o/BxB+rYqnrvbMB3A2EMLZa7gjArKxXyn0XOcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594913434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQ/sBhBjSgAmz+Xpp5cNpgbzQiTMNd29YJCKR9OgmVs=;
        b=hQpABB1fvOGRoo0aqgsicnldEgjApxYc4E2J92P3z2CrjGsoywqC0K9DQIqOcptViCkHq6
        DlOLYgK9LwYZ/MDw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: math-emu: Fix up 'cmp' insn for clang ias
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527135352.1198078-1-arnd@arndb.de>
References: <20200527135352.1198078-1-arnd@arndb.de>
MIME-Version: 1.0
Message-ID: <159491343346.4006.6445776713545348721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     81e96851ea32deb2c921c870eecabf335f598aeb
Gitweb:        https://git.kernel.org/tip/81e96851ea32deb2c921c870eecabf335f598aeb
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 27 May 2020 15:53:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jul 2020 17:26:42 +02:00

x86: math-emu: Fix up 'cmp' insn for clang ias

The clang integrated assembler requires the 'cmp' instruction to
have a length prefix here:

arch/x86/math-emu/wm_sqrt.S:212:2: error: ambiguous instructions require an explicit suffix (could be 'cmpb', 'cmpw', or 'cmpl')
 cmp $0xffffffff,-24(%ebp)
 ^

Make this a 32-bit comparison, which it was clearly meant to be.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20200527135352.1198078-1-arnd@arndb.de

---
 arch/x86/math-emu/wm_sqrt.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/math-emu/wm_sqrt.S b/arch/x86/math-emu/wm_sqrt.S
index 3b2b581..40526dd 100644
--- a/arch/x86/math-emu/wm_sqrt.S
+++ b/arch/x86/math-emu/wm_sqrt.S
@@ -209,7 +209,7 @@ sqrt_stage_2_finish:
 
 #ifdef PARANOID
 /* It should be possible to get here only if the arg is ffff....ffff */
-	cmp	$0xffffffff,FPU_fsqrt_arg_1
+	cmpl	$0xffffffff,FPU_fsqrt_arg_1
 	jnz	sqrt_stage_2_error
 #endif /* PARANOID */
 
