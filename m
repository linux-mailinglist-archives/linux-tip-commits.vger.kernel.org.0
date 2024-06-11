Return-Path: <linux-tip-commits+bounces-1371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281469041EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A4428C915
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727EB79B7E;
	Tue, 11 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OifOgMsA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7DaS91mR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747336EB7C;
	Tue, 11 Jun 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124842; cv=none; b=gYWcFdP+Fb8wtuNxtDCxkn4kUj2IcrRAOuPTe0YvO31RW4P4RJ2RBitdff9sXJVfbocZbGdA7qtxdCYkA+X9GFKzHHylGmlnMYVo3ONRly7o0xK11XBrLJSihuBMliFddcUtoaY2ArbFGNJDy2HXPdiYgn5/2Xvw5H0FXvJUy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124842; c=relaxed/simple;
	bh=2jeDWgdHz49fRwDVRqRwrJjU0yFBKKLACKPDD56mS64=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TDbdsfwGStjrcKPDntXE3WWrLMfcH2EfR5AyIKdfxuY/9ZhWFaWG+pilOySZkJaXVZ2tkCd9l5beIfBCZK24gf1ZjkNHBfXzOmBwtNAdZcM0edweBgqKbpK8NTCXXPrkwyNMOywmBktk7foHxOpwmr9EroPaqVnti/ht2PQwT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OifOgMsA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7DaS91mR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYBz7lPUZPRKZrKxm7qGMPAKO4p1PUgrNXFucCgBrc4=;
	b=OifOgMsAM3WEu8kUQJLQiEGt+YmaEuW5APdW4dIH0uTB6mmPWOUeKEk9MZx6IhqTOHTZfP
	49dER3IpgpQquo74frb2Ox6ohlDCVGhNZSfeynCAeVPBi36kUa6ixfxE9uGcLdZ5xKE5Fy
	KIj9cUg8yT8fOGbufH0/xEs1+jXs99fAirRIvJVx6orA2tOl7utWqaFNhdYf2PPDN3vuKQ
	9R+BZjXEOWkW0vPNPMf5LliwU2a6m0LeKFa+UVY5XWR1LNMojpC5b2mMtXAdsoiQfB46Bp
	vqtNmLLq+wiYchgfkdTnoFGShJp/gbSk5CpZdWJz1dbWemw5pQvU+xFnBCg/2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYBz7lPUZPRKZrKxm7qGMPAKO4p1PUgrNXFucCgBrc4=;
	b=7DaS91mRc/U6wbx4YAmodpSV+Da9vYoBf57TUgfo0B685VG2Kn5njfEcTfhtTLAq9bAXah
	GaJZfmCKN9pCIcAQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert alternative_call_2()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-9-bp@kernel.org>
References: <20240607111701.8366-9-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482844.10875.6372075166561515978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     719ac02347ee5f94a9f3d5c2fe84640f855432a9
Gitweb:        https://git.kernel.org/tip/719ac02347ee5f94a9f3d5c2fe84640f855432a9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:55 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:17:10 +02:00

x86/alternative: Convert alternative_call_2()

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-9-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index b659757..bc260f2 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -358,23 +358,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2, \
-			   output, input...)				\
-	asm_inline volatile (ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1, \
-		"call %c[new2]", ft_flags2)				\
-		: output, ASM_CALL_CONSTRAINT				\
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
+#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
+			   output, input...)						\
+	asm_inline volatile(N_ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
+		"call %c[new2]", ft_flags2)						\
+		: output, ASM_CALL_CONSTRAINT						\
+		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2), ## input)
 
-#define n_alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
-			   output, input...)				      \
-	asm_inline volatile (N_ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,\
-		"call %c[new2]", ft_flags2)				      \
-		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
-
-
 /*
  * use this macro(s) if you need more than one output parameter
  * in alternative_io

