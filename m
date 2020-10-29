Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886EC29E9A1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgJ2Kvm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgJ2Kvl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9EC0613CF;
        Thu, 29 Oct 2020 03:51:41 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUo9vUxJALWoRbeGWl9eG8dvMrTMEjVqiCq4f6+uwQA=;
        b=rwQmXGUAlBbJkzM/CLWhi5WGFjF67Y1Fb+/3JaItZ0oQnEG2fCgJWr8mBfLaxjRnQiB7xo
        FSO+mwWIrdHW8pVAceC3nZnpwxuGY/UpuOjbAkSBQmTlGKEwXKJsgTUgdQpC0J5ys9N4w2
        tE2/szlpHvTQ1v9DuDgCrqZ/7Znecb3lcbVXE1uo+U1X1hjcvl1nQM+PFXCbBxFGcR3B54
        8V5+JbzzlmL8RLK88thSpCpGOl61teV4G99QkB+pPdr0vlfosvSn9hyx5qBt+QATp9tRGw
        /Gge9Pa9vVaNgkhQgCo60KaBZt3IsbL14AzbMDyQIXfDK9XnsbCTSjVjgYyRJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUo9vUxJALWoRbeGWl9eG8dvMrTMEjVqiCq4f6+uwQA=;
        b=TpQj9EBT1uKqz03IBQFZKYfB39COGdEBjzympdQbBS8uMeg98VG7UeWR6vnmiAfKi9zadX
        J+9v28KLBDAIcVCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add Rocket Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201019153528.13850-3-kan.liang@linux.intel.com>
References: <20201019153528.13850-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396869901.397.12647985959685130395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     907a196fbc70a48338ee8512da32f70fd33c97eb
Gitweb:        https://git.kernel.org/tip/907a196fbc70a48338ee8512da32f70fd33c97eb
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 19 Oct 2020 08:35:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:40 +01:00

perf/x86/msr: Add Rocket Lake CPU support

Like Ice Lake and Tiger Lake, PPERF and SMI_COUNT MSRs are also
supported by Rocket Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201019153528.13850-3-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 4be8f9c..680404c 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -99,6 +99,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
+	case INTEL_FAM6_ROCKETLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
