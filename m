Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2A2D2768
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Dec 2020 10:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgLHJWv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 8 Dec 2020 04:22:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgLHJWv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 8 Dec 2020 04:22:51 -0500
Date:   Tue, 08 Dec 2020 09:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607419329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbYmfTSHSURq22bkLjKpyea5MYZXwpbexckIwe5I0go=;
        b=vAVyuL3zAXwwmYa0KQsT6PQ/GRpmYc6JDcr0EizUntViUiU3n0FXA1BpRDwH8AvcKKf+Gd
        qYOgS3qyYkQkvSsv2Hz7od3GikYp8W6Q9y2nqvvgr7eX5Yjj81DUCFA8VZ4U7cIcit2yp4
        W/FzO8sxjfZXV7e6Z6U2XvpzQB5nub/+gLv6mkPJMkcbS64eY5zQJHns5wadd0HPFdymjS
        xr5JAFHAd74WyyagRswJx7qrSAblU4AXFc5BEGKdnyVNrYunCEGuZYuAKNx/uvvDjBhvnV
        VneisDzpcwcGpjnOIuAgRR5vSFB5HVgykpWDqp+2BNZNHK6qBItXeeJo+dRdhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607419329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbYmfTSHSURq22bkLjKpyea5MYZXwpbexckIwe5I0go=;
        b=69o0teH//x7DXdYknF7JT27SSasw6Qj5EBx4XrHAUgmvNNGG9t14GG1TmmxdaJpxnT1GYI
        0LQVw669KrmOw5Dw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Add a pointer to an URL which contains
 further details
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201205002825.19107-1-bp@alien8.de>
References: <20201205002825.19107-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160741932810.3364.658134697822426874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f77f420d34754b8d08ac6ebf094ff7193023196a
Gitweb:        https://git.kernel.org/tip/f77f420d34754b8d08ac6ebf094ff7193023196a
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 05 Dec 2020 01:19:45 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Dec 2020 10:17:08 +01:00

x86/msr: Add a pointer to an URL which contains further details

After having collected the majority of reports about MSRs being written
by userspace tools and what tools those are, and all newer reports
mostly repeating, add an URL where detailed information is gathered and
kept up-to-date.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201205002825.19107-1-bp@alien8.de
---
 arch/x86/kernel/msr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 95e6b97..8a67d1f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,8 +99,9 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d).\n",
 	        reg, current->comm, current->pid);
+	pr_warn("See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for details.\n");
 
 	return 0;
 }
