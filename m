Return-Path: <linux-tip-commits+bounces-2975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535739E556E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B36C188262F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A5218822;
	Thu,  5 Dec 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lcpkuKP3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vq5ui2Z0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA3217F41;
	Thu,  5 Dec 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401693; cv=none; b=oJStd06AShL+QkYB39PoQfhM47sswRHhZw3ZHzkcdfYsLGY4mZ9KgqRixnsh21lSHLTYTL//0//OEap5Y6LfTPOL7UykodtcuETDIyTaZ9gf8dNHYF/1rDfftWvm6fiADBuXtzMxt65zflOv9dUFLZlkRMy6fPovR/+K36nM4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401693; c=relaxed/simple;
	bh=27JrLT+0xWyJFkR4OkeXPIE498Je2AiFNTuU4Z6raKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lLheU3bPv1UzRf8JAdvMjNeWy4EBAn2z6OqH5VpZXypm/O9PoCWB7gvyx9K852/mC02YKapjLnLEjEDk6Jy1iHXjAiE97rRl+XRQbF6sq36+/Wb7r3QPHt8Xy4PysEyEYtvBbSyHmYEkIgw/qGl0YO6w0eLB3h+9ZVQoIfyqlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lcpkuKP3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vq5ui2Z0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82pOOtDN/dOyIpajuMRML/q6oEn6I6DMfMl0e43cXrQ=;
	b=lcpkuKP39nMs2yFiaymPc1X7e5FdLIoy8KDygBbd40grhDE6iVf3AVqNexaxw4sOkHoh9c
	h7QL8J1sD+bnADUaDile2cLHcplJT8yaoraxCsKTWzVMRkjcJr70As4Ftg09oLfZ0EAtKc
	wrxoqmh9iJO1c3WYPD61NlfTlVnvMnbZ/ZRw6pEAElFEz7ibImr5LCnqKXK736/SqjPptf
	8DKBgRhaThI/HyqrT6zfQv1x7HSLjaTKt6eZCNILE1Sv4dZVrozvdXb5LblgZEFwdNblfk
	KWCnbFHFTNRlOqkUO9Z/uAqhKnIcucvM2Aax2g9JoF4rYCo4rrjUYrfxlF2PjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82pOOtDN/dOyIpajuMRML/q6oEn6I6DMfMl0e43cXrQ=;
	b=vq5ui2Z0s+CqwUDm4HzDHVoWPTXKfcayc4xJ8I2zMePsFrDKQOdEZ+/Dae9iBwHT4CTB86
	AVoAXGyOe3xCqXAA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Move .head.text into its own output section
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205112804.3416920-15-ardb+git@google.com>
References: <20241205112804.3416920-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340168948.412.7949063025410452017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a6a4ae9c3f3a8894c54476cc842069f82af8361c
Gitweb:        https://git.kernel.org/tip/a6a4ae9c3f3a8894c54476cc842069f82af8361c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 12:28:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:18:55 +01:00

x86/boot: Move .head.text into its own output section

In order to be able to double check that vmlinux is emitted without
absolute symbol references in .head.text, it needs to be distinguishable
from the rest of .text in the ELF metadata.

So move .head.text into its own ELF section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205112804.3416920-15-ardb+git@google.com
---
 arch/x86/kernel/vmlinux.lds.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1ce7889..56cdf13 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -135,8 +135,6 @@ SECTIONS
 #endif
 		ALIGN_ENTRY_TEXT_END
 
-		/* bootstrapping code */
-		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -151,6 +149,11 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
+	/* bootstrapping code */
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
+		HEAD_TEXT
+	} :text = 0xcccccccc
+
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);

