Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547DC7B62B2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Oct 2023 09:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJCHqE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 3 Oct 2023 03:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJCHqC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 3 Oct 2023 03:46:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5BCAC;
        Tue,  3 Oct 2023 00:45:57 -0700 (PDT)
Date:   Tue, 03 Oct 2023 07:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696319155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhLqVOfcPgrbB1gJ8W2N133NiucGxKXHBuTDVSwkgS8=;
        b=A2oJNAX/gSsjG7Xk8/gQcJWGmetDkWiMCWk+WKLarSijWrEaKuY5D7+rafWpKNACuDzFYM
        K/MV50vqWugpCZ0mYX8sbPsZe815gOnlDrh5oGMcu0Mkek0hpMbvmzSCFLOQjudtwyAPTh
        bURZ8vrKH/OjEcZZ5CZp/vsHGdfm2X58ZuXcPHLi9Q8hzqpj4TLMitVeccpRJ9JIjp2opH
        T8fbEd7CK5xA2JQpbJv7fE/G6Wtdf0OP+W+7xhFMxNbt5tUKBl66fn5olQ2GC3AOqf8Uek
        7xYX0Zsw0XeWgsKafcOGVaGuX+MmznPZ9KgPU45LfbFYgNCEQIojtjk6lwFaCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696319155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhLqVOfcPgrbB1gJ8W2N133NiucGxKXHBuTDVSwkgS8=;
        b=65cCUwwPp5uagRjrMJKk6FO3yN9nsdsNzuokoUfMsqAcl74yD7/J0VbQ35mMK3eyzgdWST
        hURngMWtyy0v7/Bg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Stop doing cpu_relax() in the
 local64_cmpxchg() loop in rapl_event_update()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807145134.3176-1-ubizjak@gmail.com>
References: <20230807145134.3176-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169631915503.3135.14731625648889165839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     df22fb4bcdd6f67c4f568e6321c9b0050819d213
Gitweb:        https://git.kernel.org/tip/df22fb4bcdd6f67c4f568e6321c9b0050819d213
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 16:51:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 09:36:17 +02:00

perf/x86/rapl: Stop doing cpu_relax() in the local64_cmpxchg() loop in rapl_event_update()

According to the following commit:

   f5fe24ef17b5 ("lockref: stop doing cpu_relax in the cmpxchg loop")

   "On the x86-64 architecture even a failing cmpxchg grants exclusive
    access to the cacheline, making it preferable to retry the failed op
    immediately instead of stalling with the pause instruction."

Based on the above observation, remove cpu_relax() from the
local64_cmpxchg() loop of rapl_event_update().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230807145134.3176-1-ubizjak@gmail.com

Cc. "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/events/rapl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 1579429..e8f53b2 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -184,10 +184,8 @@ again:
 	rdmsrl(event->hw.event_base, new_raw_count);
 
 	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count) {
-		cpu_relax();
+			    new_raw_count) != prev_raw_count)
 		goto again;
-	}
 
 	/*
 	 * Now we have the new raw value and have updated the prev
