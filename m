Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF62AD69C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgKJMpY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgKJMpY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04300C0613D3;
        Tue, 10 Nov 2020 04:45:24 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Lha2A8bfbgCXhuMpCdT7/y1nWrh8/0EUM1b2E6H500=;
        b=K1JYXTHRMoVFJ7IU963zkkQVadWJ4VC8RbSYDXkKVdC7T9Yex3EIvZWfZbOQWN5qroeBrh
        9fEwwvzBAdba/5L06qudthLF69FA+K0kwALqWxfKXq2jbWW46TEsFTrzwLu/eY6ndKo5FA
        pjl6FH3NW4mquJQ6qI1n7ZCR6lDvMbKfi1ssidlM7FZG2yuPM8Txg7GUE0Ob/jRAehARzr
        vHjXvDtNLGZ8SjlP+RsqOGbTH5P1oY5F5Z5CtYYqBGTir4Mc2FiDaxigFni5a74Kccnz0G
        i5DxpiE5piIoVJk/zkm1L3QrzHqQB3W+OlWEJpOXvL9smFIUMUFUhhGeilOqMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Lha2A8bfbgCXhuMpCdT7/y1nWrh8/0EUM1b2E6H500=;
        b=IlP4i72DNkwtloOc8r2ZPC9W2S8hkQtv0g9YszjioLJXiX2E8eXikKTPp6KJGabo7PrU5x
        flf/4nxmcDbGAhCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix get_recursion_context()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030151955.120572175@infradead.org>
References: <20201030151955.120572175@infradead.org>
MIME-Version: 1.0
Message-ID: <160501232179.11244.15698770094548974419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ce0f17fc93f63ee91428af10b7b2ddef38cd19e5
Gitweb:        https://git.kernel.org/tip/ce0f17fc93f63ee91428af10b7b2ddef38cd19e5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 12:49:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:34 +01:00

perf: Fix get_recursion_context()

One should use in_serving_softirq() to detect SoftIRQ context.

Fixes: 96f6d4444302 ("perf_counter: avoid recursion")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201030151955.120572175@infradead.org
---
 kernel/events/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index fcbf561..402054e 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -211,7 +211,7 @@ static inline int get_recursion_context(int *recursion)
 		rctx = 3;
 	else if (in_irq())
 		rctx = 2;
-	else if (in_softirq())
+	else if (in_serving_softirq())
 		rctx = 1;
 	else
 		rctx = 0;
