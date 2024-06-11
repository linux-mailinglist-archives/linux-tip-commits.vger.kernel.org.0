Return-Path: <linux-tip-commits+bounces-1373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56979041F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE6A28CECB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AF80605;
	Tue, 11 Jun 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXZcdNdo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z0bD1YCX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8550770E6;
	Tue, 11 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124843; cv=none; b=iN2MezzP1Vu0m7+zh1naVK2mWt16kYlzcvowwZ3WBMjF/qiGzA3Ovoj7WXPb7ZtbtiiTaHq5rIbGZyQlG4EbH1EblyEO0HYmF0RNdTjdvrxvd4SiUD9Vn/m1iGrUTnJjuBa3Vy+eS7oHiLVH6evgy6gft4ScEvbcTb0rn9/RET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124843; c=relaxed/simple;
	bh=42pe3S5hcoj+G5XZqdSbkgFHJZmiybymCTGaIhR2k2Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qq46fcnKWBNHDocrxy16SQL/zqqL91VgjeX8mVBh3IMHrhl8CGtARMPkr+j5piFKcPn7ivPXAOKYdAiw4qAqqFFbJIPgu++nah8IWJLMCW6HxQE4dnF1nzQGuiow5aJIyuhNSG4zmo/ucLAH/muXEUmssYGO6yPlFuYWxoZM69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXZcdNdo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z0bD1YCX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHjELHl3VPeKps7H9jwiSu83aFvEtqYUYDnezEXBuDE=;
	b=SXZcdNdoRfQqZqhIf3dVUQ2MgD5CGOt761FN1tQlAXDkj2dd9795quKL4sbL0L5tjND5yh
	H/iV4AfyqWl8Tv9ZbefgKG+aNJ5bQHt46kt7BGP6OHAmDHdpC5wy3Dkr3czAzhI8tW8ssf
	nsLptEt7L4aU8uvt7Ab/fQCKNyphqT+5Yzev3L5q2bNWGx/SmfZsYlKPTVlBPL9h6BBuZF
	tB7gMeSm20YHy8pUVgzW98pvr0ThwAiJ0N357IfCCn4PJR8x2K79UVNFo3fJzmF+l5I7Rg
	iyZqJy2uzY0+qHnk0W06CYYNnQ8zPtpDw6jqkwIN2hNuIsby0ordiY9dbeFGaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHjELHl3VPeKps7H9jwiSu83aFvEtqYUYDnezEXBuDE=;
	b=Z0bD1YCXxZ1yFsmc2U05bkLgGme60YInzpoi3S3hdcebE0cCKIV1WYN5Bt/5aDowqdi8qc
	YhCAXJPVN8xL3zCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert alternative_2()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-5-bp@kernel.org>
References: <20240607111701.8366-5-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482942.10875.12132425870305609806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     8cb1f14b707d3d9b7d2b330c0acd62537576c6a7
Gitweb:        https://git.kernel.org/tip/8cb1f14b707d3d9b7d2b330c0acd62537576c6a7
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:51 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:06:58 +02:00

x86/alternative: Convert alternative_2()

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-5-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index c05bff2..21ead5d 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -319,9 +319,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
-
-#define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
 /*

