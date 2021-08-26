Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515A63F8347
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbhHZHqR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbhHZHqQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 03:46:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B7C0613C1;
        Thu, 26 Aug 2021 00:45:29 -0700 (PDT)
Date:   Thu, 26 Aug 2021 07:45:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629963927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSS5kClsZRsYiccPEtyP9nwREbAEDG556oTNCuOIhPU=;
        b=vKhOmIXLKnVd9vy0AGx70fA+LCYwg95R4Ck5L0eaQQ54Ztq8n1XfyTccfLnfLaE2dZxPmb
        sdMeWcAlVraLKC/ax2O7W2sub8f6CpyvXqwq99PCw0+pTDjt9jkaS8HFBNHPpGGWj+fi0K
        kksf5P1zA0MJFCet9BDOtFDacth/Bz0fM+fT40bm8IcnxiPlL8Ggym6f5BZBlgk03GBom2
        7r4aU/dlD0EcLpOeTceS7FUowfN/AiYpYJHDFdbkMoUKgBz3leUH38Q7vC7dIyYFC7AkVE
        9lGaH2LAaFexZz7WxYIhfuG8Cu3QR1PbwdMX1WkrYjEbfN+M6cC5RZ8ny3yvkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629963927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSS5kClsZRsYiccPEtyP9nwREbAEDG556oTNCuOIhPU=;
        b=ARpLU295UvbY/vGB2z/fw8YTmzU89zmJraY2V123MFfV7EGX8gEq/8AsdwoWHEaebIm30i
        fqExDHET8GUPLkAQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix integer overflow on 23
 bit left shift of a u32
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210706114553.28249-1-colin.king@canonical.com>
References: <20210706114553.28249-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <162996392716.25758.13184611014584247262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0b3a8738b76fe2087f7bc2bd59f4c78504c79180
Gitweb:        https://git.kernel.org/tip/0b3a8738b76fe2087f7bc2bd59f4c78504c79180
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Tue, 06 Jul 2021 12:45:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 08:58:02 +02:00

perf/x86/intel/uncore: Fix integer overflow on 23 bit left shift of a u32

The u32 variable pci_dword is being masked with 0x1fffffff and then left
shifted 23 places. The shift is a u32 operation,so a value of 0x200 or
more in pci_dword will overflow the u32 and only the bottow 32 bits
are assigned to addr. I don't believe this was the original intent.
Fix this by casting pci_dword to a resource_size_t to ensure no
overflow occurs.

Note that the mask and 12 bit left shift operation does not need this
because the mask SNR_IMC_MMIO_MEM0_MASK and shift is always a 32 bit
value.

Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Addresses-Coverity: ("Unintentional integer overflow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20210706114553.28249-1-colin.king@canonical.com
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 609c24a..c682b09 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4811,7 +4811,7 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 		return;
 
 	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
-	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
+	addr = ((resource_size_t)pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
 
 	pci_read_config_dword(pdev, mem_offset, &pci_dword);
 	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
