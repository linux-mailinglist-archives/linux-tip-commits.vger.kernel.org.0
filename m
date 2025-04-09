Return-Path: <linux-tip-commits+bounces-4786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C29A823D9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89CA8C351E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B025E807;
	Wed,  9 Apr 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y232yHbM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAAqV43m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C825E46F;
	Wed,  9 Apr 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199067; cv=none; b=ttT0Wv5JyzdwtLJ4Je/kvGLt9M+z5uFd6TMtABS0/+7+tEIxh5eayqmT31V1SComww0q4rq32xUuQrLNXZyd1i2o6xSKMELtCSEU12UxDUUARjEyp+CXSxp1acUK2dEBqyA54cyrsHluIC1/6eQvxOUF6VMaGA/d2aMifiPBr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199067; c=relaxed/simple;
	bh=1zuuKfq8Fb2gUxCOT5nm7PjF4ClnVz1Kne9wx5wdnT0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=udYVg2zSoK+q9h+IQk6vfMb+c/W4ZB2IfbtPVYQ/t2erHMxglPAaV5M9tECdb3v/uIVkwiGhjcVI/CFf0LjH63dsevKVL0P0Otqe//G/kUUlWeYWchg9gqmqVs6eyJhl24Jzezzn2Y5ivOa77NXTN+JyxlTkJ/jrTp0LReMblPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y232yHbM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAAqV43m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNLd30xIMik6LI+ehTepOf+SXmSqYObNycz8f+vXaSs=;
	b=Y232yHbM85VIXm1W2J/wuLZVh7K+mXVEW0jNxFbzU6rJ/B3F2xc4P0dPbOwkVllcsKD0Rq
	Rk1SbwTULgfoBwHQsH8lCaI6TtZLTMDEqUGDW/+sn/3ehTuwjR4JHU9ojBEeYF1yY2woE9
	sHgbNJQcRpaVgFBV2KUjKrMHkEhC5EdZTtNr3Y0iBGHrmEOuIQXpFOL6tBK6ftujYoo3Vd
	By11TEP1IcRAjDEF7jkxO9SzX9lkv8qoKq5nQGiHGHYSjfbLk59dQa7bJIYIeEVW4lQjgk
	tJdxPW35wYoQOe01x+ucgP1pMdkdqCFAlWYIhnSbeQsOfklnGjIxwOpUF+Fa+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNLd30xIMik6LI+ehTepOf+SXmSqYObNycz8f+vXaSs=;
	b=vAAqV43mrKlQPRdNS43ODnevcrAKb+oq8Biy6PHdWmiyDukNqnPJDB6jL0oFekzdbbZJn4
	Bx4ZQ4Iae8y6C/AQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Amit Shah <amit.shah@amd.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Woodhouse <dwmw2@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <84a1226e5c9e2698eae1b5ade861f1b8bf3677dc.1744148254.git.jpoimboe@kernel.org>
References:
 <84a1226e5c9e2698eae1b5ade861f1b8bf3677dc.1744148254.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419906403.31282.6211937821580800684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     18bae0dfec15b24ec14ca17dc18603372f5f254f
Gitweb:        https://git.kernel.org/tip/18bae0dfec15b24ec14ca17dc18603372f5f254f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 14:47:33 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:41:55 +02:00

x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline

eIBRS protects against guest->host RSB underflow/poisoning attacks.
Adding retpoline to the mix doesn't change that.  Retpoline has a
balanced CALL/RET anyway.

So the current full RSB filling on VMEXIT with eIBRS+retpoline is
overkill.  Disable it or do the VMEXIT_LITE mitigation if needed.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Amit Shah <amit.shah@amd.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Link: https://lore.kernel.org/r/84a1226e5c9e2698eae1b5ade861f1b8bf3677dc.1744148254.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9926509..a10b37b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1617,20 +1617,20 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	case SPECTRE_V2_NONE:
 		return;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
+	case SPECTRE_V2_EIBRS_LFENCE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
 		return;
 
-	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
-		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		return;
 	}
 

