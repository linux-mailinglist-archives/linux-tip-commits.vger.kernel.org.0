Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7593A40FFD4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbhIQT2o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIQT2o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 15:28:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E1C061574;
        Fri, 17 Sep 2021 12:27:22 -0700 (PDT)
Date:   Fri, 17 Sep 2021 19:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631906840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=me2BWA/5YAvTVoJFvL2wGRYy0dapHMyHIG3V9ptKeQM=;
        b=hRQ7GibP4Jm/ZRBUTlbSn7UUGAgfXz0IUTEFyWuPKeWJlHpzFW8xmM7/vFgwR18wkdLi9+
        NWJw9dvhHa15jrPfpmZ6y7hgRNFXi2SzfZvWsfijeT7P3+Dewfz4m3zAG9Ev20UQHb9CSL
        QdMXB9fNRLr+Q6XrTwuAgHQwKoCLwwELtie1p8mgaXh60f2R/dr4fmafj/RJ7SA/qReN8i
        CnO4Ai5WA/8feAyqkwnvXnXFkz1Jf2MY+LA2Jg3cCoe6qCW3Cs33AaKZbZFsbQ0IvAhq2R
        bxl6Ms3WxdBGUymyJJ1eLK6rBGNOGoKZ99FIH3bmvLQXigBDWebWjZVSlup/0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631906840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=me2BWA/5YAvTVoJFvL2wGRYy0dapHMyHIG3V9ptKeQM=;
        b=Ik1ST8zMwY6+lsKAn4W39Kmwm0Y0s9dsW6R6w9Ka0U3RkaYhOoBRXMhYdoceLN3Nv6/YdA
        zC/T2EDqXhW8dODQ==
From:   "tip-bot2 for Tim Gardner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/smp: Remove unnecessary assignment to local
 var freq_scale
Cc:     Tim Gardner <tim.gardner@canonical.com>,
        Borislav Petkov <bp@suse.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210910184405.24422-1-tim.gardner@canonical.com>
References: <20210910184405.24422-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Message-ID: <163190683957.25758.3367474272186551096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     85784470efa2d5733e86679ba05d310ece81b20f
Gitweb:        https://git.kernel.org/tip/85784470efa2d5733e86679ba05d310ece81b20f
Author:        Tim Gardner <tim.gardner@canonical.com>
AuthorDate:    Fri, 10 Sep 2021 12:44:05 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 17 Sep 2021 21:20:34 +02:00

x86/smp: Remove unnecessary assignment to local var freq_scale

Coverity warns of an unused value in arch_scale_freq_tick():

  CID 100778 (#1 of 1): Unused value (UNUSED_VALUE)
  assigned_value: Assigning value 1024ULL to freq_scale here, but that stored
  value is overwritten before it can be used.

It was introduced by commit:

  e2b0d619b400a ("x86, sched: check for counters overflow in frequency invariant accounting")

Remove the variable initializer.

Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Link: https://lkml.kernel.org/r/20210910184405.24422-1-tim.gardner@canonical.com
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e24..c453b82 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2166,7 +2166,7 @@ DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void arch_scale_freq_tick(void)
 {
-	u64 freq_scale = SCHED_CAPACITY_SCALE;
+	u64 freq_scale;
 	u64 aperf, mperf;
 	u64 acnt, mcnt;
 
