Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5B27E0A9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgI3Fx6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3Fx6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:53:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E1C061755;
        Tue, 29 Sep 2020 22:53:57 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:53:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601445236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJiB2fm5x1gGbnFhUb8vMcHWNb8zswnIRVSN8p+W8Y8=;
        b=fnFFnCkyRfYMzZ8oYXe77ODzsmh0I/EqGl21V2K0N14ULGncEBCMuCSJGdeSpa7LyQbLkO
        gOVnb+uqKfdXPNJ40CT2bsEveLmLXYRYqeqxI8SRHDgHttJeE5xY+JAfki6wHF+vuQS19v
        mBzPbNyhVZg42imWzJNNoQZYjav78qEPTFB+UbnwhcpkHws1ntOsbGZMbzVFOxm8a8fbH3
        4SZ/HZMMVwafl8K8sb/ltQFXSvvjrXFx07COSO8jyuyOlspfxG7GU6byYc6iOYI+QIIYEl
        qHKV4ONrzlRhMF20s2/fXZ6h4VqWbDHPsKNG7lnvoyhQPu2fiY0NT4x3G0OI8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601445236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJiB2fm5x1gGbnFhUb8vMcHWNb8zswnIRVSN8p+W8Y8=;
        b=9pgamrm6+29OAdlb+d0SAh+kMtv05z3mDPNLffHS86zn3sSWgCM/K8bpddhzrKxJbuXHiU
        tL/lQlwDQmJB0nDA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Drop AMD-specific "DEFERRED" case from Intel
 severity rule list
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200930021313.31810-3-tony.luck@intel.com>
References: <20200930021313.31810-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160144523516.7002.14378369290028684589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     ed9705e4ad1c19ae51ed0cb4c112f9eb6dfc69fc
Gitweb:        https://git.kernel.org/tip/ed9705e4ad1c19ae51ed0cb4c112f9eb6dfc69fc
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 29 Sep 2020 19:13:13 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Sep 2020 07:49:58 +02:00

x86/mce: Drop AMD-specific "DEFERRED" case from Intel severity rule list

Way back in v3.19 Intel and AMD shared the same machine check severity
grading code. So it made sense to add a case for AMD DEFERRED errors in
commit

  e3480271f592 ("x86, mce, severity: Extend the the mce_severity mechanism to handle UCNA/DEFERRED error")

But later in v4.2 AMD switched to a separate grading function in
commit

  bf80bbd7dcf5 ("x86/mce: Add an AMD severities-grading function")

Belatedly drop the DEFERRED case from the Intel rule list.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200930021313.31810-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/severity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 567ce09..e072246 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -97,10 +97,6 @@ static struct severity {
 		EXCP, KERNEL_RECOV, MCGMASK(MCG_STATUS_RIPV, 0)
 		),
 	MCESEV(
-		DEFERRED, "Deferred error",
-		NOSER, MASK(MCI_STATUS_UC|MCI_STATUS_DEFERRED|MCI_STATUS_POISON, MCI_STATUS_DEFERRED)
-		),
-	MCESEV(
 		KEEP, "Corrected error",
 		NOSER, BITCLR(MCI_STATUS_UC)
 		),
