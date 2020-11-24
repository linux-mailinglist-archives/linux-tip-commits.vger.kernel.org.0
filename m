Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5D2C26B3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbgKXNCM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 08:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbgKXNCL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 08:02:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F47C0613D6;
        Tue, 24 Nov 2020 05:02:11 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606222929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8VN/kfRh36+3NAFfuKkaFebip0ORxdCzqxj6gJfY3E=;
        b=f8zLvINOg3VsJ/pyu7Es8sSgeuQ1dct/KX7reEoEtfGd2n3lAqyY2OlLqIKH3nZK+yGyvW
        x4A6Q+urCOOfgmb/9dFOaGl1QcUPnvAw2zD8lfiSZQxuDzZF5wO+oCrTsnGIpgZHBcLGb2
        Q/QXCsIwYXC2WO7urWnMdutzCGAa2odG5r4fyb2GqWoziwIbTERNOfmNIKKF7j6BIS7t0l
        DuqZO0ufqZfGjU864xK3/okCRExZPXTgaMduZ7SaydumWi4h9iDfHSTGYtfeAcTZ1TPyVK
        26s3nxlmhxHHWlbqZVdZ1v02JYAAVxmSRet4wz/y0o2Ezujymhopsy2MyuZ53A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606222929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8VN/kfRh36+3NAFfuKkaFebip0ORxdCzqxj6gJfY3E=;
        b=M5AR2TSLXWy50Eg1ukuwgZvmS5NxhuP3gWGGKn//vd5bpuQVgMsgqdZdbmL5z/ODHe0mse
        5ZKy8smUhS8iivDA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] selftests/x86/fsgsbase: Fix GS == 1, 2, and 3 tests
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7567fd44a1d60a9424f25b19a998f12149993b0d.1604346596.git.luto@kernel.org>
References: <7567fd44a1d60a9424f25b19a998f12149993b0d.1604346596.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <160622292883.11115.1532167880287226599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     716572b0003ef67a4889bd7d85baf5099c5a0248
Gitweb:        https://git.kernel.org/tip/716572b0003ef67a4889bd7d85baf5099c5a0248
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Mon, 02 Nov 2020 11:51:10 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Nov 2020 13:46:16 +01:00

selftests/x86/fsgsbase: Fix GS == 1, 2, and 3 tests

Setting GS to 1, 2, or 3 causes a nonsensical part of the IRET microcode
to change GS back to zero on a return from kernel mode to user mode. The
result is that these tests fail randomly depending on when interrupts
happen. Detect when this happens and let the test pass.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/7567fd44a1d60a9424f25b19a998f12149993b0d.1604346596.git.luto@kernel.org
---
 tools/testing/selftests/x86/fsgsbase.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 7161cfc..8c780cc 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -392,8 +392,8 @@ static void set_gs_and_switch_to(unsigned long local,
 		local = read_base(GS);
 
 		/*
-		 * Signal delivery seems to mess up weird selectors.  Put it
-		 * back.
+		 * Signal delivery is quite likely to change a selector
+		 * of 1, 2, or 3 back to 0 due to IRET being defective.
 		 */
 		asm volatile ("mov %0, %%gs" : : "rm" (force_sel));
 	} else {
@@ -411,6 +411,14 @@ static void set_gs_and_switch_to(unsigned long local,
 	if (base == local && sel_pre_sched == sel_post_sched) {
 		printf("[OK]\tGS/BASE remained 0x%hx/0x%lx\n",
 		       sel_pre_sched, local);
+	} else if (base == local && sel_pre_sched >= 1 && sel_pre_sched <= 3 &&
+		   sel_post_sched == 0) {
+		/*
+		 * IRET is misdesigned and will squash selectors 1, 2, or 3
+		 * to zero.  Don't fail the test just because this happened.
+		 */
+		printf("[OK]\tGS/BASE changed from 0x%hx/0x%lx to 0x%hx/0x%lx because IRET is defective\n",
+		       sel_pre_sched, local, sel_post_sched, base);
 	} else {
 		nerrs++;
 		printf("[FAIL]\tGS/BASE changed from 0x%hx/0x%lx to 0x%hx/0x%lx\n",
