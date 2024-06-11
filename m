Return-Path: <linux-tip-commits+bounces-1374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF79041F4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5614D1F26249
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B414535A;
	Tue, 11 Jun 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Db+1AWG8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CNUcyiLY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23D7C6D4;
	Tue, 11 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124844; cv=none; b=miA8hBIrcBUGEV5/xG6MCIGe7hzHuBJMPHCWp8QCS/aXGq2qsnFGOKLSOjPNPrDrfYS3pvHpdEiZ3kTwUp8H2OeRAkIo9YTrZm0PTpL1qUX0NKO/j96wSKnrA9CzkyOMauedf7EVPYqHHIF8PXJSCKYqxisa9EyfbHQrMEJEIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124844; c=relaxed/simple;
	bh=cYuE3aGRBZCarf3/UAqWF6lXfo1rpRErBne3l5M8TBg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RX2rtWIYXrzE2ffkOEisngG/ZK7P3du9lSrLsegrJVxUgxYlLL47VKL9iQlG9AIM92dyH+3+NID6a149M1xgG3Fuh6fdM5qLfVq+zfshqVJl4Nx2VL/GR27OsMubL6rsA1rHnJ2ZtNGvZsvpgKDuywOiQPOx9U2s6QzW4eQu0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Db+1AWG8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CNUcyiLY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRjCgeFpr71J9L+wNpsYziWJPiycGNQiSWAbNp7TGdk=;
	b=Db+1AWG8JNMdOdJC244JHFn5gTbn0Re4i2mhW+dRHSqMoaC6md5DgTVRBKZM6V+5pEgaw1
	UpGvlCPCSEnlXiy8oibmRqrHDTk0iNTI2nAfpwEI4V/0w00/NCDE/ErFIWCcMKz0GjdsWw
	Y7+/9ginvgtvszYA5lzXGz1al33hGKJR5kBlukoi6dxHyzmVbvu4UdqAHb9BzD+X7XvS8k
	dS2/yv0E2gGcQi2YHVBaBgXKkBsRanJHcHCzURDO/Ccequd/FBFhcaQZacCjRq7fHrMzkf
	m5Ng70R7abxvTZV/QqW08g1b8xTwIWPVJrgxwAMyAlpkcXYzBLB9gp5k3o9CFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRjCgeFpr71J9L+wNpsYziWJPiycGNQiSWAbNp7TGdk=;
	b=CNUcyiLY4uGRtXXy9k6/ycTWVEALlG21/4qJsHVlZtnU+RliU7iKj7m5jKDynRHklnVKzH
	Nd8Ox9Z1uS8zjlBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert alternative_io()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-7-bp@kernel.org>
References: <20240607111701.8366-7-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482893.10875.4374270758808029965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     ad36085ee3563001cf1720eeb93c2e85715eb5cd
Gitweb:        https://git.kernel.org/tip/ad36085ee3563001cf1720eeb93c2e85715eb5cd
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:53 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:12:29 +02:00

x86/alternative: Convert alternative_io()

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-7-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 428d6ef..6a74681 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -335,11 +335,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
-		: output : "i" (0), ## input)
-
-#define n_alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
 /*

