Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9330B2B6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBAWXd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 17:23:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBAWXc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 17:23:32 -0500
Date:   Mon, 01 Feb 2021 22:22:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612218169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwDkxqOqYq0cWGMA5VvEabZAGB6FOjJmi7JTzobQgTI=;
        b=Vu3/q3ZNCe2NDuk7Vo8aptUrOsNOwY6njYQ7R1v4w5+9MVy8GOFLYUzROmqIGXfcNcqm8R
        u0FI/s7L4d97US8adS80fK9/cpfYdD7U4d4QqepmVg6HsfPJvxEf0jS0x4xt4pH+ogZZFO
        6lHUM1XF2PDDhbEFfEs+WGG0mmSZnownDpq7i1uC4dlJ280mvS8f1WY89b13bWpCN00Sme
        shUzyyFoPPKSZCaiJ0JHRMFepHC9SlOhAoliIZLfr+S1pbUFtLbxV9Udn3TXJ2Sf3lNogO
        /JPqW3qLJnFEV44lcY31lc/aPnAq11NKLzQhMg6p1zOgZTvLk769T+jdni1Jnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612218169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwDkxqOqYq0cWGMA5VvEabZAGB6FOjJmi7JTzobQgTI=;
        b=cRNqYs06xukCASdZ+fUEuY+TH7LhDvbZxYNtzVwXLM5J24KHgU8FnR0bx3OvQqCLspvzv0
        DQyMdBW/7vjlMqCg==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/split_lock: Enable the split lock feature on
 another Alder Lake CPU
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210201190007.4031869-1-fenghua.yu@intel.com>
References: <20210201190007.4031869-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <161221816840.23325.8312246225432884053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8acf417805a5f5c69e9ff66f14cab022c2755161
Gitweb:        https://git.kernel.org/tip/8acf417805a5f5c69e9ff66f14cab022c2755161
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 01 Feb 2021 19:00:07 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 01 Feb 2021 21:34:51 +01:00

x86/split_lock: Enable the split lock feature on another Alder Lake CPU

Add Alder Lake mobile processor to CPU list to enumerate and enable the
split lock feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210201190007.4031869-1-fenghua.yu@intel.com
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 59a1e3c..816fdbe 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1159,6 +1159,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
 	{}
 };
 
