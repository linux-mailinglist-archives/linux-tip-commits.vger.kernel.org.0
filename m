Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B32B82E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgKRRS3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgKRRS1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:27 -0500
Date:   Wed, 18 Nov 2020 17:18:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrhub5TLKDVuSrb3jgw0/EUsNbV2HtdETd/SDRYhguo=;
        b=IHeanZvJJRg1ftgxhepganPfce87TKOmu5gQtgcITPZEwoyQtaAU5+51FGd2mRUAjdOB0B
        5MbvO7ZlXH2A2LwHUlb4qbSkwSMftEV7EzHx9Fs/jVRSodeYxu93CREKkCyTxW/JlToSeU
        eRSYKeC6kiaw7xo0NospKTB55eZEpMT27ytjDo0y6ZanVhiv4OtGQ8bl1IS/ZVBSvPcrdg
        ABDkFMZIudpPjIe4PwI1Vnin5in6uZIFbnhdceAhjHg356crXAX8VrLVsRVCwpWVOkxws2
        ZMwIg+GZf6+v+v4chLYs+Br0ZX63e4mHX66D5zt8/Ca/WqOLk0Msi8ej7s6f+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrhub5TLKDVuSrb3jgw0/EUsNbV2HtdETd/SDRYhguo=;
        b=BZZa6wCiZJWTE8/Oj6G98yeC6Ho7ukFMThkN7gjdZTV0NaYotx4cAkmeoTvVxCf1tnxaGj
        MdNweKXDJO5alEDQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/cpu/intel: Add a nosgx kernel parameter
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-9-jarkko@kernel.org>
References: <20201112220135.165028-9-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990588.11244.9096170663826227133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     38853a303982e3be3eccb1a1132399a5c5e2d806
Gitweb:        https://git.kernel.org/tip/38853a303982e3be3eccb1a1132399a5c5e2d806
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:19 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/cpu/intel: Add a nosgx kernel parameter

Add a kernel parameter to disable SGX kernel support and document it.

 [ bp: Massage. ]

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-9-jarkko@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/kernel/cpu/feat_ctl.c                  |  9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d..42d1528 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3368,6 +3368,8 @@
 
 	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
 
+	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index d38e973..3b1b01f 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -99,6 +99,15 @@ static void clear_sgx_caps(void)
 	setup_clear_cpu_cap(X86_FEATURE_SGX_LC);
 }
 
+static int __init nosgx(char *str)
+{
+	clear_sgx_caps();
+
+	return 0;
+}
+
+early_param("nosgx", nosgx);
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
 	bool tboot = tboot_enabled();
