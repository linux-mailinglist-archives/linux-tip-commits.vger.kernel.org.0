Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB63D77A2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhG0N67 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:58:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbhG0N64 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:56 -0400
Date:   Tue, 27 Jul 2021 13:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhywEA2d2mjBpb3j+rb+RQgkPBW26w/xgVV6kvrWA7c=;
        b=q6ZCv/l9yj6ury/RtHtXQSXi7S1r4Yl67RszFYayve40+wfJoQsXCHH0vcLm2ciLIits2W
        XxsJvKyDoTb4xJf5QEF4M/JmUMUDk5/nKn6VwarL1HEBpu8oZtMYKy4x7ETYEyt8ZgqnNp
        sE+yo+wUrMliuCxZ4OMdplnL70Vwj0mNt6aQWZeIizw9DkQUfe8PqEJ2BiQjgp4Oi/FkLm
        LlQPfLC/V3VBzPpI8AXD2IC1Uu8WZ38ae6K/toh8C6ELZS9YP8Kvtdb/ZEEXYiATVQcQiv
        0p6puucNmUSl1Q6zpGkXkmvA9m4R4xyS7impCMp1V6XTUXR5hLXUSrIOANCMkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhywEA2d2mjBpb3j+rb+RQgkPBW26w/xgVV6kvrWA7c=;
        b=q/w5lJkcKYk5NaN4uRpzn6sdC1AuMiIGgCHyyKeqQ7l6+kicnFjJd4hGKtQLZUer1rykTu
        NUMOpWDyBnVLQIBQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix integer overflow on 23
 bit left shift of a u32
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210706114553.28249-1-colin.king@canonical.com>
References: <20210706114553.28249-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <162739433456.395.16686146185253041437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     92279a3b11a0a8486ce6b92384ddc0849eb4060f
Gitweb:        https://git.kernel.org/tip/92279a3b11a0a8486ce6b92384ddc0849eb4060f
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Tue, 06 Jul 2021 12:45:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:48 +02:00

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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20210706114553.28249-1-colin.king@canonical.com
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index f665b16..9a178a9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4834,7 +4834,7 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
 		return -ENODEV;
 
 	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
-	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
+	addr = ((resource_size_t)pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
 
 	pci_read_config_dword(pdev, mem_offset, &pci_dword);
 	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
