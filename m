Return-Path: <linux-tip-commits+bounces-3883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A5A4D8FD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50303B53C5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CCA1FFC4B;
	Tue,  4 Mar 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjYjxXYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3hw6eGG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADC1FF605;
	Tue,  4 Mar 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081045; cv=none; b=MuLQxByTIElkHkWnZf+njz7c2WD0f1WjHB2ekTPbU8MMTW2sDhVR42HsP4+ynlPQjHbTBtXGntOEQVxHkSY9WB/BRZk1RXXRKHhQ07uWyzUK+S5CaqYh92ftMnjneCi9+WFdVdcHkWCmRF/6EieepBPWyTI+cMntHigCj+Z/s/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081045; c=relaxed/simple;
	bh=yYHqbGlfj331PKZVuyDW+n7RB26jrczWpwf2kIPq6sQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AfYZKsaQ/eHCN5CMfizEzxv4YSY4R216PcTTBc8KTYf0Pa2p7n+/D64O6/E4fa0nHXZnfHSpVXsyJJ15yfiOzSTlVCm4TrzaWOYkDCZ/C4JOk9tfKWPm+x8eeAMYmW8aw5InqW4g8JzOKVOBlkVrbIqlqneqdG/2Jql5ZpuEohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjYjxXYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3hw6eGG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LB8EPbzDW8lT8I11GcgmwwusvK2aKBXuQBwm+3V24s8=;
	b=VjYjxXYstSVrMwSXA01Z93T8/uR+HfozcLqc8kf7edF/Zf76+AY+fBbT4FkJvlWBEgKPfP
	lTJXrOJuCvZKqt2wSrwW0z+hQgtZwujT9WiT4SgMP/b4EwtxT27SArgBGokr3/XtFqIrvr
	3Jh+t2RyILaXBlOGCHYKvKJOYQtyQYrpK2T7aWAYr6N85lEThUApUO8NqITU9KzEOV5FxX
	DJk+oX30Kz8Gtf/jyAz41jQE8sU99ahjOHUOo9widOE/sW4PCT7xSHTZGRb0Z3UArYetVp
	gw9qCtfqQCaVhmHsqZxSIJBhgJ9O8cR5KkKgNRlbtJZtMKVsdSX2u3foTbqY6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LB8EPbzDW8lT8I11GcgmwwusvK2aKBXuQBwm+3V24s8=;
	b=n3hw6eGGBXDT5tZabKTq4moRamdwLoFkPNj2ptbqyAI8RKoadx0VbrdQLAjJTUk57eCaSn
	g3aC0BjaACHUYXBw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpuid: Include <linux/build_bug.h> in <asm/cpuid.h>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-5-darwi@linutronix.de>
References: <20250304085152.51092-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108104168.14745.16455238640570622239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     025caf2ff96d4c605e96e495620383db518a45a3
Gitweb:        https://git.kernel.org/tip/025caf2ff96d4c605e96e495620383db518a45a3
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:07:17 +01:00

x86/cpuid: Include <linux/build_bug.h> in <asm/cpuid.h>

<asm/cpuid.h> uses static_assert() at multiple locations but it does not
include the CPP macro's definition at linux/build_bug.h.

Include the needed header to make <asm/cpuid.h> self-sufficient.

This gets triggered when cpuid.h is included in new C files, which is to
be done in further commits.

Fixes: 43d86e3cd9a7 ("x86/cpu: Provide cpuid_read() et al.")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-5-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index b2b9b4e..a92e4b0 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 #include <asm/string.h>

