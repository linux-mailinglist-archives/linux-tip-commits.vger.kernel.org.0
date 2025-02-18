Return-Path: <linux-tip-commits+bounces-3513-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94CA39BE6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF063A6BD4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75A2475CE;
	Tue, 18 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2VaU+r6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbsOj1MB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB756243957;
	Tue, 18 Feb 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880716; cv=none; b=SjmcGK5u4BqrrlGhk8m5CzWRxHvxqv1lYEvliSeJ36BhtvCJ5gTT2aC4+lOOBS/ZLR8xb6YQDeHQR8p6z7yQ74dCENQv2KsEExTDM5ve8fB/sMZ1i10RiOKFttmwTX4DnkNe51/hURV49UdG6S6H+0giiFKS5FKI4Bb7q1aBQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880716; c=relaxed/simple;
	bh=mN9/XLD7QHX0dbGj9xtAM0pkwuC99gv+9b7tq+ZxAqM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z9YQddSW0+eOl31HXt7H/2hDrrl2JuJJnan2DbOtK++1sp7gvxm2DkEQ9qHkGC4ZSc8jF/4D7WFhbhMWD7KsUmHYbrmLgrnLp+GwoiAfWDAcJuRpP8qf3h6dOaQy9XEI/D7Frj0SMXOnvsoLs+u6YFjD9fVTnExTOJlFRrI5qd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2VaU+r6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xbsOj1MB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWh5wbGu5dyNhZNzjbsfnxt5GGJjwr3OBGad+7rNLAg=;
	b=N2VaU+r6R4eZUrJ0h95gdmHuCD4s6hotgmomGRpRY7wgLS16TvcDinHJHbixUQ3Ya8o2PH
	hIFZt2EMQbPq/84sOdLmWcTuFx44A9FBdxufeR4VDAA2QQvaBx2aaBQiJ5tf+7Xcd5WQv0
	51hnyA4M6dSTySqhErVvCkLtMe6MDbp9dRYp1rO+0TlwkMAIzDL6MSBsMEqqZz2PsiDIdc
	V4VHT6k1zmDPpvrBebLW6Yhnu5uVfno9L31XinmkLUJgNeciTQBEjtlN0fVf6t898uKO1q
	7GMH+3/iNh5NlOH7uZQHzwQ5U4IqOhSUXfqze5vxi8vCJAhu5lr4xaCEJSK33w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWh5wbGu5dyNhZNzjbsfnxt5GGJjwr3OBGad+7rNLAg=;
	b=xbsOj1MBVRmYq86gnJK+TaOMlKWG6FAFcrrRl/kG+e9Gr0jvi9Q9uFzFJU7PW5Z4bwSdbT
	ZTZEn+EmSskszzBw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/boot: Disable stack protector for early boot code
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-4-brgerst@gmail.com>
References: <20250123190747.745588-4-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988071310.10177.13642802755066548423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a9a76b38aaf577887103e3ebb41d70e6aa5a4b19
Gitweb:        https://git.kernel.org/tip/a9a76b38aaf577887103e3ebb41d70e6aa5a4b19
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:35 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:14:51 +01:00

x86/boot: Disable stack protector for early boot code

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before user-space is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-4-brgerst@gmail.com
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e..84cfa17 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o

