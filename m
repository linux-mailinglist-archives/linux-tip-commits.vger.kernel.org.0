Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753D9342C0B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Mar 2021 12:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCTLXI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 20 Mar 2021 07:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCTLXB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 20 Mar 2021 07:23:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C82C0613E7;
        Sat, 20 Mar 2021 04:23:01 -0700 (PDT)
Date:   Sat, 20 Mar 2021 11:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616239377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rg2r13TeEmFlMZ9mC4lVgssicyek8KfXCl/qsSqTApw=;
        b=zqXSmsi0Zp+MmlHHutRyVYjz15iSu7JSBTj+9PqiJrDZjdrSsTW3opogkZ94JwTGebbOXT
        LRSudbBrpx+NgdAvBwSkdlYPxcqvFwJNo2xM7907EPx1mLXt9GSgBpj2YziGnIL6z9KLh8
        wz93k1lNgmvPhz8q66iXpEYgpVP22F4cwt0D1iAVTDiexQ/9dyyjCmGH79inwHC44dLjnS
        7ftSGEGK/kAeBmqfJmsMvMHJCw39M/4D1gGNyDCpjKkvNMKNhafBEkRxWnXbbMMOaS6zIa
        i4a9H3HQ0SMDzzTjIVHJEkLTxKi8MNqLEwqmV32oyj50ngNlf1QQxoRRAKar6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616239377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rg2r13TeEmFlMZ9mC4lVgssicyek8KfXCl/qsSqTApw=;
        b=20q2nlMgoq2lE3ovP4zaVi6FVGgU7vYOJJ2TDgi+pFkkJLAaq32Y19Wk3fYbQa9k3HmeBz
        lecPjtNbW1yOYUBA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Add Xeon Sapphire Rapids to list of CPUs that
 support PPIN
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210319173919.291428-1-tony.luck@intel.com>
References: <20210319173919.291428-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <161623937626.398.13415015758248106593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a331f5fdd36dba1ffb0239a4dfaaf1df91ff1aab
Gitweb:        https://git.kernel.org/tip/a331f5fdd36dba1ffb0239a4dfaaf1df91ff1aab
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 19 Mar 2021 10:39:19 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 20 Mar 2021 12:12:10 +01:00

x86/mce: Add Xeon Sapphire Rapids to list of CPUs that support PPIN

New CPU model, same MSRs to control and read the inventory number.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210319173919.291428-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index e309476..acfd5d9 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -486,6 +486,7 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
 
