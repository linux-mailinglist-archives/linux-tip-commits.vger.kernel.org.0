Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2542CAA7D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 19:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgLASGh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 13:06:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgLASGh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 13:06:37 -0500
Date:   Tue, 01 Dec 2020 18:05:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606845954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huFZ19MEgCoEjChf6oqqE5iRSukWTFaMP4x+vz6ezEU=;
        b=H1b8Vq0H/pNSEoL8Bc9RpWSUM7YicK5iDMId1Ue0E3gHwBD7CuuFr95ns3z4DtpgG6iPZC
        4J0yiNqeUSfD3YlIEFdS9NH6PNuvhbsqgGf5jd+MuIa9GUnAv/fB+787gOEypKs+KofI5e
        t7P91eRSM7xW5XmN76s4F8vGv/QyU9gc1HeQWxVH/yZa7XcpVpXNSEOd/QtcI9NzvgUHRx
        B7UVd/vSDPhNQE+aG2hfMWnIzRHXkyBvKwIrNdC6kzgDv4pmHqsRuUGjVFWbXy8r92/ZLb
        3E3cDxW/t7vEvrxMevQxkqZQKPuYrCjFPVvYlPTB5MD3OSmnbYH/+Llm6dZMzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606845954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huFZ19MEgCoEjChf6oqqE5iRSukWTFaMP4x+vz6ezEU=;
        b=eh5kjdyh0i6Hfc/ud9vKSgU1tm7YYKbHU7r7jY3GhwhnKG8LB5JKAQdrPeiXjsfitxBf7M
        L1It0BuHvp9BnYAQ==
From:   "tip-bot2 for Gabriele Paoloni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove redundant call to irq_work_queue()
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201127161819.3106432-5-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-5-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Message-ID: <160684595404.3364.4509615068323236541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d5b38e3d0fdb1a16994b449bc338fb8b26816b07
Gitweb:        https://git.kernel.org/tip/d5b38e3d0fdb1a16994b449bc338fb8b26816b07
Author:        Gabriele Paoloni <gabriele.paoloni@intel.com>
AuthorDate:    Fri, 27 Nov 2020 16:18:18 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 18:54:32 +01:00

x86/mce: Remove redundant call to irq_work_queue()

Currently, __mc_scan_banks() in do_machine_check() does the following
callchain:

  __mc_scan_banks()->mce_log()->irq_work_queue(&mce_irq_work).

Hence, the call to irq_work_queue() below after __mc_scan_banks()
seems redundant. Just remove it.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20201127161819.3106432-5-gabriele.paoloni@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 99da2e0..a9991a9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1406,9 +1406,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	if (worst > 0)
-		irq_work_queue(&mce_irq_work);
-
 	if (worst != MCE_AR_SEVERITY && !kill_it)
 		goto out;
 
