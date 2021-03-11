Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B8336E76
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Mar 2021 10:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhCKJJB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Mar 2021 04:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCKJI5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Mar 2021 04:08:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACCC061574;
        Thu, 11 Mar 2021 01:08:56 -0800 (PST)
Date:   Thu, 11 Mar 2021 09:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615453729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kq9Vd6dVRi8UdZfNdOm0b+aTVgLJN6XPgExV0td+gs=;
        b=NBn4YnQnXUtc3jRv7deMsc/76Ofuytz26DDM7yFEEmp9bfmYynMY/5Lr0H0THGd3Xvdkiw
        pU3xkoUQJDDR/NvCn7YdUaoTilAsYE3iew7sY2J0KyHZ4wj6jA6zkXh2gu5dvgRtwjxQhB
        YTeVohLWNsU2idR228ErCoJ2/1GQRf+odx0OV4a6juxwG2k5QxCm+cYOyIMPS2cxx3Vdxt
        yFPLiNzcx1zoK27QbjlVVO7W5lR742y3imgwGzYmVVR+DtNGZa692LWIFSujOZKtOuQiwJ
        8QZZeuH1YpWZih9BSk6QjjHUDWNlqiO21/jxUmpenvtRpJdomZBdPWhdslK6KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615453729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kq9Vd6dVRi8UdZfNdOm0b+aTVgLJN6XPgExV0td+gs=;
        b=fgnNE6AjHG/IjjxN1Ry6/28p89O/O9dqJa9aT51rDXjhGZwDdw2usGvSxWSZkuQfu1w1Ek
        CcgsjIKgOnApZsDw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/perf: Use RET0 as default for guest_get_msrs
 to handle "no PMU" case
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210309171019.1125243-1-seanjc@google.com>
References: <20210309171019.1125243-1-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <161545372825.398.16630924831930486998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c8e2fe13d1d1f3a02842b7b909d4e4846a4b6a2c
Gitweb:        https://git.kernel.org/tip/c8e2fe13d1d1f3a02842b7b909d4e4846a4b6a2c
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 09 Mar 2021 09:10:19 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Mar 2021 16:45:09 +01:00

x86/perf: Use RET0 as default for guest_get_msrs to handle "no PMU" case

Initialize x86_pmu.guest_get_msrs to return 0/NULL to handle the "nop"
case.  Patching in perf_guest_get_msrs_nop() during setup does not work
if there is no PMU, as setup bails before updating the static calls,
leaving x86_pmu.guest_get_msrs NULL and thus a complete nop.  Ultimately,
this causes VMX abort on VM-Exit due to KVM putting random garbage from
the stack into the MSR load list.

Add a comment in KVM to note that nr_msrs is valid if and only if the
return value is non-NULL.

Fixes: abd562df94d1 ("x86/perf: Use static_call for x86_pmu.guest_get_msrs")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210309171019.1125243-1-seanjc@google.com
---
 arch/x86/events/core.c | 15 ++++++---------
 arch/x86/kvm/vmx/vmx.c |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6ddeed3..18df171 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -81,7 +81,11 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_guest_get_msrs,  *x86_pmu.guest_get_msrs);
+/*
+ * This one is magic, it will get called even when PMU init fails (because
+ * there is no PMU), in which case it should simply return NULL.
+ */
+DEFINE_STATIC_CALL_RET0(x86_pmu_guest_get_msrs, *x86_pmu.guest_get_msrs);
 
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -1944,13 +1948,6 @@ static void _x86_pmu_read(struct perf_event *event)
 	x86_perf_event_update(event);
 }
 
-static inline struct perf_guest_switch_msr *
-perf_guest_get_msrs_nop(int *nr)
-{
-	*nr = 0;
-	return NULL;
-}
-
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2025,7 +2022,7 @@ static int __init init_hw_perf_events(void)
 		x86_pmu.read = _x86_pmu_read;
 
 	if (!x86_pmu.guest_get_msrs)
-		x86_pmu.guest_get_msrs = perf_guest_get_msrs_nop;
+		x86_pmu.guest_get_msrs = (void *)&__static_call_return0;
 
 	x86_pmu_static_call_update();
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 50810d4..32cf828 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6580,8 +6580,8 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 	int i, nr_msrs;
 	struct perf_guest_switch_msr *msrs;
 
+	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
 	msrs = perf_guest_get_msrs(&nr_msrs);
-
 	if (!msrs)
 		return;
 
