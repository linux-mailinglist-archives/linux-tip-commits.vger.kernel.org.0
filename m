Return-Path: <linux-tip-commits+bounces-1901-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F43944CBD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9091F241A4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F871A3BB7;
	Thu,  1 Aug 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBvGy/bV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDGmJXfN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B641A0B13;
	Thu,  1 Aug 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517438; cv=none; b=VXEXggAkF38gIB610Nci7KG7MZeBr0HjNFg9kbjx5u5Ldiq4Xs4hLf4En0XIZd3FdjfOqrqXUXkNWoy9przTXpnUtkSvx9fXZGvzcUDE6yCTKYxw1cYZ3PtYI4e88YmxsFq0fNoB6Vo0hY+6o7187OkAnmrM4kbdLetXs1Wh+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517438; c=relaxed/simple;
	bh=5IIbKNqv87M3CWfWpecsyUx53C5v92n1V7HMcT+EUi4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=a14lgRwluc23e3efmw77QrUuVhLte2xSqbA5H3+/ux3HwqR432YoULkgwQfU3jyGkZVC2GL2fEnnhFkNbFScaOvv1AplyXrV+nuRFU50Cx6JknF93tH734eM0n3bf+TUlxPm4ajx5nFk+iTlZjr7KYYWieRNFuPiVtvATD5fsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBvGy/bV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDGmJXfN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 13:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722517432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BgVvPqj9/SqEX9mmRASbPE67cHxeogYcuCj54vYpj30=;
	b=jBvGy/bVHmBNbtqHeNU49ikNcry85QA7mIPannpBkS9UeWYjZoY9JPCQnWMm1+F6FN0MMj
	DVX07zKHg3gLnzbmLEyQuNLlSgV53DBY+OOIIpMi6b3j2ZbesEK/jE6nO2l63PaKevdrWz
	gYgnz4h36v5g1iSSjGI9FHcI/ogGq3EL14JJ/IzWAq63BSZnAthahE7pPgDWkPpyY6wqyb
	vkOFR/28TV1fl9uFdHkGZ+DhqL0ButTRN6AEA67O9gG4o6EObI58jL7iw+Q1Zr+uosquJs
	1jrFshmG8CbvqC/huoIaslZigwXFKvOrwsA0zj77Uve0SlBvzYNH8+dyOAwQkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722517432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BgVvPqj9/SqEX9mmRASbPE67cHxeogYcuCj54vYpj30=;
	b=FDGmJXfNQM6pSv3oCzPmSfOMfksykd8RdzDakcJhFKp08sSMLWxxRNwWzMNy+EbzE9lQ14
	6h5Me+Ma9PfSUoCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172251743219.2215.3718826163204561626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3db03fb4995ef85fc41e86262ead7b4852f4bcf0
Gitweb:        https://git.kernel.org/tip/3db03fb4995ef85fc41e86262ead7b4852f4bcf0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 01 Aug 2024 12:42:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Aug 2024 14:52:56 +02:00

x86/mm: Fix pti_clone_entry_text() for i386

While x86_64 has PMD aligned text sections, i386 does not have this
luxery. Notably ALIGN_ENTRY_TEXT_END is empty and _etext has PAGE
alignment.

This means that text on i386 can be page granular at the tail end,
which in turn means that the PTI text clones should consistently
account for this.

Make pti_clone_entry_text() consistent with pti_clone_kernel_text().

Fixes: 16a3fe634f6a ("x86/mm/pti: Clone kernel-image on PTE level for 32 bit")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 48c5032..bfdf5f4 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -496,7 +496,7 @@ static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  PTI_LEVEL_KERNEL_IMAGE);
 }
 
 /*

