Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120E540C8B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhIOPum (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41506 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbhIOPuk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:40 -0400
Date:   Wed, 15 Sep 2021 15:49:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720958;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHcEx3+c9QMJSlRYniPuzcWZUJh8e/7jv7r9PUDbQPA=;
        b=MOdlob+8v35Dz9LWwgaW9WwzyK8HoznHmPqMPp7ThaBBKHVExy+1y8eSheXenvLyf++nT6
        3sQOwj8jq3DRouEhjv0ZonWbzJcWZR8DgIjJbvrWJ8dnExprjzz0dmhZ+RQdL1stALYVmB
        f0HUwhEPo/zzgzoG/XA9bXQWqJSKpMug8eVz/dSJXk7XVuqfS0p1Be86Wa1SQIee1/E/V1
        s0bXWXQg4Ta2Xxn+5CdvCfT9kHtupJ1iMGQlhiF+TDLtFT/vM3yOtdcNDDqEcSv1KOsAew
        ENp5aQT0mwccboOOOauhAa3jBNk9/fC2SZr2kkA+BbAl1Aows4zBHeZ3Ek47Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720958;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHcEx3+c9QMJSlRYniPuzcWZUJh8e/7jv7r9PUDbQPA=;
        b=WQdI9qlg6IjAdWM2d1aKWzr3an9dUWQvhJWMj5tr32iONwjFkq2GG1wWmJZGpVvsQlwUUA
        Vwe0qZBIuqU6noAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Mark xen_force_evtchn_callback() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.996055323@infradead.org>
References: <20210624095148.996055323@infradead.org>
MIME-Version: 1.0
Message-ID: <163172095769.25758.11532406051825712065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     41b8edc60d7232d1f3e49165fb6de20f424c4385
Gitweb:        https://git.kernel.org/tip/41b8edc60d7232d1f3e49165fb6de20f424c4385
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:51 +02:00

x86/xen: Mark xen_force_evtchn_callback() noinstr

vmlinux.o: warning: objtool: check_events()+0xd: call to xen_force_evtchn_callback() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.996055323@infradead.org
---
 arch/x86/include/asm/xen/hypercall.h | 2 +-
 arch/x86/xen/irq.c                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 990b8aa..4a7ff8b 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -358,7 +358,7 @@ HYPERVISOR_event_channel_op(int cmd, void *arg)
 	return _hypercall2(int, event_channel_op, cmd, arg);
 }
 
-static inline int
+static __always_inline int
 HYPERVISOR_xen_version(int cmd, void *arg)
 {
 	return _hypercall2(int, xen_version, cmd, arg);
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index f52b60d..2f695b5 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -19,7 +19,7 @@
  * callback mask. We do this in a very simple manner, by making a call
  * down into Xen. The pending flag will be checked by Xen on return.
  */
-void xen_force_evtchn_callback(void)
+noinstr void xen_force_evtchn_callback(void)
 {
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
