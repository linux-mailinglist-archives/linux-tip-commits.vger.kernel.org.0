Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8988F22ACCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jul 2020 12:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgGWKnp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Jul 2020 06:43:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgGWKno (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:44 -0400
Date:   Thu, 23 Jul 2020 10:43:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHMAhr8ZvN++ywZ+BF/oBknLc88Ue4IFCSS7t0DC0tA=;
        b=mFUAkEsBqi1A8MgiDBaypCUbLYu81kZIPT5BfalgR0tXnW1cdUgfvpFNvPgK5SInc9BZVW
        DOkUvXAJfPNZR47CyME+Atp+mvjRZNa+JTmko0pNA6/b/hp910XY0LAZLG9674uJhZDpNs
        WurwrlySIkLtdiqQm7oNzD8xXQ8kGFL4yizqy44RCNyASrMZNu8u3eOVLWyNJpAjnwoBjz
        1ycLC75hPUahVwoSUUuyCM+iv269eBS4AWbd8E0KiAxoTuDo9KWWChCv1JMrKCquEoc9m4
        Hea5fu20fHJvT+sCt7anFnkTURt/nyIYsQEwOPa3/CpaMNp9rtRk7mKQpeY+7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHMAhr8ZvN++ywZ+BF/oBknLc88Ue4IFCSS7t0DC0tA=;
        b=KKaHhcTqPsD5REHZHD4xaiYx5F57Ogk4fWHYV3glpUTCb6u2a30L5H43UlFUITz8/ejKPS
        H3XGgvnB+DIefODA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Remove "e" constraint from XADD
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-6-ndesaulniers@google.com>
References: <20200720204925.3654302-6-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102240.4006.7732685434667367105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e4d16defbbde028aeab2026995f0ced4240df6d6
Gitweb:        https://git.kernel.org/tip/e4d16defbbde028aeab2026995f0ced4240df6d6
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:19 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:40 +02:00

x86/percpu: Remove "e" constraint from XADD

The "e" constraint represents a constant, but the XADD instruction doesn't
accept immediate operands.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://lkml.kernel.org/r/20200720204925.3654302-6-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2a24f3c..9bb5440 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -220,7 +220,7 @@ do {									\
 		break;							\
 	case 8:								\
 		asm qual ("xaddq %0, "__percpu_arg(1)			\
-			    : "+re" (paro_ret__), "+m" (var)		\
+			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	default: __bad_percpu_size();					\
