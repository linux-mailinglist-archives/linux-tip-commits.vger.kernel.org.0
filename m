Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA662D72E3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437436AbgLKJf3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 04:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405659AbgLKJfV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 04:35:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB53C061793;
        Fri, 11 Dec 2020 01:34:40 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607679279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaUzluTxxLvVGhwIkMbwiHnQBiWKCHX2d0bKa1Tn+wg=;
        b=2Kb5/J1wB8zfz0642xGktwh8Xjw7+Gs5GWAr68xGRuV3Eh0SV7OC/YyScYftiRRvnyf5E0
        9GYK6pW5HjXOgLRPcrhcjLwoWgZo13+oDVaSl6wqMkyUM19aqKqQ6mejlIccfGBXQqPJh1
        Q8RII6SFQdtbGAfY+35LayE+zn3DAVWMgyhibl1HM+OyHLtD2yCaGwffIaSe6PPI+r0cat
        UI/O/y/8tCzupmSJ28YOFsj6gMpXP90j1zZzT4/oru1wBirtHzmbFVW6fVbMPBv6BEih0M
        3EOhupWYzmeMdfEGmBYaVphrDVtoswF9bVpC0W98DUZSthiFU+i/3aBOSbOwFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607679279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaUzluTxxLvVGhwIkMbwiHnQBiWKCHX2d0bKa1Tn+wg=;
        b=+su4KTryswcw1Q1r5EPbUsuYYxJBh10DFF1YlsuM2kex+DazU3ijlgoyq/nierhsqqFrS6
        eOHbZj6eRtsVipBQ==
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86: Print ratio freq_max/freq_base used in
 frequency invariance calculations
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112182614.10700-4-ggherdovich@suse.cz>
References: <20201112182614.10700-4-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <160767927852.3364.6128551434512082318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3149cd55302748df771dc1c8c10f34b1cbce88ed
Gitweb:        https://git.kernel.org/tip/3149cd55302748df771dc1c8c10f34b1cbce88ed
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Thu, 12 Nov 2020 19:26:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Dec 2020 10:30:23 +01:00

x86: Print ratio freq_max/freq_base used in frequency invariance calculations

The value freq_max/freq_base is a fundamental component of frequency
invariance calculations. It may come from a variety of sources such as MSRs
or ACPI data, tracking it down when troubleshooting a system could be
non-trivial. It is worth saving it in the kernel logs.

 # dmesg | grep 'Estimated ratio of average max'
 [   14.024036] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1289

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20201112182614.10700-4-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c5dd5f6..3577bb7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2110,6 +2110,7 @@ static void init_freq_invariance(bool secondary, bool cppc_ready)
 	if (ret) {
 		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
+		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
 	}
