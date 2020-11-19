Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9022B8F5A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 10:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgKSJtj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:49:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKSJtj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:49:39 -0500
Date:   Thu, 19 Nov 2020 09:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27xDr3zZdW9uQ8O3xvgtep5LG+sM/yokBerwhbjXf10=;
        b=atXB+lmqjaQ2EtZzo7jescXWeT55bmTPn21h1FoVmQZlMEKyXKszr2pOJCRSMYsgl0z2qu
        DW6f7abKD07RfhEJtYk50FhP2pseRH3ulh0wlbQrP+FE3ilZd5kjaSfWoE9GX0evFni9QJ
        SHlEdC1Qpcl0SB7rsBDACztzDzR6ZH8TyKkQyn7vg9aY4uWcnuZB/s6Him7uKh5WAAupRq
        OCixj5uTC6KKCqH8K/Mbh6iTUIMY6CedNxQPfH8W5AZ3G4h+mIDEdqlfZNvErS/KmTrJbt
        pxsC6B83aCp7C6EKXsHJSs3bTX7QlSJQBwQFb9lFj8SNWviwg1T/2KBxMdteVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27xDr3zZdW9uQ8O3xvgtep5LG+sM/yokBerwhbjXf10=;
        b=M67+XUUHZHHVFNYvTG/P9UQFFVVAlsO6VxNVYPGsoWW+f0Y5ukqbDbPNPDCHXYJme6EDed
        uiov4AOKbWQzHvDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Downgrade unrecognized MSR message
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118123806.19672-1-bp@alien8.de>
References: <20201118123806.19672-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160577937591.11244.10105162163319299241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     b023fd5f741f34d2cd90258ccc3f245924d2eadd
Gitweb:        https://git.kernel.org/tip/b023fd5f741f34d2cd90258ccc3f245924d2eadd
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 18 Nov 2020 13:34:07 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 10:46:54 +01:00

x86/msr: Downgrade unrecognized MSR message

It is a warning and not an error so use pr_warn().

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201118123806.19672-1-bp@alien8.de
---
 arch/x86/kernel/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index b114786..95e6b97 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,8 +99,8 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
-	       reg, current->comm, current->pid);
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
+	        reg, current->comm, current->pid);
 
 	return 0;
 }
