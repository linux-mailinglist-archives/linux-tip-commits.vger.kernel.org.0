Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5B30D81F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Feb 2021 12:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhBCLHH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Feb 2021 06:07:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhBCLHG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Feb 2021 06:07:06 -0500
Date:   Wed, 03 Feb 2021 11:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612350384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdPGkYJTZTbVxZ9DKMjF1sG7BkpdM3iM4N+HvJFd28o=;
        b=RboukP3PMrDi4HJeCIBBe3zd05XGjH4jgRyM4L3u71K4zxl+RkGe4isx6kRHwnG+BJUVF9
        T0WgzexQIDMUFspMFjYOXNnSbnI30au/Q3t7PRKUQxW4Ogy2FmD/is/e1momF+eo2Ug88j
        at1fkzvYjbY4A5qoVqk0ZkPiBKBjYtBQiTTx8CFBCmB32MlLLvUkEX5BJSaGVT1xN90PXy
        qXVHPfCgOUeTJMKfX+GUT75gP38X7HGk1NbPzBWyO+2qFp3Bb7pnekjVg1IZKON0qSjZYi
        nV8keTLBTDLm1iPDA37q2DoYfP1R68rdHX77mIxPHL1V5sRqOI+rKEGeKPRt1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612350384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdPGkYJTZTbVxZ9DKMjF1sG7BkpdM3iM4N+HvJFd28o=;
        b=L0Vi8RrFEUNmez4XhNFCJYvERGunF5X+jAo+xAcEnfXAZOPRxvrwfopsulyO2dTISzy9lR
        T+NbUrcMGdnfZmCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] tools/power/turbostat: Fallback to an MSR read for EPB
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210127132444.981120-1-dedekind1@gmail.com>
References: <20210127132444.981120-1-dedekind1@gmail.com>
MIME-Version: 1.0
Message-ID: <161235038377.23325.12734433059631581902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7f1b11ba3564a391169420d98162987a12d0795d
Gitweb:        https://git.kernel.org/tip/7f1b11ba3564a391169420d98162987a12d0795d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 28 Jan 2021 20:28:56 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 03 Feb 2021 11:58:19 +01:00

tools/power/turbostat: Fallback to an MSR read for EPB

Commit

  6d6501d912a9 ("tools/power/turbostat: Read energy_perf_bias from sysfs")

converted turbostat to read the energy_perf_bias value from sysfs.
However, older kernels which do not have that file yet, would fail. For
those, fall back to the MSR reading.

Fixes: 6d6501d912a9 ("tools/power/turbostat: Read energy_perf_bias from sysfs")
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Link: https://lkml.kernel.org/r/20210127132444.981120-1-dedekind1@gmail.com
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea52..a7c4f07 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1834,12 +1834,15 @@ int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 int get_epb(int cpu)
 {
 	char path[128 + PATH_BYTES];
+	unsigned long long msr;
 	int ret, epb = -1;
 	FILE *fp;
 
 	sprintf(path, "/sys/devices/system/cpu/cpu%d/power/energy_perf_bias", cpu);
 
-	fp = fopen_or_die(path, "r");
+	fp = fopen(path, "r");
+	if (!fp)
+		goto msr_fallback;
 
 	ret = fscanf(fp, "%d", &epb);
 	if (ret != 1)
@@ -1848,6 +1851,11 @@ int get_epb(int cpu)
 	fclose(fp);
 
 	return epb;
+
+msr_fallback:
+	get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
+
+	return msr & 0xf;
 }
 
 void get_apic_id(struct thread_data *t)
