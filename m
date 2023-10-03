Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCED7B719C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Oct 2023 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjJCTTL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 3 Oct 2023 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTTL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 3 Oct 2023 15:19:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0759E;
        Tue,  3 Oct 2023 12:19:08 -0700 (PDT)
Date:   Tue, 03 Oct 2023 19:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696360746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXwvdKEZsex1mUoiT3XttWgQj+pJN6iq2V/O4MOUH1I=;
        b=FUxtqVW8OwpMOV8Ywim0HCwzrO6/sb/8hP3enKsQn9QkZhuTQzR+ci9of6smeIDYtvVmDr
        9TOIGWRNlMlToaGAzZahrVSznPSWUUQk/yXJwOUbDmdpNHq55bRf/v6EpiAUYJBVMv5wbx
        sX44BhGWeHGTbzqV8wiDa3eslY+9KGVdAxvBFgGsHHEYBGkmuKvACId8HtLl0U3aKEj16w
        L3x0wfs7doDdlAKq861bKJ7nTcm3hxZ+ut4XMcL4rSR2D3WB3rm3W8d/DLo+Kzw2sB3JS1
        7kYmRzdguc/OQk7BsG/N8yl5EZUdqUAC+Dulhn2wmTWhKod04HVYB5B9b+1GLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696360746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXwvdKEZsex1mUoiT3XttWgQj+pJN6iq2V/O4MOUH1I=;
        b=9fdDZ6GSljP3XkgxfSA43gwqQi42+Oaae0fwYXfLK2Tz78sS8/L/bbJja9dGmyWpG0FZhZ
        nTcQ3SCKfQa+iIBg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Use local64_try_cmpxchg in
 rapl_event_update()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807145134.3176-2-ubizjak@gmail.com>
References: <20230807145134.3176-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169636074590.3135.6268444567676526920.tip-bot2@tip-bot2>
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

Commit-ID:     bcc6ec3d954bbcc8bec34a21c05ea536a2e96d6f
Gitweb:        https://git.kernel.org/tip/bcc6ec3d954bbcc8bec34a21c05ea536a2e96d6f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 16:51:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 21:13:45 +02:00

perf/x86/rapl: Use local64_try_cmpxchg in rapl_event_update()

Use local64_try_cmpxchg() instead of local64_cmpxchg(*ptr, old, new) == old.

X86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after CMPXCHG (and related move instruction in front of CMPXCHG).

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when CMPXCHG
fails. There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230807145134.3176-2-ubizjak@gmail.com
---
 arch/x86/events/rapl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e8f53b2..6d3e738 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -179,13 +179,11 @@ static u64 rapl_event_update(struct perf_event *event)
 	s64 delta, sdelta;
 	int shift = RAPL_CNTR_WIDTH;
 
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdmsrl(event->hw.event_base, new_raw_count);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		rdmsrl(event->hw.event_base, new_raw_count);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	/*
 	 * Now we have the new raw value and have updated the prev
