Return-Path: <linux-tip-commits+bounces-4599-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04AA774FA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90D87A2E08
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAF1E8329;
	Tue,  1 Apr 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgQ1Yzuy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CEvDi23"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF01917F4;
	Tue,  1 Apr 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491720; cv=none; b=X4lwkKa+hsoIOtoBVeYT/tSUdoIdgdLBXaoWrjxzhJm76T2/X7x6dyFukFRvEDuYum1DiVOx+CrGFxrLPOl6o0Q4CfcGegUnETGuOn5fj50sQptAGwA/6Xsgt67tE7T8FUBX6uIYqVIUP6NzGuvcGw8ceyjqP61vfe4HOKARUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491720; c=relaxed/simple;
	bh=YdpQ2vu+OrqgZ3RmtnMXmsfyMoe2tI4h+kI0ggFlK3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZAe58X7+FPHp3XQBNHBzwcDMCkirQuimb1ObI/hALrkzd/SmcfyTRL+7QENmo7J4F2fDlNxGptFXWia7OAtOz0am3gEBYc1clVT1ukQah/XhiOvHD2qeC2M9it9Uke+G8jwvAeIMLOshrJAA5vmg0OlSYNJdsbB3PLCL2ZM477s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KgQ1Yzuy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CEvDi23; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKo0GDum4TJdCpqSz+zT5uuOmRYntJT7ZyBDN21dgpM=;
	b=KgQ1YzuyIMvpyXZttT1ZnGv3tkCiS9GlfW9Z2uvvPbfA9jowBwXGmAlTlS89dyUz0h6vY3
	CfkTTZblOv0yD+WlJ5ueuOKxBF9vBp7CHJR4rAFdAaEEl1oIH9rUstDDgRwRSeRvHuRM19
	/LOkJif3AiwnA5eShUCiMkAbiWjGAJpePX86I5GaR5N3lfdZdwK0q0TbD2g8FL1SjCgqSP
	91LvszIf9aVuygkiH+3tjjc6nAM5W4DjyKqwIb9SGPXAeV1+EL6LDhHcKidoKAW6diWPnI
	uim90aN5UiGH/nw4wYkr5uM2buFzvbFawAORFXG98+mqTQPZ2R2mfp9BWp9TpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKo0GDum4TJdCpqSz+zT5uuOmRYntJT7ZyBDN21dgpM=;
	b=1CEvDi23HUktCk5drngYf1XIBt1aReu155N/RE+yeG0xuINx6DfYvSLaYgODT6idzW0NUp
	/YcNFmSAzoSWtgDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] sched/smt: Always inline sched_smt_active()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <1d03907b0a247cf7fb5c1d518de378864f603060.1743481539.git.jpoimboe@kernel.org>
References:
 <1d03907b0a247cf7fb5c1d518de378864f603060.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349171647.14745.6621823717542987651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     09f37f2d7b21ff35b8b533f9ab8cfad2fe8f72f6
Gitweb:        https://git.kernel.org/tip/09f37f2d7b21ff35b8b533f9ab8cfad2fe8f72f6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:44 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:13 +02:00

sched/smt: Always inline sched_smt_active()

sched_smt_active() can be called from noinstr code, so it should always
be inlined.  The CONFIG_SCHED_SMT version already has __always_inline.
Do the same for its !CONFIG_SCHED_SMT counterpart.

Fixes the following warning:

  vmlinux.o: error: objtool: intel_idle_ibrs+0x13: call to sched_smt_active() leaves .noinstr.text section

Fixes: 321a874a7ef8 ("sched/smt: Expose sched_smt_present static key")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/1d03907b0a247cf7fb5c1d518de378864f603060.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/r/202503311434.lyw2Tveh-lkp@intel.com/
---
 include/linux/sched/smt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index fb1e295..166b19a 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -12,7 +12,7 @@ static __always_inline bool sched_smt_active(void)
 	return static_branch_likely(&sched_smt_present);
 }
 #else
-static inline bool sched_smt_active(void) { return false; }
+static __always_inline bool sched_smt_active(void) { return false; }
 #endif
 
 void arch_smt_update(void);

