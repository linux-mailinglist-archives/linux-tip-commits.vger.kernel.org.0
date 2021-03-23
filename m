Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B0346DCA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 00:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhCWXRC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhCWXQm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 19:16:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFAC061574;
        Tue, 23 Mar 2021 16:16:42 -0700 (PDT)
Date:   Tue, 23 Mar 2021 23:16:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616541393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROlGSJk/36JOBgfFFkCiAbFR713lsD8yowkd1H4tQJE=;
        b=s2OPYSMazcZSzP4bNJQlmkrJtuytwrbSNRDsaSbU5KijR/tuKvBD+lv8diW8dqAO45pvzL
        DMj7MPMT5wA+iXsBoJx58ePSDvo2bwfOGGMBhONDwbI2rvEMiGbodW0gLxef9VhNAPM8dO
        IqtZqj3NZWx5aTUJhgYtG7uI1SjXExaUu40NynQLj5SGSmtXIdgIn5NcqwDePBQD2bWMgQ
        Sl+Ebw8/1aBiI0Ijrcfp+qTzHJlYKXOp5CvJdhxz1bsWXCRjZCXCWFUB3QTeiy4qO2Zvu2
        RxXr1UXtda+zInrtv3j42ABLPHyZZXGSrnzML/D6PjKtqIWvEmCJZAPRkxaiPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616541393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROlGSJk/36JOBgfFFkCiAbFR713lsD8yowkd1H4tQJE=;
        b=KbyKDs0B9mbiUWsm10SWUfX7PtD1/MB2IYSS1ArNoMjaLceTWv4l0UFQxxcl5rya1Osqul
        f4qXP4LjV6em5/BA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Add IPID for injection too
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210314201806.12798-1-bp@alien8.de>
References: <20210314201806.12798-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161654139112.398.16619229725316596585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     2ffdc2c34421561c12f843e497dd7ce898478c0f
Gitweb:        https://git.kernel.org/tip/2ffdc2c34421561c12f843e497dd7ce898478c0f
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 13 Mar 2021 17:13:29 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 24 Mar 2021 00:04:45 +01:00

x86/mce/inject: Add IPID for injection too

Add an injection file in order to specify the IPID too when injecting
an error. One use case example is using the machinery to decode MCEs
collected from other machines.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210314201806.12798-1-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/inject.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 7b36073..4e86d97 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -74,6 +74,7 @@ MCE_INJECT_SET(status);
 MCE_INJECT_SET(misc);
 MCE_INJECT_SET(addr);
 MCE_INJECT_SET(synd);
+MCE_INJECT_SET(ipid);
 
 #define MCE_INJECT_GET(reg)						\
 static int inj_##reg##_get(void *data, u64 *val)			\
@@ -88,11 +89,13 @@ MCE_INJECT_GET(status);
 MCE_INJECT_GET(misc);
 MCE_INJECT_GET(addr);
 MCE_INJECT_GET(synd);
+MCE_INJECT_GET(ipid);
 
 DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
 static void setup_inj_struct(struct mce *m)
 {
@@ -629,6 +632,8 @@ static const char readme_msg[] =
 "\t    is present in hardware. \n"
 "\t  - \"th\": Trigger APIC interrupt for Threshold errors. Causes threshold \n"
 "\t    APIC interrupt handler to handle the error. \n"
+"\n"
+"ipid:\t IPID (AMD-specific)\n"
 "\n";
 
 static ssize_t
@@ -652,6 +657,7 @@ static struct dfs_node {
 	{ .name = "misc",	.fops = &misc_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "addr",	.fops = &addr_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "synd",	.fops = &synd_fops,   .perm = S_IRUSR | S_IWUSR },
+	{ .name = "ipid",	.fops = &ipid_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "bank",	.fops = &bank_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "flags",	.fops = &flags_fops,  .perm = S_IRUSR | S_IWUSR },
 	{ .name = "cpu",	.fops = &extcpu_fops, .perm = S_IRUSR | S_IWUSR },
