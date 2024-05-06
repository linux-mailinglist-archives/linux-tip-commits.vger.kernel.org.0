Return-Path: <linux-tip-commits+bounces-1243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA18BCE74
	for <lists+linux-tip-commits@lfdr.de>; Mon,  6 May 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27818B21A52
	for <lists+linux-tip-commits@lfdr.de>; Mon,  6 May 2024 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312BF3FE2A;
	Mon,  6 May 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PEhX7xTC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkSERiCu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4071DFED;
	Mon,  6 May 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999872; cv=none; b=AqMDRLYoXwuFUjtDt8RNyPR/Icbo0fWFxushZd9T+1KiFIsqw0mLY6Eth76FS13yK6J1yr8BmYRwIiIe4/ur2q4HeP3oH4Jpd7/iEzTuQQLJp64Xc0HKVVDJaFGBFSSY9UE4A/4yn3VjMMhQU7u7POu/hankosdgV1sqrP2X5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999872; c=relaxed/simple;
	bh=3Ao0x/m2mpxl4SFB3+8g1f7cnMl1hk4Nf58EF0zRgVM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nX9VnjLZPMvfrAn5IQJ1t3U7KxqEEed/+5S9Z0I2S6rxXJXRQyYIsArF8gJxsJEHb7LTutC4rVJnoxmvqNSlNG20e2/ixisuuvWp2n9ZA4dbR6bE716qoCB76m+o6PTq1fNf0elfYLfGEZVaGlVMuR4kqnxR+gw/Ms9Zw6QvrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PEhX7xTC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fkSERiCu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 06 May 2024 12:51:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714999868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1ZBY+BbMdsCz/HAj/ALR7pCIHzRHF2huH/d4Yke+r0=;
	b=PEhX7xTCnbDcj4HNREaccKDiqbGu4CRhubokuZwBmyWLX+bof+1J4lifvnFMyfx438snHp
	gmK+wkqzri5yMTZBrfJ+7UVC3PbD8wR/MvRqb+dqQrggSB8KqvN9H+iGVWfU5FOTxPvpql
	1m+CRMZ0eQ4maUEEz/KynCT7U4EzgyAqfYJNcf7dRGMmrUhzKTFf1borAlPPchm67ozAeM
	WnCpR2vIEV9sAEQXsr5Hc8UI0P7ZaRIXUrqcc3M9MpFrz565uvLz4hrxXtwhcS49wU8Igz
	3ICbIJTjs9+HJQywWhe7ci4DUXFXgiL3pWxBqS51FCwALus/xLZXdjloJqii9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714999868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1ZBY+BbMdsCz/HAj/ALR7pCIHzRHF2huH/d4Yke+r0=;
	b=fkSERiCuy1veK0BrWxmsMAZuH3y2M5J5SVM2CvyGzgxkSc5UDOQ1IUAeGALLXp/wFsqGXF
	NnzSR8tyNPmSa4AQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Remove alternative_input_2()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240506122848.20326-1-bp@kernel.org>
References: <20240506122848.20326-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171499986751.10875.10656752309329992312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     8dc8b02d707ee4167fffaf3a97003bcdac282876
Gitweb:        https://git.kernel.org/tip/8dc8b02d707ee4167fffaf3a97003bcdac282876
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 06 May 2024 14:28:48 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 May 2024 14:30:54 +02:00

x86/alternatives: Remove alternative_input_2()

It is unused.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240506122848.20326-1-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 67b68d0..c595358 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -286,20 +286,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: : "i" (0), ## input)
 
-/*
- * This is similar to alternative_input. But it has two features and
- * respective instructions.
- *
- * If CPU has feature2, newinstr2 is used.
- * Otherwise, if CPU has feature1, newinstr1 is used.
- * Otherwise, oldinstr is used.
- */
-#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	     \
-			   ft_flags2, input...)				     \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1,     \
-		newinstr2, ft_flags2)					     \
-		: : "i" (0), ## input)
-
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
 	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\

