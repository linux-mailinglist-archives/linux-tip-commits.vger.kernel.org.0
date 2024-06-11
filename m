Return-Path: <linux-tip-commits+bounces-1377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF59041F8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A42828104C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BDC152780;
	Tue, 11 Jun 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDbXgr5l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dj00EASL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DF82D66;
	Tue, 11 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124846; cv=none; b=CxzDu0MJ+/RQ77c14r+Na5SFr26SgVzn7P1kKSYsNL/ady2SYaF5bXCgoSfWgeX1DToh6oHZc6wBypaRW326SVBFf4+tBEWu/HCRwUcV4wSs47m9hs/itFbZnRRuWPZbLLWzyMIp4G7n8j+LQ7hmpEeBXRML3OgUGwdHAaevUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124846; c=relaxed/simple;
	bh=CRERkj6WgPUsR368J3IJOemdqqOO3tozL1LGGGbTx9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RQ+NWPhZJpRy74QxhafZgAsKDHT36tiQhZQKXEggAy9oD/knTHA2fVwechACkW0yprEt8jHHwLhXtBJV0n62ykLvpHGX5N77ZXaonFeN4oEcF6eb1nWJfYkQRrzM4W+x1Aw8iDULABJ/iSVwvQURaYfovrqeg1V+YmqFYtblPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDbXgr5l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dj00EASL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S6fyhG98EbOM3o6+wYbOKJDsqgPwBdkUMei3wr4p64=;
	b=GDbXgr5lABvYI1C5wNlkz6p4EyhXKi4lI33CnwjMK+w4YFd3aLBzNmse6HMJA/KE37a9n7
	5OEWE2xroaJ7p2d2Tnddxi+ivPLbjyyV8Hs+SjTQ3YWLmETc0H539hBb01aLke8YfZ2emC
	ign1LeS8hpLFQ7VUO/SLklRaIFJc4Jp9APDEkGbmAGCLUlHWO9PscDfKpJDOib9R+jmoEb
	AoSThjDvfTHjgXkqmTEKNhJmOG8YxPtk6DUqkEZ+Ys2YN9/zHKonyfkOF1DiUdwWrpIV29
	Tap8dM5Y1dmlhaKtfD53XTWxEulAngukaeqyob1iWhRXRGKob4cZ4A5QGTItxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S6fyhG98EbOM3o6+wYbOKJDsqgPwBdkUMei3wr4p64=;
	b=dj00EASLpknYwdX+80y2ssMgr54e9EDrE5IHUcaOBudO1L0H8MWCn222gUcKR4kYRa2qYf
	2oDIU0NhvsD4fLCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Zap alternative_ternary()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-2-bp@kernel.org>
References: <20240607111701.8366-2-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812483021.10875.10862182365499163698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     9cbf2643b3ec7866e688df35d5b28c8b07ecbe6c
Gitweb:        https://git.kernel.org/tip/9cbf2643b3ec7866e688df35d5b28c8b07ecbe6c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:48 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 17:07:35 +02:00

x86/alternative: Zap alternative_ternary()

Unused.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-2-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ba99ef7..6db7890 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -271,9 +271,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-#define alternative_ternary(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) ::: "memory")
-
 /*
  * Alternative inline assembly with input.
  *

