Return-Path: <linux-tip-commits+bounces-4170-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00029A5E482
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 20:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42713A63E0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AADA2594AA;
	Wed, 12 Mar 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IIPChTRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9npN8H1C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B502586FE;
	Wed, 12 Mar 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808009; cv=none; b=Px8EOMIDzJF5KB3tzj9xRUzjmpPSqwsvWe4ULvCD/mlYfsxp9e33u+sifg7Ppkl2WsvxA9MhL2xC4fPRejpFUQywRXHVW4lTyMNelbxexPn4X/sRXpzofe/lWqXSffJo1shWmo6F7+bvUT5Yzgxdyldx+iNilqvejrwpD2g8Ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808009; c=relaxed/simple;
	bh=dQtD7A1dxyEl/TawHTXixTLvpkFdMd6DEMCnD4PqM7E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MwaKJS+cThSLD55BhZdNfRRfhWJEWHOFV7i7T1qPRu0acN8aky+PjddHlVpAZm5ToiJ7sccpxXCyw3NSO0GHwMQSJ30HAhaNa4qtisZxO4nP5CIoZNwa0pmDHkBPK/hxt+WfIeDkCUPdmU5ICcQSLjUQ3DCZA1jSwElGQqoinJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IIPChTRi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9npN8H1C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 19:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741808005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sUXBAocjh/dVW/FgBZk/YcashHThJioHpfF9odOhzM=;
	b=IIPChTRib3huYC8PMQm6DdrZK9Wvr789ElPtcwwRl5uG7m/q8VdCCRQSfqFjBnZ5nr9nEQ
	BzI/1R/Q0hD5YVUJi0n2U/6rQFY6CHpBsS/WsRS7BglHjts3u81+Deg3g59MFC8PDAV7+d
	cCLYOd3B+Y0HgJ+k9zGbo/mNUEkXq1gbegynz4FhfiFPtZiE6DadHmN0pUX9tgBEyVSZBh
	9IyT/1GcAZDIXamT5t9XR4GdylYZRyrBgaLdb7DomzJH74NaW9AzeflCCazs7GRC1Kg0+h
	ffbK9aaeid9DUxJvGmvauoGt/Tm+4QdOMXhhuQKPoemYdrL0EiBORcfqrSLTvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741808005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sUXBAocjh/dVW/FgBZk/YcashHThJioHpfF9odOhzM=;
	b=9npN8H1CbfXRofhSJm8SXPmxfobW4Cr8jxNZX+P5S3CXeXlaBRKUyy/mhPRmG+siVbs0yu
	s8anJfO+0V3hSEAA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/hweight: Use named operands in inline asm()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312123905.149298-1-ubizjak@gmail.com>
References: <20250312123905.149298-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180800520.14745.12493115932200431344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     f9d73498e7bfe3dc47bb4c7ce37ad07286dd8d16
Gitweb:        https://git.kernel.org/tip/f9d73498e7bfe3dc47bb4c7ce37ad07286dd8d16
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 13:38:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Mar 2025 20:18:28 +01:00

x86/hweight: Use named operands in inline asm()

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312123905.149298-1-ubizjak@gmail.com
---
 arch/x86/include/asm/arch_hweight.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd..a11bb84 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,9 +16,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "=" REG_OUT (res)
+			 : [val] REG_IN (w));
 
 	return res;
 }
@@ -44,9 +44,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "=" REG_OUT (res)
+			 : [val] REG_IN (w));
 
 	return res;
 }

