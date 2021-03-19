Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB643417D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 09:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCSI5i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 04:57:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35460 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhCSI5d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 04:57:33 -0400
Date:   Fri, 19 Mar 2021 08:57:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616144252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fAS4vxdT0qW0DzsRucTlbOn3gQoSqPCoumLuZg2W7M=;
        b=kkpdPVB0zdV2TJh5geOfrb/1Q6Ao35F/lc0Ic/VcdXOBiTOQMnKW+TtKmNNXiUSty8kp7H
        zUcCxRWUmuxKRQsTju77+jrNdkqiK6htmCq9fJAJBoNTHojJoLX5GW05zfhIF/K8vCwUEF
        r0PMU5T9IM0lDNaw1fjsDGSe014W2efE4L+yidAjBkXOP4sXsxcs63rKLoiStOnqi/f9i5
        NQSGbCx9YmlOTcTYF0oFGeU83adUQTVEOs9bQDxyo9ggNlctZX25iRU9OmTOF4/tTANkjJ
        BP0vgNav9q8WfqR9Uzmxda+J6NIoXH2tSQDtrLWC3wozIdgzMFukQhWHabZdxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616144252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fAS4vxdT0qW0DzsRucTlbOn3gQoSqPCoumLuZg2W7M=;
        b=PmjrRpcuK2UWPVaADNBc5WHKieukp9OUiDR2fj/m1xznHSdn5C0se5O3w1V0O0bgq9TgLN
        1aXYXssEyh4PVMAA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix uninitialized 'nid' variable
Cc:     kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318214933.29341-1-dave.hansen@intel.com>
References: <20210318214933.29341-1-dave.hansen@intel.com>
MIME-Version: 1.0
Message-ID: <161614425117.398.12898724326370108722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     262e88b63f55e3d2bacdf629874a0af486775572
Gitweb:        https://git.kernel.org/tip/262e88b63f55e3d2bacdf629874a0af486775572
Author:        Dave Hansen <dave.hansen@intel.com>
AuthorDate:    Thu, 18 Mar 2021 14:49:33 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 19 Mar 2021 09:51:55 +01:00

x86/sgx: Fix uninitialized 'nid' variable

The NUMA fallback in __sgx_alloc_epc_page() recently grew an
additional 'nid' variable to prevent extra trips through the
fallback loop in case where the thread is migrated around.

But, the new copy is not properly initialized.  Fix it.

This was found by some fancy clang that 0day runs.  My gcc
does not detect it.

Fixes: 5b8719504e3a ("x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20210318214933.29341-1-dave.hansen@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 5c9c5e5..13a7599 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -489,7 +489,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
 	struct sgx_epc_page *page;
 	int nid_of_current = numa_node_id();
-	int nid;
+	int nid = nid_of_current;
 
 	if (node_isset(nid_of_current, sgx_numa_mask)) {
 		page = __sgx_alloc_epc_page_from_node(nid_of_current);
