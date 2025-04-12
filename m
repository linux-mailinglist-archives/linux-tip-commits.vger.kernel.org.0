Return-Path: <linux-tip-commits+bounces-4906-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02CA86EF7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6D8C0624
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A81C3C08;
	Sat, 12 Apr 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1yk9apcJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e33R+CVU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2474315F;
	Sat, 12 Apr 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483616; cv=none; b=AwK6aQeOL5xIsduRBGvcV98dXp5/IozfO6eLrmbq2qGR0xKzx2db/FdTGZeEE3yxz+4PvmN26ZI1rtSJU4uAMHToZ06Ck6gW5OtdW0QzYKaa2S4WJFQMtz2cQnXAGG8X5kj3GA/dPsLTp/wxOWUIrp/O4m4n4BSPrkeW6OkRkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483616; c=relaxed/simple;
	bh=xX8iGqPmSZ1nVvd9asXm8OsG20SJvWswfpZ8UiclRfI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M6Vwu5HdlI/mkkfjkpDPfrXYzar3jB4RjXd0KV9Ck/mMeg0QaG6YihufrI13MFYxCyK01XiJdUesi1ngpcD+T1exEE/bFl4RJc7MZjKSLo1amJhVR4BOln4bY1PLvFsjozadfUMlPCmDW3XfCr/VjrHdbJCRYmdTUbDoDjXs3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1yk9apcJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e33R+CVU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 18:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744483609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUOr1HeuQGxYTfgvwdl1TNfChlQBzYYTSD6XlwYS51s=;
	b=1yk9apcJ7mtHzr7n12o6TTHctpIyJWueupY2NiA0pSgUq3l4VjO0YOw/XBMQJj5aCzVpX6
	dov6q5lcZ+w8FzZwPhnOI+EfJwBPQemLIjS9DTDClnF9tNi5gLzeELfb31gFnk5z/kuYhz
	3IkxwuUAmHzbwF9L/xUCeKxlDfQKTucBVcwv4q+NlAlNCGcdq7fAPV+xW6D9anawYWkA2U
	Eph26KoeuL+mrTdHsEMMOUGGzFm4B1vz7p81tZngWbKkqSXagXA95bf5EMYGtrnYAan3jb
	0LWpqB18cnyG3rln17XZlGq+rXIuUdiRVecEkj8Z3DtDj1MUK7qRUDyoBbweDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744483609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUOr1HeuQGxYTfgvwdl1TNfChlQBzYYTSD6XlwYS51s=;
	b=e33R+CVUbWAcUgl+XF2RwiD4KkNy1cNAmjzSWLX3yAkSrKphDjlwAzPeBKuqgdG2UZztmv
	7jrYVe09U+Xwe7Dw==
From: "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/efi: Make efi_enter/leave_mm() use the
 use_/unuse_temporary_mm() machinery
Cc: Andy Lutomirski <luto@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402094540.3586683-7-mingo@kernel.org>
References: <20250402094540.3586683-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448360887.31282.4227052210506129936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     e7021e2fe0b4335523d3f6e2221000bdfc633b62
Gitweb:        https://git.kernel.org/tip/e7021e2fe0b4335523d3f6e2221000bdfc633b62
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 02 Apr 2025 11:45:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 10:06:04 +02:00

x86/efi: Make efi_enter/leave_mm() use the use_/unuse_temporary_mm() machinery

This should be considerably more robust.  It's also necessary for optimized
for_each_possible_lazymm_cpu() on x86 -- without this patch, EFI calls in
lazy context would remove the lazy mm from mm_cpumask().

[ mingo: Merged it on top of x86/alternatives ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402094540.3586683-7-mingo@kernel.org
---
 arch/x86/platform/efi/efi_64.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ac57259..a5d3496 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -434,15 +434,12 @@ void __init efi_dump_pagetable(void)
  */
 static void efi_enter_mm(void)
 {
-	efi_prev_mm = current->active_mm;
-	current->active_mm = &efi_mm;
-	switch_mm(efi_prev_mm, &efi_mm, NULL);
+	efi_prev_mm = use_temporary_mm(&efi_mm);
 }
 
 static void efi_leave_mm(void)
 {
-	current->active_mm = efi_prev_mm;
-	switch_mm(&efi_mm, efi_prev_mm, NULL);
+	unuse_temporary_mm(efi_prev_mm);
 }
 
 void arch_efi_call_virt_setup(void)

