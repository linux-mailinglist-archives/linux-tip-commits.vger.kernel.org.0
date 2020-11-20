Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE792BAA2C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgKTMeC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgKTMeC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D4C0617A7;
        Fri, 20 Nov 2020 04:34:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6ZZzTnXXAPBAjmm8dD1OV9oMh/fa3mfBwyL6H4CJKA=;
        b=Y1ZE5zKJhf3mIMPMRLLdgOnhO7s4ItbHuFauAXtZ0gd5H/57665qLh4nm8jTDy1f+ei8op
        JmfORJn4qB4Jd9xGAKEphADoFzMO+9zPy3JpkC9W90p4K6tQnAW0dJhzdk7HGH6FN+eTQb
        POvzHS1HJb8aBaGt0WtNrf/+XHxDGtuj1q+102wpHdIjkP7bUgGjEaE8rRhVdftJLnTaQy
        H1sMh70TETjmP8Gr1fjS53KdMh71hDOnQT25gh8LYJzrJOKx65P9GhpsMp+CEc7SzrNB2f
        3ykTh65LFoh21ynoTd0gV7+TsmW+aZ1opp1jf8TiHBeJ3NdeJd7TNPLdgtZJzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6ZZzTnXXAPBAjmm8dD1OV9oMh/fa3mfBwyL6H4CJKA=;
        b=hj13RosFLe6rk2f9jNyZEkI3+if2JvsRKduxeJl/wzWVkYMDsxWoW6FcMGIVsiXHAidl3i
        d80QYLa1nIwAtoAA==
From:   "tip-bot2 for Jakub Jelinek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] ilog2 vs. GCC inlining heuristics
Cc:     Jakub Jelinek <jakub@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201021132718.GB2176@tucnak>
References: <20201021132718.GB2176@tucnak>
MIME-Version: 1.0
Message-ID: <160587563846.11244.17275939588139394513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     ecbd43f6728a5cf79c8b50ed326658e9181531b1
Gitweb:        https://git.kernel.org/tip/ecbd43f6728a5cf79c8b50ed326658e9181531b1
Author:        Jakub Jelinek <jakub@redhat.com>
AuthorDate:    Wed, 21 Oct 2020 15:27:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:26:18 +01:00

ilog2 vs. GCC inlining heuristics

Hi!

Based on the GCC PR97445 discussions, I'd like to propose following change,
which should significantly decrease the amount of code in inline functions
that use ilog2, but as I'm already two decades out of the Linux kernel
development, I'd appreciate if some kernel developer could try that (all
I have done is check that it gives the same results as before) and if it
works submit it for inclusion into the kernel?

Thanks.

Improve ilog2 for constant arguments

As discussed in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97445
the const_ilog2 macro generates a lot of code which interferes badly
with GCC inlining heuristics, until it can be proven that the ilog2
argument can or can't be simplified into a constant.

It can be expressed using __builtin_clzll builtin which is supported
by GCC 3.4 and later and when used only in the __builtin_constant_p guarded
code it ought to always fold back to a constant.
Other compilers support the same builtin for many years too.

Other option would be to change the const_ilog2 macro, though as the
description says it is meant to be used also in C constant expressions,
and while GCC will fold it to constant with constant argument even in
those, perhaps it is better to avoid using extensions in that case.

Signed-off-by: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201021132718.GB2176@tucnak
---
 include/linux/log2.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index c619ec6..4307d34 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -156,7 +156,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 #define ilog2(n) \
 ( \
 	__builtin_constant_p(n) ?	\
-	const_ilog2(n) :		\
+	((n) < 2 ? 0 :			\
+	 63 - __builtin_clzll (n)) :	\
 	(sizeof(n) <= 4) ?		\
 	__ilog2_u32(n) :		\
 	__ilog2_u64(n)			\
