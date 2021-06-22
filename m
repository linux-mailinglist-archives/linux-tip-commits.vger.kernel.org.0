Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F443B0398
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFVMF7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhFVMF5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504EC061574;
        Tue, 22 Jun 2021 05:03:40 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624363418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsOYEfmLx8KrqVoUWJaLH5f0JOIanErST/uzM6IYTSA=;
        b=3dDEqGpBYTX7pS0x32PGSBMONh7CHsgoe2ztoccR97X2Yt1qmE5nHkKxrLHu2nI/9hnOpf
        FT9NMjdBaBpCgujy4ixpGSgR4shFgnpbE1qBy3kR1RDu3kQ8kGwPAWuRODydfBiKcvTWf9
        tYXODHPr+5AwmrLZO6s4EFFly7eXQX2cl3jLrmEOoZiiAhxfy3qvtkBqM7MGZafHHYwacr
        T4xW/XhPqFhAnVlKLtJaQgypODUNd9W0CuLHvJJmLwsyqfkkKAIPQlfoxobSSS8R68/n3X
        XiYK3dQsm4OoV2T5CgfuOCxu2L26v3Ef9ZseQq4scUt8y6C8x6EbGjK8XXDBQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624363418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsOYEfmLx8KrqVoUWJaLH5f0JOIanErST/uzM6IYTSA=;
        b=Gko3CaShMmHzXKfpl2Gx4KktGrQrc34G+fMTzjX/f7eX78weAhJg7U0yBK+ibxoTOkAsIM
        SfPV9Ew2ldAvrgAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86: Always inline task_size_max()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210621120120.682468274@infradead.org>
References: <20210621120120.682468274@infradead.org>
MIME-Version: 1.0
Message-ID: <162436341797.395.13837570842333490587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     1f008d46f1243899d27fd034ab5c41985bd16cee
Gitweb:        https://git.kernel.org/tip/1f008d46f1243899d27fd034ab5c41985bd16cee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Jun 2021 13:12:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 13:56:43 +02:00

x86: Always inline task_size_max()

Fix:

  vmlinux.o: warning: objtool: handle_bug()+0x10: call to task_size_max() leaves .noinstr.text section

When #UD isn't a BUG, we shouldn't violate noinstr (we'll still
probably die, but that's another story).

Fixes: 025768a966a3 ("x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210621120120.682468274@infradead.org
---
 arch/x86/include/asm/page_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index ca840fe..4bde0dc 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -75,7 +75,7 @@ void copy_page(void *to, void *from);
  *
  * With page table isolation enabled, we map the LDT in ... [stay tuned]
  */
-static inline unsigned long task_size_max(void)
+static __always_inline unsigned long task_size_max(void)
 {
 	unsigned long ret;
 
