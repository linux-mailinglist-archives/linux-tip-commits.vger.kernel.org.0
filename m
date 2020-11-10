Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655AA2AD6BB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgKJMpv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKJMpW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:22 -0500
Date:   Tue, 10 Nov 2020 12:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtnXMzSzaOPu6h0vfEVKJleqFYSEHIqAn/XWEwy7Tt0=;
        b=K7+dEAI+/iKRGS7f5+440hfLW3fgkEmKmNu0LXSGiIasWkbfCVIDZNxKvsQ4DiX9j6Y2ZW
        z9ie5vWHQxB/iVGoP8dDaF71DKRA8zp0F30Tb3yJ7OSOYL3AfE15ZfTjkmWOHDHsmzYrgi
        +F2/8B/a6mrbFG3S1gRZsZT/sekHiYhMdeb3QscZQW5uDdOo+Jj9HaFEeqJdYF3t2BxqeA
        zj9HZigrzf6/ETvhHCp13P5NU7sued5/XmDcB8rt1WtbVnZr2u+cV9UUaez8S78QQL2WjL
        m1aZ6z2FOextKDFW5BcSu6zb3k1pwcssxL2Pja8iP1kODUMPGyVxnJKQnRE0cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtnXMzSzaOPu6h0vfEVKJleqFYSEHIqAn/XWEwy7Tt0=;
        b=0ijBzOEKdpug6/IA36yTpDgBD7TrJxMyI6Se/B2C3aef76EuyUdJQmc2C3M1DREnRP69em
        MO62UIsLGe+58AAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Make dummy_iregs static
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030151955.324273677@infradead.org>
References: <20201030151955.324273677@infradead.org>
MIME-Version: 1.0
Message-ID: <160501231994.11244.6830281963445643876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e506d1dac0edb2df82f2aa0582e814f9cd9aa07d
Gitweb:        https://git.kernel.org/tip/e506d1dac0edb2df82f2aa0582e814f9cd9aa07d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 12:15:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:35 +01:00

perf/x86: Make dummy_iregs static

Having pt_regs on-stack is unfortunate, it's 168 bytes. Since it isn't
actually used, make it a static variable. This both gets if off the
stack and ensures it gets 0 initialized, just in case someone does
look at it.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201030151955.324273677@infradead.org
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 276b29d..b47cc42 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1738,7 +1738,7 @@ __intel_pmu_pebs_event(struct perf_event *event,
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
-	struct pt_regs dummy_iregs;
+	static struct pt_regs dummy_iregs;
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		/*
