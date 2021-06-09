Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8333A14F8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jun 2021 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhFIM6T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Jun 2021 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhFIM6R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Jun 2021 08:58:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9DC061574;
        Wed,  9 Jun 2021 05:56:22 -0700 (PDT)
Date:   Wed, 09 Jun 2021 12:56:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623243380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCQCaQyb0jTJ5LiNhvotdpCjdtNnWoHqjPLhWRxGJ/4=;
        b=2sZg2B2ej5y6OjhDS6xrY5HXtoPtmn5ONhyqcVO+Mv0ehRIve6Oipdrf+m/usNF4TuNYmK
        4oJ/SbAL34IoksPgEnbbWgAkF8xQ/xEerLwPHMLq+WmaFOCecsPv/OsUdfyXSfzMjt14/8
        0qJ8B41HC11/Vy0LkL5DagvGYnwNMuYNeRSIJiPj8+ZXbYO/zlGr+EvsnaCPt6Rl7aQ9Ig
        4CfbY/RgPtP1GMS32u/C+i508jOQJOjHLBhbLzjx8IvlI0BL7iOrajsQgFLQ859WU0Re57
        aeej0xH12v9ibBhgD+OOLNJsjVp0kfGUYHXoc7Jf/4b82aDG91Lj8N6fZsuoyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623243380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCQCaQyb0jTJ5LiNhvotdpCjdtNnWoHqjPLhWRxGJ/4=;
        b=9246PAGfveGk+V35+UBkfrmnRiZpFpYn9g9/2W3EqwM4k3DK2JzCho6xnHcN/mxTSq4O+L
        OvZ5iAAZbE3lJQBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add address range checks to copy_user_to_xstate()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210608144346.140254130@linutronix.de>
References: <20210608144346.140254130@linutronix.de>
MIME-Version: 1.0
Message-ID: <162324337978.29796.11158541383873203858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f72a249b0ba85564c6bfa94d609a70567485a061
Gitweb:        https://git.kernel.org/tip/f72a249b0ba85564c6bfa94d609a70567485a061
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 08 Jun 2021 16:36:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Jun 2021 14:46:20 +02:00

x86/fpu: Add address range checks to copy_user_to_xstate()

copy_user_to_xstate() uses __copy_from_user(), which provides a negligible
speedup.  Fortunately, both call sites are at least almost correct.

__fpu__restore_sig() checks access_ok() with xstate_sigframe_size()
length and ptrace regset access uses fpu_user_xstate_size. These should
be valid upper bounds on the length, so, at worst, this would cause
spurious failures and not accesses to kernel memory.

Nonetheless, this is far more fragile than necessary and none of these
callers are in a hotpath.

Use copy_from_user() instead.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rik van Riel <riel@surriel.com>
Link: https://lkml.kernel.org/r/20210608144346.140254130@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a85c640..8ac0f67 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1190,7 +1190,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	offset = offsetof(struct xregs_state, header);
 	size = sizeof(hdr);
 
-	if (__copy_from_user(&hdr, ubuf + offset, size))
+	if (copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
@@ -1205,7 +1205,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			if (__copy_from_user(dst, ubuf + offset, size))
+			if (copy_from_user(dst, ubuf + offset, size))
 				return -EFAULT;
 		}
 	}
@@ -1213,7 +1213,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
 		offset = offsetof(struct fxregs_state, mxcsr);
 		size = MXCSR_AND_FLAGS_SIZE;
-		if (__copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
+		if (copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
 			return -EFAULT;
 	}
 
