Return-Path: <linux-tip-commits+bounces-3875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85567A4D8AC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E587A8315
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF51FCCF7;
	Tue,  4 Mar 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpKDHQkp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eUV40SVK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751061F4CAD;
	Tue,  4 Mar 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081035; cv=none; b=cm77F/esyb9bLAl/rLX5KbzcMBLYtRHYoWWay1B/HGWGp+ILkza+uD7gPnLdO/0TzPsOhI7ReBxIuHx/MT/2Gsw/eyR1jJI/GAq+Qz5zQf0ZuvCJgavy7jDboNaEQMMQBqEBQy01+JfFZmzKTQvodNvDojyL6VueRhrZrH33D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081035; c=relaxed/simple;
	bh=alnMX2VArX4zJlKVNJUclbKr0d4Nr3D+vHgxYFWKK3c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g1cnWk4DjW1bmt3US1p3tcdg5huo6Jfh1c5Ki9tpxeANN7HUHOwtnml94CA05ALY0wXcxkgaiW+qZa/3JzmiCkPJqRmVYsWV3eYsxImKWLgEpokjbDpMznxpwfKp0xtTxnlDZPUI2k5Ye2seQFeGKi3CRuubBJ2dR3CwK3mzsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpKDHQkp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eUV40SVK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stsi3TTUJvVvOqIFv7edkEbMJFXRxeoOZ/25UW3FaGk=;
	b=dpKDHQkp9mUx7ftE8yiPZWLYxhOZtrVgm24oJE+t/JYYInkY3nI5zeRzQXknc5eTHKwQgw
	GKKJ2DUkJ3bw9Tvp/8kKXHviDp9Cquxb3YbAVcJUTml2K/9N8+eYy9DZbx5tcJENzhzmli
	lIHw6RBBGzuT4MyDWNqGWpRb93Ec9U6SFEAh6PxCRxSP6GWDK81uyC9Dfw8PsiV36tclC+
	1fEpOzvWS3N5tGtvaQJI4Gj0SMFgcVd8LaPFyl71PTHkC+JslpjJhCcTC9bAm9orLGUGdA
	VJZ6vuozfCO//QmzmefRyLiwq5s0jnskLs02H/KdH4tFuFbLZ89McKk+Xrw5vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stsi3TTUJvVvOqIFv7edkEbMJFXRxeoOZ/25UW3FaGk=;
	b=eUV40SVKsS9+QBo5bV6weFhCFXlfZAiZZlBo1HyVMrkMV8qmBXUdiIXXCqeVPlNvEjfaQr
	JYU3hMp4r+AIhTAQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Validate CPUID leaf 0x2 EDX output
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 stable@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-3-darwi@linutronix.de>
References: <20250304085152.51092-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108103121.14745.64964785500812681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1881148215c67151b146450fb89ec22fd92337a7
Gitweb:        https://git.kernel.org/tip/1881148215c67151b146450fb89ec22fd92337a7
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:59:14 +01:00

x86/cpu: Validate CPUID leaf 0x2 EDX output

CPUID leaf 0x2 emits one-byte descriptors in its four output registers
EAX, EBX, ECX, and EDX.  For these descriptors to be valid, the most
significant bit (MSB) of each register must be clear.

Leaf 0x2 parsing at intel.c only validated the MSBs of EAX, EBX, and
ECX, but left EDX unchecked.

Validate EDX's most-significant bit as well.

Fixes: e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250304085152.51092-3-darwi@linutronix.de
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3dce22f..2a3716a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -799,7 +799,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 3 ; j++)
+		for (j = 0 ; j < 4 ; j++)
 			if (regs[j] & (1 << 31))
 				regs[j] = 0;
 

