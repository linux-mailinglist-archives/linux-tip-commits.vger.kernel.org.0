Return-Path: <linux-tip-commits+bounces-1369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF19041EA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FA11C20B55
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD207581B;
	Tue, 11 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ea7tWUBc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fI+PPqSl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356B54F87;
	Tue, 11 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124841; cv=none; b=OTiPEgOdVmCb8ujKQqcS/ZM7Z9DrZZKGKozOqRL6E4P8j1nDzV8oPeo1BHqo0lGSkjvCJyv2DJjpkz7/x0WEpcGGzkSLimyQ2mbj3avCIeIgU7RmKWAqRtqY6gpKfqubBWD2TCbT9MW77k2tj9rE108Jr7aAc2al1Rc+ZBQQSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124841; c=relaxed/simple;
	bh=HaAST8bKT2MLYLbSME38/FHVe10PQTlJWtlIdz1pzsU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q6fPfPc+shosGZKulnoJQcud/p+EfWSLx/YNOZP3tZvsQkRcu+l9mNsPKnoUXvGfcGKcQE2qC1dxdwKwfNqF4NJZypZYxSyuoT4YOpLtptZ+d3zS98LCf6KHutrUCOfzmDQTxSZLzBT5LMOszVdf1oiRYRR7akTf9p4FwyeI8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ea7tWUBc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fI+PPqSl; arc=none smtp.client-ip=193.142.43.55
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
	bh=NPEmiG0J/+M6PsxFaTQGoLa/PkP8fCWdZt5TMfxUXUU=;
	b=ea7tWUBcJsh9QlYrjilsWTJBmB/8qHNpIDl57aHgFumKN/y/uwOQc4n9bRhWs8c5FaiFvP
	eXWgqDDDuinmRaYYM9/W64RB475tsYVWrUqaPCblKNKoIwRgJ/FKleZTF9v4RTwVXU7cOs
	ToRUGlFTwsq6dGnvJaSvZ49shk/h+h7P2uN1KGUFI1gyV8LlH/Dl0KzzekWkEdPHo1bb96
	uSor1mjg96fVSXV755UsAtZ5vKNi9KTOdPSNdu+VcjS4TspvajYqxfT7wTyUtaFgyTbPj9
	Ntd1/drbu+AVTEcWMHDcz1OXigjo+c+721/3QFLFkZomSdHbtK8eIVPAf+5b5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPEmiG0J/+M6PsxFaTQGoLa/PkP8fCWdZt5TMfxUXUU=;
	b=fI+PPqSlIGe2nQ5JQKQAT+sAMSZWswJaIUrPrzBtPDTNQKUNjBCoxuomIxcE6PZup9iy9O
	dXAW6klfhDhepWCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternative: Convert ALTERNATIVE_TERNARY()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-10-bp@kernel.org>
References: <20240607111701.8366-10-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482818.10875.11347382340489705696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     d2d302b1bbe28dba3bd8da855ac9c16aa5dbd00e
Gitweb:        https://git.kernel.org/tip/d2d302b1bbe28dba3bd8da855ac9c16aa5dbd00e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:56 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:20:41 +02:00

x86/alternative: Convert ALTERNATIVE_TERNARY()

The C macro.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-10-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index bc260f2..007baab 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -274,15 +274,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-		      newinstr_yes, ft_flags)
-
-/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
-#define N_ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-
 #define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
 			newinsn3, ft_flags3)				\
 	OLDINSTR_3(oldinsn, 1, 2, 3)					\

