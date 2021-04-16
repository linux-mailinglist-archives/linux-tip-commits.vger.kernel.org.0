Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638B236235B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbhDPPCV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbhDPPCS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C1C061763;
        Fri, 16 Apr 2021 08:01:53 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPe/ud/7r1sjgssIgoiYTR7iIX1sgTxDyKF2EnRBIVA=;
        b=s6KCGXKDIGaxLvWmuLvJZTowIhJsffzoAnNn13y3cPeiHEH8ydE7p0wvaxWxCmECgOPNuC
        TazSH7cmfdY3tnQ4qMTawWhjqVsDlOx16Kmpzif7lF+CSS9zavQodovXnlq1yvdVnaB2GA
        /b4G8Zrrw7BZ6jE6HLGHAzryjOiop7fQcSZAFCJvx8hQLUfjDtSYo3IGaVTt4flytQXY+F
        pbtRPMQ5w/Fy4b4qoaGYV8tzqsVrwAuK7EwuR7ThkjygYzDNHDad071XpQdSq+eb+wTw1j
        MGQenlO1S+h/hUrvhuN8ig7h8pml+tbsL6KDH+p0vccbWU95nPgV48FRW4/bdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPe/ud/7r1sjgssIgoiYTR7iIX1sgTxDyKF2EnRBIVA=;
        b=NmcxovV06iOOfpHHWkGgoMeHe34taGOggjjsms7h1Of3jJYZwPMEHkrphfElNcczhq/pln
        Qa3X+NTTOtbkk6Ag==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210408103605.1676875-3-elver@google.com>
References: <20210408103605.1676875-3-elver@google.com>
MIME-Version: 1.0
Message-ID: <161858531152.29796.6913083188712976214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     47f661eca0700928012e11c57ea0328f5ccfc3b9
Gitweb:        https://git.kernel.org/tip/47f661eca0700928012e11c57ea0328f5ccfc3b9
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 08 Apr 2021 12:35:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:40 +02:00

perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children

As with other ioctls (such as PERF_EVENT_IOC_{ENABLE,DISABLE}), fix up
handling of PERF_EVENT_IOC_MODIFY_ATTRIBUTES to also apply to children.

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lkml.kernel.org/r/20210408103605.1676875-3-elver@google.com
---
 kernel/events/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 318ff7b..10ed2cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3200,16 +3200,36 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 static int perf_event_modify_attr(struct perf_event *event,
 				  struct perf_event_attr *attr)
 {
+	int (*func)(struct perf_event *, struct perf_event_attr *);
+	struct perf_event *child;
+	int err;
+
 	if (event->attr.type != attr->type)
 		return -EINVAL;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_BREAKPOINT:
-		return perf_event_modify_breakpoint(event, attr);
+		func = perf_event_modify_breakpoint;
+		break;
 	default:
 		/* Place holder for future additions. */
 		return -EOPNOTSUPP;
 	}
+
+	WARN_ON_ONCE(event->ctx->parent_ctx);
+
+	mutex_lock(&event->child_mutex);
+	err = func(event, attr);
+	if (err)
+		goto out;
+	list_for_each_entry(child, &event->child_list, child_list) {
+		err = func(child, attr);
+		if (err)
+			goto out;
+	}
+out:
+	mutex_unlock(&event->child_mutex);
+	return err;
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx,
