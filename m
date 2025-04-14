Return-Path: <linux-tip-commits+bounces-4973-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33447A879FD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 10:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770E218914C3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605E25C70F;
	Mon, 14 Apr 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyVcqZ9t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Fk0DfYI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD925B670;
	Mon, 14 Apr 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618518; cv=none; b=fnaflh0YL74/QXFEsic/dElKu1BiJccS+dWaZH2Q2w28/Ebh7gqaejh4jthWH1LLGy0ikjJvujytC6Jp0LHqaAcRPS87qyoVMZ9V+vu8daM80takbHYX7lkN4PfSg/H7DdCYJfF4dt0Yn9j3gq3FPw8f8dt9YP2E1y7p7EVRPYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618518; c=relaxed/simple;
	bh=hw2TIGbufc6i1LQqNqpDpw838rNBe6MzrwdpvViCW7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tiyWiL79GRkgu/TeKjpjnMl0eDqgIbTrgCaTdkwUnGiAqv/NC5KiGdQsOgrv8DgaYQIYNSCi7m7v00+8WR7LauMgpFYlAhceSollWVKOTcQwbO4G8FWkbiNhkrvq/0HOFe3Kv70mjeXDudgIRnyzH9YzLZV3KBtZRxqxlH5O1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyVcqZ9t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Fk0DfYI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 08:15:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744618515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8zHV09KkzrZ+TAluezG8pf8VAfFswvZ1to5HSz9D3w=;
	b=UyVcqZ9tCU/DtqcxOY7M1REW4piC76+MrFQma+7XPpQYGSwakhbIa35WOWU3NYriCSBMRc
	1BPExMcR1kfFnKnka9VwRRCT6yZG7iELsMZyn/LmSAdy0YrDQWEYDHO2YE53p1fJvTxXj+
	xNoJHL+G/C1WBv+n1WknrLejgDU5GtuJTeSjVtIP6dlXiSNQvuZXpSVzkHtIjT9u+jgjGS
	yK9ecF0+6xBc2FYO8UfxLe2ekRWr2TaCcZ/Qu05dOILEElCMnQrqmVDWdXIAvTklqvIsTy
	FugfjKxb+YmXQTEfYClHHl2G5q4+e4HQIogSkn9d3vUWjzXkywozYgUhnaC0LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744618515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8zHV09KkzrZ+TAluezG8pf8VAfFswvZ1to5HSz9D3w=;
	b=6Fk0DfYI2eK76ibvhjvotkKHwtx7lj2ySP6or7Z+c4PuEPFzd/OcyhFA6OC++Xf20FQdgV
	mFTY0/5pizjNF0Aw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/platform/amd: Add standard header guards to
 <asm/amd/ibs.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mario Limonciello <superm1@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413084144.3746608-3-mingo@kernel.org>
References: <20250413084144.3746608-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461851464.31282.5811075467823156003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     861c6b1185fbb2e3fa158aa3aca75d2f767db2a8
Gitweb:        https://git.kernel.org/tip/861c6b1185fbb2e3fa158aa3aca75d2f767db2a8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Apr 2025 10:41:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:31:47 +02:00

x86/platform/amd: Add standard header guards to <asm/amd/ibs.h>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mario Limonciello <superm1@kernel.org>
Link: https://lore.kernel.org/r/20250413084144.3746608-3-mingo@kernel.org
---
 arch/x86/include/asm/amd/ibs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index 77f3a58..3ee5903 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AMD_IBS_H
+#define _ASM_X86_AMD_IBS_H
+
 /*
  * From PPR Vol 1 for AMD Family 19h Model 01h B1
  * 55898 Rev 0.35 - Feb 5, 2021
@@ -151,3 +154,5 @@ struct perf_ibs_data {
 	};
 	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
 };
+
+#endif /* _ASM_X86_AMD_IBS_H */

