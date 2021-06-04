Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540C239BB6A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jun 2021 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFDPIg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Jun 2021 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDPIf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Jun 2021 11:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE17C061766;
        Fri,  4 Jun 2021 08:06:49 -0700 (PDT)
Date:   Fri, 04 Jun 2021 15:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622819205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSjfyQAy4svVzeRM/BwRbOMMXLsTCDjfjNSqQwvpIgE=;
        b=rzLBNxmU3ev63H0jHvVfdvSQiNXvsKaScsct3vB5IumTpK79NzbiGa4j1Wc/+nGRF13wy/
        oV5jEmrLSuTwbjh3aeWM0Oqencf54IsCLAvXmwqIcF+HqGMe8ykSojp/aqMHmV0azmA6T1
        /4L8OUIRZCPnJDj1bKPO1H9cTDQCoj6yN01LdbKV2eFj803GrqXYvCvGihlF3NwFlnqxHl
        U1eSnDfy4wj/ydW1g2OVs2zevz6m9Ww5FeP0YaVhLzpKoEdpQyZmK/l3FCewa4uooicZ3n
        qgtH9erpAq4/h3OU9t4u/QpKM4r+f7e+49Lyg2FU4CXC65mG1PvrX/Ur8wTrNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622819205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSjfyQAy4svVzeRM/BwRbOMMXLsTCDjfjNSqQwvpIgE=;
        b=HOZj4WcOLpkl4iFk7Q2XjzZmaInni8fZLY/aWCzxfsJmitl63Q743Oi9WVkNKmjwie6lsE
        UMGiBoGyUQZ+GsBw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/pkeys: Skip 'init_pkru' debugfs file creation when
 pkeys not supported
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210603230810.113FF3F2@viggo.jf.intel.com>
References: <20210603230810.113FF3F2@viggo.jf.intel.com>
MIME-Version: 1.0
Message-ID: <162281920427.29796.9638166561480513633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     314a1e1eabea5b86532e90e0d4e217fa88471e3b
Gitweb:        https://git.kernel.org/tip/314a1e1eabea5b86532e90e0d4e217fa88471e3b
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Thu, 03 Jun 2021 16:08:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 04 Jun 2021 17:01:03 +02:00

x86/pkeys: Skip 'init_pkru' debugfs file creation when pkeys not supported

The PKRU hardware is permissive by default: all reads and writes are
allowed.  The in-kernel policy is restrictive by default: deny all
unnecessary access until explicitly requested.

That policy can be modified with a debugfs file: "x86/init_pkru".
This file is created unconditionally, regardless of PKRU support in
the hardware, which is a little silly.

Avoid creating the file when pkeys are not available.  This also
removes the need to check for pkey support at runtime, which would be
required once the new pkey modification infrastructure is put in place
later in this series.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210603230810.113FF3F2@viggo.jf.intel.com
---
 arch/x86/mm/pkeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a2332ee..4a67b92 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -192,6 +192,10 @@ static const struct file_operations fops_init_pkru = {
 
 static int __init create_init_pkru_value(void)
 {
+	/* Do not expose the file if pkeys are not supported. */
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return 0;
+
 	debugfs_create_file("init_pkru", S_IRUSR | S_IWUSR,
 			arch_debugfs_dir, NULL, &fops_init_pkru);
 	return 0;
