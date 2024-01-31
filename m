Return-Path: <linux-tip-commits+bounces-290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15068449C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 22:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159241F22DA3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD541776;
	Wed, 31 Jan 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BxQnW4Vb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+eFQopcb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC693BB47;
	Wed, 31 Jan 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735698; cv=none; b=AJHXGj+PvXIvm1BQ1YeAZ+XMhT7pJ+wcaMIg8EdoU8QSIK7/ZUjwRLkqMcUnZzl/BUoOJwneZavZUdXW5jeZLABVIk60R52I7xAFTT0tWc7bgtDXkVW8G97wEl+BdQpjXsxtKCy3MJ4ckZNlm8NYo65u3ljVFc5jEIcpWGK5xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735698; c=relaxed/simple;
	bh=lm5xyBXUHW7nrV7vkqJpZ367IKHsHpufQhe586XuoRk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VediRxMpe55K7/Pb9R1uIaKRpg6XB29WtV8UDAqKAET4xFgubk7fzOoAOaWliUyN9ruC9qTn6jOM0F267NZfbWQLNpdWvMa8bASSrXTOsgrTxvMf6lXIVjWSWRjRN0P8TMDhqNJ4Pm0WPGulMQNHpQSfsChyk0I3UmjCA/9rvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BxQnW4Vb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+eFQopcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a4mOrkThonDMdzj9hsnaed7Jjjg6dSJ+AnrkaRKz/CM=;
	b=BxQnW4VblKfv1L1o56ufw0+kCdWrnyYlb/X2DJuczY2NoYnRw+Ky9j1Rgp2QctVwfibhDb
	1vB0THAJFGRamBPlNqKmNZotl0R8wmMKlxvS8l5S1nfLs5DYxbYVAI9wuTswnp8afrm88M
	2B/ll8cSuhTW/fMKLKj03AeOSDYPC9bUrtj8VuEEImMyBO+G0kUjcnr8c29oMBb0TgSSPp
	yqiV9+seLpbRFx2MpdcfJFx2fG1gAJmUChKMpOo5dsNjmtngYF5lu5nUwy486GQswP0CNL
	Tx+Mu7Hg09vz/5CNwAc5+bSuqISpKzCX1bKlFz2HHDDmzAeT8heSUIkVU8LUHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a4mOrkThonDMdzj9hsnaed7Jjjg6dSJ+AnrkaRKz/CM=;
	b=+eFQopcbV1i6l00tC+BGNZ24ePn9bGGU7sRqShlnHRz5cgpNcrMJs10cZPbQRn0FQPK+iy
	qeZRzz/7tsn//nDQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/cpu: Add MSR numbers for FRED configuration
Cc: Megha Dey <megha.dey@intel.com>, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-13-xin3.li@intel.com>
References: <20231205105030.8698-13-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673569292.398.7382050929198104727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     cd6df3f378f63f5d6dce0987169b182be1cb427c
Gitweb:        https://git.kernel.org/tip/cd6df3f378f63f5d6dce0987169b182be1cb427c
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:01 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:01:05 +01:00

x86/cpu: Add MSR numbers for FRED configuration

Add MSR numbers for the FRED configuration registers per FRED spec 5.0.

Originally-by: Megha Dey <megha.dey@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-13-xin3.li@intel.com
---
 arch/x86/include/asm/msr-index.h       | 13 ++++++++++++-
 tools/arch/x86/include/asm/msr-index.h | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b9..1f9dc9b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer */
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 1d51e18..74f2c63 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer */
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)

