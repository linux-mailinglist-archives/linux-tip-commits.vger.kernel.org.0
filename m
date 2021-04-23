Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312B8368DAB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Apr 2021 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhDWHLD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Apr 2021 03:11:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhDWHLC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Apr 2021 03:11:02 -0400
Date:   Fri, 23 Apr 2021 07:10:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619161825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IdG+qE4nPL1Uo6a1wGpJTVXFA+NtzVeHtYSiyWCwrg=;
        b=DSIid6MWSUJk9iC4U2hgKJk14MGGCPLCLkvnSn8Q9AFYv/G7erDgW629Zfs5rXa6p16oqB
        336BMp1NmxbDbl65OROCLN8+tC2jc12WIdPn8LEM4KM5pjdvaLP2nn0eEcAUmQgznz3nw2
        8gZt/eHyaHuitoEI9y9du3hr43tLL1uLZG+GcRKx3cbZdHTWw+11mprcYyG+n80yR59bm0
        VIOEpmRCKclWfGUK6vWQektB8EtpKf6JeDwAY48kZzbqPU4jq+wYIxDdOnM3Ke3hMcwKi9
        i5Tk7CAc2WvrgmbkihTY0B81LvIIFb1IMjAenfLj5rDGp+M6zIexXr1P5vqGkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619161825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IdG+qE4nPL1Uo6a1wGpJTVXFA+NtzVeHtYSiyWCwrg=;
        b=4vBGwEqH8f8sKIUmYK1WC4H0rUsydnEIdnTB1loReYiAik+3Kd+fNbDubVMBfHOi22KY8l
        kfI73KjN0UWZPNBA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] signal, perf: Add missing TRAP_PERF case in siginfo_layout()
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422191823.79012-2-elver@google.com>
References: <20210422191823.79012-2-elver@google.com>
MIME-Version: 1.0
Message-ID: <161916182507.29796.16853623340794568240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ed8e50800bf4c2d904db9c75408a67085e6cca3d
Gitweb:        https://git.kernel.org/tip/ed8e50800bf4c2d904db9c75408a67085e6cca3d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 22 Apr 2021 21:18:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Apr 2021 09:03:16 +02:00

signal, perf: Add missing TRAP_PERF case in siginfo_layout()

Add the missing TRAP_PERF case in siginfo_layout() for interpreting the
layout correctly as SIL_PERF_EVENT instead of just SIL_FAULT. This
ensures the si_perf field is copied and not just the si_addr field.

This was caught and tested by running the perf_events/sigtrap_threads
kselftest as a 32-bit binary with a 64-bit kernel.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210422191823.79012-2-elver@google.com
---
 kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index f683518..343d87c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3206,6 +3206,8 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 			else if ((sig == SIGSEGV) && (si_code == SEGV_PKUERR))
 				layout = SIL_FAULT_PKUERR;
 #endif
+			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
+				layout = SIL_PERF_EVENT;
 		}
 		else if (si_code <= NSIGPOLL)
 			layout = SIL_POLL;
