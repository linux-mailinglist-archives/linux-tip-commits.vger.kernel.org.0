Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE4412FBE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhIUHyX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhIUHyX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:54:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563CC061574;
        Tue, 21 Sep 2021 00:52:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632210774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1QOzZheecOFkSCMtCpbq7MNEXfm7EmBx/vYQLDFQcg=;
        b=pRvb0YhVq/Gl8xKYaeyJxy/udcQkhx2wPzze121ER5qSSj7jHjJEaE+Z0xUuqGt9gN024V
        tY1tS0GcNlzwHr7zJ07uD/yx+mvv8AT0L85WvZjZPiqHSa4hnRQFK5zMotoep0jPXQqB88
        7K1VW1Mp0l3txeIwOgHgTsj9qRRzmbP7V4AWkQURMXicJdishMISjtOKT8a3S2k8K9x0Xn
        tNcAnTWeFWKuP4IC0mmPDZZv/EylgHWpHcqfzky7hYHht3WF1944A6OeC3tDtukKt2Cj/z
        tGq+tVxmXWUfTzNxA2S0Q2SX7cdOPziYnk821hgPsz+PY+nOTLzRCL3y9sC7Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632210774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1QOzZheecOFkSCMtCpbq7MNEXfm7EmBx/vYQLDFQcg=;
        b=ix81ZB+/qgLHkUvpgcbPZ5/+oheaavBRidqD3ViFYzrPiy5SG7bC5e0Lup/UKdQVhiWMld
        Vf980fafyjGC1eDw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Drop copyin special case for #MC
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210818002942.1607544-4-tony.luck@intel.com>
References: <20210818002942.1607544-4-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163221077303.25758.8788992055844267780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     690658471b5f28d306e6492c4585d748cb5304e8
Gitweb:        https://git.kernel.org/tip/690658471b5f28d306e6492c4585d748cb5304e8
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 17 Aug 2021 17:29:42 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Sep 2021 21:18:23 +02:00

x86/mce: Drop copyin special case for #MC

Fixes to the iterator code to handle faults that are not on page
boundaries mean that the special case for machine check during copy from
user is no longer needed.

For a full list of those fixes, see the output of:

  git log --oneline v5.14 ^v5.13 -- lib/iov_iter.c

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210818002942.1607544-4-tony.luck@intel.com
---
 arch/x86/lib/copy_user_64.S | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 57b79c5..2797e63 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -234,24 +234,11 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
-	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
-	je 3f
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
-	/*
-	 * Return zero to pretend that this copy succeeded. This
-	 * is counter-intuitive, but needed to prevent the code
-	 * in lib/iov_iter.c from retrying and running back into
-	 * the poison cache line again. The machine check handler
-	 * will ensure that a SIGBUS is sent to the task.
-	 */
-3:	xorl %eax,%eax
-	ASM_CLAC
-	ret
-
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
