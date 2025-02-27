Return-Path: <linux-tip-commits+bounces-3727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DCA48B2C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 23:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61127188D56F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697B26FA79;
	Thu, 27 Feb 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a8fhmwwA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pjxzayxk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC77221F13;
	Thu, 27 Feb 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694591; cv=none; b=tsGgXecdgGr/7HT7oe+upskjjpSTav3maStV8ufddImbcRYG8+qpxxDwSU974DMxJLlLG80BVtQ0eIJh4daE9eRHrzCyppI+H0bk9YNNFNqJ3zR7pDGw+LLTsMUtYLJJ0UEyY7Z+P8TIG0bXyOn54a5ePv5nNF7+yvvshP8OoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694591; c=relaxed/simple;
	bh=U8qUmHpj3dVYbRs7Z7FWaNtxyegIa/qelQKjBv5eLSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AcGQRZHhNe71aXabIsKwlw4nRXyPtqJKkaHpjdzDe1WJ53U4+6dbPmgetsY0r45Y/4ZVBwVAN7ke735oS9YMcN5eimDrZnXxLqCj1B9nP+L3RWA+f+8X+4ERYtkfpPFjpbu5TBc9acPI4uc8RfV0p6Sh4Ph2fFRIfJL/BY56uuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a8fhmwwA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pjxzayxk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 22:16:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740694587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm4aUgVKTiF7f/dRdPWxX2laOs5h0A+54a9mrPyA2uA=;
	b=a8fhmwwA9P8jNivd2p4/nJ2yZr0Nnozrrg/IhSpxE+GiOtpm2zunsf4oA0LUd5WN8qd2+c
	LKp7PfThtKtKHzwnxEOsPGiP5m3EdAQGHvchz57M1RY2ZJe5KmL42/nDz6Zm1o4VvPaQTQ
	1gB3Q2BGfHAPDl591knCpPo1R0sGt5kPzpw/mD2pE1/yTVquQP/6fm7JHzlCp1VkI87yr0
	0WC9sxkvkPgy0yhdoQS8IKUfKny8aM7HZygKQq2TyFAgU9YGLiiwggkqr+UATp5+fsYIcI
	t203oAzOPIGcWOzbPsHgdsjAJBRP/cDywMnKQ0ld4p0AFXqD9GgqZAvMavKCjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740694587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm4aUgVKTiF7f/dRdPWxX2laOs5h0A+54a9mrPyA2uA=;
	b=pjxzayxkitI1hN053IqrL29GgQJ6QpX65RXC/aXv+Fy4km7RhyieMI5CCOocearXAO5vul
	vqsSfImKKd2TA+Bg==
From: "tip-bot2 for Kevin Loughlin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add missing RIP_REL_REF() invocations during
 sme_enable()
Cc: Kevin Loughlin <kevinloughlin@google.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122202322.977678-1-kevinloughlin@google.com>
References: <20241122202322.977678-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174069458621.10177.15982017592902412155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     72dafb567760320f2de7447cd6e979bf9d4e5d17
Gitweb:        https://git.kernel.org/tip/72dafb567760320f2de7447cd6e979bf9d4e5d17
Author:        Kevin Loughlin <kevinloughlin@google.com>
AuthorDate:    Fri, 22 Nov 2024 20:23:22 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 23:01:33 +01:00

x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()

The following commit:

  1c811d403afd ("x86/sev: Fix position dependent variable references in startup code")

introduced RIP_REL_REF() to force RIP-relative accesses to global variables,
as needed to prevent crashes during early SEV/SME startup code.

For completeness, RIP_REL_REF() should be used with additional variables during
sme_enable():

  https://lore.kernel.org/all/CAMj1kXHnA0fJu6zh634=fbJswp59kSRAbhW+ubDGj1+NYwZJ-Q@mail.gmail.com/

Access these vars with RIP_REL_REF() to prevent problem reoccurence.

Fixes: 1c811d403afd ("x86/sev: Fix position dependent variable references in startup code")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241122202322.977678-1-kevinloughlin@google.com
---
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index e6c7686..9fce5b8 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -565,7 +565,7 @@ void __head sme_enable(struct boot_params *bp)
 	}
 
 	RIP_REL_REF(sme_me_mask) = me_mask;
-	physical_mask &= ~me_mask;
-	cc_vendor = CC_VENDOR_AMD;
+	RIP_REL_REF(physical_mask) &= ~me_mask;
+	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }

