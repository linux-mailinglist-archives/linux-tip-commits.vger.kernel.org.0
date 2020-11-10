Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757BA2AD6B9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgKJMpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKJMpU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1EC0613D1;
        Tue, 10 Nov 2020 04:45:19 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:45:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BAKtyzOhe5LsD3Qo3E4fwrPGWfTOSpyEDldWeaAwJg=;
        b=q1gVIDjYBuTrJ6Ph8olsBpEsJyAQP2TqhJMQns2dNbUnBu+a0oUkU1Vf1MkNZ/L+QPZgIU
        LIPzGROrCNfybCo5otZfFahdjYyjYsNK40LLJaR13b30FqqADqQj+rCprr2snJQnUAPW5N
        /4JyoMpt1fdFivj2ypVfc/Fvaph1AzJObh8Zsp9ouWpz+Vwj9wiQ1BJqf6TO9IwrZrdu6Z
        ow8pYaYAA60mfxvtdDWKXVB/kB4Ra8D3KbVqidN10J/vx8i3MXrvrDFGzD85qAXvDNvcbQ
        4YQDb4vBr3meCa5dbhagNH2M0HVXNYd46hQBjFtxVoG/lfmo8rWpAS0erh+uXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BAKtyzOhe5LsD3Qo3E4fwrPGWfTOSpyEDldWeaAwJg=;
        b=gTj8azF17IKzh5OnoAZJBOfxiCGM2G1v++xlVVd3qrAnCR7GK8zeNFyJe00Eqqwrt2odeS
        wtTOgEICmZQrDECg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Tweak perf_event_attr::exclusive semantics
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029162902.105962225@infradead.org>
References: <20201029162902.105962225@infradead.org>
MIME-Version: 1.0
Message-ID: <160501231753.11244.9753179853237971652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1908dc911792067287458fdb0800f036f4f4e0f6
Gitweb:        https://git.kernel.org/tip/1908dc911792067287458fdb0800f036f4f4e0f6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Oct 2020 16:32:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:36 +01:00

perf: Tweak perf_event_attr::exclusive semantics

Currently perf_event_attr::exclusive can be used to ensure an
event(group) is the sole group scheduled on the PMU. One consequence
is that when you have a pinned event (say the watchdog) you can no
longer have regular exclusive event(group)s.

Inspired by the fact that !pinned events are considered less strict,
allow !pinned,exclusive events to share the PMU with pinned,!exclusive
events.

Pinned,exclusive is still fully exclusive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201029162902.105962225@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 00be48a..dc568ca 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2637,7 +2637,7 @@ static int group_can_go_on(struct perf_event *event,
 	 * If this group is exclusive and there are already
 	 * events on the CPU, it can't go on.
 	 */
-	if (event->attr.exclusive && cpuctx->active_oncpu)
+	if (event->attr.exclusive && !list_empty(get_event_list(event)))
 		return 0;
 	/*
 	 * Otherwise, try to add it if all previous groups were able
