Return-Path: <linux-tip-commits+bounces-4970-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48324A879F7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7FB3B148E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF4C25A2BB;
	Mon, 14 Apr 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7sIsSjy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCmhggKy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E0259CA7;
	Mon, 14 Apr 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618514; cv=none; b=ibEL21h7LXfNbdi7kBZ+LVuTTtYGi85r+zFmPuM80TLaTfjIFPakfhNgAfrfeLf639qDppXAQLRGU2jUdY7oLgxV27GvBUvZq/n71aLZUKYxzeHWAx+KQC8DwtoW2aSprACkLvCxho3aitojaZUHl8KOE69YUXeLVE05O2OVLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618514; c=relaxed/simple;
	bh=oz0NyM1NEwAUa1PARaoqlrYUQ3hyhwiCeigcHu9+fQ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OxZo+P9J8IOWd0HX3b6FFPWGd+XWu2nsYeEeiIt75SjJZv5zM1A1HAQualbHNEmGEVEVkrsLDbBLf9kRNC81iUNtBBvU10jfRX0ep5cWB0iphEA8t76WWu1TCMUWR8YunQJBom3wSqq4ySNzDgp72nuc7wu97tA4iwOm/n/1ND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7sIsSjy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCmhggKy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 08:15:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744618511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJqz442uurMuTgWSGUyMgPrX7VoPA0wDtwx6j+QWZlM=;
	b=M7sIsSjyHq2uhiRw30LsXgTH+rFs4OfbG0mhriWhopC0en+P98jl1EsyI8PMAzgN7m5Zjb
	BRVUVZhvBrRpPzFFmt0DoKVSF7dpaTdiCl0qJu4S0vd41XRN9LVfVnpNmWUK5BnPN23iwA
	PBubYQy/22DETJGul+BJL6vp10ElckNC2r2w+WgIIO+dkRiguTO47ylE0fcsVYeYFKa6Jo
	XTVL0PFZPJ6KqH5ScTvw9agad1c1+P21ED9rDoVUNGGqFoI7xH0CXY7MHdpKWw1rNAn9TQ
	WmYxks3OQCKoo/kcYWX3rIT+psy+P9JWPo+u4stIVk1jB8I4KqZq3+g6eO7AWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744618511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJqz442uurMuTgWSGUyMgPrX7VoPA0wDtwx6j+QWZlM=;
	b=UCmhggKyy8Qfy6x3apJ8Ewb+H6gLv6snDyjHsCQ0PLsZSE+DVDGKgoIKJvYC31S3Uaricp
	6yOppazs7Y152wDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/platform/amd: Clean up the <asm/amd/hsmp.h>
 header guards a bit
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Carlos Bilbao <carlos.bilbao@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mario Limonciello <superm1@kernel.org>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413084144.3746608-6-mingo@kernel.org>
References: <20250413084144.3746608-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461851047.31282.9095869533219412855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     5bb144e52c666dc0082a90662a5406133415cacc
Gitweb:        https://git.kernel.org/tip/5bb144e52c666dc0082a90662a5406133415cacc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Apr 2025 10:41:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:34:17 +02:00

x86/platform/amd: Clean up the <asm/amd/hsmp.h> header guards a bit

 - There's no need for a newline after the SPDX line
 - But there's a need for one before the closing header guard.

Collect AMD specific platform header files in <asm/amd/*.h>.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Carlos Bilbao <carlos.bilbao@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Link: https://lore.kernel.org/r/20250413084144.3746608-6-mingo@kernel.org
---
 arch/x86/include/asm/amd/hsmp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd/hsmp.h b/arch/x86/include/asm/amd/hsmp.h
index 03c2ce3..2137f62 100644
--- a/arch/x86/include/asm/amd/hsmp.h
+++ b/arch/x86/include/asm/amd/hsmp.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-
 #ifndef _ASM_X86_AMD_HSMP_H_
 #define _ASM_X86_AMD_HSMP_H_
 
@@ -13,4 +12,5 @@ static inline int hsmp_send_message(struct hsmp_message *msg)
 	return -ENODEV;
 }
 #endif
+
 #endif /*_ASM_X86_AMD_HSMP_H_*/

