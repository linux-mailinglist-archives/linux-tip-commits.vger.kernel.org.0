Return-Path: <linux-tip-commits+bounces-4847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C7A858CB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04293189FD8D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C52BD582;
	Fri, 11 Apr 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e3guskau";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cngTtLRf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247629DB7C;
	Fri, 11 Apr 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365711; cv=none; b=KoSS8ek5LrmqS6lYRZyNz0hJkk0nEZXHJ86diNYh59lcdhCAPMCQElHTbNcI1Rfnbs4y4AtBGq3dA8UPNXHphZlLhJqeSCkaLbS15d6/nflf6I6uMAzbP29ODyOaBeVjVvDG+xjjTi+9xi3gBLLeMzVAkVC918HXITNYdAbKAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365711; c=relaxed/simple;
	bh=dCXAI8bB/vJAcSdJjGJ+wFhYLbIcFt+wTUgCsXF5Ji4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fmV2blYE3Q6oBoD37y5iGVapiqNq24teelQuupR62SEDIGd3FEXPJShk4WwzjOwsczpaZSszB8DO8LLYZ2VzSeWMtumutmfoNgsLbYmC/ALXabw5heytBeU+Qzj5mWFMCGHDZrLWWaUhM6HuamDgkdPJEFk07gAiVgQ4ZQNPfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e3guskau; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cngTtLRf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWNDzvnzNfTX6GNCTTG0BgWIVv+LHPNFMJfaXIUS734=;
	b=e3guskaukt6GCYquNJkJxDqAuPiDZfNWQjBo08RMr9wZGBlge/A8RvcKd1EsN0AzKdoije
	BqGx2S+265w70lwcvJO8xDVdLTRzRn2oeeR9yCp314kM+CT/TjwvmG+zRLoQdvWDKrnSSD
	Y1XA0FkLWUBcALwSWrhT4KRnTFcEtTl5RlOD1lSVLdLBKZRyFYcbL73MaA0xiB5j5bP0w2
	N5qKaY/Ju+tlic7a2d/qZ7Xbx6zJyPtH1wBM3EOHHQFamFESrG2brSxswJstgNrcnLtlaa
	x0KbRd7agzWM0GtUouMoh7MQtPYd2qiSGRBOIJOcODbqGro8g6QRD0zIwpKbNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWNDzvnzNfTX6GNCTTG0BgWIVv+LHPNFMJfaXIUS734=;
	b=cngTtLRfB2SjVB4NQMfs26Aei7V/aATgvy4aJg5XGI7kpY32kbXhcx2n7/8r1XMJEDVxC2
	mum9KY3Xxy/QD2CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Constify text_poke_addr()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-43-mingo@kernel.org>
References: <20250411054105.2341982-43-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570728.31282.18167006608499327086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     6af9540379628a769c63b0a101ff371d7719ec04
Gitweb:        https://git.kernel.org/tip/6af9540379628a769c63b0a101ff371d7719ec04
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Constify text_poke_addr()

This will also allow the simplification of patch_cmp().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-43-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a747b08..14ca17d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2493,7 +2493,7 @@ static __always_inline void put_text_poke_array(void)
 	raw_atomic_dec(refs);
 }
 
-static __always_inline void *text_poke_addr(struct smp_text_poke_loc *tp)
+static __always_inline void *text_poke_addr(const struct smp_text_poke_loc *tp)
 {
 	return _stext + tp->rel_addr;
 }

