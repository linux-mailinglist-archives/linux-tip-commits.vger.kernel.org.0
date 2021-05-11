Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3B37A150
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 May 2021 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhEKIDt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 11 May 2021 04:03:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKIDn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 11 May 2021 04:03:43 -0400
Date:   Tue, 11 May 2021 08:02:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620720156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5O24x81upTyoGlUsrTjQHVDQ39mpHr6bnhzCRyp618Y=;
        b=hvGvxcx1s7J4O2u3iCUU24IftA0QrEadNVPZmhHpS7f4OYn/O80qNfKEdU0gN0cesRrw0m
        g6rIZeLqr+fRfnF/vRbOi7U/mKnSDbzuwAnH2APpMDhg36iIaI35cGl5MpH0lNtwNGZDcw
        W1TCajJ/oi/xn6kIupQoA9YF+yMqr7aVv5+gIyOie7BsmrtcgEimY8B86XiHV+xWi86I1B
        D/kQkZKZrWvfdWX3n4v7Qchv/lp/KVkqqkIW5xMtgZHf5B/0Mqmu8vV2FDoUFEZ39Kwu41
        pCL+ClDbvorahSx8T9NSeYUQrO2mZIh38fPblggA1qBwU8inROVK5iXUxFBLvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620720156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5O24x81upTyoGlUsrTjQHVDQ39mpHr6bnhzCRyp618Y=;
        b=CLj6bJsT3tBj6+7p1y3W+galUlwkruMbyoOvwbLT5uCjrYspsYMxdn6fmP8Apgs36gYlLj
        YizNZoLh/MXY//CQ==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] stack: Replace "o" output with "r" input constraint
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210419231741.4084415-1-keescook@chromium.org>
References: <20210419231741.4084415-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <162072015599.29796.13527415433369376189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     2515dd6ce8e545b0b2eece84920048ef9ed846c4
Gitweb:        https://git.kernel.org/tip/2515dd6ce8e545b0b2eece84920048ef9ed846c4
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Mon, 19 Apr 2021 16:17:41 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 May 2021 09:56:11 +02:00

stack: Replace "o" output with "r" input constraint

"o" isn't a common asm() constraint to use; it triggers an assertion in
assert-enabled builds of LLVM that it's not recognized when targeting
aarch64 (though it appears to fall back to "m"). It's fixed in LLVM 13 now,
but there isn't really a good reason to use "o" in particular here. To
avoid causing build issues for those using assert-enabled builds of earlier
LLVM versions, the constraint needs changing.

Instead, if the point is to retain the __builtin_alloca(), make ptr appear
to "escape" via being an input to an empty inline asm block. This is
preferable anyways, since otherwise this looks like a dead store.

While the use of "r" was considered in

  https://lore.kernel.org/lkml/202104011447.2E7F543@keescook/

it was only tested as an output (which looks like a dead store, and wasn't
sufficient).

Use "r" as an input constraint instead, which behaves correctly across
compilers and architectures.

Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://reviews.llvm.org/D100412
Link: https://bugs.llvm.org/show_bug.cgi?id=49956
Link: https://lore.kernel.org/r/20210419231741.4084415-1-keescook@chromium.org

---
 include/linux/randomize_kstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index fd80fab..bebc911 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
 		u32 offset = raw_cpu_read(kstack_offset);		\
 		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
-		asm volatile("" : "=o"(*ptr) :: "memory");		\
+		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
 } while (0)
 
