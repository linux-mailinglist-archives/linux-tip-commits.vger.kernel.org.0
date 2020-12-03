Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256492CD243
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbgLCJOP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgLCJOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:14:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86517C061A4D;
        Thu,  3 Dec 2020 01:13:22 -0800 (PST)
Date:   Thu, 03 Dec 2020 09:13:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0ROyCIqqYbPXixaIjK+PBx0FyRM8sa8WhcGP5yS1Vg=;
        b=3uI/s73boVpf9TDPkWLLTO27x9mjR8+xRi+eHcxt2+4XCGukoeoCdwyYsQlvzBnKn9bdUE
        6RmeDFsiYOIz4cSQNLY75M77aS7L9+pjKieqiDOM+Sa8Qc0m4NouqOamhT30RoWOoEOeGP
        +Ar7dvX8cOw4cUX7j1db1s+Q7lKKG7G8l+kBF5egH0h4EvhoY3vw7aD+5JkXnc6QJ1lGKx
        YxxPOQAHKn+ZcM2BTggOXzlliUo03HkcJfl9Hsi+4B2N0FnmKXDiRZIGg6xTIh740lMHxw
        037O7OycN7XwEMvmB0mRVXmR51+p5Rkj8VZbFqg9jZFcLdmNiJoAc+zN0MCgxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0ROyCIqqYbPXixaIjK+PBx0FyRM8sa8WhcGP5yS1Vg=;
        b=oXNJVuIXo04bsbxYMEidWSsXRJ7BHwpxlfcC+09IcyGg5NAy8SUjiCYXvi/cXip+R9qEkd
        RhZ+bS3WY30TEBDA==
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86: Print ratio freq_max/freq_base used in
 frequency invariance calculations
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112182614.10700-4-ggherdovich@suse.cz>
References: <20201112182614.10700-4-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <160698680049.3364.3119999970508477644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     24f326686c925a848d603a2c22f1f6ed1b7786e2
Gitweb:        https://git.kernel.org/tip/24f326686c925a848d603a2c22f1f6ed1b7786e2
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Thu, 12 Nov 2020 19:26:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:35 +01:00

x86: Print ratio freq_max/freq_base used in frequency invariance calculations

The value freq_max/freq_base is a fundamental component of frequency
invariance calculations. It may come from a variety of sources such as MSRs
or ACPI data, tracking it down when troubleshooting a system could be
non-trivial. It is worth saving it in the kernel logs.

 # dmesg | grep 'Estimated ratio of average max'
 [   14.024036] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1289

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
