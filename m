Return-Path: <linux-tip-commits+bounces-4941-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE37A87354
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B1B1890630
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853620012B;
	Sun, 13 Apr 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nl3l9N4y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d8l6l06H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1631F3BA6;
	Sun, 13 Apr 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570589; cv=none; b=Hduro4EoGPdvf+DjEbpgI9QwG9njKlJyFYVvo5Y9UqlhftK09tAWChLX3hQ76KuJCG1UlCj6KYX9IIXRaCmiLD41cir+fDw1lG0cFU5bccoN4rmUf/5xJqMxs4pjykjMX/s2Y2sizGeSSff+EURuuEgOxSMxoN8MZmbTVSSXaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570589; c=relaxed/simple;
	bh=9MLH4ELfgyjdE8BWOZIhdxGd7pYtzy77RwxHqE+uhG0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AxqjUTuN11t/cTjyV5Ogs5My+Y3/0Isw8Bu+s9FVHg+wnmScvyaGoGF0Qz7eAhUG+Ctn6ZTuwKEGhr+t7mFyluLczXsfP4bmOiIGf7NAXnyMHZZWP+775y3qOvPTGbd5yxREQqI+z/wbmdnnjvFyZnJyBycfVuyw14NgwCFjyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nl3l9N4y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d8l6l06H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SFmk25VEEKV1LPpFzC35S9vL5eYZN9YLzsoZhZcQKCY=;
	b=Nl3l9N4yKwawirfxnQr/0vW9AP3jB7s/kiOUNGAlHqq+4r/Q+ZXTuOh1OfQ0UHzHl6ImAz
	MyuWbXhTYVxlsOk+f6XkUCHFN6nCF7SNA3aaMw3WAuIFp3KYYZDqdrtLkAf2LP3jYneDy1
	RfNW1IAGOp/35v0Bhy+W63M+SZ9idJr2PCKgfVbpZHKV2Z9J/3sWSCDzvkIyj5mg+AjKGN
	v0duSVv9MfvspTKaQeZLqmEb4LHOUW8YCedkwPduusH8BJOaokTEMUZ27/47qwl9yTx36I
	f3z9ZyRWgVb2AWfJbk3vPWS0mzWzWM+wufULtaUDi+vYvZw+eDpKtzF99fR8zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SFmk25VEEKV1LPpFzC35S9vL5eYZN9YLzsoZhZcQKCY=;
	b=d8l6l06HbvOIaGovJbTPBJliJ7JTjU/Kgg5hAq9JhRLjyeITCwXQNwiUQkoYrL1rAJE8kB
	S42ImV3rCzWOeDBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/msr] x86/msr: Use u64 in rdmsrl_safe() and paravirt_read_pmc()
Cc: Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@intel.com>, Xin Li <xin@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457058541.31282.13598330252936280450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     cd905826cbc833b7494573998bd1c407dfa7924f
Gitweb:        https://git.kernel.org/tip/cd905826cbc833b7494573998bd1c407dfa7924f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:58:07 +02:00

x86/msr: Use u64 in rdmsrl_safe() and paravirt_read_pmc()

The paravirt_read_pmc() result is in fact only loaded into an u64 variable.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/paravirt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c4c2319..c270ca0 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -231,7 +231,7 @@ static inline void wrmsrl(unsigned msr, u64 val)
 	_err;						\
 })
 
-static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
+static inline int rdmsrl_safe(unsigned msr, u64 *p)
 {
 	int err;
 
@@ -239,7 +239,7 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
 	return err;
 }
 
-static inline unsigned long long paravirt_read_pmc(int counter)
+static inline u64 paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, cpu.read_pmc, counter);
 }

